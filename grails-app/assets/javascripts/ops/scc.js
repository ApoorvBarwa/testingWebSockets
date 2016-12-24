
$(document).ready(function(){


	changeRequestsTable = $('#pendingSccApprovalTable').DataTable({
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
                  "processing": true,
                  "dom": '<"toolbar">T<"clear">lfrtip',
                  "order": [[ 0, "desc" ]],
                  "scrollX" : true
        });

	$("#introJsDashboard_1").on('click', function(){

    $("#dataTableStatus").val("pendingSCCApproval")
		viewCrqsStatus($("#dataTableStatus").val());
		var urlToLoad = "/ops/getSCCTableDetails?status=pendingSCCApproval"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of CRQs,pending approval from SCC')

	})
	$("#introJsDashboard_2").on('click', function(){
		 $("#dataTableStatus").val("pendingClarificationFromOPS")
    viewCrqsStatus($("#dataTableStatus").val());
		var urlToLoad = "/ops/getSCCTableDetails?status=pendingClarificationFromOPS"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of CRQs, SCC seeking clarification from OPS')
	})

	$("#introJsDashboard_3").on('click', function(){
		$("#dataTableStatus").val("inProgress")
    viewCrqsStatus($("#dataTableStatus").val());
		var urlToLoad = "/ops/getSCCTableDetails?status=inProgress"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of inprogress CRQs')
	})

	$("#introJsDashboard_4").on('click', function(){
		$("#dataTableStatus").val("historic")
    viewCrqsStatus($("#dataTableStatus").val());
		var urlToLoad = "/ops/getSCCTableDetails?status=historic"
		changeRequestsTable.ajax.url(urlToLoad).load()
		$('#changeRequestsHeader').html('List of Historic CRQs')
	})

  $("#dataTableStatus").val("pendingSCCApproval")
	viewCrqsStatus("all");
	var urlToLoad = "/ops/getSCCTableDetails?status=pendingSCCApproval"
	changeRequestsTable.ajax.url(urlToLoad).load()
	$('#changeRequestsHeader').html('List of CRQs,pending approval from SCC')

  $("#autoRefreshTable").on('click',function(){
      var url = "/ops/getSCCTableDetails?status=" + $("#dataTableStatus").val()
      changeRequestsTable.ajax.url(url).load()
      viewCrqsStatus($("#dataTableStatus").val())

    })

})

var crqVal
$(document).on("click",".crqbtn",function(e){
	crqVal = $(this).val();
  window.location.href = "/ops/crqDetails?crqId=" + crqVal
});


function viewCrqsStatus(status) {

           $.ajax({

              url:"/ops/fetchSCCDashBoardValues",
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

                var currentVal = parseInt(data.pendingApproval) + parseInt(data.inProgress) + parseInt(data.pendingOPSClarification) + parseInt(data.historic) + parseInt(100)
                var toBeRequestedVal = data.toBeRequested
                var pendingApprovalVal = data.pendingApproval
                var pendingOPSClarificationVal = data.pendingOPSClarification
                var inProgressVal = data.inProgress
                var historicVal = data.historic

                var allCounts = setInterval(function ()
                  { 
                      if (currentVal == refVal)
                      {
	                $("#pendingApproval").html(data.pendingApproval);
	                $("#pendingOPSClarification").html(data.pendingOPSClarification);
             		$("#inProgress").html(data.inProgress);
             		$("#historicRequests").html(data.historic);

                        clearInterval(allCounts);
                        
                      }
                      else
                      {
                          currentVal--;   
                          if(currentVal >= pendingApprovalVal){
                            $("#pendingApproval").html(currentVal);
                          }
                          if(currentVal >= pendingOPSClarificationVal){
                            $("#pendingOPSClarification").html(currentVal);
                          }
                          if(currentVal >= inProgressVal){
                            $("#inProgress").html(currentVal);
                          }
                          if(currentVal >= historicVal){
                            $("#historicRequests").html(currentVal);
                          }
                      }
                  }, 5)

              },
              error:function(jqXHR,textStatus,errorThrown){
              }
           })

}


$(document).on("click",".approveCrq",function(e){

$("#spanCrqDetails").text("CRQ Details - Approved");
$(".approveCrq").css("display","none");
$(".rejectCrq").css("display","inline");
$(".rejectCrq").css("margin-left","80%");

$("#crqDetailsConfirm").val('confirm');
chkProceedButton();
});

$(document).on("click",".rejectCrq",function(e){

$("#spanCrqDetails").text("CRQ Details - Rejected");
$(".approveCrq").css("display","inline");
$(".rejectCrq").css("display","none");

$("#crqDetailsConfirm").val('reject');
chkProceedButton();
});

$(document).on("click",".approverSelect",function(e){

$("#spanApproverDetails").text("Approvers - Approved");
$(".approverSelect").css("display","none");
$(".approverReject").css("display","inline");
$(".approverReject").css("margin-left","80%");

$("#approverConfirm").val('confirm');
chkProceedButton();
});

$(document).on("click",".approverReject",function(e){
$("#spanApproverDetails").text("Approvers - Rejected");
$(".approverSelect").css("display","inline");
$(".approverReject").css("display","none");

$("#approverConfirm").val('reject');
chkProceedButton();
});



$(document).on("click",".environmentSelect",function(e){

$("#spanEnvDetails").text("Environment - Approved");
$(".environmentSelect").css("display","none");
$(".environmentReject").css("display","inline");
$(".environmentReject").css("margin-left","80%");

$("#envConfirm").val('confirm');
chkProceedButton();
});

$(document).on("click",".environmentReject",function(e){
$("#spanEnvDetails").text("Approvers - Rejected");
$(".environmentSelect").css("display","inline");
$(".environmentReject").css("display","none");

$("#envConfirm").val('reject');
chkProceedButton();
});


$(document).on("click","#btnCrqDetails",function(e){
var crqVal = $("#crqId").val();
window.location.href = "/ops/mopDetails?crqId="+crqVal; 
});

function chkProceedButton()
{
var crqVal = $("#crqDetailsConfirm").val();
var approverVal = $("#approverConfirm").val();
var envVal = $("#envConfirm").val();

if((crqVal != '') && (approverVal != '') && (envVal != ''))
{
$("#showButton").css("display","block");
}
else
{
$("#showButton").css("display","none"); 
}
}

