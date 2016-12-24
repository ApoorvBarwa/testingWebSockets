<g:form class="form-horizontal" name="editContactForm" role="form" autoComplete="off" method="post">

<input type="hidden" value="${crqId}" id="crqId" name="crqId">
<input type="hidden" value="access_control" id="currentPageId" name="currentPageId">
<input type="hidden" value="editPreActivity" id="nextPage" name="nextPage">
<div id="form1" class="nonEIS">
	<div classs="row"  style="width:50%;margin-left: 25%;">
		<div class="col-sm-12">
			<h4>Approval Summary for ${crqId}</h1>
		</div>
	</div>
<div class="row" style="width:50%;margin-left: 25%;">
	<div class="col-md-12">
		<div class="panel panel-default">
			
			<div class="panel-body">
				<table cellpadding="0" cellspacing="0" border="0"  id="mopTable" style="width:100%;" class="table table-striped table-bordered">
              		<thead class="alignCenter">
                 		<tr>
				          	<th class="headerclass">Approval Sections </th>
	           				<th class="headerclass">Status</th>
	           				
                 		</tr>
              		</thead>
              		<tbody>
              			<tr>
              				<td>CRQ Details</td><td><span style="color: #21b384; font-size:14px;" class="approveMop">
				<span class="glyphicon glyphicon-ok"></span></span> </td><tr>
				<tr>
              				<td>CRQ Approvals</td><td><span style="color: #21b384; font-size:14px;" class="approveMop">
				<span class="glyphicon glyphicon-ok"></span></span> </td><tr>
				<tr>
              				<td>CRQ Environment</td><td><span style="color: #ed6a43; font-size:14px;" class="approveMop">
				<span class="glyphicon glyphicon-remove"></span></span> </td><tr>
				<tr>
              				<td>MOP Approvals</td><td><span style="color: #ed6a43; font-size:14px;" class="approveMop">
				<span class="glyphicon glyphicon-remove"></span></span> </td><tr>

              		</tbody>

              		
              	</table> 
				<input type="hidden" name="mopDetailsConfirm" id="mopDetailsConfirm" value="" />

			</div>
		</div>

	</div>
</div>
<div class="row" id="showMopButton"  style="width:50%;margin-left: 25%;">
	<div class="col-md-12">
		SCC Comments:<br/>
		<textarea rows=4 cols=120></textarea>
	</div>
	
</div>
<div class="row" id="showMopButton"  style="width:50%;margin-left: 25%;text-align: center;">
	
	<div class="col-md-12"><br/>
		<button class="btn btn-success" id="btnMopDetails" type="button" >Send back to OPS</button> &nbsp;
		<button class="btn btn-danger" id="btnMopDetails" type="button" ><span style="color: #fff; font-size:14px;" class="approveMop">
				<span class="glyphicon glyphicon-remove"></span></span> Reject</button>
	</div>
</div>
</g:form>