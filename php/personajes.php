<?php

require_once 'cors.php';
require_once 'conexion.php';

$sql = "
    SELECT 
        p.id,
        p.nombre,
        p.poder,
        p.img,
        t.nombre AS tipo,
        u.nombre AS universo
    FROM personaje p
    JOIN tipo t ON t.id = p.tipo_id
    JOIN universo u ON u.id = p.universo_id
";

$stmt = $pdo->query($sql);

echo json_encode($stmt->fetchAll());