<?php
//registerUser.php
/****************************************************************************
Accepts data for registration of a user
$_REQUEST['first_name']	- required
$_REQUEST['last_name']	- required
$_REQUEST['email']	- required
$_REQUEST['password']	- required

Returns XML with error code and message
success message 
<?xml version="1.0" encoding="utf-8" ?>
<data>
	<code>0</code>
	<message>User successfully  registered</message>
</data>

failure example
<?xml version="1.0" encoding="utf-8" ?>
<data>
	<code>2343</code>
	<message>Missing required field.</message>
</data>

****************************************************************************/
define('SALT', 'Th1s1sTh3S4ltK3y');
header("Content-Type: text/xml");
echo '<?xml version="1.0" encoding="utf-8" ?>' ."\r\n";
$link = mysqli_connect("localhost", "sampleuser", "samplepass", "samplesite") or die('<data>
																																							<code>1111</code>
																																							<message>Unable to connect with the database.</message>
																																						</data>');


if( isset($_REQUEST['first_name']) && isset($_REQUEST['last_name']) && isset($_REQUEST['email']) && isset($_REQUEST['password']) ){
	
	$fn = trim($_REQUEST['first_name']);
	$ln = trim($_REQUEST['last_name']);
	$em = trim($_REQUEST['email']);
	$pw = trim($_REQUEST['password']);
	
	if( empty($fn) || empty($ln) || empty($em) || empty($pw) ){
			
		echo '<data>
				<code>4444</code>
				<message>All fields must be completed.</message>
			</data>';
		
	}else{
		
		$fn = mysqli_real_escape_string($link, $fn);
		$ln = mysqli_real_escape_string($link, $ln);
		$em = mysqli_real_escape_string($link, $em);
		$pw = hash_hmac('sha1', $pw, SALT);
		
		$strSQL = "INSERT INTO mtm1525_users(first_name, last_name, email, pwd)
							VALUES('$fn', '$ln', '$email', '$pw') ";
		$ret = mysqli_query($link, $strSQL);
		if($ret){
			echo '<data>
				<code>0</code>
				<message>User successfully  registered.</message>
			</data>';
		}else{
			echo '<data>
				<code>3333</code>
				<message>Unable to save user in database.</message>
				<dbmessage>' . mysqli_error($link) . '<dbmessage>
			</data>';
		}	
	}
}else{
	echo '<data>
		<code>2222</code>
		<message>Missing required field(s).</message>
	</data>';

}


?>