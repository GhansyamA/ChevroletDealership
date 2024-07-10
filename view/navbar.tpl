<nav class="navbar navbar-light navbar-expand-md navigation-clean-button sticky-top" style="background-color: white">
    <div class="container">
        <a class="navbar-brand" href="index.php">Chevrolet</a>
        <button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-1"><span class="visually-hidden">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navcol-1">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="index.php?controle=car&action=lists">Our vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?#services">Service</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?#parts">Parts</a></li>
                <?php
                if (isset($_SESSION["user"])) {
                    echo '<li class="nav-item"><a href="index.php?controle=user&action=dashboard" class="nav-link">My Purchases & Services</a></li>';
                }
                if (isset($_SESSION["user"]) && $_SESSION["user"]["role"] === "admin") {
                    echo '<li class="nav-item"><a href="index.php?controle=admin&action=dashboard" class="nav-link">Admin Dashboard</a></li>';
                }
                ?>
            </ul>
            <?php
            if (isset($_SESSION["user"])) {
                if ($_SESSION["user"]["iduser"] == 1){
                    echo '<span class="navbar-text actions" style="display: flex; align-items: center;">
                        <img src="./assets/img/gh.jpg" alt="Image" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;">
                        <a class="login" href="index.php?controle=user&action=signout">Sign out</a></span>';
                }
                else if ($_SESSION["user"]["iduser"] == 2){
                    echo '<span class="navbar-text actions" style="display: flex; align-items: center;">
                        <img src="./assets/img/mn.jpg" alt="Image" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;">
                        <a class="login" href="index.php?controle=user&action=signout">Sign out</a></span>';
                }
                else{
                    echo '<span class="navbar-text actions"><a class="login" href="index.php?controle=user&action=signout">Sign out</a></span>';
                }
            }else {
                echo '<span class="navbar-text actions"><a class="login" href="index.php?controle=user&action=signin">Sign in</a><a class="btn btn-light action-button" role="button" href="index.php?controle=user&action=signup" style="background: #209cee;">Sign up</a></span>';
            }
            ?>
        </div>
    </div>
</nav>
