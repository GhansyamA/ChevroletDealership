<?php

function getModels(&$models = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "SELECT * FROM model";

    try {
        $cmd = $pdo->prepare($sql);
        $exec = $cmd->execute();

        if ($exec) {
            $models = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($models) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getParts(&$parts = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "SELECT * FROM part";

    try {
        $cmd = $pdo->prepare($sql);
        $exec = $cmd->execute();

        if ($exec) {
            $parts = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($parts) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getPart($idpart, &$part = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT * FROM part WHERE idpart = :idpart";

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":idpart", $idpart, PDO::PARAM_INT);

        $exec = $cmd->execute();

        if ($exec) {
            $part = $cmd->fetchAll(PDO::FETCH_ASSOC)[0];
            return count($part) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getModel($idmodel, &$model = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT * FROM model WHERE idmodel = :idmodel";

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idmodel", $idmodel);
        $exec = $cmd->execute();
        if ($exec) {
            $model = $cmd->fetchAll(PDO::FETCH_ASSOC)[0];
            return count($model) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function maxAvailable($idmodel)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = 'SELECT COUNT(idstock) AS max FROM stock WHERE idmodel = :idmodel AND status = "available"';

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idmodel", $idmodel);
        $exec = $cmd->execute();

        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC)[0]["max"];
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}


function getVehicleId($idmodel)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT idstock FROM stock WHERE idmodel = :idmodel AND status = "available"';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idmodel", $idmodel);
        $exec = $cmd->execute();
        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getPartName($idpart)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT partname FROM part WHERE idpart = :idpart';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":idpart", $idpart);
        $exec = $cmd->execute();
        if ($exec) {
            return $cmd->fetch(PDO::FETCH_ASSOC);
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getPartId($idpart)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT idpart FROM part WHERE idpart = :idpart';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":idpart", $idpart);
        $exec = $cmd->execute();
        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC);
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getPrice($idmodel)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT price FROM model WHERE idmodel = :idmodel";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":idmodel", $idmodel, PDO::PARAM_INT);
        $exec = $cmd->execute();
        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC)[0]["price"];
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getPartsPrice($idpart)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT price FROM part WHERE idpart = :idpart";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":idpart", $idpart);
        $exec = $cmd->execute();
        if ($exec) {
            return $cmd->fetchAll(PDO::FETCH_ASSOC)[0]["price"];
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function insertModel($namemodel, $features, $photo, $price)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "INSERT INTO model VALUES (DEFAULT, :namemodel, :features, :photo, :price)";

    $price = (int) $price;

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":namemodel", $namemodel);
        $cmd->bindParam(":features", $features);
        $cmd->bindParam(":photo", $photo);
        $cmd->bindParam(":price", $price);

        $exec = $cmd->execute();
        if ($exec) {
            return $pdo->lastInsertId();
        }
        return NULL;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to insert : " . $e->getMessage() . "\n");
        die();
    }
}
