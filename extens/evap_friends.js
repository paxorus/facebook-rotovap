/* Prakhar Sahay 04/14/2015

evap: friends
pay: user, name, numfs, names
*/

// now evaporate the friends!

function evap_friends(){
	var pay={user:localStorage.username,name:"",numfs:[],names:[]};
	pay.name=document.getElementById("fb-timeline-cover-name").textContent;
	localStorage.pay=JSON.stringify(pay);

	// go push to numfs[] and names[]
	scroll_down();
}

function scroll_down(){
	var fblock=document.getElementById("pagelet_timeline_medley_friends").nextSibling;
	if(fblock==null){
		console.log("reattempt");
		scrollBy(0,2000);
		setTimeout(function(){scroll_down()},500);
	}else{
		finish_friends();
	}
}


function finish_friends(){
	var numfs=[],names=[];
	var arr=document.getElementsByClassName("fsl fwb fcb");
	for(var i=0;i<arr.length;i++){
		var fs;
		console.log(arr[i].nextSibling)
		// skip pushing if no info on fs
		fs=arr[i].nextSibling;
		if(fs){	
			if(fs.textContent.indexOf("friends")>-1){
				numfs.push(fs.textContent);
				names.push(arr[i].textContent);
			}
		}
	}

	// send over
	var pay=JSON.parse(localStorage.pay);
	pay.numfs=numfs;
	pay.names=names;	
	localStorage.pay=JSON.stringify(pay);

	localStorage.duty="log";
	var href_end=(localStorage.username.startsWith("profile.php"))?"&sk=allactivity":"/allactivity";
	location.href="https://www.facebook.com/"+localStorage.username+href_end;	
}