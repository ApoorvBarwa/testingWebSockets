<!DOCTYPE html>
<html>
<head>
<meta name='layout' content='main'/>
<title>CRQ Details ${currentPage}</title>
<asset:stylesheet href="application_scc.css"/>
<asset:javascript src="application.js"/>
<asset:stylesheet src="application_crq.css"/>

</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-sm-12">
			<div id="edit-runBook" class="content scaffold-edit"  role="main">
				
			</div>
		</div>
	</div>
	<!--  Tabs included  -->
	<g:render template="crq_tabs" />
	<g:render template="non_mopDetails" />

	<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading"><span id="spanMopDetails">MOP Details  for ${crqId}</span>
				<span style="margin-left:70%; cursor:pointer;color: #21b384; font-size:14px;" title="Approve Mop" class="approveMop">
				<span class="glyphicon glyphicon-ok"></span></span> 
				<span style="margin-left:3%; cursor:pointer;color: #ed6a43; font-size:14px;" title="Reject Mop" class="rejectMop"><span class="glyphicon glyphicon-remove"></span></span> 
			</div>
			<div class="panel-body">
				<input type="hidden" name="mopDetailsConfirm" id="mopDetailsConfirm" value="" />

				<table cellpadding="0" cellspacing="0" border="0"  id="mopTable" style="width:100%;" class="table table-striped table-bordered">
              		<thead class="alignCenter">
                 		<tr>
				          	<th class="headerclass">MOP Name</th>
	           				<th class="headerclass">Customer Name</th>
	           				<th class="headerclass">Created By</th>
	           				<th class="headerclass">Created At</th>
	           				<th class="headerclass">Approved By</th>
	           				<th class="headerclass">Approved At</th>
                 		</tr>
              		</thead>
              		<tbody></tbody>
              		
              	</table> 
			</div>
		</div>

	</div>
</div>

</div>

<asset:javascript src="application_mop.js"/>
</body>
</html>
