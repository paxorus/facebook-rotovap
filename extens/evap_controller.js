/* Prakhar Sahay 04/11/2015

This is the operational switch to discriminate what needs to be done on the page.
*/


setTimeout(function(){
	if(!location.href.startsWith("https://www.facebook.com")){
		return;
	}
	console.log("Good page.");
	Parse.initialize("RbxG0jfMX943mJSPt9Yc3j9low4y43HcDybxJuG1","R3xwX3Bxfx26cTdAKgSNuYVUibIAxNQYiFwBkzD1");
	var Subject=Parse.Object.extend("Subject");
	var sub=new Subject();
	var payload;

	var href=location.href.indexOf(".com/");
	href=location.href.substring(href+5);

	switch(localStorage.duty){
		case "groups":evap_groups();break;
		case "about":evap_about();break;
		case "top10":evap_top10();break;
		case "ninc":evap_ninc();break;
		case "nout":evap_nout(sub);break;

		case "log":evap_log();break;
		case "friends":evap_friends();break;
		case "chat":evap_chat();break;
		default:
			localStorage.username=href;// save username
			evap_profile();
	}

	// sub.set("name",localStorage.name);
	// sub.set("payload",payload.);
},100);