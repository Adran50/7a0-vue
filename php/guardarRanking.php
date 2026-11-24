<?php
require_once "cors.php";
require_once "conexion.php";

$datos = json_decode(file_get_contents("php://input"), true);

// Validar datos minimos requeridos (equipo de 1 a 3 integrantes)
if (
    !isset($datos["usuario"], $datos["poder"], $datos["equipo"]) ||
    !is_string($datos["usuario"]) ||
    !is_array($datos["equipo"]) ||
    count($datos["equipo"]) < 1 ||
    count($datos["equipo"]) > 3
) {
    http_response_code(400);
    echo json_encode(["error" => "Datos incompletos"]);
    exit;
}

$usuario = trim($datos["usuario"]);
$poder = (int) $datos["poder"];

if ($usuario === "" || mb_strlen($usuario) > 100) {
    http_response_code(400);
    echo json_encode(["error" => "Nombre de usuario inválido"]);
    exit;
}

try {
    $pdo->beginTransaction();

    // Guardar el registro de ranking
    $stmt = $pdo->prepare(
        "INSERT INTO ranking (usuario, poder) VALUES (?, ?)"
    );
    $stmt->execute([$usuario, $poder]);
    $id = (int) $pdo->lastInsertId();

    // Guardar los integrantes del equipo
    $stmt = $pdo->prepare(
        "INSERT INTO equipo_personajes (fk_ranking, fk_personaje) VALUES (?, ?)"
    );

    foreach ($datos["equipo"] as $idPersonaje) {
        $stmt->execute([$id, (int) $idPersonaje]);
    }

    $pdo->commit();

    echo json_encode([
        "mensaje" => "Ranking guardado correctamente",
        "id" => $id
    ]);

} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    http_response_code(500);
    echo json_encode([
        "error" => "No se pudo guardar el ranking"
    ]);
}
?>
