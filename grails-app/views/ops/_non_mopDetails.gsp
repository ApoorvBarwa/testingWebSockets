<g:form class="form-horizontal" name="editContactForm" role="form" autoComplete="off" method="post">

<input type="hidden" value="${crqId}" id="crqId" name="crqId">
<input type="hidden" value="access_control" id="currentPageId" name="currentPageId">
<input type="hidden" value="editPreActivity" id="nextPage" name="nextPage">
<div id="form1" class="nonEIS">
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

<div class="row" id="showMopButton" style="display:none;">
	<div class="col-md-4"></div>
	<div class="col-md-4">
		<button class="btn btn-success" id="btnMopDetails" type="button" >Next</button>
	</div>
	<div class="col-md-4"></div>
</div>
</g:form>