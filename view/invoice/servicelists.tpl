<!doctype html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
</head>
<body>
    <?php include_once "./view/navbar.tpl" ?>
    <div class="container">
        <h1>Service history</h1>
        <?php echo $message ?>
        <div class="table-responsive border rounded" style="margin-top: 16px;">
            <table class="table table-striped" style="margin: 0">
                <thead>
                    <tr>
                        <th class="text-center">Photo</th>
                        <th class="text-center">Model</th>
                        <th class="text-center">Registration Number</th>
                        <th class="text-center">Service Type</th>
                        <th class="text-center">Date&Time</th>
                        <th class="text-center">Cancellation</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($servinvoices as $servinvoice) {
                        echo '<tr>';
                        printf('<td class="d-xl-flex justify-content-xl-center"><img class="img-fluid" src="./assets/vehicle/img/%s"
                            alt="%s" width="200px" height="100px"></td>', $servinvoice["photo"], $servinvoice["photo"]);
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>', htmlspecialchars($servinvoice["namemodel"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>', htmlspecialchars($servinvoice["regnum"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>', htmlspecialchars($servinvoice["servtype"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s | %s</p></td>',
                             $servinvoice["servdate"] , $servinvoice["servtime"]);
                        printf('<td class="text-center align-middle"><a class="btn btn-dark" type="button"
                                href="index.php?controle=invoice&action=servcancel&id=%s">CANCEL</a>',$servinvoice["idinvoice"]);
                        echo '</tr>';
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    <?php include_once "./view/footer.tpl" ?>
</body>
</html>