<?php

const NB_CHAMPS = 7; // The photo does not go into $_POST
const MAX_PLACES = 7;

function dashboard()
{
    require_once "./view/admin/dashboard.tpl";
}

function model()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    if ($_SESSION["user"]["role"] !== "admin") {
        header("Location: index.php");
    }

    if (count($_POST) === NB_CHAMPS) {
        if (!valid($_POST["nbPlaces"], $_POST["price"], $_POST["quantity"])) {
            showPage("Invalid entry, please start again", "model", false);
        }
        $Filename = str_replace(" ", "", ucwords($_POST["namemodel"]));
        $Imagefile = ""; #Imagefile
        if ($_FILES["photo"]["name"] !== "") {
            $info = pathinfo($_FILES["photo"]["name"]);
            $Imagefile = $Filename . "." . $info["extension"];

            if (!file_exists("assets/vehicle/img/" . $Imagefile)) {
                move_uploaded_file($_FILES["photo"]["tmp_name"], "assets/vehicle/img/" . $Imagefile);
            }
        }
        $data = array(
            "Engine" => $_POST["Engine"],
            "Transmission" => $_POST["Transmission"],
            "Fuel" => $_POST["Fuel"],
            "nbPlaces" => (int) $_POST["nbPlaces"]
        );
        $json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
        $fichierJSON = $Filename . ".json";
        file_put_contents("assets/vehicle/json/" . $fichierJSON, $json);
        require_once "./model/model_bd.php";
        $idmodel = insertModel($_POST["namemodel"], $fichierJSON, $Imagefile, $_POST["price"]);
        require_once "./model/vehicle_bd.php";
        for ($i = 0; $i < (int) $_POST["quantity"]; ++$i) {
            insertVehicle($idmodel);
        }
        showPage("New model added", "model", true);
    } else {
        showPage(NULL, "model");
    }
}

function stock()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    if ($_SESSION["user"]["role"] !== "admin") {
        header("Location: index.php");
    }
    if (isset($_POST["idmodel"], $_POST["quantity"])) {
        if ($_POST["idmodel"] === "0") {
            showPage("Please select a model", "stock", false);
        }
        require_once "./model/model_bd.php";
        $dispos = (int) maxAvailable($_POST["idmodel"]);
        $choix = (int) $_POST["quantity"];
        $nbChangements = abs($choix - $dispos);
        require_once "./model/vehicle_bd.php";

        if ($choix === $dispos) {
            showPage("Please enter the new stock quantity", "stock", false);
        } // Add vehicles
        else if ($choix > $dispos) {
            for ($i = 0; $i < $nbChangements; ++$i) {
                insertVehicle($_POST["idmodel"]);
            }
            showPage($nbChangements . " additions completed successfully", "stock", true);
        }
        else {
            for ($i = 0; $i < $nbChangements; ++$i) {
                removeAvailableVehicle($_POST["idmodel"]);
            }
            showPage($nbChangements . " withdrawals completed successfully", "stock", true);
        }
    }
    showPage(NULL, "stock");
}

function valid($nbPlaces, $price, $quantity)
{
    return is_numeric($nbPlaces) && $nbPlaces > 0 && $nbPlaces <= MAX_PLACES && is_numeric($price) &&
        is_numeric($quantity) && $quantity >= 0;
}

function showPage($msg, $controle, $succes = false)
{
    if ($succes) {
        $message = '<div class="alert alert-success" role="alert">' . $msg . '</div>';
    } else {
        $message = '<div class="alert alert-danger" role="alert">' . $msg . '</div>';
    }
    if ($msg === NULL) {
        $message = NULL;
    }
    if ($controle === "stock") {
        require_once "./model/model_bd.php";
        getModels($models);
        $qt = 0;
        if (isset($_GET["id"]) && !isset($_POST["quantity"])) {
            require_once "./model/model_bd.php";
            $qt = maxAvailable($_GET["id"]);
        }
    }
    require_once "./view/admin/$controle.tpl";
}
