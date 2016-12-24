<div class="panel-heading">
               		<input type="hidden" name="getTime" id="getTime" value="${time}" />
                     <i class="fa fa-table"></i><span id="changeRequestsHeader" style="color: #5c9bd1;"> All Change Requests </span>

                      <div class="panel-tools">
                      
	                      <sec:ifAnyGranted roles="ROLE_SCC">
	                      <button type="button" id="requestBreakFix" class="btn btn-danger" style="padding: 0px 6px;">Request Break Fix</button>
	                      </sec:ifAnyGranted>

                  <button type="button" id="autoRefreshTable"><span id="test"></span><span class="glyphicon glyphicon-refresh text-success"></span></button>
                  <span style="color: #5c9bd1;">Table Auto Refreshing in <span id="time" style="color: #f36a5a;"></span> minutes!</span>

                </div>
                     
              </div> 