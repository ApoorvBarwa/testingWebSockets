<div class="row">
<div class="col-md-12">
<!-- start: FORM WIZARD PANEL -->
<div class="panel-default">
	
<div class="panel-body">
<div class="swMain">
<ul class="anchor">


<g:if test="${currentPage=='edit' || currentPage=='create'}"><g:set var="currentStep" value="1" /></g:if>
<g:elseif test="${currentPage=='mopDetails'}"><g:set var="currentStep" value="2" /></g:elseif>
<g:elseif test="${currentPage=='summary'}"><g:set var="currentStep" value="3" /></g:elseif>
<g:else test="${currentPage=='summary'}"><g:set var="currentStep" value="3" /></g:else>

<g:if test="${crqId != ''}">
<li>
	<a rel="1" isdone="1" class="<g:if test="${currentStep=='1'}">selected</g:if><g:else test="${currentStep>'1'}">selected</g:else>" href="<g:if test="${crqId != ''}">${request.contextPath}/ops/crqDetails?crqId=${crqId}</g:if><g:else>#</g:else>">                
		<div class="stepNumber">1</div><span class="stepDesc"><small>CRQ Details</small></span>
	</a>
</li>
<li>
	<a rel="2" isdone="0" 
	class="<g:if test="${currentStep=='2'}">selected</g:if><g:elseif test="${currentStep<'2'}"></g:elseif><g:else test="${currentStep>'2'}">selected</g:else>"
	href="<g:if test="${crqId != ''}">${request.contextPath}/ops/mopDetails/${crqId}</g:if><g:else>#</g:else>">
		<div class="stepNumber">2</div><span class="stepDesc"><small>Mop Details</small></span>
	</a>
</li>
<li>
	<a rel="3" isdone="0" 
	class="<g:if test="${currentStep=='3'}">selected</g:if><g:elseif test="${currentStep<'3'}"></g:elseif><g:else test="${currentStep>'3'}">selected</g:else>"
	href="<g:if test="${crqId != ''}">${request.contextPath}/ops/summary/${crqId}</g:if><g:else>#</g:else>" >
		<div class="stepNumber">3</div><span class="stepDesc"><small>Summary</small></span>
	</a>
</li>

</g:if>

</ul>
<!-- <div class="stepContainer"><div class="progress progress-striped active progress-sm content">
	<div class="progress-bar progress-bar-success step-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: 25%;">
		<span class="sr-only"> 0% Complete (success)</span>
	</div>-->
</div>
</div>    
</div>
</div>
<!-- end: FORM WIZARD PANEL -->
</div>

