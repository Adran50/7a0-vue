<?php
require_once 'cors.php';
require_once 'conexion.php';

// Cantidad de personajes segun el modo (por defecto 3)
$cantidad = isset($_GET['cantidad']) ? (int)$_GET['cantidad'] : 3;
if ($cantidad < 1) $cantidad = 1;
if ($cantidad > 3) $cantidad = 3;

// Se sortean 3 opciones para el jugador + N para el rival
$limite = 3 + $cantidad;

$sql = "SELECT p.id, p.nombre, p.img, p.poder, t.nombre AS tipo, u.nombre AS universo
        FROM personaje p
        LEFT JOIN tipo t ON t.id = p.tipo_id
        LEFT JOIN universo u ON u.id = p.universo_id
        ORDER BY RAND() LIMIT :limite";

$stmt = $pdo->prepare($sql);
$stmt->bindValue(':limite', $limite, PDO::PARAM_INT);
$stmt->execute();
$personajes = $stmt->fetchAll(PDO::FETCH_ASSOC);

$equipo = [
    "lista" => array_slice($personajes, 0, 3),
    "rival" => array_slice($personajes, 3, $cantidad)
];

echo json_encode($equipo);
?>
