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
            <form action="index.php?controle=user&action=signup" method="post">
                <h2 class="text-center"><strong>Create </strong>your account</h2>
                <?php
                    if ($error !== NULL) {
                        printf('<div class="mb-3"><div class="alert alert-danger" role="alert">%s</div></div>', $error);
                    }
                ?>
                <div class="mb-3"><input class="form-control" type="text" placeholder="Name" name="name" required></div>
                <div class="mb-3">
                    <select class="form-control" name="gender" id="gender" required>
                        <option value="" disabled selected>Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>
                <div class="mb-3"><input class="form-control" type="phone" name="phone" placeholder="Phone" required></div>
                <div class="mb-3"><input class="form-control" type="email" name="mail" placeholder="Mail" required></div>
                <div class="mb-3"><input class="form-control" type="password" name="password" placeholder="Password" required></div>
                <div class="mb-3">
                    <div class="form-check"><label class="form-check-label"><input class="form-check-input" type="checkbox" required>I accept the&nbsp;<a href="#">Terms of Service</a></label></div>
                </div>
                <div class="mb-3">
                    <button class="btn btn-primary d-block w-100" type="submit" style="background: #209cee;">Register
                    </button>
                </div>
                <a class="already" href="index.php?controle=user&action=signin">Do you already have an account? Log in here</a>
            </form>
        </div>
    </section>
    <?php include_once "./view/footer.tpl" ?>
</body>
</html>