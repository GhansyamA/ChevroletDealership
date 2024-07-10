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

        .form-control {
            height: 38px !important;
        }
    </style>
</head>

<body>

    <?php include_once "./view/navbar.tpl" ?>

    <section class="contact-clean d-flex flex-column justify-content-center align-items-center" style="height: 100vh;width: 100vw;">
        <form method="post" action="index.php?controle=admin&action=model" enctype="multipart/form-data">
            <h2 class="text-center">Add a car model</h2>
            <?php echo $message ?>
            <div class="mb-2"><label class="form-label" for="namemodel">Model Name</label><input class="form-control" type="text" required name="namemodel" placeholder="Camaro">
            </div>
            <div class="mb-2"><label class="form-label" for="photo">Illustrative photo</label><input class="form-control" type="file" required accept="image/*" name="photo"></div>
            <div class="container" style="padding: 0;">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="Engine">Engine</label><input class="form-control" type="text" placeholder="6198cc" name="Engine"></div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="Transmission">Gearbox</label><input class="form-control" type="text" placeholder="Automatic" name="Transmission"></div>
                    </div>
                </div>
            </div>
            <div class="container" style="padding: 0;">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="Fuel">Fuel</label><input class="form-control" type="text" placeholder="Petrol" name="Fuel"></div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="nbPlaces">Number of seats</label><input class="form-control" type="number" name="nbPlaces" min="1" max="8" placeholder="4">
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="padding: 0;">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="price">Price ($)</label><input class="form-control" type="text" placeholder="150" name="price"></div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-2"><label class="form-label" for="quantity">Initial stock</label><input class="form-control" type="number" name="quantity" min="0" placeholder="3"></div>
                    </div>
                </div>
            </div>
            <div class="mb-2">
                <button class="btn btn-primary" type="submit" style="width: 100%;">ADD</button>
            </div>
        </form>
    </section>

    <?php include_once "./view/footer.tpl" ?>

</body>

</html>