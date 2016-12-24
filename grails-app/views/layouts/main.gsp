<%@ page import="ir.CockpitConfiguration" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
   
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

  <asset:javascript src="application.js"/>
  <asset:stylesheet src="application.css"/>
       
    <!--[if lt IE 9]>
      <asset:javascript src="application_ielt9.js"/>
    <![endif]-->
    
    <g:layoutHead/>
    <r:layoutResources />

<g:if test="${CockpitConfiguration.findByKey('CHAT_MODULE').value.equals('Y')}">
<sec:ifLoggedIn>
<script type="text/javascript">

   var timestamp = '';
   var status = '';
   var fetchStatus = true;
  
    function retrieveLatestMessages() {
                fetchStatus = false;
    var m = $.ajax({
           type: 'post',
           url: '${request.contextPath}/chatMessage/fetchDetails?timestamp=' + timestamp + "&status=" + status,
           success: function(data) {
                          if ( data.message != undefined ) {
                           $('#chatDetails').append(data.message);    
                           timestamp = data.timestamp;
                          }
                           if (data.agentStatus == 'typing' ) {
                              $('#agentStatus').html(data.agentName + ' is typing.....');
                           }
                           else {
                              $('#agentStatus').html('');
                           }
                           
                           $('#chatDetails').scrollTop( $('#chatDetails').prop("scrollHeight"));
                           fetchStatus = true;
           }
    });
    if($('.toggle_chat').css('display') == 'none'){
      m.abort();
    }
     }

    function sendChatMessage() {
    $.ajax({
           type: 'post',
           url: '${request.contextPath}/chatMessage/sendDetails?message='+ $("#send").val() + '&pageLocation=' + location.pathname,
           success: function(data) {
                    $("#send").val('');
           }
    });
     }


    function pollMessages() {
        if (  fetchStatus ) { 
          retrieveLatestMessages();
        }
        setTimeout('pollMessages()', 1000);
    }
    pollMessages();

$(document).ready(function(){
   $( "#send" ).focus(function() {
      status = 'typing';
   });
   $("#send").focusout(function() {
     status = 'not typing';
   });

 $('#send').keyup(function(e){
    if(e.keyCode == 13)
    {
        sendChatMessage();
    }
});

$("#liveChatMenu").click(function(e){
  $(".shout_box").css('display','block');
  $('.toggle_chat').css('display','block');
  retrieveLatestMessages();
  localStorage.setItem('chatEnabled', 'true');
});

if(localStorage.getItem('chatEnabled') === 'true'){
  $(".shout_box").css('display','block');
}

$(".chatCloseBtn").click(function (e) {
  $(".shout_box").css('display','none');
  localStorage.setItem('chatEnabled', 'false');
});

$(".chat_header").click(function (e) {   
  if($('.toggle_chat').css('display') == 'none'){
    $('.toggle_chat').css('display','block');
    retrieveLatestMessages();
  }else{
    $('.toggle_chat').css('display','none');
  }
});

$("body").keydown(function (e) {  
    if(e.keyCode == "113"){
        $("#startTourMenu").trigger('click');
    }
});

});//end document

</script>
</sec:ifLoggedIn>
</g:if>

<style type="text/css">
<!--
.shout_box {
  background: #990000;
  width: 285px;
  overflow: hidden;
  position: fixed;
  bottom: 0;
  right: 20%;
  z-index:9;
}
.shout_box .header{
  padding: 5px 3px 5px 5px;
  font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
  font-weight: bold;
  color:#fff;
  border: 1px solid #97A0AF;
  border-bottom:none;
  cursor: pointer;
}
.shout_box .header:hover{
  background-color: #7F0F0F;
}
.shout_box .message_box {
  background: #FFFFFF;
  height: 200px;
  overflow:auto;
  border: 1px solid #CCC;
}
.shout_msg{
  margin-bottom: 10px;
  display: block;
  border-bottom: 1px solid #F3F3F3;
  padding: 0px 5px 5px 5px;
  font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
  color:#7C7C7C;
}
.message_box:last-child {
  border-bottom:none;
}
time{
  font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
  font-weight: normal;
  float:right;
  color: #D5D5D5;
}
.shout_msg .username{
  margin-bottom: 10px;
  margin-top: 10px;
}
.user_info input {
  width: 85%;
  height: 25px;
  border: 1px solid #CCC;
  border-top: none;
  padding: 3px 0px 0px 3px;
  font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
}
.shout_msg .username{
  font-weight: bold;
  display: block;
}
.shout_box .sendBtn{
  display:inline-block; color:white; cursor: pointer; text-decoration: none;
  font: bold 11px "lucida grande",tahoma,verdana,arial,sans-serif;
}
.shout_box .sendBtn:hover, .user_info:hover{
  background-color: #7F0F0F;
}
#agentStatus {
    background-color: #fff;
    border-bottom: 1px solid #ccc;
    border-left: 1px solid #ccc;
    border-right: 1px solid #ccc;
    color: #726161;
    font-style: italic;
    padding-left: 3px;
    font-size: 11px;
}
-->
.customIntroJsCls{
  max-width: 800px !important; 
}
</style>
  </head>
  <body>

           <g:set var="shout2team" value="N" />
           <sec:ifAnyGranted roles="ROLE_SHOUT2AUTOM8">
                <g:set var="shout2team" value="Y" />
           </sec:ifAnyGranted>

