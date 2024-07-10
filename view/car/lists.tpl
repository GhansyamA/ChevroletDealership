<!DOCTYPE html>
<html lang="en">

<head>
    <?php include_once "./view/header.tpl" ?>
</head>

<body>

<?php include_once "./view/navbar.tpl" ?>

<div class="container">
    <h1>Our vehicles</h1>
    <section class="article-list">
        <div class="container">
            <?php
            require_once "./model/vehicle_bd.php";

            $nb = 1;
            echo '<div class="row row-cols-3 justify-content-center articles">';
            foreach ($models as $model) {
                echo '<div class="col-sm-6 col-md-4 item" style="width: 325px">';
                echo '<div class="pb-3" style="background-color: #fffafa">';

                $photo = $model["photo"];
                printf('<img class="img-fluid" style="height: 200px; width: 300px;" src="./assets/vehicle/img/%s" alt="%s">', $photo, $photo);

                $name = $model["namemodel"];
                printf('<h3 class="name">%s</h3>', htmlspecialchars($name));

                $cars = $model["features"];
                echo '<ul class="list-unstyled text-start description">';

                printf('<li>Engine : %s</li>', htmlspecialchars($cars["Engine"]));
                printf('<li>Transmission : %s</li>', htmlspecialchars($cars["Transmission"]));
                printf('<li>Fuel : %s</li>', htmlspecialchars($cars["Fuel"]));
                printf('<li>Seats : %s</li>', htmlspecialchars($cars["nbPlaces"]));

                echo '</ul>';

                printf('<p class="text-dark fw-bolder text-center description">Price : $ %s </p>',
                    number_format($model["price"], 0, ',', ' '));
                $max = maxAvailable($model["idmodel"]);
                if ($max > 0) {
                    printf('<a class="btn btn-primary btn-sm mt-3 fw-bold" type="button" role="button"
                           href="index.php?controle=car&action=book&id=%s" style="width: 200px;">Book Now</a>',
                        $model["idmodel"]);
                } else {
                    printf('
                    <button class="btn btn-secondary btn-sm mt-3 fw-bold" type="button" role="button"
                            style="width: 200px;" disabled>OUT OF STOCK
                    </button>
                    ');
                }
                echo '</div></div>';

                if ($nb === 3) {
                    $nb = 0;
                    echo '</div><div class="row row-cols-3 justify-content-center articles">';
                }
                ++$nb;
            }
            echo '</div>';
            ?>
        </div>
    </section>
</div>

<?php include_once "./view/footer.tpl" ?>

</body>

</html>