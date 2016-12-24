var numberOnly= function (event) {
	    if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
	             // Allow: Ctrl+A
	            (event.keyCode == 65 && event.ctrlKey === true) ||
	 
	        // Allow: home, end, left, right
	            (event.keyCode >= 35 && event.keyCode <= 39)) {
	              // let it happen, don't do anything
	              return;
	        } else {
	            // Ensure that it is a number and stop the keypress
	            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
	                event.preventDefault();
	            }
	        }
	   }

var alphaOnly = function (e) {     
	 if (e.shiftKey || e.ctrlKey || e.altKey) {
	 		 // e.preventDefault();
	 } else {
		 var key = e.keyCode;
		 if (!((key == 8) || (key == 32) || (key == 46) || (key >= 35 && key <= 40) || (key >= 65 && key <= 90))) {
	 		// e.preventDefault();
	 	 }
	 }
}


function calculateDuration(startTime,endTime,id) {
   

	  var one_day=1000*60*60*24;

	  
	  var match = startTime.match(/^(\d+)-(\d+)-(\d+) (\d+)\:(\d+)$/)
	  if(!match){
		  return false;
	  }
	  var date1 = new Date(match[1], match[2] - 1, match[3], match[4], match[5])

	  match = endTime.match(/^(\d+)-(\d+)-(\d+) (\d+)\:(\d+)$/)
	  if(!match){
		  return false;
	  }
	  var date2 = new Date(match[1], match[2] - 1, match[3], match[4], match[5])
      
	  if (date2.getTime() < date1.getTime()){
		  alert("End time cannot be less than start time");
		  return false
	  }

	  if (date2.getTime() == date1.getTime()){
		  alert("End time cannot be equal to start time");
		  return false
	  }


	  var date1_ms = date1.getTime();
	  var date2_ms = date2.getTime();

	  // Calculate the difference in milliseconds
	  var difference_ms = date2_ms - date1_ms;
	  //take out milliseconds
	  
	  //alert(difference_ms)
	  
	  //console.log("diff " + difference_ms)
	   
	  difference_ms = difference_ms/1000;
	  
	  
	  var seconds = Math.floor(difference_ms % 60);
	  difference_ms = difference_ms/60; 
	  
	 // console.log(seconds)
	  var minutes = Math.floor(difference_ms % 60);
	  difference_ms = difference_ms/60; 
	  //console.log(minutes)
	  
	  var hours = Math.floor(difference_ms % 24);  
	  var days = Math.floor(difference_ms/24);

	  //alert(hours + "-->" + days)
	  hours = (days * 24) + hours;
	  
	  
	  
	  var string = '';
	  
	  
	  if(hours != 0){
		  string = hours  +' hrs '
	  }

	  if(minutes != 0){
		  string = string + minutes +' mins '
	  }
	  
	  //alert(string);
	  $('#'+id).val(string);
	  
	  return true
	 
	}
