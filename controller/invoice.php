<?php

function lists()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    showPage();
}
function listall()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    showlistallPage();
}

function partslists()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    showpartsPage();
}

function servicelists()
{
    if (!isset($_SESSION["user"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    showservicePage();
}

function partpay()
{
    if (!isset($_SESSION["user"], $_GET["idpart"], $_GET["idinvoice"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    require_once "./model/invoice_bd.php";
    setPartStatus($_GET["idinvoice"],$_SESSION["user"]["iduser"], $_GET["idpart"], true);
    require_once "./model/vehicle_bd.php";
    showPartsPage("Payment completed successfully");
}
function partcancel()
{
    if (!isset($_SESSION["user"], $_GET["idpart"], $_GET["idinvoice"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    require_once "./model/invoice_bd.php";
    removeBookedPart($_GET["idinvoice"],$_SESSION["user"]["iduser"], $_GET["idpart"]);
    require_once "./model/vehicle_bd.php";
    showPartsPage("Cancellation successfull");
}

function pay()
{
    if (!isset($_SESSION["user"], $_GET["id"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    require_once "./model/invoice_bd.php";
    setStatus($_SESSION["user"]["iduser"], $_GET["id"], true);
    require_once "./model/vehicle_bd.php";
    showPage("Payment completed successfully");
}
function cancel()
{
    if (!isset($_SESSION["user"], $_GET["id"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    require_once "./model/invoice_bd.php";
    removeBooked($_SESSION["user"]["iduser"], $_GET["id"]);
    require_once "./model/vehicle_bd.php";
    setAvailability(NULL, $_GET["id"], "available");
    showPage("Cancellation successfull");
}
function servcancel()
{
    if (!isset($_SESSION["user"], $_GET["id"])) {
        header("Location: index.php?controle=user&action=signin");
    }
    require_once "./model/invoice_bd.php";
    removeService($_SESSION["user"]["iduser"], $_GET["id"]);
    showservicePage("Cancellation successfull");
}

function showservicePage($msg = NULL)
{
    require_once "./model/invoice_bd.php";
    $servinvoices = array();
    getServiceInvoices($_SESSION["user"]["iduser"], $servinvoices);
    require_once "./model/model_bd.php";
    require_once "./model/vehicle_bd.php";
    foreach ($servinvoices as &$servinvoice) {
        getModel($servinvoice["idmodel"], $model);
        $servinvoice["photo"] = $model["photo"];
        $servinvoice["namemodel"] = $model["namemodel"];
    }
    unset($servinvoice);
    $message = NULL;
    if ($msg !== NULL) {
        $message = '<div class="alert alert-success w-100" role="alert" style="margin-top: 16px">' . $msg . '</div>';
    }
    require "./view/invoice/servicelists.tpl";
}


function showPartsPage($msg = NULL)
{
    require_once "./model/invoice_bd.php";
    $partinvoices = array();
    getPartsInvoices($_SESSION["user"]["iduser"], $partinvoices);
    require_once "./model/model_bd.php";
    require_once "./model/vehicle_bd.php";
    foreach ($partinvoices as &$partinvoice) {
        $partId = getPartId($partinvoice["idpart"]);
        getPart($partId, $part);
    }
    unset($partinvoice);
    $message = NULL;
    if ($msg !== NULL) {
        $message = '<div class="alert alert-success w-100" role="alert" style="margin-top: 16px">' . $msg . '</div>';
    }
    require "./view/invoice/partslists.tpl";
}


function showPage($msg = NULL)
{
    require_once "./model/invoice_bd.php";
    $invoices = array();
    getUserInvoices($_SESSION["user"]["iduser"], $invoices);
    require_once "./model/model_bd.php";
    require_once "./model/vehicle_bd.php";
    foreach ($invoices as &$invoice) {
        getModel(getIdModel($invoice["idvehicle"]), $model);
        $invoice["photo"] = $model["photo"];
        $invoice["namemodel"] = $model["namemodel"];
    }
    unset($invoice);
    $message = NULL;
    if ($msg !== NULL) {
        $message = '<div class="alert alert-success w-100" role="alert" style="margin-top: 16px">' . $msg . '</div>';
    }
    require "./view/invoice/lists.tpl";
}

function showlistallPage($msg = NULL)
{
    require_once "./model/invoice_bd.php";
    $allinvoices = array();
    getallUserInvoices($allinvoices);
    require_once "./model/model_bd.php";
    require_once "./model/vehicle_bd.php";
    foreach ($allinvoices as &$allinvoice) {
        getModel(getIdModel($allinvoice["idvehicle"]), $model);
        $allinvoice["photo"] = $model["photo"];
        $allinvoice["namemodel"] = $model["namemodel"];
    }
    unset($allinvoice);
    $message = NULL;
    if ($msg !== NULL) {
        $message = '<div class="alert alert-success w-100" role="alert" style="margin-top: 16px">' . $msg . '</div>';
    }

    require "./view/invoice/listall.tpl";
}