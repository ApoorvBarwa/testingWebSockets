<style>
.border-red {
border-color: #2fb5bf !important;
}
.m-heading {
background: #eff3f8 none repeat scroll 0 0;
border-left: 8px solid #2fb5bf;
margin: 10px 0;
padding: 5px 0 1px 15px;
}
</style>

<div id="commentModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div id="crqNumber"></div>
      </div>
      <div class="modal-body" id="modalBody">
      
        <input type="hidden" id="crqId" name="crqId"/>
        <g:render template="commonDiv" />
        <div id="uploadBody"></div>
       </div>
        <!--  <table class="table table-bordered table-striped">
        <thead>
        <tr>
         <td>Date</td>
         <td>Comments </td>
         <td>Comments By</td>
        </tr>
        </thead>
        <tbody>
        </tbody>
        </table>-->
      </div>
    </div>

  </div>