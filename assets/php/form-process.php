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

// Phone
if (empty($_POST["phone"])) {
    $phone = "Not provided";
} else {
    $phone = $_POST["phone"];
}

// Package
if (empty($_POST["package"])) {
    $package = "Not specified";
} else {
    $package = $_POST["package"];
}

// MESSAGE
if (empty($_POST["message"])) {
    $message = "No message provided";
} else {
    $message = $_POST["message"];
}


$EmailTo = "admin@seoconsultantsrilanka.com";

$Subject = "New SEO Pricing Inquiry - " . $package;

// prepare email body text
$Body = "";
$Body .= "New Contact Form Submission from SEO Pricing Page\n";
$Body .= "================================================\n\n";
$Body .= "Name: ";
$Body .= $name;
$Body .= "\n\n";
$Body .= "Email: ";
$Body .= $email;
$Body .= "\n\n";
$Body .= "Phone Number: ";
$Body .= $phone;
$Body .= "\n\n";
$Body .= "Package Interested: ";
$Body .= $package;
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