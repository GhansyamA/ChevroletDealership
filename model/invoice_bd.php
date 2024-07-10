<?php

function addInvoice($iduser, $idvehicle, $variant, $color, $amount, $bookdate, $method)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "INSERT INTO invoice VALUES (DEFAULT, :iduser, :idvehicle, :variant, :color, :amount, :bookdate, :method, false)";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idvehicle", $idvehicle);
        $cmd->bindParam(":variant", $variant);
        $cmd->bindParam(":color", $color);
        $cmd->bindParam(":amount", $amount);
        $cmd->bindParam(":bookdate", $bookdate);
        $cmd->bindParam(":method", $method);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Insert failed : " . $e->getMessage() . "\n");
        die();
    }
}

function addPartsInvoice($iduser, $idpart, $quantity, $amount, $bookdate, $method)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $partname = getPartName($idpart)['partname'];
    $sql = "INSERT INTO partinvoice VALUES (DEFAULT, :iduser, :idpart, :partname, :quantity, :amount, :bookdate, :method, false)";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":iduser", $iduser); 
        $cmd->bindParam(":idpart", $idpart);
        $cmd->bindParam(":partname", $partname);
        $cmd->bindParam(":quantity", $quantity);
        $cmd->bindParam(":amount", $amount);
        $cmd->bindParam(":bookdate", $bookdate);
        $cmd->bindParam(":method", $method);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Insert failed : " . $e->getMessage() . "\n");
        die();
    }
}


function addServiceInvoice($iduser, $idmodel, $regnum,$servtype, $servdate, $servtime)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "INSERT INTO serviceinvoice VALUES (DEFAULT, :iduser, :idmodel, :regnum, :servtype, :servdate, :servtime)";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idmodel", $idmodel);
        $cmd->bindParam(":regnum", $regnum);
        $cmd->bindParam(":servtype", $servtype);
        $cmd->bindParam(":servdate", $servdate);
        $cmd->bindParam(":servtime", $servtime);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Insert failed : " . $e->getMessage() . "\n");
        die();
    }
}

function getPartsInvoices($iduser, &$partinvoices = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT * FROM partinvoice WHERE iduser = :iduser';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":iduser", $iduser);
        $exec = $cmd->execute();
        if ($exec) {
            $partinvoices = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($partinvoices) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getServiceInvoices($iduser, &$servinvoices = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT * FROM serviceinvoice WHERE iduser = :iduser';
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);
        $exec = $cmd->execute();
        if ($exec) {
            $servinvoices = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($servinvoices) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getUserInvoices($iduser, &$invoices = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = 'SELECT * FROM invoice WHERE iduser = :iduser ';

    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);

        $exec = $cmd->execute();
        if ($exec) {
            $invoices = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($invoices) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getallUserInvoices(&$allinvoices = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = 'SELECT invoice.*, user.name AS username 
            FROM invoice 
            INNER JOIN user ON invoice.iduser = user.iduser';
    try {
        $cmd = $pdo->prepare($sql);
        $exec = $cmd->execute();
        if ($exec) {
            $allinvoices = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($allinvoices) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function setStatus($iduser, $idvehicle, $paystatus)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "UPDATE invoice 
            SET paystatus = :paystatus 
            WHERE iduser = :iduser 
            AND idvehicle = :idvehicle 
            AND paystatus = 0";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":paystatus", $paystatus);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idvehicle", $idvehicle);

        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to update : " . $e->getMessage() . "\n");
        die();
    }
}

function removeBooked($iduser, $idvehicle)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "DELETE 
            from invoice
            WHERE iduser = :iduser
            AND idvehicle = :idvehicle";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idvehicle", $idvehicle);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to update : " . $e->getMessage() . "\n");
        die();
    }
}
function removeService($iduser, $idinvoice)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "DELETE 
            from serviceinvoice
            WHERE iduser = :iduser
            AND idinvoice = :idinvoice";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":iduser", $iduser);
        $cmd->bindParam(":idinvoice", $idinvoice);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to update : " . $e->getMessage() . "\n");
        die();
    }
}

function setPartStatus($idinvoice, $iduser, $idpart, $paystatus)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "UPDATE partinvoice 
            SET paystatus = :paystatus 
            WHERE iduser = :iduser 
            AND idinvoice = :idinvoice
            AND idpart = :idpart 
            AND paystatus = 0";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":paystatus", $paystatus);
        $cmd->bindValue(":iduser", $iduser, PDO::PARAM_INT);
        $cmd->bindValue(":idpart", $idpart, PDO::PARAM_INT);
        $cmd->bindParam(":idinvoice", $idinvoice);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to update : " . $e->getMessage() . "\n");
        die();
    }
}
function removeBookedPart($idinvoice, $iduser, $idpart)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "DELETE from partinvoice  
            WHERE iduser = :iduser 
            AND idinvoice = :idinvoice
            AND idpart = :idpart";
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindValue(":iduser", $iduser, PDO::PARAM_INT);
        $cmd->bindValue(":idpart", $idpart, PDO::PARAM_INT);
        $cmd->bindParam(":idinvoice", $idinvoice);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Failed to update : " . $e->getMessage() . "\n");
        die();
    }
}