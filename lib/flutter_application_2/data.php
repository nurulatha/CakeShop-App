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

// Ambil data dari permintaan POST
$name = $_POST['name'];
$phone_number = $_POST['phone_number'];
$address = $_POST['address'];
$item_name = $_POST['item_name'];
$item_price = isset($_POST['item_price']) ? floatval($_POST['item_price']) : 0.0;

// Siapkan statement SQL menggunakan prepared statement untuk mencegah SQL Injection
$stmt = $conn->prepare("INSERT INTO customers (name, phone_number, address, item_name, item_price) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("ssssd", $name, $phone_number, $address, $item_name, $item_price);

// Eksekusi statement
if ($stmt->execute()) {
    echo "New record created successfully";
} else {
    echo "Error: " . $stmt->error;
}

// Tutup statement dan koneksi
$stmt->close();
$conn->close();
?>
