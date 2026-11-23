<?php

require_once 'cors.php';
require_once 'conexion.php';

$sql = "SELECT * FROM personaje ORDER BY RAND() LIMIT 6";
$stmt = $pdo->query($sql);
$personajes = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Dividimos el arreglo en dos partes de 3 personajes cada una
$equipo = [
    "lista" => array_slice($personajes, 0, 3),
    "rival" => array_slice($personajes, 3, 3)
];

echo json_encode($equipo);