/* Prakhar Sahay 04/11/2015

evap: profile->blocks, groups, about, top10, incoming, outgoing, finish
pay: date, user, name, nf, ng, birth, top, nblock, ninc, nout
*/

// default, initial call
function evap_profile(){
	var pay={date:new Date(),user:localStorage.username,name:"",nf:0,ng:0,birth:"",top:[],nblock:0,ninc:0,nout:0};
	pay.name=document.getElementById("fb-timeline-cover-name").textContent;
	pay.nf=parseInt(document.getElementsByClassName("_gs6")[0].textContent,10);
	if(!pay.nf){
		pay.nf=(document.getElementsByClassName("requestInfoContainer").length)?1:0;
	}
	localStorage.pay=JSON.stringify(pay);

	// get the blocked people
	document.getElementsByClassName("_59fb")[0].click();
	setTimeout(function(){
		document.getElementsByClassName("_8-c")[2].click();
		setTimeout(function(){evap_blocks(pay)},1000);
	},3000);

}

// evap_profile->evap_blocks
function evap_blocks(pay){
	pay.nblock=document.getElementsByClassName("_dp-").length;
	localStorage.pay=JSON.stringify(pay);	

	localStorage.duty="groups";
	location.href="https://www.facebook.com/groups/?category=membership";
}


// get # of groups
function evap_groups(){
	var pay=JSON.parse(localStorage.pay);
	pay.ng=document.getElementsByClassName("_5xsz").length;
	localStorage.pay=JSON.stringify(pay);

	localStorage.duty="about";
	var href_end=(localStorage.username.startsWith("profile.php"))?"&sk=about":"/about";
	location.href="https://www.facebook.com/"+localStorage.username+href_end;
}

// set the birthday
function evap_about(){
	var pay=JSON.parse(localStorage.pay);
	var temp=document.getElementsByClassName("_c24 _50f3");
	for(var i=0;i<temp.length;i++){
		if(temp[i].textContent.startsWith("Birth")){
			pay.birth=temp[i].textContent.substring(8);			
			break;
		}
	}
	localStorage.pay=JSON.stringify(pay);

	localStorage.duty="top10";
	var href_end=(localStorage.username.startsWith("profile.php"))?"&sk=friends":"/friends";
	location.href="https://www.facebook.com/"+localStorage.username+href_end;
}

// set the top 10 friends
function evap_top10(sub){
	var pay=JSON.parse(localStorage.pay);
	var f_arr=[];
	var elem_arr=document.getElementsByClassName("fcb");
	for(var i=0;i<10;i++){
		f_arr.push(elem_arr[i].textContent);
	}
	pay.top=f_arr;
	localStorage.pay=JSON.stringify(pay);

	localStorage.duty="ninc";
	location.href="https://www.facebook.com/friends/requests/?fcref=jwl";
}

// set the # of incoming friend requests
function evap_ninc(){
	var pay=JSON.parse(localStorage.pay);
	pay.ninc=parseInt(document.getElementsByClassName("_34e")[0].textContent.substring(16),10);
	localStorage.pay=JSON.stringify(pay);

	localStorage.duty="nout";
	location.href="https://www.facebook.com/friends/requests/?fcref=jwl&outgoing=1";
}

// set the # of sent friend requests
function evap_nout(sub){
	var see_more=document.getElementsByClassName("_5cz")[0];
	if(see_more && see_more.textContent=="See More Requests"){
		console.log("reattempt");
		see_more.click();
		setTimeout(function(){evap_nout(sub)},300);
	}else{
		finish_nout(sub);
	}
}


function finish_nout(sub){
	var pay=JSON.parse(localStorage.pay);
	pay.nout=document.getElementsByClassName("_6-_").length;	
	localStorage.pay=JSON.stringify(pay);

	sub.set("name",pay.name);
	sub.set("payload",pay);
	sub.save({success:function(){
		// completed phase 1/3
		localStorage.pay="";
		localStorage.duty="friends";
		var href_end=(localStorage.username.startsWith("profile.php"))?"&sk=friends":"/friends";
		location.href="https://www.facebook.com/"+localStorage.username+href_end;
	}});
}