<?php
require_once 'cors.php';

$datos = json_decode(file_get_contents("php://input"), true);

$poderJugador = isset($datos["poderJugador"]) ? (int)$datos["poderJugador"] : 0;
$poderRival = isset($datos["poderRival"]) ? (int)$datos["poderRival"] : 0;

$total = $poderJugador + $poderRival;
$chanceJugador = $total > 0 ? ($poderJugador / $total) : 0.5;

// Tirada aleatoria entre 0 y 1
$tirada = mt_rand(1, 10000) / 10000;

if ($poderJugador === $poderRival && $tirada >= 0.48 && $tirada <= 0.52) {
    $resultado = "empate";
} elseif ($tirada <= $chanceJugador) {
    $resultado = "victoria";
} else {
    $resultado = "derrota";
}

echo json_encode([
    "resultado" => $resultado,
    "probabilidad" => round($chanceJugador * 100, 1),
    "poderJugador" => $poderJugador,
    "poderRival" => $poderRival
]);
?>
