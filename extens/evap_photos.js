/* Prakhar Sahay 04/16/2015

First get "photos of you" (if possible) and # of albums+pictures. Then iterate through 8 weeks of photos. 
*/

var MONTHS=["January","February","March","April","May","June",
	"July","August","September","October","November","December"];
var start_url="";
var today=new Date();
var stop_date={d:today.getDate(),m:(today.getMonth()+9)%12};


function evap_phofyo(){// photos of you
	var pay={user:localStorage.username,name:"",dates:[],likes:[],comments:[]};
	pay.name=document.getElementById("fb-timeline-cover-name").textContent;
	localStorage.pay=JSON.stringify(pay);

	// may not have phofyo, skip duty
	if(get_tab("Photos of You")){
		scroll_page(finish_phofyo);
	}else{
		localStorage.duty="albums";
		get_tab("Albums").click();
	}
}

function scroll_page(callback){
	var fblock=document.getElementsByClassName("mbm _5vf sectionHeader _4khu")[0];
	if(fblock==null){
		console.log("reattempt!");
		scrollBy(0,2000);
		setTimeout(function(){scroll_page(callback)},600);
	}else{
		callback();
	}
}

function finish_phofyo(){
	var elem=document.getElementsByClassName("fbPhotosRedesignBorderOverlay")[0];
	var num=elem.children.length;

	// canon
	var pay=JSON.parse(localStorage.pay);
	pay.phofyo=num;
	localStorage.pay=JSON.stringify(pay);
	localStorage.duty="albums";
	get_tab("Albums").click();
	setTimeout(function(){location.reload()},500);
	// var href_end=(localStorage.username.startsWith("profile.php"))?"&sk=photos":"/photos_albums";
	// location.href="https://www.facebook.com/prakhar.studios/photos_albums";
}

function finish_albums(){
	var arr=document.getElementsByClassName("photoTextTitle");
	var num_photos=[];
	for(var i=0;i<arr.length;i++){
		num_photos.push(arr[i].nextSibling.textContent);
	}

	// canon
	var pay=JSON.parse(localStorage.pay);
	pay.albums=arr.length;
	pay.photos=num_photos;
	localStorage.pay=JSON.stringify(pay);
	localStorage.duty="photos";

	get_tab("Your Photos").click();
	setTimeout(function(){location.reload()},500);
}

// one-time call for "Your Photos"
function evap_photos(sub){
	var grid=document.getElementsByClassName("fbStarGrid");
	if(grid[0].parentNode.className.indexOf("hidden_elem")>-1){
		grid=grid[1];// there's probably a second one that's not hidden
	}else{
		grid=grid[0];
	}
	var first_img=grid.getElementsByClassName("uiMediaThumbImg")[0];	

	// localStorage.duty="panning";
	first_img.click();
	setTimeout(function(){pan_photo(sub)},2000);
}

// takes across multiple pages: go back 8 weeks of photos
function pan_photo(sub){
	var stamp=document.getElementById("fbPhotoSnowliftTimestamp").firstChild.textContent;
	if(start_url==location.href || should_stop(stamp)){// if returning to start_url, or beyond 8 weeks
		console.log(should_stop(stamp));
		console.log(stamp);
		finish_photo(sub);
		return;
	}else if(start_url==""){// if first call
		start_url=location.href;
	}

	// strip photo
	var ops_bar=document.getElementsByClassName("UIActionLinks UIActionLinks_bottom")[0];
	var like_bar=ops_bar.nextSibling.getElementsByClassName("UFILikeSentence")[0];
	var likes=(like_bar)?like_bar.textContent:0;
	var comments=ops_bar.nextSibling.getElementsByClassName("UFICommentContent").length;

	// modified canon
	var pay=JSON.parse(localStorage.pay);
	pay.likes.push(likes);
	pay.comments.push(comments);
	pay.dates.push(stamp);
	localStorage.pay=JSON.stringify(pay);

	// click next
	var next_arrow=document.getElementsByClassName("snowliftPager next hilightPager")[0];
	next_arrow.click();
	setTimeout(function(){pan_photo(sub)},750);
}

function finish_photo(sub){
	var pay=JSON.parse(localStorage.pay);
	sub.set("name",pay.name);
	sub.set("payload",pay);
	sub.save({success:function(){
		console.log("Bro!");
		localStorage.duty="";
	}});
}


function get_tab(name){
	var tab_list=document.getElementsByClassName("_3dc lfloat _ohe _5brz")[0].children;
	for(var i=0,tab;i<tab_list.length;i++){
		if(tab_list[i].textContent==name){
			tab=tab_list[i];
			i=tab_list.length+10;// break
		}
	}
	return tab;
}

// cases: "February 28 at 10:23pm", "May 4, 2013", "2009" 
function should_stop(date){
	if(date.length==4){// "2009"
		return true;
	}
	var a=date.split(" ");

	if(a.length==3){// "May 4, 2013"
		return true;
	}

	var m=MONTHS.indexOf(a[0]);
	if(stop_date.m>m){
		return true;
	}
	var d=parseInt(a[1],10);
	if(stop_date.m==m && stop_date.d>d){
		return true;
	}

	return false;// date is good, strip it
}
