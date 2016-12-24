
$(document).ready(function(){

	changeRequestsTable = $('#changeRequestsTable').DataTable({
                "tableTools": {
                        "sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf",
                        "aButtons": [
                            {
                                "sExtends": "copy",
                                "sButtonText": "Copy To ClipBoard",
                            },
                            {
                                "sExtends": "xls",
                                "sFileName": "*.xls",
                                "sButtonText": "Download XLS",
                            },
                            {
                                "sExtends": "print",
                            }
                     ]
                  },
	          "bInfo": false,
            "sEmptyTable": "There are no records",
            "aaSorting": [],
            "processing": true,
            "dom": '<"toolbar">T<"clear">lfrtip',
            "scrollX" : true
        });

  $("#requestBreakFix").on('click',function (){
    $("#breakFixModal").modal();
  })

/*console.log("Starting eventSource");
var eventSource = new EventSource("/ops/test?crqId=" + $("#crqId").val() + "&updatedAt=" + $("#updatedAt").val() + "&updatedBy=" + $("#updatedBy").val() + "&role=" + $("#role").val());
console.log("Started eventSource");
eventSource.onmessage   = function(e) {
console.log(e.data)

var data = JSON.parse(e.data)
console.log("Message received: " + data); 

  if(data != "No Updates"){
    changeRequestsTable.clear().rows.add(data).draw()
  }
};

eventSource.addEventListener('NOEVENT', function (event){
  console.log(event.data)

var data = JSON.parse(event.data)
console.log("Message received: NOEVENT" + data); 

});

eventSource.addEventListener('OPS', function (event){
  console.log(event.data)

var data = JSON.parse(event.data)
console.log("Message received: OPS" + data); 

});

eventSource.onopen      = function(event) { console.log("Open " + event); };
eventSource.onerror     = function(event) { console.log("Error " + event.data); };
console.log("eventState: " + eventSource.readyState);*/
// Stop trying after 10 seconds of errors
//setTimeout(function() {eventSource.close();}, 10000);

var ws = new SockJS("http://localhost:8080/stomp");
var wsClient = Stomp.over(ws)
var subscribedMessage 
wsClient.connect({}, function(){
  subscribedMessage = client.subscribe("/topic/update", function(message){
    console.log("Message from Server is " + message.body)
  })
})

	var urlToLoad = "/ops/getTableDetails?status=1"

		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of Change Requests Pending For Approval')

    $("#dataTableStatus").val("1")

    $("#autoRefreshTable").on('click',function(){
      var url = "/ops/getTableDetails?status=" + $("#dataTableStatus").val()
      changeRequestsTable.ajax.url(url).load()
      viewCrqsStatus($("#dataTableStatus").val())

    })

	$("#introJsDashboard_1").on('click', function(){
		
    viewCrqsStatus("1")
    $("#dataTableStatus").val("1")
		var urlToLoad = "/ops/getTableDetails?status=1"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of CRQs, to be requested for SCC Approval')

	})
	$("#introJsDashboard_2").on('click', function(){
		viewCrqsStatus("2")
    $("#dataTableStatus").val("2")
		var urlToLoad = "/ops/getTableDetails?status=2"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of CRQs,pending approval from SCC')
	})

	$("#introJsDashboard_3").on('click', function(){
		viewCrqsStatus("3")
    $("#dataTableStatus").val("3")
		var urlToLoad = "/ops/getTableDetails?status=3"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of CRQs, SCC seeking clarification from you')
	})

	$("#introJsDashboard_4").on('click', function(){
		viewCrqsStatus("4")
    $("#dataTableStatus").val("4")
		var urlToLoad = "/ops/getTableDetails?status=4"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of inprogress CRQs')
	})

	$("#introJsDashboard_5").on('click', function(){
		viewCrqsStatus("5")
    $("#dataTableStatus").val("5")
		var urlToLoad = "/ops/getTableDetails?status=5"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of Historic CRQs')
	})

	viewCrqsStatus("all");

})

