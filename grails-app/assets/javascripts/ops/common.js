
var changeRequestsTable

$(document).ready(function () {

    startTimer(parseInt($("#getTime").val()), $('#time'));

  $.toaster({ settings : {
    'donotdismiss' : [],
    'timeout'      : 2000,
    'toaster'      :
    {
          'id'        : 'toaster',
          'container' : 'body',
          'template'  : '<div></div>',
          'class'     : 'toaster',
          'css'       :
          {
              'position' : 'fixed',
              'top'      : '10px',
              'right'    : '10px',
              'width'    : '500px',
              'zIndex'   : 50000
          }
      },
      
  }});
  
})


function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = parseInt(timer / 60, 10)
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.text(minutes + ":" + seconds);

        if (--timer < 0) {
            $("#autoRefreshTable").trigger('click')
            timer = duration;
        }
    }, 1000);
}

function generateErrorMessage(ele,msg){
  $('html, body').animate({
    scrollTop: $("#"+ele).offset().top-200
  }, 1000);

  $("#"+ele).focus();
  $.toaster({ priority : 'danger', title : 'Error', message : msg });
}

function fetchCrqDetails(crqId,eng){

  var url = "/ops/fetchCrqTimeLines?id=" + crqId + "&comments=" + eng
  $("#uploadBody").empty();
  $("#crqId").val(crqId);

  $.ajax({

    type:"GET",
    url:url,
    cache: false,
        contentType: false,
        processData: false,
        success:function (data){
          
          var text = ""
          var text2 = ""
          var status 
          var number
          $.each(data,function (index){
            if(index < (data.length - 1)){
              text =text+"<div class='border-red m-heading'> <strong>"+data[index].updatedBy+"</strong> on "
              text+=data[index].updatedAt+"<p>"+data[index].comments+"</p></div>"
            }else{
              text2 = data[index].div
              status = data[index].status
              number = data[index].crqNumber
            }

          })
          $("#crqNumber").html(number)
          console.log(data.length) 
         if(data.length <= 1){
        $("#commentsSection").hide()
        $("#textArea").html(text2)
           }
         else{ 
             $("#commentsDiv").html(text);
             $("#textArea").html(text2)
             if(text2.indexOf("textarea") > 0){
              $("#commentsSection").find('p:first').hide()
             }else{
              $("#commentsSection").find('p:first').show()
             }
          $("#commentsSection").show()         
         }
         if(parseInt(status) == 4 && eng == "ops"){

              initiateDropZone(status)
          }
          if(parseInt(status) == 8){

            initiateDropZone(status)
            showUploadedFiles(crqId)

          }if(parseInt(status) == 6){
            showUploadedFiles(crqId)
          }
        },
        error:function (){
          console.log("Error Occured")
        }


  })

  $("#commentModal").modal()

}

function initiateDropZone(status){

  var myDropZone = new Dropzone("form#crqDrop",{init:function() {
                this.on("error", function(file, data) {
                        alert(data);
                });
                this.on("addedfile", function(file) {
                        // Create the remove button
                        var removeButton = Dropzone.createElement("<div><button style='width: 100%;text-align:center;' class='btn btn-danger dz-remove'>Remove</button></div>");
                        // Capture the Dropzone instance as closure.
                        var _this = this;

                        // Listen to the click event
                        removeButton.addEventListener("click", function(e) {
                                // Make sure the button click doesn't submit the form:
                                e.preventDefault();
                                e.stopPropagation();
                                // Remove the file preview.
                                _this.removeFile(file);

                                $.ajax({
                                        url: "/ops/removeImage",
                                        data:{id:$("#id").val(),fileName:file.name},
                                        dataType: "json",
                                        success: function(data) {
                                        }
                                });
                        });

                        // Add the button to the file preview element.
                        file.previewElement.appendChild(removeButton);
                });
        }})

          if(status == 4){
            $.get("/ops/getUploadedFiles?id="+$("#id").val(),function(data){
            if(data != ""){

              $.each(data,function(key,value){

                var mockFile = { name: "Filename", size: 12345 };
              myDropZone.emit("addedfile", mockFile);
              myDropZone.emit("thumbnail", mockFile, "/ops/getImage?id="+$("#id").val()+"&file="+value.fileName);

              // Make sure that there is no progress bar, etc...
              myDropZone.emit("complete", mockFile);

              })

            }
          });
          }
}
function updateCrq(status){

  if($("#comments").val() == ""){

    generateErrorMessage('comments',"Comments cannot be Empty");

    return false;
  }

  var postData = new FormData();

  postData.append('id',$("#crqId").val())
  postData.append('description',$("#comments").val())
  postData.append('status',status)

  $.ajax({

    url:"/ops/updateCrqStatus",
    data:postData,
    type:"POST",
    cache: false,
        contentType: false,
        processData: false,
        success:function (){
          console.log("Success")
          viewCrqsStatus();
        var urlToLoad = "/ops/getTableDetails?status=" + status
        changeRequestsTable.ajax.url(urlToLoad).load()
        },
        error:function (){
          console.log("Error Occured")
        }
  })

  var element = document.getElementById("commentModal");

  if(element != null){

    $("#commentModal").modal('hide')

  }else{
    window.location.href = "/ops/scc/"
  }

}