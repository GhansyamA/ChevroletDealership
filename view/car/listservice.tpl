<!DOCTYPE html>
<html lang="en">

<head>
    <?php include_once "./view/header.tpl" ?>
</head>

<body>

<?php include_once "./view/navbar.tpl" ?>

<div class="container">
    <h1>Select your model</h1>
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

                echo '</ul>';

                printf('<a class="btn btn-primary btn-sm mt-3 fw-bold" type="button" role="button"
                        href="index.php?controle=car&action=service&id=%s" style="width: 200px;">Select</a>',
                        $model["idmodel"]);
                
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