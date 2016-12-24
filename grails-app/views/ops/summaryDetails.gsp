<!DOCTYPE html>
<html>
<head>
<meta name='layout' content='main'/>
<title>CRQ Details ${currentPage}</title>
<asset:stylesheet href="application_scc.css"/>
<asset:javascript src="application.js"/>

<asset:javascript src="application_crq.js"/>
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
	<g:render template="non_summaryDetails" />

</div>
</body>
</html>
