<?php

function getCompanies(&$companies)
{
    require_once "./model/connect.php";
    $pdo = PDO();

    $sql = "SELECT * FROM company";

    try {
        $cmd = $pdo->prepare($sql);
        $exec = $cmd->execute();

        if ($exec) {
            $companies = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($companies) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}

function getCustomers(&$customers)
{
    require_once "./model/connect.php";
    $pdo = PDO();
    $sql = "SELECT * FROM user";
    try {
        $cmd = $pdo->prepare($sql);
        $exec = $cmd->execute();
        if ($exec) {
            $customers = $cmd->fetchAll(PDO::FETCH_ASSOC);
            return count($users) > 0;
        }
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Failed to select : " . $e->getMessage() . "\n");
        die();
    }
}