function showUploadedFiles (crqId) {

$("#uploadBody").empty()
$("#id").val(crqId);

  $.get("/ops/getUploadedFiles?id="+crqId,function(data){
                    var i = 1
                    var span = document.createElement('span')
                    var textNode = document.createTextNode("Uploaded Documents")
                    span.setAttribute("id","crqAttachmentsHeading")
                    span.appendChild(textNode)
                    document.getElementById("uploadBody").appendChild(span)

                    if(data == ""){
                      $("#crqAttachmentsHeading").html($("#crqAttachmentsHeading").html() + " ( No documents Uploaded )") 
                      //$("<BR><span>You have not uploaded any documents</span><BR>").appendTo("#uploadedImages")
                    }else{
                      var table = document.createElement('table')
                          table.setAttribute("id","uploadedImages")
                          table.setAttribute("class","table table-bordered")
                          table.setAttribute("style","width:10%;")
                                                  
                      var tableBody = document.createElement('TBODY')
                      var tableRow
                      var tableCell2 
                      var tableCell3 

                      $.each(data,function(index){

                          tableCell2 = document.createElement('TD')

                          document.getElementById("uploadBody").appendChild(table) 
                          tableRow = document.createElement('TR');
                          tableRow.setAttribute("id","image_"+i);
                          
                         $("<a target='_blank' href='"+ data[index].name +"'>"+data[index].fileName+" </a>").appendTo(tableCell2)
                          tableRow.appendChild(tableCell2)
                         if(data[index].button != ""){

                         tableCell3 = document.createElement('TD')
                           
                           $(data[index].button.split("(")[0] + "('" + data[index].fileName+","+i+","+crqId+ "'" + data[index].button.split("(")[1]).appendTo(tableCell3)
                           tableRow.appendChild(tableCell3)
                           
                         }
                         tableBody.appendChild(tableRow)
                          
                        i++;
                        
                      });

                      document.getElementById("uploadedImages").appendChild(tableBody)
                    }
                  })
  
}

function removeUploadedImages(details){
  var fileName = details.split(",")[0]
  var link = details.split(",")[1]
  var crqId = details.split(",")[2]

  $.ajax({

    url:"/ops/removeImage?fileName=" + fileName + "&id=" + crqId,
    type:"POST",
    cache: false,
    contentType: false,
    processData: false,
    success:function(){
    },
    error:function(){
      alert("Could Not Delete File")
    },
    complete:function(){
      $("#image_"+link).remove()
    }
  })
}

function viewCrqsStatus(status) {

           $.ajax({

              url:"/ops/fetchDashBoardValues",
              dataType:"json",
              success:function(data){
                
              	var refVal = parseInt(0)
              	var counter = parseInt(0)

              	$.each(data,function(key,value){

              		if(counter == parseInt(0)){

              			refVal = parseInt(data.key)

              			counter++;
              		}else if(parseInt(data.key) < refVal){

              			refVal = parseInt(data.key)

              			counter++ ;
              		}else{

              			counter++;
              		}
              	})

                var currentVal = parseInt(data.toBeRequested) + parseInt(data.pendingApproval) + parseInt(data.inProgress) + parseInt(data.pendingClarification) + parseInt(data.historic) + parseInt(100)
                var toBeRequestedVal = data.toBeRequested
                var pendingApprovalVal = data.pendingApproval
                var pendingClarificationVal = data.pendingClarification
                var inProgressVal = data.inProgress
                var historicVal = data.historic

                var allCounts = setInterval(function ()
                  { 
                      if (currentVal == refVal)
                      {
              		      $("#toBeRequested").html(data.toBeRequested);
	                      $("#pendingApproval").html(data.pendingApproval);
             		        $("#pendingClarification").html(data.pendingClarification);
             		        $("#inProgress").html(data.inProgress);
             		        $("#rejected").html(data.historic);

                        clearInterval(allCounts);
                        
                      }
                      else
                      {
                          currentVal--;   
                          if(currentVal >= toBeRequestedVal){

                            $("#toBeRequested").html(currentVal);
                          
                          }
                          if(currentVal >= pendingApprovalVal){
                            $("#pendingApproval").html(currentVal);
                          }
                          if(currentVal >= pendingClarificationVal){
                            $("#pendingClarification").html(currentVal);
                          }
                          if(currentVal >= inProgressVal){
                            $("#inProgress").html(currentVal);
                          }
                          if(currentVal >= historicVal){
                            $("#rejected").html(currentVal);
                          }
                      }
                  }, 5)

              },
              error:function(jqXHR,textStatus,errorThrown){
              }
           })

}
