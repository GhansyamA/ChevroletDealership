<!DOCTYPE html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">
</head>
<body>
<?php include_once "./view/navbar.tpl" ?>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<section class="contact-clean">
    <form method="post" action="index.php?controle=car&action=service&id=<?php echo $_GET["id"] ?>">
        <img class="img-fluid" src="./assets/vehicle/img/<?php echo $model["photo"] ?>" alt="<?php echo $model["photo"] ?>" style="margin-bottom: 0px;">
        <h4 class="text-center" style="margin-top: 8px;"><?php echo htmlspecialchars($model["namemodel"]) ?></h4>
        <p class="text-center">General Cost : $ 66</p>
        <?php echo $message ?>
        <div class="mb-3">
            <input type="hidden" name="idmodel" value="<?php echo $_GET["id"] ?>">
        </div>
        <div class="mb-3"><input class="form-control" type="text" name="regnum" placeholder="Registration number" required></div>
        <div class="mb-3">
            <select class="form-select" required name="servtype">
                <option value="" selected disabled>Service Type</option>
                <option value="General Repair">General Repair</option>
                <option value="Periodic Maintenance">Periodic Maintenance</option>
                <option value="Body & Paint">Body & Paint</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Date for service</label>
            <input class="form-control" type="date" name="servdate" id="servdate" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Date for service</label>
            <select class="form-control" name="servtime" id="servtime" required>
                <option value="" selected disabled>-- : --</option>
                <option value="09:00">09:00</option>
                <option value="10:00">10:00</option>
                <option value="11:00">11:00</option>
                <option value="12:00">12:00</option>
                <option value="13:00">13:00</option>
                <option value="14:00">14:00</option>
            </select>
        </div>
        <script>
            $(document).ready(function() {
                $('#servtime').select2();
            });
        </script>
        <script>
            function isSunday(date) {
                return date.getDay() === 0;
            }
            function adjustDateAvailability() {
                var selectedDate = new Date(document.getElementById("servdate").value);
                if (isSunday(selectedDate)) {
                    alert("Sundays are not available. Please choose another date.");
                    document.getElementById("servdate").value = '';
                }
            }   
            var today = new Date();
            var minDate = new Date(today);
            minDate.setDate(minDate.getDate() + 1);
            var maxDate = new Date(today);
            maxDate.setFullYear(maxDate.getFullYear() + 1);
            var inputDate = document.getElementById("servdate");
            while (isSunday(minDate)) {
                minDate.setDate(minDate.getDate() + 1);
            }
            inputDate.setAttribute('min', minDate.toISOString().split('T')[0]);
            inputDate.setAttribute('max', maxDate.toISOString().split('T')[0]);
            inputDate.addEventListener('change', adjustDateAvailability);
        </script>

        <div class="d-inline-flex justify-content-between align-items-center mb-3" style="width: 100%;">
            <div class="mb-3" style="display: none;">
                <label class="form-label">Quantity</label>
                <input class="form-control" type="number" min="1" max="<?php echo $max ?>" placeholder="1" name="quantity" value="1" >
            </div>
            <?php
            if ($max > 0) {
                echo '<button class="btn btn-primary" type="submit" style="margin-top: 0px;width: 150px;">Book for Service</button>';
            }
            else {
                echo '<button class="btn btn-secondary" type="submit" style="margin-top: 0px;width: 150px;" disabled>Unavailable</button>';
            }
            ?>
        </div>
        <p class="text-center"><a href="index.php?controle=car&action=servicelists">Return to model list</a></p>
    </form>
</section>
<?php include_once "./view/footer.tpl" ?>
</body>
</html>
