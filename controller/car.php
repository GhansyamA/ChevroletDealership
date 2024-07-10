<?php

function lists()
{
    require_once "./model/model_bd.php";
    getModels($models);
    foreach ($models as $index =>  $model) {
        $path = "./assets/vehicle/json/" . $model["features"];
        $c_string = file_get_contents($path);
        $models[$index]["features"] = json_decode($c_string, true);
    }
    require_once "./view/car/lists.tpl";
}

function servicelists(){
    require_once "./model/model_bd.php";
    getModels($models);
    foreach ($models as $index =>  $model) {
        $path = "./assets/vehicle/json/" . $model["features"];
        $c_string = file_get_contents($path);
        $models[$index]["features"] = json_decode($c_string, true);
    }
    require_once "./view/car/listservice.tpl";
}

function listparts(){
    require_once "./model/model_bd.php";
    getParts($parts);
    require_once "./view/car/listparts.tpl";
}

function parts()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    if (!isset($_GET["idpart"])) {
        header("Location: index.php?controle=car&action=listparts");
    }
    else if (isset($_POST["quantity"],$_POST["method"])) {
        require_once "./model/model_bd.php";
        require_once "./model/invoice_bd.php";
        $iduser = $_SESSION["user"]["iduser"];
        require_once "./model/vehicle_bd.php";
        $amount =(int) $_POST["quantity"]*(int) getPartsPrice($_GET["idpart"]);
        addPartsInvoice($iduser, $_GET["idpart"], $_POST["quantity"], $amount, $_POST["bookdate"], $_POST["method"]);
        showPartsPage("Booking successful", true);
    } 
    else {
        showPartsPage(NULL);
    }
}

function service()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    if (!isset($_GET["id"])) {
        header("Location: index.php?controle=car&action=servicelists");
    }
    else if (isset($_POST["regnum"],$_POST["servtype"],$_POST["servdate"], $_POST["servtime"], $_POST["quantity"])) {
        if (validRegNum($_POST["regnum"])) {
            $regnum = strtoupper($_POST["regnum"]);
            require_once "./model/model_bd.php";
            require_once "./model/invoice_bd.php";
            $iduser = $_SESSION["user"]["iduser"];
            require_once "./model/vehicle_bd.php";
            addServiceInvoice($iduser, $_POST["idmodel"],$regnum,$_POST["servtype"], $_POST["servdate"], $_POST["servtime"]);
            showServicePage("Service booked successfully", true);
        }
        else{
            showServicePage("Invalid Registration number, please try again",false);
        }
    }
    else {
        showServicePage(NULL);
    }
}

function book()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    if (!isset($_GET["id"])) {
        header("Location: index.php?controle=car&action=lists");
    }
    else if (isset($_POST["variant"],$_POST["color"], $_POST["method"], $_POST["bookdate"], $_POST["quantity"])) {
        if ($_POST["variant"] === "") {
            showPage("Select Variant");
            return;
        }
        if ($_POST["color"] === "") {
            showPage("Select Color");
            return;
        }
        if ($_POST["method"] === "") {
            showPage("Select Payment method");
            return;
        }
        require_once "./model/model_bd.php";
        $ids = getVehicleId($_GET["id"]);
        $idvehiclesmodel = array();
        for ($i = 0; $i < (int) $_POST["quantity"]; ++$i) {
            $idvehiclesmodel[] = $ids[$i]["idstock"];
        }
        require_once "./model/invoice_bd.php";
        $iduser = $_SESSION["user"]["iduser"];
        require_once "./model/vehicle_bd.php";
        foreach ($idvehiclesmodel as $idvehicle) {
            setAvailability($iduser, $idvehicle, "Booked");
            $amount = (int) getPrice($_GET["id"]);
            addInvoice($iduser, $idvehicle, $_POST["variant"], $_POST["color"], $amount, $_POST["bookdate"], $_POST["method"]);
        }
        showPage("Booking successful", true);
    } 
    else {
        showPage(NULL);
    }
}

function showPage($msg, $succes = false) 
{
    require_once "./model/model_bd.php";
    getModel($_GET["id"], $model);
    $max = maxAvailable($_GET["id"]);
    if ($succes) {
        $message = '<div class="alert alert-success" role="alert">' . $msg . '</div>';
        header("Location: index.php?controle=invoice&action=lists");
    } else {
        $message = '<div class="alert alert-danger" role="alert">' . $msg . '</div>';
    }
    if ($msg === NULL) {
        $message = NULL;
    }
    require "./view/car/book.tpl";
}

function showServicePage($msg, $succes = false)
{
    require_once "./model/model_bd.php";
    getModel($_GET["id"], $model);
    $max = maxAvailable($_GET["id"]);
    if ($succes) {
        $message = '<div class="alert alert-success" role="alert">' . $msg . '</div>';
    } else {
        $message = '<div class="alert alert-danger" role="alert">' . $msg . '</div>';
    }
    if ($msg === NULL) {
        $message = NULL;
    }
    require "./view/car/service.tpl";
}

function showPartsPage($msg, $succes = false)
{
    require_once "./model/model_bd.php";
    getPart($_GET["idpart"], $part);
    
    if ($succes) {
        $message = '<div class="alert alert-success" role="alert">' . $msg . '</div>';
    } else {
        $message = '<div class="alert alert-danger" role="alert">' . $msg . '</div>';
    }

    if ($msg === NULL) {
        $message = NULL;
    }
    require "./view/car/parts.tpl";
}
function validRegNum($regnum)
{
    return preg_match("/^[A-Za-z]{3}[0-9]{3,4}$|^[A-Za-z]{2}\d{2}[A-Za-z]{2}\d{4}$/", $regnum);
}
