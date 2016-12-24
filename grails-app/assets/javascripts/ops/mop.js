
var mopTable;


/* Mop Details */
$(document).on("click",".approveMop",function(e){

  $("#spanMopDetails").text("MOP Details - Approved");
  $(".approveMop").css("display","none");
  $(".rejectMop").css("display","inline");
  $(".rejectMop").css("margin-left","80%");

  $("#mopDetailsConfirm").val('confirm');
  chkMopProceedButton();
});

$(document).on("click",".rejectMop",function(e){
  
  $("#spanMopDetails").text("MOP Details - Rejected");
  $(".approveMop").css("display","inline");
  $(".rejectMop").css("display","none");

  $("#mopDetailsConfirm").val('reject');
  chkMopProceedButton();
});

$(document).on("click","#btnMopDetails",function(e){
  var crqVal = $("#crqId").val();
  window.location.href = "/ops/summaryDetails?crqId="+crqVal; 
});


function chkMopProceedButton()
{
  var mopVal = $("#mopDetailsConfirm").val();
  
  if((mopVal != ''))
  {
    $("#showMopButton").css("display","block");
  }
  else
  {
   $("#showMopButton").css("display","none"); 
  }
}

fnMopTable();

function fnMopTable()
{

  table = $('#mopTable').DataTable({
      "ajax":{
          "type" : "POST", 
          "url":"/Ops/fetchMopDetails",
          "data" : {
              crqId:$("#crqId").val()
          }
      },
      "columnDefs": [
          
      ],
      "bPaginate": false,
      "order": [[ 1, 'desc' ]],
      "sScrollX": "100%",
      "bFilter": false,
      "columns": [
          { "data": "mopName" },
          { "data": "customerName" },
          { "data": "create_user"},
          { "data": "create_datetime"},
          { "data": "approval_user"},
          { "data": "approval_datetime"}
      ],
      "processing": true,
      "dom": '<"toolbar">T<"clear">lfrtip'
  });
}
