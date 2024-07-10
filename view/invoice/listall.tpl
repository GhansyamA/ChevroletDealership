<!doctype html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
</head>
<body>
    <?php include_once "./view/navbar.tpl" ?>
    <div class="container">
        <h1>All Customer Bookings</h1>
        <?php echo $message ?>
        <div class="table-responsive border rounded" style="margin-top: 16px;">
            <table class="table table-striped" style="margin: 0">
                <thead>
                    <tr>
                        <th class="text-center">Customer</th>
                        <th class="text-center">Photo</th>
                        <th class="text-center">Model</th>
                        <th class="text-center">Variant</th>
                        <th class="text-center">Color</th>
                        <th class="text-center">Booking Date</th>
                        <th class="text-center">Payment Method</th>
                        <th class="text-center">Payment</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($allinvoices as $allinvoice) {
                        echo '<tr>';
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["username"]));
                        printf('<td class="d-xl-flex justify-content-xl-center"><img class="img-fluid" src="./assets/vehicle/img/%s/%s.jpg"
                            alt="%s" width="200px" height="100px"></td>', $allinvoice["namemodel"], $allinvoice["color"],$allinvoice["photo"]);
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["namemodel"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["variant"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["color"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["bookdate"])); 
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($allinvoice["method"]));
                        if ($allinvoice["paystatus"] == 0) {
                            printf('<td class="text-center align-middle"><p style="margin: 0;">NOT PAID </p></td>');
                        } else {
                            printf('<td class="text-center align-middle"><p style="margin: 0;">PAID </p></td>');
                        }
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