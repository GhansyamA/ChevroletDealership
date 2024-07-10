<!DOCTYPE html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('select[name="color"]').change(function() {
                var selectedColor = $(this).val();
                var modelPhoto = "<?php echo $model['photo'] ?>";
                $('img.img-fluid').attr('src', './assets/vehicle/img/' + "<?php echo $model['namemodel'] ?>" + '/' + selectedColor + '.jpg');
            });
            $('select[name="method"]').change(function() {
                var selectedMethod = $(this).val();
                if (selectedMethod === "Credit" || selectedMethod === "Debit") {
                    $('#card_number_input').show();
                } else {
                    $('#card_number_input').hide();
                }
            });
        });
    </script>
</head>
<body>
    <?php include_once "./view/navbar.tpl" ?>
    <section class="contact-clean">
        <form method="post" action="index.php?controle=car&action=book&id=<?php echo $_GET["id"] ?>">
            <img class="img-fluid" src="./assets/vehicle/img/<?php echo $model["photo"] ?>" alt="<?php echo $model["photo"] ?>" style="margin-bottom: 0px;">
            <h4 class="text-center" style="margin-top: 8px;"><?php echo htmlspecialchars($model["namemodel"]) ?></h4>
            <p class="text-center">Price : $ <?php echo number_format($model["price"], 0, ',', ' ') ?> </p>
            <?php
            if ($model["price"] >= 50000) {
                printf('<p class="text-center">Booking Amount : $ 7000  </p>');
            } elseif ($model["price"] >= 30000 && $model["price"] < 50000) {
                printf('<p class="text-center">Booking Amount : $ 5000  </p>');
            } else {
                printf('<p class="text-center">Booking Amount : $ 3000  </p>');
            }
            ?>
            <?php echo $message ?>
            <?php
            $pdo = PDO();
            $sql = "SELECT id, varname FROM variants WHERE id= " . $_GET["id"];
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $variants = $stmt->fetchAll(PDO::FETCH_ASSOC);
            ?>
            <div class="mb-3">
                <select class="form-select" required name="variant">
                    <option value="" selected disabled>Variant</option>
                    <?php
                    foreach ($variants as $variant) {
                        printf(
                            '<option value="%s">%s</option>',
                            htmlspecialchars($variant["varname"], ENT_QUOTES, 'UTF-8'),
                            htmlspecialchars($variant["varname"], ENT_QUOTES, 'UTF-8')
                        );
                    }
                    ?>
                </select>
            </div>
            <?php
            $pdo = PDO();
            $sql = "SELECT id, color FROM colors WHERE id= " . $_GET["id"];
            $stmt = $pdo->prepare($sql);
            $stmt->execute();
            $colors = $stmt->fetchAll(PDO::FETCH_ASSOC);
            ?>
            <div class="mb-3">
                <select class="form-select" required name="color">
                    <option value="" selected disabled>Color</option>
                    <?php
                    foreach ($colors as $color) {
                        printf(
                            '<option value="%s">%s</option>',
                            htmlspecialchars($color["color"], ENT_QUOTES, 'UTF-8'),
                            htmlspecialchars($color["color"], ENT_QUOTES, 'UTF-8')
                        );
                    }
                    ?>
                </select>
            </div>
            <div class="mb-3" style="display: none;">
                <input class="form-control" type="date" name="bookdate" id="bookdate" value="<?php echo date('Y-m-d'); ?>" required>
            </div>
            <div class="mb-3">
                <select class="form-select" required name="method">
                    <option value="" selected disabled>Payment Method</option>
                    <option value="Credit">Credit Card</option>
                    <option value="Debit">Debit Card</option>
                    <option value="UPI">UPI</option>
                </select>
            </div>
            <div id="card_number_input" class="mb-3" style="display: none;">
                <input class="form-control" type="text" name="card_number" placeholder="Enter Card Number" required pattern="\d{16}">
            </div>
            <script>
                $(document).ready(function() {
                    $('select[name="color"]').change(function() {
                        var selectedColor = $(this).val();
                        var modelPhoto = "<?php echo $model['photo'] ?>";
                        $('img.img-fluid').attr('src', './assets/vehicle/img/' + "<?php echo $model['namemodel'] ?>" + '/' + selectedColor + '.jpg');
                    });
                    $('select[name="method"]').change(function() {
                        var selectedMethod = $(this).val();
                        if (selectedMethod === "Credit" || selectedMethod === "Debit") {
                            $('#card_number_input').show();
                            $('input[name="card_number"]').prop('disabled', false); // Enable input
                        } else {
                            $('#card_number_input').hide();
                            $('input[name="card_number"]').prop('disabled', true); // Disable input
                        }
                    });
                });
            </script>
            <div class="d-inline-flex justify-content-between align-items-center mb-3" style="width: 100%;">
                <div class="mb-3" style="display: none;">
                    <label class="form-label">Quantity</label>
                    <input class="form-control" type="number" min="1" max="<?php echo $max ?>" placeholder="1" name="quantity" value="1">
                </div>
                <?php
                if ($max > 0) {
                    echo '<button class="btn btn-primary" type="submit" style="margin-top: 0px;width: 150px;">Book</button>';
                } else {
                    echo '<button class="btn btn-secondary" type="submit" style="margin-top: 0px;width: 150px;" disabled>Unavailable</button>';
                }
                ?>
            </div>
            <p class="text-center"><a href="index.php?controle=car&action=lists">Return to model list</a></p>
        </form>
    </section>
    <?php include_once "./view/footer.tpl" ?>
</body>
</html>
