import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'main.dart';
import './models/usuario.dart';
import './database/banco_de_dados.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMega',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

void _showAlterSheet(BuildContext context) {
  // Define os controladores para os campos de texto
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (bottomSheetContext) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Título
              const Text(
                'Alterar Perfil',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                  height: 16.0), // Espaço entre o título e o conteúdo

              // Campos de texto
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: firstNameController,
                labelText: 'Nome',
                icon: Icons.person,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: lastNameController,
                labelText: 'Sobre Nome',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: emailController,
                labelText: 'E-mail',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24.0),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Cor de fundo do botão
                      foregroundColor: Colors.black, // Cor do texto do botão
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto do botão
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      final String firstName = firstNameController.text;
                      final String lastName = lastNameController.text;
                      final String email = emailController.text;

                      // Lógica para salvar os dados
                      print('Nome: $firstName');
                      print('Sobre Nome: $lastName');
                      print('E-mail: $email');

                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showAlterPasswordSheet(BuildContext context) {
  // Define os controladores para os campos de texto
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (bottomSheetContext) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Título
              const Text(
                'Alterar Senha',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                  height: 16.0), // Espaço entre o título e o conteúdo

              // Campos de texto
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: passwordController,
                labelText: 'Nova Senha',
                icon: Icons.lock,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: confirmPasswordController,
                labelText: 'Confirmar Senha',
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 24.0),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Cor de fundo do botão
                      foregroundColor: Colors.black, // Cor do texto do botão
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto do botão
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      final String password = passwordController.text;
                      final String confirmPassword =
                          confirmPasswordController.text;

                      // Lógica para verificar e salvar a nova senha
                      if (password == confirmPassword) {
                        print('Nova Senha: $password');
                        // Adicione aqui a lógica para atualizar a senha
                      } else {
                        print('As senhas não coincidem.');
                      }

                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showEditSheet(BuildContext context) {
  // Define os controladores para os campos de texto
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController responsibleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (bottomSheetContext) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Título
              const Text(
                'Editar Patrimônio',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                  height: 16.0), // Espaço entre o título e o conteúdo

              // Campos de texto

              const SizedBox(height: 12.0),
              _buildTextField(
                controller: locationController,
                labelText: 'Localização',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: responsibleController,
                labelText: 'Responsável',
                icon: Icons.person,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: dateController,
                labelText: 'Data',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 24.0),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Cor de fundo do botão
                      foregroundColor: Colors.black, // Cor do texto do botão
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto do botão
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      final String description = descriptionController.text;
                      final String location = locationController.text;
                      final String responsible = responsibleController.text;
                      final String date = dateController.text;

                      // Lógica para salvar os dados
                      print('Localização: $location');
                      print('Responsável: $responsible');
                      print('Data: $date');

                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showInactivateSheet(BuildContext context) {
  // Define os controladores para os campos de texto
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController motivoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (bottomSheetContext) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Título
              const Text(
                'Inativar Patrimônio',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0), // Espaço entre o título e o aviso

              // Aviso sobre a irreversibilidade
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.yellow[100], // Cor de fundo do aviso
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: Colors.yellow[700]!, width: 1.5), // Borda do aviso
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.yellow[800],
                      size: 24.0,
                    ),
                    const SizedBox(
                        width: 8.0), // Espaço entre o ícone e o texto
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Atenção: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[800],
                                fontSize: 16.0,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'Após a inativação, o processo é irreversível.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0), // Espaço entre o aviso e o conteúdo

              // Campos de texto
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: motivoController,
                labelText: 'Motivo da Inativação',
                icon: Icons.info,
              ),
              const SizedBox(height: 12.0),
              _buildTextField(
                controller: dateController,
                labelText: 'Data',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 24.0),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Cor de fundo do botão
                      foregroundColor: Colors.black, // Cor do texto do botão
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto do botão
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      final String description = descriptionController.text;
                      final String motivo = motivoController.text;
                      final String date = dateController.text;

                      // Lógica para salvar os dados
                      print('Motivo da Inativação: $motivo');
                      print('Data: $date');

                      Navigator.of(bottomSheetContext).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blueAccent), // Ícone moderno
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.blueAccent), // Cor do rótulo
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
            color: Colors.blueAccent, width: 2.0), // Borda ao focar
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
            color: Colors.grey[300]!, width: 1.0), // Borda desativada
      ),
    ),
    keyboardType: keyboardType,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/Dmega-logo.png',
              height: 50,
            ),
            // Espaço flexível para empurrar a imagem para o lado esquerdo
            const Spacer(),
          ],
        ),
        // Remover o título padrão da AppBar
        titleSpacing: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.lightBlue[800],
              child: FutureBuilder<int?>(
                future: LocalDatabase.instance.getLoggedInUserId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Erro ao carregar ID do usuário',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  final userId = snapshot.data;

                  if (userId == null) {
                    return const Center(
                      child: Text(
                        'Usuário não encontrado',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  return FutureBuilder<User?>(
                    future: LocalDatabase.instance.buscarUsuarioPorId(userId),
                    builder: (context, snapshot) {
                      String userName = 'Usuário'; // Default name

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Erro ao carregar usuário',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      }

                      if (snapshot.hasData) {
                        User? user = snapshot.data;
                        userName = user?.nameUser ?? 'Usuário';
                      }

                      return DrawerHeader(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/logo.ico',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/icon2.jpg'),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlue.shade100, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          topLeft: Radius.circular(16.0),
                        ),
                      ),
                      child: ExpansionTile(
                        title: const Text(
                          'Tipos de Relatório',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: const Icon(
                          Icons.report,
                          color: Colors.lightBlue,
                        ),
                        children: [
                          _buildListTile(
                            context,
                            Icons.assignment,
                            'Relatório por cadastrado',
                          ),
                          _buildListTile(
                            context,
                            Icons.assignment,
                            'Relatório por Inativos',
                          ),
                          _buildListTile(
                            context,
                            Icons.assignment,
                            'Relatório por Movimentação Recente',
                          ),
                          _buildListTile(
                            context,
                            Icons.assignment,
                            'Relatório por localização',
                          ),
                          _buildListTile(
                            context,
                            Icons.assignment,
                            'Relatório do Responsável',
                          ),
                        ],
                      ),
                    ),
                    _buildListTile(
                      context,
                      Icons.add,
                      'Registrar Patrimônio',
                      onTap: () => _showRegisterAssetModal(context),
                    ),
                    _buildListTile(
                      context,
                      Icons.location_on,
                      'Adicionar locais',
                      onTap: () => _showAddLocationModal(context),
                    ),
                    _buildListTile(
                      context,
                      Icons.person_add,
                      'Adicionar responsável',
                      onTap: () => _showAddResponsibleModal(context),
                    ),
                    _buildListTile(
                      context,
                      Icons.settings,
                      'Configuração',
                    ),
                    _buildListTile(
                      context,
                      Icons.logout,
                      'Sair',
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                    _buildListTile(
                      context,
                      Icons.info,
                      'Sobre',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.edit, color: Colors.white),
          Icon(Icons.cancel, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        inactiveIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.edit, color: Colors.white),
          Icon(Icons.cancel, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        levels: const ["Home", "Editar", "Inativos", "Perfil"],
        activeLevelsStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue,
        ),
        inactiveLevelsStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        circleColor: Colors.lightBlue,
        color: Colors.lightBlue,
        tabCurve: Curves.decelerate,
        iconCurve: Curves.linear,
        tabDurationMillSec: 500,
        iconDurationMillSec: 100,
        activeIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
          pageController.jumpToPage(_tabIndex);
        },
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          setState(() {
            _tabIndex = v;
          });
        },
        children: [
          // Página com DataTable
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  "Movimentação Recente",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(Colors.lightBlue),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        dataRowColor: WidgetStateProperty.all(Colors.white),
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          top: BorderSide.none,
                          bottom: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                        ),
                        columns: const [
                          DataColumn(label: Text('Descrição')),
                          DataColumn(label: Text('ID Patrimônio')),
                          DataColumn(label: Text('Localização')),
                          DataColumn(label: Text('Responsável')),
                          DataColumn(label: Text('Data')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 1')),
                            DataCell(Text('ID123')),
                            DataCell(Text('Localização 1')),
                            DataCell(Text('Responsável 1')),
                            DataCell(Text('01/01/2024')),
                            DataCell(Text('Status 1')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 2')),
                            DataCell(Text('ID124')),
                            DataCell(Text('Localização 2')),
                            DataCell(Text('Responsável 2')),
                            DataCell(Text('02/01/2024')),
                            DataCell(Text('Status 2')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 3')),
                            DataCell(Text('ID125')),
                            DataCell(Text('Localização 3')),
                            DataCell(Text('Responsável 3')),
                            DataCell(Text('03/01/2024')),
                            DataCell(Text('Status 3')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 4')),
                            DataCell(Text('ID126')),
                            DataCell(Text('Localização 4')),
                            DataCell(Text('Responsável 4')),
                            DataCell(Text('04/01/2024')),
                            DataCell(Text('Status 4')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 5')),
                            DataCell(Text('ID127')),
                            DataCell(Text('Localização 5')),
                            DataCell(Text('Responsável 5')),
                            DataCell(Text('05/01/2024')),
                            DataCell(Text('Status 5')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Descrição do Item 6')),
                            DataCell(Text('ID128')),
                            DataCell(Text('Localização 6')),
                            DataCell(Text('Responsável 6')),
                            DataCell(Text('06/01/2024')),
                            DataCell(Text('Status 6')),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Outras telas
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // Área de pesquisa estilizada
                AppBar(
                  automaticallyImplyLeading: false,
                  title: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar Patrimônio',
                      hintStyle: TextStyle(
                        color: Colors
                            .white, // Define a cor do hintText como branco
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color:
                            Colors.white, // Define a cor do ícone como branco
                      ),
                    ),
                    onChanged: (query) {
                      // Lógica para pesquisar pode ser colocada aqui
                    },
                  ),
                ),

                // Tabela de dados
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.3), // Aumenta a opacidade para um efeito mais forte
                          spreadRadius: 4, // Aumenta o spread da sombra
                          blurRadius:
                              12, // Aumenta o blur para um efeito mais suave
                          offset:
                              const Offset(0, 6), // Ajusta a posição da sombra
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(
                        16.0), // Adiciona uma margem ao redor do Container
                    padding: const EdgeInsets.all(
                        8.0), // Adiciona um padding interno ao Container
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12.0), // Adiciona bordas arredondadas ao ClipRRect
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor:
                              WidgetStateProperty.all(Colors.lightBlue),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                12, // Reduz o tamanho da fonte no cabeçalho
                          ),
                          dataRowColor: WidgetStateProperty.all(Colors.white),
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            left: BorderSide.none,
                            right: BorderSide.none,
                          ),
                          columnSpacing:
                              8, // Reduz o espaçamento entre as colunas
                          dataRowHeight:
                              36, // Reduz a altura das linhas de dados
                          columns: const [
                            DataColumn(
                              label: SizedBox(
                                width:
                                    100, // Define uma largura fixa para a coluna
                                child: Text('Descrição',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width:
                                    80, // Define uma largura fixa para a coluna
                                child: Text('ID Patrimônio',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width:
                                    100, // Define uma largura fixa para a coluna
                                child: Text('Localização',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width:
                                    100, // Define uma largura fixa para a coluna
                                child: Text('Responsável',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width:
                                    80, // Define uma largura fixa para a coluna
                                child: Text('Data',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width:
                                    120, // Define uma largura fixa para a coluna
                                child: Text('Ação',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID123',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('01/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID124',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('02/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID125',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('03/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID126',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('04/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID127',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('05/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            DataRow(cells: [
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('ID128',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              const DataCell(SizedBox(
                                width: 80,
                                child: Text('06/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        _showEditSheet(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () {
                                        _showInactivateSheet(
                                            context); // Chama o modal de inativação
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinha o título à esquerda
              children: [
                // Área de pesquisa estilizada
                Container(
                  color: Colors.lightBlue, // Cor de fundo da área de pesquisa
                  padding: const EdgeInsets.all(
                      16.0), // Padding ao redor do TextField
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar patrimônio inativos',
                      hintStyle: TextStyle(
                        color: Colors.white, // Cor do hintText
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white, // Cor do ícone
                      ),
                    ),
                    onChanged: (query) {
                      // Lógica para pesquisar pode ser colocada aqui
                    },
                  ),
                ),

                // Título
                const Padding(
                  padding: EdgeInsets.all(10.0), // Padding ao redor do título
                  child: Center(
                    child: Text(
                      'Patrimônios Inativos',
                      style: TextStyle(
                        fontSize: 24, // Tamanho da fonte do título
                        fontWeight: FontWeight.bold, // Negrito
                        color: Colors.black, // Cor do texto
                      ),
                    ),
                  ),
                ),
                // Tabela de dados
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(12.0), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.3), // Opacidade da sombra
                          spreadRadius: 4, // Spread da sombra
                          blurRadius: 12, // Blur da sombra
                          offset: const Offset(0, 6), // Posição da sombra
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(
                        16.0), // Margem ao redor do Container
                    padding: const EdgeInsets.all(
                        8.0), // Padding interno do Container
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12.0), // Bordas arredondadas
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                              const Color.fromARGB(
                                  255, 254, 2, 2)), // Cor de fundo do cabeçalho
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12, // Tamanho da fonte do cabeçalho
                          ),
                          dataRowColor: WidgetStateProperty.all(Colors.white),
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            top: BorderSide.none,
                            bottom: BorderSide.none,
                            left: BorderSide.none,
                            right: BorderSide.none,
                          ),
                          columnSpacing: 8, // Espaçamento entre as colunas
                          dataRowHeight: 36, // Altura das linhas de dados
                          columns: const [
                            DataColumn(
                              label: SizedBox(
                                width: 100, // Largura fixa para a coluna
                                child: Text('Descrição',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 80, // Largura fixa para a coluna
                                child: Text('ID Patrimônio',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100, // Largura fixa para a coluna
                                child: Text('Localização',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100, // Largura fixa para a coluna
                                child: Text('Responsável',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 80, // Largura fixa para a coluna
                                child: Text('Data',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID123',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 1',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('01/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID124',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 2',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('02/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID125',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 3',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('03/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID126',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 4',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('04/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID127',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 5',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('05/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Descrição do Item 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('ID128',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Localização 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Text('Responsável 6',
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 80,
                                child: Text('06/01/2024',
                                    style: TextStyle(fontSize: 12)),
                              )),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                // Foto de perfil
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/icon2.jpg'),
                ),
                const SizedBox(height: 20),
                // Informações de perfil
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Espaço para ajustar a posição dos textos
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Nome: DAVID',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Sobrenome: MEGA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Email: d',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Botões para alterar informações
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Chama a função que exibe o modal para alterar informações
                          _showAlterSheet(context);
                        },
                        child: const Text(
                          'Alterar Informações',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          _showAlterPasswordSheet(context);
                        },
                        child: const Text(
                          'Alterar Senha',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  void _showRegisterAssetModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permitir fechar ao clicar fora
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white, // Define o fundo do Dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: const RegisterAssetPage(),
        );
      },
    );
  }

  void _showAddLocationModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permitir fechar ao clicar fora
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white, // Define o fundo do Dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: const AddLocationPage(),
        );
      },
    );
  }

  void _showAddResponsibleModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permitir fechar ao clicar fora
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white, // Define o fundo do Dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: const AddResponsiblePage(),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) onTap();
      },
    );
  }
}

class RegisterAssetPage extends StatefulWidget {
  const RegisterAssetPage({super.key});

  @override
  _RegisterAssetPageState createState() => _RegisterAssetPageState();
}

class _RegisterAssetPageState extends State<RegisterAssetPage> {
  final _formKey = GlobalKey<FormState>();

  String _descricao = '';
  String _patrimonio = '';
  String _localizacao = '';
  String _responsavel = '';
  DateTime? _dataCriacao;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(width * 0.04), // Padding responsivo
      child: Container(
        constraints: BoxConstraints(
          maxWidth: width * 0.9, // Limite de largura
          maxHeight: height * 0.6, // Limite de altura
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Registrar",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildInputField(
                        label: 'Descrição',
                        onSaved: (value) => _descricao = value ?? '',
                      ),
                      const SizedBox(height: 16.0),
                      _buildInputField(
                        label: 'Patrimônio',
                        onSaved: (value) => _patrimonio = value ?? '',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      _buildInputField(
                        label: 'Localização',
                        onSaved: (value) => _localizacao = value ?? '',
                      ),
                      const SizedBox(height: 16.0),
                      _buildInputField(
                        label: 'Responsável',
                        onSaved: (value) => _responsavel = value ?? '',
                      ),
                      const SizedBox(height: 16.0),
                      _buildInputField(
                        label: 'Data de Criação',
                        hint: 'dd/mm/aaaa',
                        keyboardType: TextInputType.datetime,
                        onSaved: (value) {
                          if (value != null) {
                            final parts = value.split('/');
                            if (parts.length == 3) {
                              _dataCriacao = DateTime(
                                int.parse(parts[2]),
                                int.parse(parts[1]),
                                int.parse(parts[0]),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            // Handle the form submission logic here
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    String? hint,
    TextInputType? keyboardType,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      style: const TextStyle(fontSize: 16.0),
      onSaved: onSaved,
    );
  }
}

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final _formKey = GlobalKey<FormState>();
  String _localizacao = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.white, // Define o fundo da página
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Adicionar Localização",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(
                    label: 'Localização',
                    onSaved: (value) => _localizacao = value ?? '',
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Handle the form submission logic here
                        // For example, save the _localizacao to a database or pass it to a provider
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      style: const TextStyle(fontSize: 16.0),
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma localização.';
        }
        return null;
      },
    );
  }
}

class AddResponsiblePage extends StatefulWidget {
  const AddResponsiblePage({super.key});

  @override
  _AddResponsiblePageState createState() => _AddResponsiblePageState();
}

class _AddResponsiblePageState extends State<AddResponsiblePage> {
  final _formKey = GlobalKey<FormState>();
  String _responsavel = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.white, // Define o fundo da página
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Adicionar Responsável",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(
                    label: 'Responsável',
                    onSaved: (value) => _responsavel = value ?? '',
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Handle the form submission logic here
                        // For example, save the _responsavel to a database or pass it to a provider
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      style: const TextStyle(fontSize: 16.0),
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o nome do responsável.';
        }
        return null;
      },
    );
  }
}
