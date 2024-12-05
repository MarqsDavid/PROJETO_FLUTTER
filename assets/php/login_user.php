<?php
if (isset($_POST['submit']) && !empty($_POST['email']) && !empty($_POST['passwordUsers'])) {
    // Conexão com o banco de dados
    $conexao = new mysqli('mysql247.umbler.com:41890', 'projects.dmega', 'Goldtanki991', 'dmega02');

    // Verifique a conexão
    if ($conexao->connect_error) {
        die(json_encode(['success' => false, 'message' => 'Erro na conexão']));
    }

    // Obter os valores do formulário
    $email = $conexao->real_escape_string($_POST['email']);
    $passwordUsers = $conexao->real_escape_string($_POST['passwordUsers']);

    // SQL query para verificar as credenciais do usuário
    $sql = "SELECT * FROM users WHERE email = '$email' AND passwordUsers = '$passwordUsers'";
    $result = $conexao->query($sql);

    if ($result->num_rows > 0) {
        // Se o usuário existe
        echo json_encode(['success' => true]);
    } else {
        // Se as credenciais estão incorretas
        echo json_encode(['success' => false]);
    }

    // Fechar conexão
    $conexao->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Dados incompletos']);
}

?>