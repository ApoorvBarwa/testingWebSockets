$(document).ready(function(){	
		 
	$("#slider").bind("valuesChanged", function(e, data){		
		//console.log("Something moved. min: " + data.values.min + " max: " + data.values.max);		
		var tempMinTime = new Date(data.values.min)
		var tempMaxTime = new Date(data.values.max)
		var url = "/cmReport/fetchAllChangeRequest?mint="+tempMinTime.getTime()+"&maxt="+tempMaxTime.getTime();
		table.ajax.url(url).load(callback);
		$('#productTableChart').hide();
		$("#searchRequestsHeader").html('Showing CRQs Between ' + tempMinTime.getFullYear() + "-" + tempMinTime.getMonth() + "-" + tempMinTime.getDate() + " " + addZero(tempMinTime.getHours()) + ":" +addZero(tempMinTime.getMinutes()) + " and " + tempMaxTime.getFullYear() + "-" + tempMaxTime.getMonth() + "-" + tempMaxTime.getDate() + " " + addZero(tempMaxTime.getHours()) + ":" +addZero(tempMaxTime.getMinutes()))
		//getCmChart(minTime,maxTime);
	});

	function addZero(val) {
	    if (val < 10) {
	        return "0" + val;
	    }	
	    return val;
	}
	var dt = new Date();
	
	$("#slider").dateRangeSlider({
	    bounds: {
	    	min: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() - 2)), 
	    	max: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() + 2), 12, 59, 59)
		},
	    defaultValues: {
	    	min: new Date(dt.getFullYear(), dt.getMonth(), dt.getDate()), 
	    	max: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() + 2), 12, 59, 59)
		},
	    range: {
	        min: {
	            hours: 1
	        }
	    },
	    scales: [{
	        first: function (value) {
	            return value;
	        },
	        end: function (value) {
	            return value;
	        },
	        next: function (value) {
	            var next = new Date(value);
	            return new Date(next.setHours(value.getHours() + 1));
	        },
	        label: function (value) {
	            return value.getHours();
	        },
	        format: function (tickContainer, tickStart, tickEnd) {
	            tickContainer.addClass("myCustomClass");
	        }
	    }],
	    formatter: function (val) {
	        var h = val.getHours();
	        var m = val.getMinutes();
	    	var days = val.getDate();
	        var month = val.getMonth() + 1;
	        var year = val.getFullYear();
	        return days + "-" + month + "-" + year + ' ' + addZero(h) + ':' + addZero(m);
	    }


	});

/*
var dt = new Date();
$("#slider").dateRangeSlider({
    bounds: {
    	min: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() - 2)), 
    	max: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() + 2), 12, 59, 59)
	},
    defaultValues: {
    	min: new Date(dt.getFullYear(), dt.getMonth(), dt.getDate()), 
    	max: new Date(dt.getFullYear(), dt.getMonth(), (dt.getDate() + 2), 12, 59, 59)
	},
	scales: [{
		first: function(value){ return value; },
		end: function(value) {return value; },
		next: function(value){
			var next = new Date(value);
			return new Date(next.setMonth(value.getMonth() + 1));
		},
		label: function(value){
			return months[value.getMonth()];
		},
		format: function(tickContainer, tickStart, tickEnd){
			tickContainer.addClass("myCustomClass");
		}
	}]
});
  */

});

function resetSlider(){

	$("#slider").dateRangeSlider("values", new Date(1421841600000), new Date(1429841600000));

}