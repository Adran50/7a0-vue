<?php
require_once "cors.php";
require_once "conexion.php";

try {
    $sql = "SELECT
                r.id,
                r.usuario,
                r.poder,
                r.fecha,
                p.id AS personaje_id,
                p.nombre,
                p.img
            FROM ranking r
            LEFT JOIN equipo_personajes ep ON ep.fk_ranking = r.id
            LEFT JOIN personaje p ON p.id = ep.fk_personaje
            ORDER BY r.poder DESC, r.fecha DESC, r.id DESC, p.id";

    $filas = $pdo->query($sql)->fetchAll();

    // Agrupar los personajes de cada ranking en un arreglo "equipo"
    $ranking = [];

    foreach ($filas as $fila) {
        $id = $fila["id"];

        if (!isset($ranking[$id])) {
            $ranking[$id] = [
                "id" => $id,
                "usuario" => $fila["usuario"],
                "poder" => $fila["poder"],
                "fecha" => $fila["fecha"],
                "equipo" => []
            ];
        }

        if ($fila["personaje_id"] !== null) {
            $ranking[$id]["equipo"][] = [
                "id" => $fila["personaje_id"],
                "nombre" => $fila["nombre"],
                "img" => $fila["img"]
            ];
        }
    }

    echo json_encode(array_values($ranking));

} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode(["error" => "No se pudo obtener el ranking"]);
}
?>