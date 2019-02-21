<html>
 <style>
    .error {color: #FF0000;}
 </style>
 <body>

 <?php

 // define variables and set to empty values
$websiteErr = $output = $curlis = "";
$website = "";
 // verify that the url provided is formatted correctly
if ($_SERVER["REQUEST_METHOD"] == "POST") {
     if (empty($_POST["website"])) {
     $website = "";
   } else {
     $website = test_input($_POST["website"]);
     // check if URL address syntax is valid
     if (!preg_match("/\b(?:(?:https?|ftp|http):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$website)) {
       $websiteErr = "*Invalid URL";
     } else {
        //execute the curl command on the remote server and return results
        $output = shell_exec('/pathName/zabbix/bin/zabbix_get -s remoteHostname -k system.run["curl -L -k -v -Is -x proxyIpAddress:proxyPort "'.$website.'"","wait"];');
        $output1 = shell_exec('/pathName/zabbix/bin/zabbix_get -s remoteHostname -k system.run["curl -L -k -v -Is -x proxyIpAddress:proxyPort "'.$website.'"","wait"];');
     }
   }
}

function test_input($data) {
   $data = trim($data);
   $data = stripslashes($data);
   $data = htmlspecialchars($data);
   return $data;
}
?>

<Center>
  <P>Test connectivity to the following URL via proxy</P>

  <Table border="1">

   <Tr>

        <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <Td><label for="file">Enter URL:</label></Td>
        <td><input type="text" name="website"><span class="error"><?php echo $websiteErr;?></span></td>
        <Td><input name="submit" type="submit" value="Check" /></Td>
        </form>
   </Tr>
  </Table>
</Center>

<?php
echo "<h2>Result:</h2>";
echo "<h3>Via First proxy (proxyIpAddress):</h2>";
echo htmlentities($output);
echo "<br>";
echo "<hr>";
echo "<h3>Via Second proxy (proxyIpAddress:proxyPort):</h2>";
echo htmlentities($output1);
echo "<br>";

?>

 </body>
</html>
