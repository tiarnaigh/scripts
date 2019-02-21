<html>

 <body>

<Center>
<img src="random_logo.jpg">
  <P>Upload latest Artifact (war/zip) files here. Upload one by one, or all at once</P>

  <Table border="1">
   <Tr>
        <form method="post" enctype="multipart/form-data">
        <Td><label for="file">Upload File(s):</label></Td>
        <Td><input type="file" name="file[]" multiple ></Td>
        <Td><input name="submit" type="submit" value="Upload" /></Td>
        </form>
   </Tr>
  </Table>
</Center>

    </body>
</html>


<?php
if(isset($_POST['submit']))
{
        // Director where files will be uploaded directly to 
        $directory="/var/nfsshare/Uploads/AppName/";
        $a=0;
        //$date = new DateTime();
        //$currentDate = $date->getTimestamp();
        $currentDate = date("Ymd_Gis");
        //%Y%m%d_%H%M%S
        $supportedFileExtension = "war";
        $supportedFileExtensionNew = "zip";

        foreach ($_FILES['file']['name'] as $nameFile)
        {
          if(is_uploaded_file($_FILES['file']['tmp_name'][$a]))
          {

                $fileName = $_FILES['file']['name'][$a];
                $fileExtension = substr($fileName, strrpos($fileName, '.') + 1);
                $fullPath = $directory.$_FILES['file']['name'][$a];

                //echo "FileName: $fileName<BR />";
                //echo "FileExt: $fileExtension<BR />";


            // Only accept *.war (Or *.zip) as uploaded file types
            if (strcasecmp($supportedFileExtension,$fileExtension) == 0 || strcasecmp($supportedFileExtensionNew,$fileExtension) == 0)
            {
             /*
              * Check if the file being uploaded already exists on the local filesystem
              * If so, rename original file and include current timestamp before uploading
              * new file (i.e. Backup original always)
              */
             if (file_exists($fullPath))
             {
               echo "<br /><Center>File already exists. Renaming original to $fullPath" . ".$currentDate" . "</Center><br />";
               rename($fullPath, $fullPath . ".$currentDate");
             }

                $success = move_uploaded_file($_FILES['file']['tmp_name'][$a], $directory.$_FILES['file']['name'][$a]);
                if (!$success)
                {
                  echo "<p><Center>Unable to save file.</Center></p>";
                  exit;
                }
                else
                {
                  // rsync uploaded files between datacentres
                  // system("sudo /usr/bin/rsync -azP --update -e \"ssh -p sshPort\" /var/nfsshare/Uploads/AppName/ root@remoteZabbixHost:/var/nfsshare/Uploads/AppName >/dev/null 2>&1");
                  // echo "<Center><P>Successfully uploaded $fileName to both DC1 & DC2</P></Center>";
                  echo "<Center><P>Successfully uploaded $fileName to site</P></Center>";

                  echo "<Center><TABLE border='1'>";
                  echo "<TR><TD>Uploaded File: </TD><TD>" . $_FILES['file']['name'][$a] . "</TD></TR>";
                  echo "<TR><TD>Type: </TD><TD>" . $_FILES['file']['type'][$a] . "</TD></TR>";
                  echo "<TR><TD>Size: </TD><TD>" . ($_FILES['file']['size'][$a] / 1024) . " Kb</TD></TR>";
                  echo "<TR><TD>File saved to: </TD><TD>" . $fullPath . " </TD></TR>";
                  echo "<TR><TD>MD5sum : </TD><TD>" . md5_file($fullPath) . "</TD></TR>";
                  echo "</TABLE></Center>";

                }
           } // End of "if($fileExtension = "war")"
           else
           {
             echo "<Center><Font color='red'><B><Br />Error: </B></Font>You may only upload war or zip files!</Center><BR />";
           }

          } // End of "if(is_uploaded_file(.......)"
         $a++;
        } // End of foreach ($_FILES....)
}
?>
