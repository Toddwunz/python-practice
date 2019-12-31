<html>
<body>
<form action ="index.php">

<ul>
  <li><input type ="checkbox" name ="chkFries" value ="11.00">Fries</li>
  <li><input type ="checkbox" name ="chkSoda"  value ="12.85">Soda</li>
  <li><input type ="checkbox" name ="chkShake" value ="1.30">Shake</li>
  <li><input type ="checkbox" name ="chkKetchup" value =".05">Ketchup</li>
</ul>
<input type ="submit">
</form>
    
<?PHP
print "chkFries:" .  $chkFries . "<br/>";
print "chkSoda:" $chkSoda . "<br/>";
print "chkShake:" . $chkShake . "<br/>";
print "chkKetchup" . $chkKetchup . "<br/>";

$total = 0;

if (!empty($chkFries)){
  print ("You chose Fries <br>");
  $total = $total + $chkFries;
}

if (!empty($chkSoda)){
  print ("You chose Soda <br>");
  $total = $total + $chkSoda;
}

if (!empty($chkShake)){
  print ("You chose Shake <br>");
  $total = $total + $chkShake;
}

if (!empty($chkKetchup)){
  print ("You chose Ketchup <br>");
  $total = $total + $chkKetchup;
}

print "The total cost is \$$total";

?>

</body>
</html>