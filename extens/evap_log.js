/* Prakhar Sahay 04/15/2015

Following evap_profile.js and evap_friends.js, this visits the activity log and evaporates
the past 8 weeks.
*/


function evap_log(sub){

	// find 3 months back to completely load two months back
	var month=(new Date().getMonth()+9)%12+1;// 3 months back, 1-indexing
	var month_name=[month-1];// 3 months back, 0-indexing
	var year=new Date().getYear()+1900;
	var id="month_"+year+"_"+month;
	scroll_log(sub,id);
}

function scroll_log(sub,id){
	var fblock=document.getElementById(id);
	if(fblock==null){
		console.log("reattempt");
		scrollBy(0,2000);
		setTimeout(function(){scroll_log(sub,id)},300);
	}else{
		finish_log(sub,id);
	}
}

function finish_log(sub,id){
	var act_hash={};
	var dates=document.getElementsByClassName("_5ep8");
	for(var i=0;i<dates.length;i++){
		var day=dates[i].textContent;
		act_hash[day]=[];
		var act=dates[i].nextSibling;
		while(act){
			act_hash[day].push(act.textContent);
			act=act.nextSibling;
		}
	}
	// canon
	var pay=JSON.parse(localStorage.pay);
	pay.log=act_hash;
	localStorage.pay=JSON.stringify(pay);

	sub.set("name",pay.name);
	sub.set("payload",pay);
	sub.save({success:function(){
		console.log("Bro!");
		localStorage.duty="friends";
	}});
}