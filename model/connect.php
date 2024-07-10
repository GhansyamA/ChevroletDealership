<?php

function PDO()
{
    $hostname = "localhost";
    $dbname = "Chev_db";
    $user = "root";
    $pass = "";
    try {
        return new PDO("mysql:server=$hostname; dbname=$dbname", $user, $pass);
    } catch (PDOException $e) {
        die("Connection Failure : " . utf8_encode($e->getMessage()) . "\n");
    }
}
