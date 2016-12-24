<!DOCTYPE html>
<html>
<head>
	    
    <meta http-equiv="x-ua-compatible" content="IE=Edge">
	<meta name='layout' content='main'/>
	<title>Change Management - SCC</title>
	<ckeditor:resources/>

	<asset:javascript src="application_scc.js"/>
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
   <g:render template="scc_dashboard" />
   <g:render template="commentsModal" />

</div>
</div>

<div class="row">
      <div class="panel panel-default">
               <g:render template="divPanel" />
              <input type="hidden" name="dataTableStatus" id="dataTableStatus" /> 
              <div class="panel-body">
		 <div id="changeRequestsTable" style="margin:0 auto; padding-top:10px; ">
	              <table cellpadding="0" cellspacing="0" border="0"  id="pendingSccApprovalTable" style="width:100%;" class="table table-striped table-bordered">
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


</body>
</html> 	

