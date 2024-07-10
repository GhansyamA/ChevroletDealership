<!DOCTYPE html>
<html lang="en">

<head>
    <?php include_once "./view/header.tpl" ?>
</head>

<body>

<?php include_once "./view/navbar.tpl" ?>

<div class="container">
    <h1>Select part</h1>
    <section class="article-list">
        <div class="container">
            <?php
            require_once "./model/vehicle_bd.php";
            $nb = 1;
            echo '<div class="row row-cols-3 justify-content-center articles">';
            foreach ($parts as $part) {
                echo '<div class="col-sm-6 col-md-4 item" style="width: 325px">';
                echo '<div class="pb-3" style="background-color: #fffafa">';
                $photo = $part["photo"];
                printf('<img class="img-fluid" style="height: 200px; width: 300px;" src="./assets/vehicle/img/%s" alt="%s">', $photo, $photo);
                $name = $part["partname"];
                printf('<h3 class="name">%s</h3>', htmlspecialchars($name));
                echo '</ul>';
                printf('<p class="text-dark fw-bolder text-center description">Price : $ %s </p>',
                    number_format($part["price"], 0, ',', ' '));
                printf('<a class="btn btn-primary btn-sm mt-3 fw-bold" type="button" role="button"
                        href="index.php?controle=car&action=parts&idpart=%s" style="width: 200px;">Select</a>',
                        $part["idpart"]);
                echo '</div></div>';
            }
            echo '</div>';
            ?>
        </div>
    </section>
</div>

<?php include_once "./view/footer.tpl" ?>

</body>

</html>