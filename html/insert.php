<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $gender = test_input($_POST["gender"]);
  $firstclass = test_input($_POST["firstclass"]);
  $secondclass = test_input($_POST["secondclass"]);
  $email = test_input($_POST["email"]);
  $mobile = test_input($_POST["mobile"]);
  $company = test_input($_POST["company"]);
  $city = test_input($_POST["city"]);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}


function alert($msg) {
    echo "<script type='text/javascript'>alert('$msg');</script>";
}

//$con = mysql_connect('172.17.0.2', 'root', 'redhat');
$conn = new mysqli('172.17.0.2', 'root', 'redhat','students');
//mysql_query("set names 'utf8'");
$conn->query("set names 'utf8'");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "INSERT INTO student (Name, Gender, FirstClass, SecondClass, Mobile, Email, Company, City)
 VALUES 
('$name','$gender','$firstclass','$secondclass','$mobile','$email','$company','$city')";

if ($conn->query($sql) === TRUE)
  {
    echo "New record created successfully";
  }
else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$get_sql = "SELECT Name,Gender,FirstClass,SecondClass,Mobile,Email,Company,City FROM student";
$result = $conn->query($get_sql);

    echo "<table><tr><th>姓名</th><th>性别</th><th>分班前班级</th><th>分班后班级</th><th>电话</th><th>E-mail</th><th>公司</th><th>所在城市</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>".$row["Name"]."</td><td>".$row["Gender"]."</td><td> ".$row["FirstClass"]."</td><td>".$row["SecondClass"]."</td><td>".$row["Mobile"]."</td><td>".$row["Email"]."</td><td>".$row["Company"]."</td><td>".$row["City"]."</td></tr>";
        }
        echo "</table>";

mysql_close($con);

?>
