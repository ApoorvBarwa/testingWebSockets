<!DOCTYPE html>
<html>
<head>
<meta name='layout' content='main'/>
<title>Approve CRQ - SCC </title>
<asset:stylesheet href="application_scc.css"/>
<asset:javascript src="application_scc.js"/>
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
	<g:render template="non_crqDetails" />
	<input type="hidden" name="crqNumber" id="crqNumber" value="${crqId}">
	<g:render template="crq_detailsTable" />
  <g:render template="commonDiv" />

  <div>
  <textarea class='ddactionproduct form-control' name='comments' required value='' id='comments' data-label='text'
   placeHolder='Enter the comments here.'></textarea>
   </div>
   <BR>
   <div style="text-align: center">
    <button type="button" class="btn btn-primary" onclick="javascript:updateCrq(4)">Approve</button>
    <button type="button" class="btn btn-primary" onclick="javascript:updateCrq(5)">Reject</button>
    <button type="button" class="btn btn-primary" onclick="javascript:updateCrq(3)">Seek Claricfication</button>
   </div>
  </div>
</body>
</html>

