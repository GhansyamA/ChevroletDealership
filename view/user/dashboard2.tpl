<!doctype html>
<html lang="en">

<head>
    <?php include_once "./view/header.tpl" ?>
    <style>
        nav {
            position: fixed !important;
            top: 0 !important;
            width: 100% !important;
        }
    </style>
</head>

<body style="background: white">

    <?php include_once "./view/navbar.tpl" ?>

    <div class="d-flex flex-column justify-content-center align-items-center" style="height: 100vh;width: 100vw;">
        <div class="container pb-2">
            <?php
                if ($_SESSION["user"]["gender"] == "Male"):
                    printf('<h1 class="display-6 text-center d-xl-flex justify-content-xl-center align-items-xl-center" style="margin-bottom: 16px;">
                        Welcome, Mr. %s</h1>', $_SESSION["user"]["name"]);
                elseif ($_SESSION["user"]["gender"] == "Female"):
                    printf('<h1 class="display-6 text-center d-xl-flex justify-content-xl-center align-items-xl-center" style="margin-bottom: 16px;">
                        Welcome, Ms. %s</h1>', $_SESSION["user"]["name"]);
                endif;
            ?>
        </div>
        <div>
            <ul class="list-group">
                <li class="list-group-item d-xl-flex justify-content-xl-center align-items-xl-center" style="text-align: center;"><a class="link-unstyled" href="index.php?controle=invoice&action=lists">My Bookings</a></li>
                <li class="list-group-item d-xl-flex justify-content-xl-center align-items-xl-center" style="text-align: center;"><a class="link-unstyled" href="index.php?controle=invoice&action=servicelists">My Services</a></li>
                <li class="list-group-item d-xl-flex justify-content-xl-center align-items-xl-center" style="text-align: center;"><a class="link-unstyled" href="index.php?controle=invoice&action=partslists">My Orders</a></li>
            </ul>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>