<sec:ifNotLoggedIn>

    <nav class="navbar navbar-inverse " role="navigation">

      <ul class="nav  navbar-nav">

        <li class="active"><a href="#">   Command Center Cockpit   <g:if env="test"> - Test </g:if>  <g:if env="development"> - Development </g:if> </a> </li>      

      </ul>

    </nav>


</sec:ifNotLoggedIn>

<sec:ifLoggedIn>


    <nav class="navbar navbar-inverse "  role="navigation">


      <ul class="nav navbar-nav ">

            <li class="active"><a href="${request.contextPath}/dashboard/index"> Command Center Cockpit   <g:if env="test"> - Test </g:if>  <g:if env="development"> - Development </g:if>  </a></li>

            <li class="dropdown active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">RCA Knowledgebase<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="${request.contextPath}/rcaMaster/rcaList">Search for RCAs</a></li>
                </ul>
            </li>

            <li class="dropdown  active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">EB Studio <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                
                          <li><a href="${request.contextPath}/incidentMaster/list">View all Notifications</a></li>
                           <li class="divider"></li>
                    <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
                           <li><a href="${request.contextPath}/incidentMaster/create">Create a new Notification</a></li>
                           <li class="divider"></li>                          
                    </sec:ifAnyGranted>       
                    <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM,ROLE_DOWNLOAD_HISTORICAL_REPORT">        
                          <li><a href="${request.contextPath}/incidentMaster/generateReport">Download Historical Notifications</a></li>
                           <li class="divider"></li>                          
                    </sec:ifAnyGranted>       
                    <sec:ifAnyGranted roles="ROLE_GENERATE_DAILY_MAJOR_INCIDENT_REPORT">
                          <li><a href="${request.contextPath}/incidentMaster/generateDailyMajorIncidentReport">Generate Daily Major Incident Report</a></li>
                           <li class="divider"></li>                          
                    </sec:ifAnyGranted>       
                    <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
                           <li><a href="${request.contextPath}/customProduct/list">Manage IRT Product List</a></li>
                           <li class="divider"></li>                          
                    </sec:ifAnyGranted>       
                </ul>
            </li>

            <li class="dropdown  active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">RCA Studio<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">

                     <li><a href="${request.contextPath}/rcaMaster/list">View RCA Documents </a></li>
                     <li class="divider"></li>

                    <li class="dropdown-submenu">
                       <a tabindex="-1" href="#">RCA Review Meetings</a>
                       <ul class="dropdown-menu" role="menu">
                         <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
                          <li><a href="${request.contextPath}/rcaMaster/createAgenda">Create New RCA Meeting Agenda </a></li>
                           <li class="divider"></li>
                           <li><a href="${request.contextPath}/rcaMaster/runRCAMeeting">Run RCA Review Meetings</a></li>
                         </sec:ifAnyGranted>       
                         <sec:ifNotGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
                           <li class="divider"></li>
                           <li><a href="${request.contextPath}/rcaMaster/runRCAMeeting">View RCA Review Meetings</a></li>
                         </sec:ifNotGranted>        
                       </ul>
                    </li>   

                     <li class="divider"></li>

           <g:if test="${shout2team.equals("Y") || CockpitConfiguration.findByKey('RCA_MODULE').value.equals('Y')}">
                  <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
                     <li><a href="${request.contextPath}/rcaMaster/create">Create New RCA from non-EB</a></li>
                     <li class="divider"></li>
                    </sec:ifAnyGranted>       
          </g:if>
                    <li class="dropdown-submenu">
                       <a tabindex="-1" href="#">Remediation Items</a>
                       <ul class="dropdown-menu" role="menu">
                          <li><a href="${request.contextPath}/rcaMaster/rcaSRList">View Details</a></li>
                           <li class="divider"></li>
                           <li><a href="${request.contextPath}/rcaMaster/rcaRemediationChart">View Charts</a></li>
                       </ul>
                    </li>   

                     <li class="divider"></li>
                    <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM,ROLE_DOWNLOAD_HISTORICAL_REPORT">        
                          <li><a href="${request.contextPath}/rcaMaster/historicalList">Download Historical RCAs</a></li>
                    </sec:ifAnyGranted>       

                     <li class="divider"></li>
                     <li><a href="${request.contextPath}/rcaReport">RCA Reports</a></li>
                    
                </ul>
            </li>


      <li class="dropdown active">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">DR Studio <span class="caret"></span></a>
    <ul class="dropdown-menu" role="menu">
      <g:if test="${CockpitConfiguration.findByKey('DR_MODULE').value.equals('Y')}">
                    <sec:ifAnyGranted roles="ROLE_SCC_INCIDENT_RESPONSE_TEAM">        
      <li><a href="${request.contextPath}/DrEvent/startRecovery">Initiate Data Center Recovery </a></li>
      <li class="divider"></li>
                    </sec:ifAnyGranted>       
      <li><a href="${request.contextPath}/DrEvent/eventProducts">View Ongoing Datacenter Recoveries</a></li>
      <li class="divider"></li>
        </g:if>
      <li><a href="${request.contextPath}/DrProduct/list">Product - Recovery Steps</a></li>
      <li class="divider"></li>
    </ul>
      </li>

