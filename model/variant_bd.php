<?php

function getVariantId($id)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "SELECT id FROM variant WHERE id = :id";

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":id", $id);
        $exec = $cmd->execute();

        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC)[0]["idmodel"];
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}