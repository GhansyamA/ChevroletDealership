<?php

function welcome()
{
    require_once "./view/user/welcome.tpl";
}

function dashboard()
{
    require_once "./view/user/dashboard2.tpl";
}

function signin()
{
    $mail = isset($_POST["mail"]) ? $_POST["mail"] : NULL;
    $password = isset($_POST["password"]) ? $_POST["password"] : NULL;
    if (isset($mail, $password)) {
        require_once "./model/user_bd.php";
        if (getUser($mail, $password, $attributes)) {
            $_SESSION["user"] = $attributes[0];
            header("Location: index.php");
        } else {
            $error = "Invalid identifiers";
            require "./view/user/signin.tpl";
        }
    } else {
        $error = NULL;
        require "./view/user/signin.tpl";
    }
}

function signup()
{
    $name = isset($_POST["name"]) ? $_POST["name"] : NULL;
    $gender = isset($_POST["gender"]) ? $_POST["gender"] : NULL;
    $phone = isset($_POST["phone"]) ? $_POST["phone"] : NULL;
    $mail = isset($_POST["mail"]) ? $_POST["mail"] : NULL;
    $password = isset($_POST["password"]) ? $_POST["password"] : NULL;
    if (isset($name, $gender, $phone, $mail, $password)) {
        if (validFields($name, $phone, $mail, $password)) {
            require_once "./model/user_bd.php";
            if (addUser($name, $phone, $mail, $password, $gender)) {
                $_SESSION["user"] = array();
                getUser($mail, $password, $attributes);
                $_SESSION["user"] = $attributes[0];
                header("Location: index.php");
            } else {
                $error = "Registration failed, please try again";
                require "./view/user/signup.tpl";
            }
        } else {
            $error = "Invalid entry, please try again";
            require "./view/user/signup.tpl";
        }
    } else {
        $error = NULL;
        require "./view/user/signup.tpl";
    }
}

function signout()
{
    session_unset();
    require_once "./view/user/signout.tpl";
    header("refresh:3, url=index.php");
}

function validFields($name, $phone, $mail, $password)
{
    return validName($name) && validPhone($phone) && validMail($mail) && validPassword($password);
}

function validName($name)
{
    return preg_match("`^[A-Z][a-zA-Z]{1,50}$`", $name);
}
function validPhone($phone)
{
    return preg_match("/^\d{10}$/", $phone);
}
function validMail($mail)
{
    return filter_var($mail, FILTER_VALIDATE_EMAIL);
}
function validPassword($password)
{
    return preg_match("`(?=.*[0-9])(?=.*[A-Z])([a-zA-Z0-9]){8,16}`", $password);
}