<g:if test="${CockpitConfiguration.findByKey('CM_MODULE').value.equals('Y')}">
      <li class="dropdown active">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Change Management<span class="caret"></span></a>
    <ul class="dropdown-menu" role="menu">
    <sec:ifNotGranted roles='ROLE_SCC'>
          <li><a href="${request.contextPath}/ops/index">Request SCC Approval</a></li>
          </sec:ifNotGranted>
          <sec:ifAnyGranted roles='ROLE_SCC'>
        <li><a href="${request.contextPath}/ops/scc">View Pending Requests</a></li>
          </sec:ifAnyGranted>
      <li class="divider"></li>
      <li><a href="${request.contextPath}/cmReport/index">Dashboard</a></li>
      <li class="divider"></li>
    </ul>
      </li>
</g:if>



   <sec:ifAnyGranted roles="ROLE_SHOUT2AUTOM8">           
<li class="dropdown  active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                
                          <li><a href="${request.contextPath}/userRole/list">View User Roles</a></li>
                           <li class="divider"></li>
                           <li class="dropdown-submenu">
                       <a tabindex="-1" href="#">Users</a>
                       <ul class="dropdown-menu" role="menu">
                          <li><a href="${request.contextPath}/user/create">Add New User</a></li>
                           <li class="divider"></li>
                           <li><a href="${request.contextPath}/user/list">View All Users</a></li>
                       </ul>
                    </li>
                         <li class="divider"></li>   
                           <li><a href="${request.contextPath}/role/list">View All Roles</a></li>
                           <li class="divider"></li>     
                 </ul>
            </li>
