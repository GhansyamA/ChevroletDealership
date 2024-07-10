<!DOCTYPE html>
<html lang="en">

<head>
    <?php include_once "./view/header.tpl" ?>
</head>

<body>
    <?php include_once "./view/navbar.tpl" ?>
    <section class="register-photo">
        <div class="form-container">
            <div class="image-holder"></div>
        <div class="form-container">
            <form action="index.php?controle=invoice&action=pay" method="post">
                <h2 class="text-center"><strong>Payment </strong></h2>
                <div class="mb-3">
                    <select class="form-control" name="method" id="method" required>
                        <option value="" disabled selected>Payment method</option>
                        <option value="Credit">Credit Card</option>
                        <option value="Debit">Debit Card</option>
                        <option value="UPI">UPI</option>
                    </select>
                </div>
                <div class="mb-3">
                    <button class="btn btn-primary d-block w-100" type="submit" style="background: #209cee;">Pay</button>
                </div>
            </form>
        </div>
    </section>
    <?php include_once "./view/footer.tpl" ?>
</body>
</html>