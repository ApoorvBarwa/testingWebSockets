<!DOCTYPE html>
<html>
<head>
	    
  <meta http-equiv="x-ua-compatible" content="IE=Edge">
	<meta name='layout' content='main'/>
	<title>Change Management - OPS</title>
	<ckeditor:resources/>

	<asset:javascript src="application_crq.js"/>
        <asset:stylesheet src="application_crq.css"/>

        <style>
			#detailsModal .modal-dialog {
			top: 80px;
			}
        </style>

</head>
<body>

<div class="container">
<div class="row">
<div id="dashboardDiv">
   <g:render template="dashboard" />
   <g:render template="commentsModal" />
   <sec:ifAnyGranted roles="ROLE_SCC">
      <g:render template="breakFixModal" />
   </sec:ifAnyGranted>
</div>
</div>

<div class="row">
      <div class="panel panel-default">
              <g:render template="divPanel" />
              <input type="hidden" name="dataTableStatus" id="dataTableStatus" /> 
              <div class="panel-body">
		 <div id="changeRequestsTableDiv" style="margin:0 auto; padding-top:10px; ">
	              <table cellpadding="0" cellspacing="0" border="0"  id="changeRequestsTable" style="width:100%;" class="table table-striped table-bordered">
          	        <thead class="alignCenter">
                	 <tr>
		          <th class="headerclass">CRQ #</th>
		          <th class="headerclass">Product</th>
		          <th class="headerclass">Description</th>
		          <th class="headerclass">CRQ Owner</th>
		          <th class="headerclass">Change Coordinator</th>
		          <th class="headerclass">Scheduled Start Time</th>
		          <th class="headerclass">Scheduled End Time</th>
		          <th class="headerclass">CCC Status</th>
		          <th class="headerclass">Action</th>
                	</tr>
	               </thead>
        	      <tbody></tbody>
	              </table>
                  </div>
             </div>
       </div>
</div>

</div>

<div id="sendToSccModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" >Modal Header</h4>
      </div>
      <div class="modal-body" id="dataFormContainer">
        <p>Chat Time Lines</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-default">Send For Scc Approval</button>
      </div>
    </div>

  </div>
</div>

</body>
</html> 	

