<!DOCTYPE html>
<html lang="en">
<head>
    <?php include_once "./view/header.tpl" ?>
</head>
<body>
    <?php include_once "./view/navbar.tpl" ?>
    <section class="login-clean">
        <form action="index.php?controle=user&action=signin" method="post" id="signinForm">
            <div class="illustration"><i class="icon ion-person-stalker" style="color: #209cee;border-color: #209cee;"></i>
            </div>
            <?php
            if ($error !== NULL) {
                printf('<div class="mb-3"><div class="alert alert-danger" role="alert">%s</div></div>', $error);
            }
            ?>
            <div class="mb-3">
                <input class="form-control" type="text" name="mail" id="mail" placeholder="Mail/Phone" required>
                <span id="emailOrPhoneError" style="color: red;"></span>
            </div>
            <div class="mb-3"><input class="form-control" type="password" name="password" placeholder="Password" required></div>
            <div class="mb-3">
                <button class="btn btn-primary d-block w-100" type="submit" style="background: #209cee;">Sign in</button>
            </div>
            <a class="forgot" href="index.php?controle=user&action=signup">No account yet? Register</a>
        </form>
    </section>
    <?php include_once "./view/footer.tpl" ?>
    <script>
        document.getElementById('signinForm').addEventListener('submit', function(event) {
            var emailOrPhoneInput = document.getElementById('mail');
            var emailOrPhoneError = document.getElementById('emailOrPhoneError');
            var mailValue = emailOrPhoneInput.value;
            if (/^\d+$/.test(mailValue)) {
                if (!isValidPhone(mailValue)) {
                    event.preventDefault();
                    emailOrPhoneError.textContent = 'Please enter a valid phone number.';
                }
            } else {
                if (!isValidEmail(mailValue)) {
                    event.preventDefault();
                    emailOrPhoneError.textContent = 'Please enter a valid email address.';
                }
            }
        });
        function isValidEmail(email) {
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
        function isValidPhone(phone) {
            var phoneRegex = /^\d{10}$/;
            return phoneRegex.test(phone);
        }
    </script>
</body>
</html>
