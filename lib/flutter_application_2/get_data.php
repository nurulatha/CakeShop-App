<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "flutter_application_2";

// Buat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Cek koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Ambil data dari database
$sql = "SELECT * FROM customers";
$result = $conn->query($sql);

$orders = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $orders[] = $row;
    }
}

// Kembalikan data sebagai JSON
echo json_encode($orders);

// Tutup koneksi
$conn->close();
