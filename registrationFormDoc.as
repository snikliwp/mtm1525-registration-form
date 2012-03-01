package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
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
		private var dataFormat:String = URLLoaderDataFormat.VARIABLES; // or .BINARY  or .TEXT		message=something&other=more&name=bob
		private	var formData:URLVariables = new URLVariables();
		
		
		public function registrationFormDoc() {
trace("in registrationFormDoc: ");
			// constructor code
			//regForm_mc.firstName_txt, lastName_txt, eMail_txt, password1_txt, password2_txt are the input fields
			//regForm_mc.submitButton is the button to click to send the data
			//regForm_mc.response_txt is the field which will hold the response from the server
//			regForm_mc.submitButton.buttonMode = true;
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
trace("in registrationFormDoc: 0");
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.MOUSE_UP, mUp);
			regForm_mc.submitButton_mc.addEventListener(MouseEvent.CLICK, validate);
trace("in registrationFormDoc: 1");
	
			//set a default value of empty string on all the text fields
			regForm_mc.firstName_txt.text = "";
			regForm_mc.lastName_txt.text = ""; 			
			regForm_mc.eMail_txt.text = ""; 			
			regForm_mc.password1_txt.text = ""; 		
			regForm_mc.password2_txt.text = ""; 		
trace("in registrationFormDoc: 2");
			
			req = new URLRequest( page );
			req.method = URLRequestMethod.POST;		// or just "POST"
trace("in registrationFormDoc: 3");
			 
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
			formData.firstname = regForm_mc.firstName_txt.text;
			formData.lastname = regForm_mc.lastName_txt.text;
			formData.email = regForm_mc.eMail_txt.text;
			formData.password = regForm_mc.password1_txt.text;
			
			if( regForm_mc.password1_txt.text !=  null  &&   formData.email.length > 0 ) {
			} else {
				regForm_mc.response_txt.text = "Password is a required field.";
			}	// endelse
			
			if( regForm_mc.password2_txt.text !=  null  &&   formData.email.length > 0 ) {
			} else {
				regForm_mc.response_txt.text = "You Must enter your Password twice.";
			}	// endelse
			
			if( regForm_mc.password1_txt.text ==  regForm_mc.password2_txt.text ) {
			} else {
				regForm_mc.response_txt.text = "The Passwords you typed did not match!";
			}	// endelse
			
			if( regForm_mc.firstName_txt.text !=  null  &&  formData.firstname.length > 0 ) {
			}else{
				regForm_mc.response_txt.text = "You must provide a First Name.";
			}// endelse
			
			if( regForm_mc.lastName_txt.text !=  null  &&  formData.lastname.length > 0 ) {
			}else{
				regForm_mc.response_txt.text = "You must provide a First Name.";
			}// endelse
			
			if( regForm_mc.eMail_txt.text !=  null  &&  formData.email.length > 0 ) {
			}else{
				regForm_mc.response_txt.text = "You must provide a First Name.";
			}// endelse
			
			

				//send the request to the server by requesting the page with the URLLoader
		}	// End Function validate
	
		public function sendData() {
			req.data = formData;
			loader.load( req );

		}	// End Function sendData
	
		public function handleResponse(ev:Event):void{
			//the xml data is back from the web server
			var vars:URLVariables = ev.target.data;				//loaderDataFormat.VARIABLES
			//var data:XML = XML( ev.target.data );				//loaderDataFormat.TEXT
			//var data:JSON = JSON( ev.target.data);			//loaderDataFormat.TEXT
			//trace( vars );
			regForm_mc.response_txt.text = vars.message;			//    message=way to go!
			//write the message into the feedback field
			
		}	// End Function handleResponse
		
		
		
		
	}	// End class registrationFormDoc
	
}	// End package