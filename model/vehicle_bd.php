<?php

function setAvailability($iduser, $idvehicle, $status)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'UPDATE stock
            SET status = :status, iduser = :iduser
            WHERE idstock = :idvehicle';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":status", $status);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idvehicle", $idvehicle);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getIdModel($idvehicle)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "SELECT idmodel FROM stock WHERE idstock = :idvehicle";

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idvehicle", $idvehicle);
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

function insertVehicle($idmodel, $status = "available", $iduser = NULL)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "INSERT INTO stock VALUES (DEFAULT, :idmodel, :status, :iduser)";

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idmodel", $idmodel);
        $cmd->bindParam(":status", $status);
        $cmd->bindParam(":iduser", $iduser);

        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to insert : " . $e->getMessage() . "\n");
        die();
    }
}

function removeAvailableVehicle($idmodel)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    // Une suppression par appel
    $sql = 'DELETE FROM stock WHERE idmodel = :idmodel AND status = "available" AND iduser IS NULL LIMIT 1';

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idmodel", $idmodel);

        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to insert : " . $e->getMessage() . "\n");
        die();
    }
}