</sec:ifAnyGranted>
            <li class="dropdown  active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Others<span class="caret"></span></a>

                <ul class="dropdown-menu" role="menu">

                <li class="dropdown-submenu">

                    <li class="dropdown-submenu">
                       <a tabindex="-1" href="#">Reachout Tool</a>
                       <ul class="dropdown-menu" role="menu">
                          <li><a href="${request.contextPath}/sendtext/create" target="_blank"> Send Message </a></li>
                           <li class="divider"></li>
                          <li><a href="${request.contextPath}/sendtext/list" target="_blank"> View Historical Messages </a></li>
                       </ul>
                    </li>   

          <li class="divider"></li>

                    <li class="dropdown-submenu">
                       <a tabindex="-1" href="#">Datacenter - DR Docs</a>
                       <ul class="dropdown-menu" role="menu">
                          <li><a href="${CockpitConfiguration.findByKey('RECOVERY_PLAN_DOCUMENT').value}" target="_blank">Datacenter Recovery Plan</a></li>
                          <li class="divider"></li>
                          <li><a href="${CockpitConfiguration.findByKey('CRISIS_MANAGEMENT_PLAN_DOCUMENT').value}" target="_blank">Crisis Management Plan</a></li>
                       </ul>
                    </li>   

          <li class="divider"></li>
                      <li> <a tabindex="-1" href="${request.contextPath}/deviceLookup/list">Device Lookup</a>  </li>
                      <li class="divider"></li>   
                      <li> <a tabindex="-1" href="${request.contextPath}/productDetail/list">Product Escalation Matrix</a>  </li>
                      <li class="divider"></li>   
                      <li> <a tabindex="-1" href="${request.contextPath}/escalationPath/searchEmployees">Escalation Path</a>  </li>
                      <li class="divider"></li>   
                      <li> <a tabindex="-1" href="${request.contextPath}/productDetail/training" target="_blank">L2 Training Videos</a>  </li>
                       

              </li>
              </ul>
             </li>   


            <li class="dropdown active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Support<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">                
                          <li><a href="${CockpitConfiguration.findByKey('DEMO_VIDEO').value}" target="_blank">Demo Video</a></li>
                           <li class="divider"></li>
                          <!-- <li><a href="javascript:" id="startTourMenu">Start Tour ( F2 )</a></li> 
                           <li class="divider"></li>-->
                           
                           <g:if test="${CockpitConfiguration.findByKey('CHAT_MODULE').value.equals('Y')}">
                          <li><a href="javascript:" id="liveChatMenu">Live Chat</a></li>
                           <li class="divider"></li>                          
                          </g:if> 
                <li><a href="mailto:shout2autom8@syniverse.com?subject=Command Center Cockpit - Feedback">Contact Us</a></li>      
                </ul>
            </li>


            <li class="active"><a href="${request.contextPath}/logout/index">Logout</a></li>      

      </ul>


        </nav>
        
<g:if test="${CockpitConfiguration.findByKey('CHAT_MODULE').value.equals('Y')}">

        <div class="shout_box" style="display:block;">
<div class="header chat_header"><span class="glyphicon glyphicon-comment"></span> Need Help? <span class="chatCloseBtn glyphicon glyphicon-remove" style="float:right;"></span></div>
  <div class="toggle_chat" style="display:none;">
<div class="message_box" id="chatDetails" name="chatDetails">
<input type="hidden" id="gid" name="gid" value="${gid}"/>


</div>
  <div class="user_info">
  <div class="col-xs-12" id="agentStatus" name="agentStatus"></div>
 <input name="send" id="send"  type="text" placeholder="Type Message Hit Enter" maxlength="100" /> 
 <a class="sendBtn" onclick="javascript:sendChatMessage()">Send</a>
    </div>
    </div>
</div>

</g:if>
      
</sec:ifLoggedIn>

        <g:layoutBody />  

<asset:stylesheet href="jquery/introjs.min.css"/>
<asset:javascript src="jquery/intro.min.js" />
<script type="text/javascript">

$(document).ready(function(){
        $.ajax({
                   type: 'post',
                   url: '${request.contextPath}/rcaMaster/fetchTourAvailable?page=' + location.pathname,
                   async:false,
                   success: function(data) {
                      if ( parseInt(data) >= 1 ) {
      $(".breadcrumb").append('<span class="btn btn-warning" id="startTourMenu" style="float:right;margin:-6px 2px -6px -6px;"><l class="glyphicon glyphicon-plane"></l> Start Tour (F2)</span>');
                      }
                   }
        });

$('#startTourMenu').click(function(e){
        $.ajax({
                   type: 'post',
                   url: '${request.contextPath}/rcaMaster/fetchTourDetails?page=' + location.pathname,
                   success: function(data) {
                      tourdetails = data;
                      setTimeout('startIntro()', 500);
                   }
        });
});

});//end document

function startIntro(){
    var intro = introJs();
    intro.setOptions(tourdetails);
    intro.start();
}
</script>

  </body>
</html>
