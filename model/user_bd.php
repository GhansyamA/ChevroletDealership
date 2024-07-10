<?php

function getUser($mail, $password, &$attributes = array())
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT * FROM user WHERE mail = :mail OR phone = :mail AND password = :password";
    $password = sha1($password);
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":mail", $mail);
        $cmd->bindParam(":password", $password);
        $exec = $cmd->execute();
        if ($exec) {
            $attributes = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($attributes) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function addUser($name, $phone, $mail, $password, $gender)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "INSERT INTO user VALUES (DEFAULT, :name, :phone, :mail, :password, :gender, DEFAULT)";
    $password = sha1($password);
    try {
        $cmd = $pdo->prepare($sql);
        $cmd->bindParam(":name", $name);
        $cmd->bindParam(":phone", $phone);
        $cmd->bindParam(":mail", $mail);
        $cmd->bindParam(":password", $password);
        $cmd->bindParam(":gender", $gender);
        return $cmd->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Insert failed : " . $e->getMessage() . "\n");
        die();
    }
}
