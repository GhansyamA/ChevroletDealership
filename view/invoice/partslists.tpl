<!doctype html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
</head>
<body>
    <?php include_once "./view/navbar.tpl" ?>
    <div class="container">
        <h1>Order history</h1>
        <?php echo $message ?>
        <div class="table-responsive border rounded" style="margin-top: 16px;">
            <table class="table table-striped" style="margin: 0">
                <thead>
                    <tr>
                        <th class="text-center">Photo</th>
                        <th class="text-center">Part</th>
                        <th class="text-center">Quantity</th>
                        <th class="text-center">Amount</th>
                        <th class="text-center">Order Date</th>
                        <th class="text-center">Payment Method</th>
                        <th class="text-center">Payment</th>
                        <th class="text-center">Cancellation</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($partinvoices as $partinvoice) {
                        echo '<tr>';
                        $part = array();
                        getPart($partinvoice["idpart"], $part);
                        printf('<td class="d-xl-flex justify-content-xl-center"><img class="img-fluid" src="./assets/vehicle/img/%s"
                            alt="%s" width="200px" height="100px"></td>', $part["photo"], $part["photo"]);
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($partinvoice["partname"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s </p></td>
                            ', number_format($partinvoice["quantity"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;"> $ %s </p></td>
                            ', number_format($partinvoice["amount"], 0, ',', ' '));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($partinvoice["bookdate"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($partinvoice["method"]));
                        if ($partinvoice["paystatus"] == 0) {
                            printf('<td class="text-center align-middle"><a class="btn btn-dark" type="button" href="index.php?controle=invoice&action=partpay&idpart=%s&idinvoice=%s">
                            PAY</a>', $partinvoice["idpart"], $partinvoice["idinvoice"]);
                        } else {
                            printf('<td class="text-center align-middle"><p style="margin: 0;">PAID </p></td>');
                        }
                        printf('<td class="text-center align-middle"><a class="btn btn-dark" type="button" 
                            href="index.php?controle=invoice&action=partcancel&idpart=%s&idinvoice=%s">CANCEL</a>',
                            $partinvoice["idpart"], $partinvoice["idinvoice"]);
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