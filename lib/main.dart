import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart'; // Certifique-se de que o caminho de importação está correto
import 'home_screen.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert';
import './models/usuario.dart';
import './database/banco_de_dados.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMega',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.lightBlue, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.lightBlue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.lightBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adminFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // Controladores e FocusNodes para o formulário de administrador
  final _adminUserController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  final _adminUserFocusNode = FocusNode();
  final _adminPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    // Dispose dos controladores e FocusNodes do administrador
    _adminUserController.dispose();
    _adminPasswordController.dispose();
    _adminUserFocusNode.dispose();
    _adminPasswordFocusNode.dispose();
    super.dispose();
  }

  void _showAdminDialog() {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) => [
        SliverWoltModalSheetPage(
          backgroundColor: Colors.white,
          mainContentSliversBuilder: (context) => [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Entrar como Administrador',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Form(
                            key: _adminFormKey,
                            child: Column(
                              children: <Widget>[
                                _buildAdminTextField(
                                  label: 'Usuário',
                                  icon: Icons.person,
                                  focusNode: _adminUserFocusNode,
                                  controller: _adminUserController,
                                ),
                                const SizedBox(height: 12),
                                _buildAdminTextField(
                                  label: 'Senha',
                                  icon: Icons.lock,
                                  obscureText: true,
                                  focusNode: _adminPasswordFocusNode,
                                  controller: _adminPasswordController,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_adminFormKey.currentState!
                                        .validate()) {
                                      Navigator.of(bottomSheetContext).pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(bottomSheetContext).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    'Fechar',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    required FocusNode focusNode,
    required TextEditingController controller,
    Color iconColor = Colors.black, // Adicionado o parâmetro iconColor
  }) {
    final isFocused = focusNode.hasFocus;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: iconColor, // Usando o parâmetro iconColor
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.lightBlue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAdminTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    required FocusNode focusNode,
    required TextEditingController controller,
  }) {
    return TextFormField(
      obscureText: obscureText,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.blue), // Define a cor azul para o texto do rótulo
        prefixIcon: IconTheme(
          data: const IconThemeData(
              color: Colors.blue), // Define a cor azul para o ícone
          child: Icon(icon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Colors.grey), // Define a cor da borda padrão
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0), // Define a cor azul para a borda em foco
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Colors.grey,
              width:
                  1.0), // Define a cor da borda quando o campo está habilitado, mas não em foco
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  void _handleLogin() async {
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text;
    final password = _passwordController.text;

    final bancoDeDados = LocalDatabase.instance;

    try {
      // Sincroniza os usuários do servidor
      await bancoDeDados.sincronizarUsuarios();

      // Busca o usuário no banco de dados local
      final usuario = await bancoDeDados.buscarUsuario(email, password);

      if (usuario != null) {
        // Usuário encontrado localmente, salva o ID e navega para a tela inicial
        if (usuario.id != null) {
          await bancoDeDados.saveLoggedInUserId(usuario.id!); // Salva o ID do usuário
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          _mostrarMensagemErro('O ID do usuário local está nulo');
        }
      } else {
        // Usuário não encontrado, tenta fazer o login no servidor
        final response = await http.post(
          Uri.parse('https://dmega.com.br/api_flutter/login_user.php'),
          body: {
            'email': email,
            'passwordUsers': password,
            'submit': 'submit',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print('Resposta do servidor: $jsonResponse'); // Exibe o JSON retornado para depuração

          if (jsonResponse['success'] == true) {
            // Verifique se o campo ID realmente existe na resposta
            if (jsonResponse.containsKey('id') && jsonResponse['id'] != null) {
              // Login bem-sucedido, cria um novo usuário
              final newUser = User(
                id: jsonResponse['id'],
                email: email,
                password: password, // Considere criptografar a senha
                nameUser: jsonResponse['nameUser'] ?? '',
              );

              // Insere o novo usuário no banco de dados local
              await bancoDeDados.insertUser(newUser);

              // Salva o ID do usuário logado
              await bancoDeDados.saveLoggedInUserId(newUser.id!);

              // Navega para a tela inicial
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else {
              // Se o ID estiver ausente ou nulo, exibe uma mensagem de erro
              _mostrarMensagemErro('O ID do novo usuário retornado do servidor está nulo ou ausente.');
            }
          } else {
            // Exibe mensagem de erro
            _mostrarMensagemErro('Email ou senha incorretos');
          }
        } else {
          // Erro ao conectar ao servidor
          _mostrarMensagemErro('Erro ao conectar com o servidor. Código: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Mensagem de erro genérica
      _mostrarMensagemErro('Ocorreu um erro: ${e.toString()}');
    }
  }
}

// Função auxiliar para exibir mensagens de erro
  void _mostrarMensagemErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logo.ico',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'D',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'MEGA',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.lightBlue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 55),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors
                                  .lightBlue, // Cor do ícone ajustada para azul
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'ENTRAR',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(35.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _buildTextField(
                                  label: 'E-MAIL',
                                  icon: Icons.email,
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                  iconColor: Colors
                                      .lightBlue, // Cor do ícone ajustada para azul
                                ),
                                const SizedBox(height: 40),
                                _buildTextField(
                                  label: 'SENHA',
                                  icon: Icons.lock,
                                  obscureText: true,
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  iconColor: Colors
                                      .lightBlue, // Cor do ícone ajustada para azul
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Começar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _showAdminDialog,
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 112, 112, 112),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          child: const Text('Entrar como administrador'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
