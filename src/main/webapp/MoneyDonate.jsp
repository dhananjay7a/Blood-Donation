<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<title>Donation</title>
  	<title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://plus.unsplash.com/premium_photo-1682309740788-04a5451ee019?q=80&w=1824&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #ffffff;
        }
        h2 {
            color: #dc3545;
        }
    </style>

</head>

<body class="sub_page">  
    <div class="container mt-5">
        <div class="row align-items-center">
            <!-- Left Side: Image -->
            <div class="col-md-6 text-center">
                <img src="images/donate.jpg" alt="Donate Image" class="img-fluid rounded">
            </div>
            
            <!-- Right Side: Form -->
            <div class="col-md-6">
                <div class="card p-4 shadow-sm">
                    <h4 class="mb-4 text-center">Donate for charity</h4>
                    <form onsubmit="event.preventDefault(); donate()" method="post">
                        <div class="form-group mb-3">
                            <label for="name">Enter Name</label>
                            <input type="text" class="form-control form-control-sm" id="name" name="name">
                        </div>
                        <div class="form-group mb-3">
                            <label for="amount">Enter Amount</label>
                            <input type="number" class="form-control form-control-sm" id="amount" name="amount">
                        </div>
                        <div class="form-group mb-3">
                            <label for="phoneno">Phone Number</label>
                            <input type="text" class="form-control form-control-sm" id="phoneno" name="phoneno">
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm w-100" name="create" id="payButton">Donate Now</button>
                        <h4 class="text-success mt-3">${requestScope['message']}</h4>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- older donation script section -->
    <script>
		function donate()
		{
			var name = document.getElementById("name").value;
			var amount = document.getElementById("amount").value;
			var phoneno = document.getElementById("phoneno").value;
			
			if(amount<50)
			{
				Swal.fire("Minimum 50 Rs have to donate.");
			}
			else
			{
				var options = {
					    "key": "rzp_test_RqM2jXtQ6rto6z", // Enter the Key ID generated from the Dashboard
					    "amount": amount*100, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
					    "currency": "INR",
					    "name": "Blood donation Organization", //your business name
					    "description": "From Dhananjay",
					    "image": "/images/donate.jpg",
					    "handler": function (response){
					        Swal.fire("Thank you "+name+" for donating. Your Transaction ID is: "+response.razorpay_payment_id);
					        
					        $.ajax({
								url: "storePayment",
								method:"post",
								data: {"name": name,"phoneno": phoneno, "amount":amount, "paymentId" : response.razorpay_payment_id},
								success: function(response)
								{
									Swal.fire(respone)
									.then((value) => {
										window.location.href = "userDashboard.jsp";
									});
								}
							})
							
					    },
					};
				
				var rzp1 = new Razorpay(options);
				rzp1.open();
				
			}
			
		}
	</script> 
    
   <!-- Donation script section -->
    <!-- <script>
        let donate = function () {
            let name = document.getElementById("name").value;
            let amount = document.getElementById("amount").value;
            let phoneno = document.getElementById("phoneno").value;
            
            if(isNaN(amount) || amount < 50) {
                Swal.fire("Minimum 50 Rs have to donate");
            } else {
                // Fetch Razorpay Order ID from the server
                fetch('/createOrder', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'amount=' + amount
                })
                .then(response => response.json())
                .then(order => {
                    // Razorpay Checkout Options
                    const options = {
                        key: "rzp_test_RqM2jXtQ6rto6z", // Your Razorpay Key
                        amount: order.amount, // Amount in paise
                        currency: order.currency,
                        name: "Blood donation organization",
                        description: "From Dhananjay pandit",
                        order_id: order.id, // Order ID from Razorpay
                        handler: function (response) {
                            // Payment success callback
                            Swal.fire("Payment successful. Payment ID: " + response.razorpay_payment_id);

                            // Send payment details to the backend for storage
                            fetch('/storePayment', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: `name=${name}&amount=${amount}&phoneno=${phoneno}&orderId=${order.id}&paymentId=${response.razorpay_payment_id}`
                            })
                            .then(response => response.json())
                            .then(data => console.log("Payment details stored"))
                            .catch(error => console.error("Error storing payment details", error));
                        },
                        theme: {
                            color: "#3399cc"
                        }
                    };
                    const rzp = new Razorpay(options);
                    rzp.open();
                })
                .catch(error => console.error("Error creating Razorpay order", error));
            }
        }; -->
    </script> 
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>


</html>