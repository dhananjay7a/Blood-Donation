<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>OTP Verification</title>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <style type="text/css">
        .container {
	    margin-top: 8%;
	    width: 400px;
	    padding: 20px;
	    border: 1px solid #ddd;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

    </style>
</head>
<body>
    <div class="container">
        <h2>Enter the OTP</h2>
        <form id="otpForm" onsubmit="event.preventDefault(); verifyOTP();" method="post">
            <div class="form-group">
                <label for="otp">OTP</label>
                <input type="text" class="form-control" id="otp" name="otp" required>
            </div>
            <button type="submit" class="btn btn-primary">Verify OTP</button>
        </form>
        <h4 id="otpMessage"></h4>
    </div>

    <!-- Script for verifying OTP -->
    <script>
        function verifyOTP() {
            var otp = document.getElementById("otp").value;

            $.ajax({
                url: "verifyOtp",
                method: "post",
                data: { "otp": otp },
                success: function(response) {
                    if (response === "success") {
                        swal("OTP Verified!", "Registration completed successfully.", "success")
                        .then(() => {
                        	setTimeout(function() {
                            window.location.href = "login.jsp"; // Redirect to OTP form
                        }, 500);
                        });
                    } else {
                        swal("Invalid OTP", "Please try again.", "error");
                    }
                }
            });
        }
    </script>

    <!-- Include JS libraries -->
    <script src="js/jquery-3.4.1.min.js"></script>
</body>
</html>
