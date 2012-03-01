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
		
		
		public function registrationFormDoc() {
			// constructor code
			//regForm_mc.firstName_txt, lastName_txt, eMail_txt, password1_txt, password2_txt are the input fields
			//regForm_mc.submitButton_mc is the button to click to send the data
			//regForm_mc.response_txt is the field which will hold the response from the server
			regForm_mc.submit_mc.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			regForm_mc.submit_mc.addEventListener(MouseEvent.MOUSE_UP, mUp);
			regForm_mc.submit_mc.addEventListener(MouseEvent.CLICK, validate);
			
			//set a default value of empty string on all the text fields
			regForm_mc.firstName_txt.text = "";
			regForm_mc.lastName_txt.text = ""; 			
			regForm_mc.eMail_txt.text = ""; 			
			regForm_mc.password1_txt.text = ""; 		
			regForm_mc.password2_txt.text = ""; 		
			
			req = new URLRequest( page );
			req.method = URLRequestMethod.POST;		// or just "POST"
			 
			loader = new URLLoader();
			loader.dataFormat = dataFormat;
			loader.addEventListener(Event.COMPLETE, handleResponse);
		}	// End Function registrationFormDoc
		
		public function mDown() {
			//visual effect

		}	// End Function mDown
	
		public function mUp() {
			//visual effect

		}	// End Function mDown
	
		public function validate() {
			//gather the data from the "form" as save as a URLRequest params before sending them to the server
			var vars:URLVariables = new URLVariables();
			vars.fullname = form_mc.fullName_txt.text;
			vars.fullNAME = "other value";
			req.data = vars;
			//add any other form fields to be sent to the server into the vars object
			//add the vars object to the request object
			if( form_mc.fullName_txt.text !=  null  &&  vars.fullname.length > 0 ){
				loader.load( req );
				//send the request to the server by requesting the page with the URLLoader
			}else{
				form_mc.feedback_txt.text = "Type something first you moron.";
			}

		}	// End Function mDown
	
		public function sendData() {

		}	// End Function mDown
	
		
		
		
		
	}	// End class registrationFormDoc
	
}	// End package