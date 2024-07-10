<!DOCTYPE html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
</head>
<body>
<?php include_once "./view/navbar.tpl" ?>
<section class="contact-clean">
    <form method="post" action="index.php?controle=car&action=parts&idpart=<?php echo $_GET["idpart"]?>">
        <input type="hidden" name="partname" value="<?php echo htmlspecialchars($part["partname"])?>">
        <img class="img-fluid" src="./assets/vehicle/img/<?php echo $part["photo"] ?>" alt="<?php echo $part["photo"] ?>" style="margin-bottom: 0px;">
        <h4 class="text-center" style="margin-top: 8px;"><?php echo htmlspecialchars($part["partname"]) ?></h4>
        <p class="text-center">$ <?php echo number_format($part["price"], 0, ',', ' ') ?> </p>
        <?php echo $message ?>
        <div class="d-inline-flex justify-content-between align-items-center mb-3" style="width: 100%;">
            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input class="form-control" type="number" min="1" placeholder="" name="quantity" value="1" >
            </div>
            <?php
                echo '<button class="btn btn-primary" type="submit" style="margin-top: 0px;width: 150px;">Order part</button>';
            ?>
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
        <p class="text-center"><a href="index.php?controle=car&action=listparts">Return to parts list</a></p>
    </form>
</section>
<?php include_once "./view/footer.tpl" ?>
</body>
</html>