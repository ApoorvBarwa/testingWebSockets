<g:form class="form-horizontal" name="editContactForm" role="form" autoComplete="off" method="post">

<input type="hidden" value="" id="crqId" name="crqId" />
<input type="hidden" value="access_control" id="currentPageId" name="currentPageId" />
<input type="hidden" value="editPreActivity" id="nextPage" name="nextPage" />

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading"><span id="spanCrqDetails">CRQ Details</span>  
			</div>
			<div class="panel-body">
				<input type="hidden" name="crqDetailsConfirm" id="crqDetailsConfirm" value="" />
 
				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">CRQ #</label>
					</div>
					<div class="col-md-2">
						<label id="crqNumber1" style="font-weight: lighter"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Product</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;" id="product"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Scheduled Start Time</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;" id="startDate"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Scheduled End Time</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;" id="endDate"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Requestor</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;" id="requestor"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Request time</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;" id="requestTime"></label>
					</div>
				</div>

			</div>
		</div>

	</div>
</div>

<div class="row" >
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading"><span id="spanApproverDetails">Approvers</span>
			</div>
			<div class="panel-body">
				<input type="hidden" name="approverConfirm" id="approverConfirm" value="" />
				

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Reviewer  & date</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" id="reviewersDate" style="font-weight: lighter;">TBD</label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Approver(s) & date</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;">TBD</label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">GCMB Approval Date</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;">TBD</label>
					</div>
				</div>

			</div>
		</div>

	</div>
</div>

<div class="row" >
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading"><span id="spanEnvDetails">Environment</span>
				
			</div>
			<div class="panel-body">
				<input type="hidden" name="envConfirm" id="envConfirm" value="" />
				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Datacenters</label>
					</div>
					<div class="col-md-2">
						<label class="control-label" id="site" style="font-weight: lighter;"></label>
					</div>
				</div>

				<div class="row">
					<div class="col-md-2">
						<label class="control-label" style="font-weight: 700">Host details </label>
					</div>
					<div class="col-md-2">
						<label class="control-label" style="font-weight: lighter;">TBD</label>
					</div>
				</div>
				
			</div>
		</div>

	</div>
</div>
<div class="row" id="showButton" style="display:none;">
	<div class="col-md-4"></div>
	<div class="col-md-4">
		<button class="btn btn-success" id="btnCrqDetails" type="button" >Next</button>
	</div>
	<div class="col-md-4"></div>
</div>
</g:form>

<script type="text/javascript">
	$(document).ready(function () {

	$.ajax({
    type:"GET",
    url:"/ops/fetchCrqDetails?crqId=${params.crqId}",
    cache: false,
    contentType: false,
    processData: false,
    dataType:"json",
    success:function (data){
      
      $("#crqId").val(data.id);
      $("#crqNumber1").html(data.crqNumber);
      $("#product").html(data.product);
      $("#startDate").html(data.startDate);
      $("#endDate").html(data.endDate);
      $("#requestor").html(data.requestor);
      $("#requestTime").html(data.requestTime);
      $("#site").html(data.site);
      $("#reviewersDate").html(data.approvers);
      fetchCrqDetails($("#crqId").val())

    },
    error:function(){
      console.log("Error Occured")
    }

  })

})  	
</script>
