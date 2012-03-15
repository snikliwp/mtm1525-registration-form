package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	import flash.net.URLLoaderDataFormat;		//format for the data coming back from the server
	import flash.net.URLRequestMethod;			//method for sending data to the server
	import flash.net.URLVariables;				//this will hold the data being sent to the server
	
	
	public class registrationFormDoc extends MovieClip {

		private var req:URLRequest;
		private var loader:URLLoader;
		private var page:String = "registerUser.php";	//the php page that will handle the response
		private var dataFormat:String = URLLoaderDataFormat.TEXT; // or .BINARY  or .TEXT		message=something&other=more&name=bob
		private	var formData:URLVariables = new URLVariables();
		private	var errors:Array;
		
		
		public function registrationFormDoc() {
			// constructor code
			//regForm_mc.firstName_txt, lastName_txt, eMail_txt, password1_txt, password2_txt are the input fields
			//regForm_mc.submitButton is the button to click to send the data
			//regForm_mc.response_txt is the field which will hold the response from the server
//			regForm_mc.submitButton.buttonMode = true;
//			regForm_mc.submitButton_mc.buttonMode = true;
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.MOUSE_UP, mUp);
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.CLICK, validate);
	
			//set up the password fields to hide the input
			regForm_mc.password1_txt.displayAsPassword  = true;
			regForm_mc.password2_txt.displayAsPassword  = true;
			//set a default value of empty string on all the text fields
			regForm_mc.firstName_txt.text = "";
			regForm_mc.lastName_txt.text = ""; 			
			regForm_mc.eMail_txt.text = ""; 			
			regForm_mc.password1_txt.text = ""; 		
			regForm_mc.password2_txt.text = "";
			
			regForm_mc.fnOk_mc.visible = false;
			regForm_mc.lnOk_mc.visible = false;
			regForm_mc.emOk_mc.visible = false;
			regForm_mc.pw1Ok_mc.visible = false;
			regForm_mc.pw2Ok_mc.visible = false;
			
			req = new URLRequest( page );
			req.method = URLRequestMethod.POST;		// or just "POST"
			 
			loader = new URLLoader();
			loader.dataFormat = dataFormat;
			loader.addEventListener(Event.COMPLETE, handleResponse);
			
			
		}	// End Function registrationFormDoc
		
		public function mDown(ev:Event) {
			//visual effect

		}	// End Function mDown
	
		public function mUp(ev:Event) {
			//visual effect

		}	// End Function mDown
	
		public function validate(ev:Event) {
			//gather the data from the "form" as save as a URLRequest params before sending them to the server
			//add any other form fields to be sent to the server into the vars object
			//add the vars object to the request object
//	regForm_mc.response_txt.text = "In Validate.";
			formData.first_name = regForm_mc.firstName_txt.text;
			formData.last_name = regForm_mc.lastName_txt.text;
			formData.email = regForm_mc.eMail_txt.text;
			formData.password = regForm_mc.password1_txt.text;
			formData.password2 = regForm_mc.password2_txt.text;
			errors = new Array();
			var errorTxt:String = ""
			//check the user has something in the firstname field
			if( regForm_mc.firstName_txt.text !=  null  &&  formData.first_name.length > 0 ) {
					regForm_mc.fnOk_mc.visible = true;
					regForm_mc.fnNok_mc.visible = false;
				}else{
				errors.push('firstName');
//				errorTxt = errorTxt  +  "You must provide a First Name.\n";
				errorTxt += "You must provide a First Name.\n";
				}// endelse
			//check the user has something in the lastname field
			if( regForm_mc.lastName_txt.text !=  null  &&  formData.last_name.length > 0 ) {
					regForm_mc.lnOk_mc.visible = true;
					regForm_mc.lnNok_mc.visible = false;
				}else{
				errors.push('lastName');
//				errorTxt = errorTxt  +  "You must provide a Last Name.\n";
				errorTxt += "You must provide a Last Name.\n";
				}// endelse
			//check the user has something in the email field
			trace(regForm_mc.eMail_txt.text, " ", formData.email.length);
			if( regForm_mc.eMail_txt.text !=  null  &&  formData.email.length > 0 ) {
					regForm_mc.emOk_mc.visible = true;
					regForm_mc.emNok_mc.visible = false;
				}else{
				errors.push('eMail');
//				errorTxt = errorTxt  +  "You must provide a valid Email address.\n";
				errorTxt += "You must provide a valid Email address.\n";
				}// endelse
			//check the user has something in the password1 field
			trace(regForm_mc.password1_txt.text, " ", formData.email.length);
			if(regForm_mc.password1_txt.text !=  null  &&   formData.password.length > 0 ) {
					regForm_mc.pw1Ok_mc.visible = true;
					regForm_mc.pw1Nok_mc.visible = false;
			} else {
				errors.push('password');
//				errorTxt = errorTxt  +  "Password is a required field.\n";
				errorTxt += "Password is a required field.\n";
			}	// endelse
			//check the user has something in the retype password field
			if( regForm_mc.password2_txt.text !=  null  &&   formData.password2.length > 0 && regForm_mc.password1_txt.text ==  regForm_mc.password2_txt.text ) {
					regForm_mc.pw2Ok_mc.visible = true;
					regForm_mc.pw2Nok_mc.visible = false;
			} else {
				errors.push('password2');
//				errorTxt = errorTxt  +  "You Must enter your Password twice.\n";
//				errorTxt += "You Must enter your Password twice.\n";
				errorTxt += "The Passwords you typed did not match!\n";
			}	// endelse
			//compare the two passwords to make sure they are the same
//			if( regForm_mc.password1_txt.text ==  regForm_mc.password2_txt.text ) {
//					regForm_mc.pw1Ok_mc.visible = true;
//					regForm_mc.pw1Nok_mc.visible = false;
//					regForm_mc.pw2Ok_mc.visible = true;
//					regForm_mc.pw2Nok_mc.visible = false;
//				} else {
//				errors.push('password3');
////				errorTxt = errorTxt  +  "The Passwords you typed did not match!\n";
//					regForm_mc.pw1Ok_mc.visible = false;
//					regForm_mc.pw1Nok_mc.visible = true;
//					regForm_mc.pw2Ok_mc.visible = false;
//					regForm_mc.pw2Nok_mc.visible = true;
//				errorTxt += "The Passwords you typed did not match!\n";
//				}	// endelse
				
			
			

				//send the request to the server by requesting the page with the URLLoader
				if (errors.length == 0) {
					regForm_mc.submitButton_mc.visible = false;
					regForm_mc.response_txt.text = "";

					sendData()
				}else {
				regForm_mc.response_txt.text = errorTxt;
				trace(regForm_mc.response_txt.text);
				};
}	// End Function validate
	
		public function sendData() {
			req.data = formData;
			loader.load( req );

		}	// End Function sendData
	
		public function handleResponse(ev:Event):void{
			//the xml data is back from the web server
			// var vars:URLVariables = ev.target.data;	//loaderDataFormat.VARIABLES
			var data:XML = XML( ev.target.data );				//loaderDataFormat.TEXT
			//var data:JSON = JSON( ev.target.data);			//loaderDataFormat.TEXT
			//trace( vars );
			regForm_mc.response_txt.text = data..message;			//    message=way to go!
			//write the message into the feedback field
			
		}	// End Function handleResponse
		
	}	// End class registrationFormDoc
	
}	// End package