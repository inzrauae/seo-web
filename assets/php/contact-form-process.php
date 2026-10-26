<?php

$errorMSG = "";

// NAME
if (empty($_POST["name"])) {
    $errorMSG = "Name is required ";
} else {
    $name = $_POST["name"];
}

// EMAIL
if (empty($_POST["email"])) {
    $errorMSG .= "Email is required ";
} else {
    $email = $_POST["email"];
}

// Phone Number
if (empty($_POST["phone_number"])) {
    $phone_number = "Not provided";
} else {
    $phone_number = $_POST["phone_number"];
}

// Subject
if (empty($_POST["subject"])) {
    $subject = "General Inquiry";
} else {
    $subject = $_POST["subject"];
}

// MESSAGE
if (empty($_POST["message"])) {
    $errorMSG .= "Message is required ";
} else {
    $message = $_POST["message"];
}


$EmailTo = "admin@seoconsultantsrilanka.com";

$Subject = "New Contact Form Submission - " . $subject;

// prepare email body text
$Body = "";
$Body .= "New Contact Form Submission\n";
$Body .= "================================================\n\n";
$Body .= "Name: ";
$Body .= $name;
$Body .= "\n\n";
$Body .= "Email: ";
$Body .= $email;
$Body .= "\n\n";
$Body .= "Phone Number: ";
$Body .= $phone_number;
$Body .= "\n\n";
$Body .= "Subject: ";
$Body .= $subject;
$Body .= "\n\n";
$Body .= "Message: ";
$Body .= $message;
$Body .= "\n\n";
$Body .= "================================================\n";
$Body .= "Submitted: " . date('Y-m-d H:i:s');

// send email
$success = mail($EmailTo, $Subject, $Body, "From: " . $email);

// redirect to success page
if ($success && $errorMSG == ""){
   echo "success";
}else{
    if($errorMSG == ""){
        echo "Something went wrong :(";
    } else {
        echo $errorMSG;
    }
}

?>
