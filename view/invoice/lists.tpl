<!doctype html>
<html lang="en">
    <head>
        <?php include_once "./view/header.tpl" ?>
    </head>
    <body>
        <?php include_once "./view/navbar.tpl" ?>
        <div class="container">
            <h1>Booking history</h1>
            <?php echo $message ?>
            <div class="table-responsive border rounded" style="margin-top: 16px;">
                <table class="table table-striped" style="margin: 0">
                    <thead>
                        <tr>
                            <th class="text-center">Photo</th>
                            <th class="text-center">Model</th>
                            <th class="text-center">Variant</th>
                            <th class="text-center">Color</th>
                            <th class="text-center">Booking Amount</th>
                            <th class="text-center">Booking Date</th>
                            <th class="text-center">Payment Method</th>
                            <th class="text-center">Payment Details</th>
                            <th class="text-center">Payment</th>
                            <th class="text-center">Cancellation</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($invoices as $invoice) {
                        echo '<tr>';
                        printf('<td class="d-xl-flex justify-content-xl-center"><img class="img-fluid" src="./assets/vehicle/img/%s/%s.jpg"
                            alt="%s" width="200px" height="100px"></td>', $invoice["namemodel"], $invoice["color"],$invoice["photo"]);
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($invoice["namemodel"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($invoice["variant"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($invoice["color"]));
                        if ($invoice["amount"] >= 50000) {
                            printf('<td class="text-center align-middle"><p style="margin: 0;"> $ 7000 </p></td>');
                        } elseif ($invoice["amount"] >= 30000 && $invoice["amount"] < 50000) {
                            printf('<td class="text-center align-middle"><p style="margin: 0;"> $ 5000 </p></td>');
                        } else {
                            printf('<td class="text-center align-middle"><p style="margin: 0;"> $ 3000 </p></td>');
                        }
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($invoice["bookdate"]));
                        printf('<td class="text-center align-middle"><p style="margin: 0;">%s</p></td>
                            ', htmlspecialchars($invoice["method"]));
                        if ($invoice["paystatus"] == 0) {
                            if ($invoice["method"] == 'UPI') {
                                printf('<td class="text-center align-middle"><input type="text" placeholder="Enter UPI ID" id="payment_details_%s"></td>', $invoice["idvehicle"]);
                            }
                            else{
                                printf('<td class="text-center align-middle"><input type="text" placeholder="Enter CVV" id="payment_details_%s"></td>', $invoice["idvehicle"]);
                            }
                            printf('<td class="text-center align-middle"><button class="btn btn-dark" type="button"
                                onclick="pay(%s)">PAY</button></td>', $invoice["idvehicle"]);
                        } else {
                            printf('<td class="text-center align-middle"><p style="margin: 0;"> --- </p></td>');
                            printf('<td class="text-center align-middle"><p style="margin: 0;">PAID </p></td>');
                        }
                        printf('<td class="text-center align-middle"><a class="btn btn-dark" type="button"
                                href="index.php?controle=invoice&action=cancel&id=%s">CANCEL</a>',$invoice["idvehicle"]);
                        echo '</tr>';
                    }?>
                </tbody>
            </table>
        </div>
    </div>
    <?php include_once "./view/footer.tpl" ?>
    <script>
        function pay(id) {
            var paymentDetails = document.getElementById('payment_details_' + id).value;
            if (paymentDetails.trim() === "") {
                alert("Please enter payment details");
            } else if (document.getElementById('payment_details_' + id).getAttribute("placeholder") === "Enter UPI ID") {
                if (!paymentDetails.match(/^[a-zA-Z0-9]+@[a-zA-Z]+$/)) {
                    alert("UPI ID should be in the format 'username/phone@provider'");
                } else {
                    window.location.href = 'index.php?controle=invoice&action=pay&id=' + id;
                }
            } else {
                if (!/^\d{3}$/.test(paymentDetails)) {
                    alert("CVV should be only 3 digits");
                } else {
                    window.location.href = 'index.php?controle=invoice&action=pay&id=' + id;
                }
            }
        }
    </script>
</body>
</html>
