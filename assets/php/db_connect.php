<?php
$servername = "mysql247.umbler.com:41890";  // ou o IP do servidor MySQL
$username = "projects.dmega";
$password = "Goldtanki991";
$dbname = "dmega02";

// Cria conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}
echo "Conexão bem-sucedida";
?>
