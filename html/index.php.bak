<!DOCTYPE HTML>  
<html>
<head>
</head>
<body>  

<?php
// define variables and set to empty values
$name = $gender = $firstclass = $secondclass = $email = $mobile = $company = $city = "";

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

# here database details
mysql_connect('172.17.0.2', 'root', 'redhat');
mysql_query("set names 'utf8'");
mysql_select_db('students');

$sql1 = "SELECT id,Classes FROM Class where id < 9";
$result1 = mysql_query($sql1);
$sql2 = "SELECT id,Classes FROM Class where id > 8";
$result2 = mysql_query($sql2);

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>校友信息收集系统</h2>
<form method="post" action="insert.php">  
  姓名: <input type="text" name="name">
  <br><br>
  性别:
  <input type="radio" name="gender" value="female">Female
  <input type="radio" name="gender" value="male">Male
  <br><br>
  分班前班级:
  <?php
  echo "<select name='firstclass'>";
  while ($row = mysql_fetch_array($result1)) {
      echo " <option value='" . $row['Classes'] ."'>" . $row['Classes'] ."</option>";
   }
  echo "</select>";
  ?>
  <br><br>
  分班后班级:
  <?php
  echo "<select name='secondclass'>";
  while ($row = mysql_fetch_array($result2)) {
      echo " <option value='" . $row['Classes'] ."'>" . $row['Classes'] ."</option>";
   }
  echo "</select>";
  ?>
  <br><br>
  E-mail: <input type="text" name="email">
  <br><br>
  手机: <input type="text" name="mobile">
  <br><br>
  公司: <input type="text" name="company">
  <br><br>
  所在城市: <input type="text" name="city">
  <br><br>
  <input type="submit" name="submit" value="Submit">  
</form>

<?php
echo "<h2>Your Input:</h2>";
echo $name;
echo "<br>";
echo $gender;
echo "<br>";
echo $email;
echo "<br>";
echo $firstclass;
echo "<br>";
echo $secondclass;
echo "<br>";
echo $mobile;
echo "<br>";
echo $company;
echo "<br>";
echo $city;
?>

</body>
</html>
