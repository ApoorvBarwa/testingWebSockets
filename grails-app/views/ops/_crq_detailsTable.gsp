<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading"><span id="spanMopDetails">MOP Details  for ${crqId}</span> 
			</div>
			<div class="panel-body">
				<input type="hidden" name="mopDetailsConfirm" id="mopDetailsConfirm" value="" />

				<table cellpadding="0" cellspacing="0" border="0"  id="mopTable" style="width:100%;margin-bottom: 0px;" class="table table-striped table-bordered">
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
<script type="text/javascript">
	$(document).ready(function (){
		//fnMopTable();
	});
  
	function fnMopTable(){ 
		table = $('#mopTable').DataTable({
	        "ajax":{
	            "type" : "POST", 
	            "url":"/Ops/fetchMopDetails",
	            "data" : {
	                crqId: "${params.crqId}"
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
</script>