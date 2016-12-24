package cm

import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat
import ir.CockpitConfiguration
import groovy.time.TimeCategory
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.core.io.ByteArrayResource
import org.springframework.core.io.InputStreamSource
import groovy.sql.Sql
import grails.util.Environment
import javax.sql.DataSource
import grails.converters.JSON
import ir.OrgChart
import ir.SrQueue
import java.nio.file.Files
import groovy.json.*
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo

@Secured(['IS_AUTHENTICATED_FULLY'])
class OpsController {
    def springSecurityService
    def dataSource_swift
    def dataSource_mysqlMOP

    def gid

    def updateArray = []

    def index() {

        [time:CockpitConfiguration.findByKey('DATATABLE_REFRESH').value]
    }
 	

    def getTableDetails(){

        gid = springSecurityService.principal.username.toLowerCase()

/*        def gidGroups = SrQueue.findAllByMembersIlike("%" + gid + "%").name

        println "Printing Queues ----->" + gidGroups*/

    	SimpleDateFormat sdf = new SimpleDateFormat('MM-dd-yyyy HH:mm z')
    	def startDate
    	def endDate

    	def dataToRender = [:]
        dataToRender.aaData = []
        def crqToFetch

        if(params.status == "4" || params.status == "8"){

        	def inProgressStatusList = []

        	inProgressStatusList << ChangeStatus.get(4)
            inProgressStatusList << ChangeStatus.get(8)

            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){
                
                crqToFetch = ChangeRequest.findAllByCccStatusInList(inProgressStatusList,[sort:"scheduledStartTime",order:"asc"])

                }else{
                crqToFetch = ChangeRequest.findAllByCccStatusInListAndAsgrpInList(inProgressStatusList,gidGroups,[sort:"scheduledStartTime",order:"asc"])

            }
	        

        }else if(params.status == "5"){

            def inProgressStatusList = []

            inProgressStatusList << ChangeStatus.get(5)
            inProgressStatusList << ChangeStatus.get(6)

            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatusInList(inProgressStatusList,[sort:"scheduledStartTime",order:"asc"])

                }else{

                crqToFetch = ChangeRequest.findAllByCccStatusInListAndAsgrpInList(inProgressStatusList,gidGroups,[sort:"scheduledStartTime",order:"asc"])

            }
            
        	
        }else{

            def statusToFetch = ChangeStatus.get(params.status)
            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatus(statusToFetch,[sort:"scheduledStartTime",order:"asc"])

            }else{

                crqToFetch = ChangeRequest.findAllByCccStatusAndAsgrpInList(statusToFetch,gidGroups,[sort:"scheduledStartTime",order:"asc"])

            }
            

        }

        def action
        def status
        crqToFetch.each(){


            println it.scheduledStartTime + "---" + it.crqNumber

        	startDate = sdf.format(new Date(it.scheduledStartTime*1000))
	        endDate = sdf.format(new Date(it.scheduledEndTime*1000))

            it.cccStatus.status=="Approved"?(status="In Progress"):(status=it.cccStatus.status);

	         if(it.cccStatus.id == 2 || it.cccStatus.id == 6 || it.cccStatus.id == 5){

                action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-comment'></span></a>"

            }else if((it.cccStatus.id == 1 || it.cccStatus.id == 3) && ((it.scheduledStartTime*1000 - Calendar.instance.time.time) <= Long.valueOf(CockpitConfiguration.findByKey('INPROGRESS_CRQ').value))) {
                println "WHy Herer"
                action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"

            }else if(it.cccStatus.id == 4){

                action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"

            }else if(it.cccStatus.id == 8){
                
                if((Calendar.instance.time.time - ChangeRequestUpdates.findAllByCrAndNewStatus(it,ChangeStatus.get(8),[sort:"updatedAt",order:"asc",max:1]).updatedAt) >= Long.valueOf(CockpitConfiguration.findByKey('WAIT_PERIOD_CRQ').value)){ // Add Configurable Parameter

                    action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"
                    status = "30 Min Wait Period Over"
                }else{

                    action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','comments'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-upload'></span></a>"
                }

            }else{

                action = ""
            }

            if(it.lockedBy != null){

                action = action + "<button class='btn btn-danger'><span class='glyphicon glyphicon-lock'></span></button>"
            }

	        dataToRender.aaData << [
						    it.crqNumber,
	        				it.product,
	        				it.description,
	        				OrgChart.findByGid(it.crqOwner)?.displayName,
	        				OrgChart.findByGid(it.changeCoordinator)?.displayName,
	        				startDate,
	        				endDate,
	        				status,
	        				action
	        ]
        }        

        render dataToRender as JSON
    }

    def getSCCTableDetails(){

        gid = springSecurityService.principal.username.toLowerCase()

        /*def gidGroups = SrQueue.findAllByMembersIlike("%" + gid + "%").name

        println "Printing Queues ----->" + gidGroups*/

    	SimpleDateFormat sdf = new SimpleDateFormat('MM-dd-yyyy HH:mm z')
    	def startDate
    	def endDate

    	def dataToRender = [:]
        dataToRender.aaData = []
        def crqToFetch

	if ( params.status == "historic" ) {

        	def historicList = []
        	historicList << ChangeStatus.get(5)
        	historicList << ChangeStatus.get(6)
	        historicList << ChangeStatus.get(7)

            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatusInList(historicList)

            }else{

                crqToFetch = ChangeRequest.findAllByCccStatusInListAndAsgrpInList(historicList,gidGroups)
            }
	        

	}
	else if ( params.status == "pendingClarificationFromOPS" ) {

        	def statusToFetch = ChangeStatus.get(3)

            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatus(statusToFetch)    
            
            }else{

                crqToFetch = ChangeRequest.findAllByCccStatusAndAsgrpInList(statusToFetch,gidGroups)

            }
        	

	}
	else if ( params.status == "inProgress" ) {

        	def inProgressStatusList = []
        	inProgressStatusList << ChangeStatus.get(4)
                inProgressStatusList << ChangeStatus.get(8)
            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatusInList(inProgressStatusList)
                    
            }else{

                crqToFetch = ChangeRequest.findAllByCccStatusInListAndQueue(inProgressStatusList)

            }
	        

	} else if ( params.status == "pendingSCCApproval" ) {
        	def statusToFetch = ChangeStatus.get(2)

            if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

                crqToFetch = ChangeRequest.findAllByCccStatus(statusToFetch)

            }else{

                crqToFetch = ChangeRequest.findAllByCccStatusAndAsgrpinList(statusToFetch,gidGroups)

            }           
        	
        }


	int cnt = 0

        crqToFetch.each(){

        	def action
		    if(it.lockedBy == null || it.lockedBy == gid){

                if (it.cccStatus.id == 2 ) {
                    action = "<button class='btn btn-primary crqbtn' value='${it.crqNumber}'><span class='glyphicon glyphicon-hand-up'></span></button>"
                        }
                else {
                        action = "<a href=\"javascript:fetchCrqDetails('"+it.id+"','scc'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-comment'></span></a>"
                }

            }else{

                action = "<button onclick=\"alert('This Crq is Locked By "+OrgChart.findByGid(it.lockedBy).name+" at "+sdf.format(new Date(it.lockedAt))+"')\" class='btn btn-danger'><span class='glyphicon glyphicon-lock'></span></button>"
            }

        	startDate = sdf.format(new Date(it.scheduledStartTime*1000))
	        endDate = sdf.format(new Date(it.scheduledEndTime*1000))
		    cnt = cnt +1 

	        dataToRender.aaData << [
						it.crqNumber,
	        				it.product,
	        				it.description,
	        				OrgChart.findByGid(it.crqOwner)?.displayName,
	        				OrgChart.findByGid(it.changeCoordinator)?.displayName,
	        				startDate,
	        				endDate,
	        				it.cccStatus.status,
	        				action
	        ]
        }        

	println "Size is " + cnt
        render dataToRender as JSON

     }

     def testOrgChart() {

        
     }

    def fetchCrqTimeLines(){
        gid = springSecurityService.principal.username.toLowerCase()
        SimpleDateFormat sdf = new SimpleDateFormat('MM-dd-yyyy, hh:mm:ss a z')

    	def fetchCrq = ChangeRequest.findById(params.id)
    	def fetchCrqUpdates = ChangeRequestUpdates.findAllByCr(fetchCrq,[sort:"updatedAt",order:"desc"])
    	def timeLineMap = []

    	fetchCrqUpdates.each(){

    		def tempMap = [:]

    		tempMap.updatedBy = OrgChart.findByGid(it.updatedBy)?.displayName
    		tempMap.updatedAt = sdf.format(new Date(it.updatedAt))
    		tempMap.comments = it.description

    		timeLineMap << tempMap

    	}

        def tempCrqIdMap = [:]

        if(fetchCrq.lockedBy == null || gid == fetchCrq.lockedBy){

            if( ! (springSecurityService.getPrincipal().getAuthorities().any {it == 'ROLE_SCC'})) {


            if((fetchCrq.cccStatus.id == 1 || fetchCrq.cccStatus.id == 3) && params.comments == "ops"){

                    tempCrqIdMap.div = "<div id='buttonDiv'><textarea class='ddactionproduct form-control' name='comments' required value='' id='comments' data-label='text' placeHolder='Enter the comments here.'></textarea><br/><div style='text-align:center'><button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>&nbsp&nbsp<button type='button' class='btn btn-primary' onclick='javascript:updateCrq(2)' id='confirmComments' name='confirmComments' >Send To SCC</button></div></div>"
                                        

                }else if(fetchCrq.cccStatus.id == 4 && params.comments == "ops"){

                        tempCrqIdMap.div = "<div id='buttonDiv'><h4>Drop or Attach Supporting Documents for This CRQ. ( Supported Document Types: <span id='othersAttachmentTypes'></span> )</h4><form action='/ops/upload' class='dropzone dropzone-file-area dz-clickable' id='crqDrop' style='border: 2px dashed #028AF4'><input type='hidden' id='id' name='id' value='"+params.id+"'/></form><BR> <textarea class='ddactionproduct form-control' name='comments' required value='' id='comments' data-label='text' placeHolder='Enter the comments here.'></textarea><br/><div style='text-align:center'><button type='button' class='btn btn-default' data-dismiss='modal'>Close</button>&nbsp&nbsp<button type='button' class='btn btn-primary' onclick='javascript:updateCrq(8)' data-dismiss='modal' id='completeComments' name='completeComments'>Start Wait Period</button>&nbsp&nbsp<button type='button' class='btn btn-primary' onclick='javascript:updateCrq(4)' data-dismiss='modal'>Add Comment</button></div></div>"

                    }else if(fetchCrq.cccStatus.id == 8 && ((Calendar.instance.time.time - ChangeRequestUpdates.findAllByCrAndNewStatus(fetchCrq,ChangeStatus.get(8),[sort:"updatedAt",order:"asc",max:1]).updatedAt)) >= Long.valueOf(CockpitConfiguration.findByKey('WAIT_PERIOD_CRQ').value) && params.comments == "ops"){
                        
                        tempCrqIdMap.div = "<div id='buttonDiv'><h4>Drop or Attach Supporting Documents for This CRQ. ( Supported Document Types: <span id='othersAttachmentTypes'></span> )</h4><form action='/ops/upload' class='dropzone dropzone-file-area dz-clickable' id='crqDrop' style='border: 2px dashed #028AF4'><input type='hidden' id='id' name='id' value='"+params.id+"'/></form><BR> <textarea class='ddactionproduct form-control' name='comments' required value='' id='comments' data-label='text' placeHolder='Enter the comments here.'></textarea><br/><div style='text-align:center'><button type='button' class='btn btn-default' data-dismiss='modal'>Cancel</button>&nbsp&nbsp<button type='button' class='btn btn-primary' onclick='javascript:updateCrq(6)' id='confirmComments' name='confirmComments' >Mark As Completed</button>&nbsp&nbsp<button type='button' class='btn btn-primary' onclick='javascript:updateCrq(8)' data-dismiss='modal' id='completeComments' name='completeComments'>Add Comment</button></div></div>"

                    }else if(fetchCrq.cccStatus.id == 8 && ((Calendar.instance.time.time - ChangeRequestUpdates.findAllByCrAndNewStatus(fetchCrq,ChangeStatus.get(8),[sort:"updatedAt",order:"asc",max:1]).updatedAt)) <= Long.valueOf(CockpitConfiguration.findByKey('WAIT_PERIOD_CRQ').value) && params.comments == "ops"){

                        tempCrqIdMap.div = "<div id='buttonDiv'><h4>Drop or Attach Supporting Documents for This CRQ. ( Supported Document Types: <span id='othersAttachmentTypes'></span> )</h4><form action='/ops/upload' class='dropzone dropzone-file-area dz-clickable' id='crqDrop' style='border: 2px dashed #028AF4'><input type='hidden' id='id' name='id' value='"+params.id+"'/></form><BR> <textarea class='ddactionproduct form-control' name='comments' required value='' id='comments' data-label='text' placeHolder='Enter the comments here.'></textarea><br/><div style='text-align:center'><button type='button' class='btn btn-primary' onclick='javascript:updateCrq(8)' data-dismiss='modal' id='completeComments' name='completeComments'>Add Comment</button></div></div>"
                    
                    }else{

                        tempCrqIdMap.div = ""
                    }

            }else{

                tempCrqIdMap.div = ""

            }

            fetchCrq.lockedAt = Calendar.instance.time.time
            fetchCrq.lockedBy = gid

        }else{
            println "HErr"
            def lockedAt = sdf.format(new Date(fetchCrq.lockedAt))
            tempCrqIdMap.div = "<div><h4>This CRQ is Locked By " + OrgChart.findByGid(fetchCrq.lockedBy).name + " at " +lockedAt+ "</h4></div>"
        }
        

        tempCrqIdMap.status = fetchCrq.cccStatus.id
        tempCrqIdMap.crqNumber = "<h4 class='modal-title' >CRQ Approval Details for "+ fetchCrq.crqNumber + " </h4>" 
        timeLineMap << tempCrqIdMap

        //timeLineMap = timeLineMap.sort{it.updatedAt}

    	println timeLineMap

    	render timeLineMap as JSON
    }

    def upload () {

        def uploadPath = CockpitConfiguration.findByKey('CRQ_UPLOAD_FILES').value
        def f = request.getFile('file')
        def crqDetails = ChangeRequest.findById(params.id)
        def randomStringPath = crqDetails.randomString
        def path = "${uploadPath}/${randomStringPath}/"
        def folder = new File(path)

        if(!folder.exists()){

            String randomString = org.apache.commons.lang.RandomStringUtils.random(100, true, true)
            crqDetails.randomString = randomString
            path = "${uploadPath}/${randomString}/"
            new File(path).mkdirs()

        }
        
        def transferPath = path +"/"+ f.getOriginalFilename().replaceAll(" ","_")
            f.transferTo(new File(transferPath))
            response.sendError(200, 'Done')
    }

    def removeImage() {

        println params

        ChangeRequest cr = ChangeRequest.get(params.id)
        def uploadFilePath = CockpitConfiguration.findByKey('CRQ_UPLOAD_FILES').value

    def fdir = uploadFilePath + cr.randomString + "/" + params.fileName
    println fdir
    new File(fdir).delete()
    response.sendError(200, 'Done')
}

def getUploadedFiles() {

        def cr = ChangeRequest.get(params.id)
        def uploadFilePath = CockpitConfiguration.findByKey('CRQ_UPLOAD_FILES').value
        def button = ""
        def crqUploadFilePath = uploadFilePath + "/" + cr.randomString  + "/"
        def list = []
        if(!(cr.cccStatus.id == 6)){

            button = "<button type='button' class='btn btn-danger remove' onclick=javascript:removeUploadedImages()><span class='glyphicon glyphicon-trash'></span></button>"
        }

        try{
            new File(crqUploadFilePath).eachFile(){ file ->
                def name = CockpitConfiguration.findByKey('CRQ_UPLOAD_FILES').value + file.name //"/" + userRandomId.randomId  + "/" + file.name
                list << [name:name,fileName:file.name,button:button]
            }
        }
        catch(Exception e) {
            println e.stackTrace
        }

 

        render list as JSON   
    }

  def getImage(){

      def crqToFind = ChangeRequest.get(params.id)
      def tempUploadPath = CockpitConfiguration.findByKey('CRQ_UPLOAD_FILES').value
      def uploadPath = tempUploadPath + "/" + crqToFind.randomString
        def map=[:]

      try{

        ByteArrayOutputStream ba = loadImage(uploadPath + "/" + params.file)
        String imageBase64String =org.apache.commons.codec.binary.StringUtils.newStringUtf8(org.apache.commons.codec.binary.Base64.encodeBase64(ba.toByteArray()));
        map.image = imageBase64String
        response.setHeader("Content-Type",'image/jpg') 
        response.setHeader("Content-Disposition","inline; filename=\"" + params.file + "\"")

        render map as JSON

        }catch(Exception ex){
          println "Here"
          println ex.message

        }

    }

    def loadImage(String fileName){
      File file = new File(fileName);
      FileInputStream fis = new FileInputStream(file);
      ByteArrayOutputStream bos = new ByteArrayOutputStream();

      byte[] buf = new byte[1024];
      try {
        for (int readNum; (readNum = fis.read(buf)) != -1;) {
          bos.write(buf, 0, readNum); //no doubt here is 0
        }
      } catch (IOException ex) {
          ex.printStackTrace();
        }
      return bos;
    }

    def test(){

        println "PArams is ---------- >" + params
        println "$request made it!"

        println "ROLE IS ---------------->>" + params.role
        println "Id is -------- >" + params.crqId
        println "Updated At is -------- >" + params.updatedAt
        println "updatedBy is -------- >" + params.updatedBy

        def id
        def updatedBy
        def updatedAt
        def roleOfGid

        SimpleDateFormat sdf = new SimpleDateFormat('MM-dd-yyyy HH:mm z')
        def startDate
        def endDate

        def dataArr = []
        def crqToFetch = []

        if(params.length < 3){
            println "Here"
            dataArr << "No Updates"

        }
       if(params.length > 2){
        id = params.crqId
        updatedBy = params.updatedBy
        updatedAt = params.updatedAt
        roleOfGid = params.role

        def updatedCrq = ChangeRequest.findById(id)
        def fetchUpdatedCrq = ChangeRequestUpdates.findAllByCrAndUpdatedAt(updatedCrq,updatedAt)
        
        def action
        def status
        
            //println fetchUpdatedCrq.scheduledStartTime + "---" + fetchUpdatedCrq.crqNumber

            startDate = sdf.format(new Date(updatedCrq.scheduledStartTime*1000))
            endDate = sdf.format(new Date(updatedCrq.scheduledEndTime*1000))

            updatedCrq.cccStatus.status=="Approved"?(status="In Progress"):(status=updatedCrq.cccStatus.status);

             if(updatedCrq.cccStatus.id == 2 || updatedCrq.cccStatus.id == 6 || updatedCrq.cccStatus.id == 5){

                action = "<a href=\"javascript:fetchCrqDetails('"+updatedCrq.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-comment'></span></a>"

            }else if((updatedCrq.cccStatus.id == 1 || updatedCrq.cccStatus.id == 3) && ((updatedCrq.scheduledStartTime*1000 - Calendar.instance.time.time) <= Long.valueOf(CockpitConfiguration.findByKey('INPROGRESS_CRQ').value))) {
                println "WHy Herer"
                action = "<a href=\"javascript:fetchCrqDetails('"+updatedCrq.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"

            }else if(updatedCrq.cccStatus.id == 4){

                action = "<a href=\"javascript:fetchCrqDetails('"+updatedCrq.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"

            }else if(updatedCrq.cccStatus.id == 8){
                
                if((Calendar.instance.time.time - ChangeRequestUpdates.findAllByCrAndNewStatus(updatedCrq,ChangeStatus.get(8),[sort:"updatedAt",order:"asc",max:1]).updatedAt) >= Long.valueOf(CockpitConfiguration.findByKey('WAIT_PERIOD_CRQ').value)){ // Add Configurable Parameter

                    action = "<a href=\"javascript:fetchCrqDetails('"+updatedCrq.id+"','ops'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-hand-up'></span></a>"
                    status = "30 Min Wait Period Over"
                }else{

                    action = "<a href=\"javascript:fetchCrqDetails('"+updatedCrq.id+"','comments'"+")\" class='btn btn-primary'><span class='glyphicon glyphicon-upload'></span></a>"
                }

            }else{

                action = ""
            }
            

            dataArr << [
                            updatedCrq.crqNumber,
                            updatedCrq.product,
                            updatedCrq.description,
                            OrgChart.findByGid(updatedCrq.crqOwner)?.displayName,
                            OrgChart.findByGid(updatedCrq.changeCoordinator)?.displayName,
                            startDate,
                            endDate,
                            updatedCrq.cccStatus.status,
                            action
            ]

    
       }

    def toSend = new JsonBuilder(dataArr)

    println "---------> " + toSend

    if(roleOfGid == null){

        roleOfGid = "NOEVENT"
    }

        response.setContentType("text/event-stream;charset=UTF-8")
        //response << "event: ${roleOfGid}\n"
        response << "data: ${toSend}\n\n"         
        render "Hi"  
}

    def test1(){

        println "$request made it!"
        response.setContentType("text/event-stream;charset=UTF-8")
        response << "data: the data\n\n"
        render "HI"
    }

    def updateCrqStatus () {

        gid = springSecurityService.principal.username.toLowerCase()

        def roleOfGid

        if(springSecurityService.getPrincipal().getAuthorities().any {it == 'ROLE_SCC'}){

            roleOfGid = 'SCC'

        }else{

            roleOfGid = 'OPS'
        }
    	
        println  params

    	def fetchCrq = ChangeRequest.findById(params.id)

    	ChangeRequestUpdates crqChanges = new ChangeRequestUpdates()

        crqChanges.oldStatus = ChangeStatus.get(fetchCrq.cccStatus.id)
    	crqChanges.newStatus = ChangeStatus.get(params.status)
    	crqChanges.description = params.description
    	crqChanges.updatedAt = Calendar.instance.time.time
    	crqChanges.updatedBy = gid
    	crqChanges.crqNumber = fetchCrq.crqNumber


        fetchCrq.lockedBy = ""
    	fetchCrq.addToCru(crqChanges)
    	fetchCrq.save(flush:true,failOnError:true)
        fetchCrq.cccStatus = crqChanges.newStatus

        render "success"
        updateService.serverUpdate
        //test(fetchCrq.id,crqChanges.updatedAt,gid,roleOfGid)
        //redirect(action:"test",params:[crqId:fetchCrq.id,updatedAt:crqChanges.updatedAt,updatedBy:gid,role:roleOfGid])

    }

    
    def scc()
    {
        [time:CockpitConfiguration.findByKey('DATATABLE_REFRESH').value]
    }

    def crqDetails()
    {
       
    }

    def fetchCrqDetails(){
        
         gid = springSecurityService.principal.username.toLowerCase()

        def crqId = params.crqId

        SimpleDateFormat sdf = new SimpleDateFormat('MM-dd-yyyy HH:mm z')
        def startDate
        def endDate
        def submitDate

        def fetchCrq = ChangeRequest.findByCrqNumber(crqId)

        fetchCrq.lockedBy = gid
        fetchCrq.lockedAt = Calendar.instance.time.time

        Sql sql = new Sql(dataSource_swift)
        def crqMap = [:]
        def query = "select infrastructure_change_id, submitter, aslogid, product_name__2_, site, scheduled_start_date, scheduled_end_date, changerequeststatusstring, submit_date from ARADMIN.chg_changeinterface where INFRASTRUCTURE_CHANGE_ID in ('"+crqId+"')"

        println "The query is ------- > " + query
        sql.eachRow(query){ q->

            startDate = sdf.format(new Date((q.scheduled_start_date).longValue()*1000))
            endDate = sdf.format(new Date((q.scheduled_end_date).longValue()*1000))
            submitDate = sdf.format(new Date((q.submit_date).longValue()*1000))

            crqMap.id = ChangeRequest.findByCrqNumber(params.crqId).id
            crqMap.crqNumber = q.infrastructure_change_id
            crqMap.product = q.product_name__2_
            crqMap.startDate = startDate
            crqMap.endDate = endDate
            crqMap.requestor = q.aslogid
            crqMap.requestTime = submitDate
            crqMap.site = q.site
            crqMap.approvers = ChangeRequest.findByCrqNumber(params.crqId).swiftApprovalLog

        }

        sql.close()

        println crqMap

        render crqMap as JSON
    }


    def mopDetails()
    {
        def crqId = params.crqId
        [currentPage:'mopDetails', crqId:crqId]
    }

    def testSplit(){

        def testString = "1355319232 g701977 Approved 1355321876 g701608 Approved 1355322646 g701977 Approved 1356033332 g701639 Rejected 1356033332 Remedy Application Service Process Rejected" 

        println testString.tokenize("^[\\d]")
    }

    def fetchMopDetails()
    {   

        def detailsList = []
        Sql sql = new Sql(dataSource_mysqlMOP)
        def crqId = params.crqId
        sql.eachRow("SELECT mop_name, mop_id, customer_name, create_user, create_datetime, approval_user, approval_datetime FROM mop_activity_info WHERE rss_no ='"+crqId+"'"){ g->
            def details = [:]
            details.mopName = "<a  style='margin-left:10px;'  target='_blank' href=http://chi-bmcmop.syniverse.com/mop/mop_view_html.php?mop_id="+g.mop_id+">"+g.mop_name+"</a>"
            details.customerName = g.customer_name
            details.create_user = g.create_user
            details.create_datetime = g.create_datetime
            details.approval_user = g.approval_user
            details.approval_datetime = g.approval_datetime
            //details.mopid = "<a  style='margin-left:10px;'  target='_blank' href=http://chi-bmcmop.syniverse.com/mop/mop_view_html.php?mop_id="+g.mop_id+"><span class='glyphicon glyphicon-eye-open' rel='tooltip' title='MOP View'></span></a>"
            detailsList << details
        }
        sql.close()

        def mopDetails = ["data": detailsList]
        render mopDetails as JSON
    }
    def summaryDetails()
    {
        def crqId = params.crqId
        [currentPage:'summaryDetails', crqId:crqId]
    }    
    def fetchDashBoardValues ( ) {

        int toBeRequested = 0
        int pendingApproval = 0
        int pendingClarification = 0
        int inProgress = 0
        int historic = 0

        def status = ChangeStatus.get(1)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            toBeRequested = ChangeRequest.findAllByCccStatus(status).size()

        }else{


            toBeRequested = ChangeRequest.findAllByCccStatusAndQueue(status).size()

        }
        

        status = ChangeStatus.get(2)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            pendingApproval = ChangeRequest.findAllByCccStatus(status).size()

        }else{

            pendingApproval = ChangeRequest.findAllByCccStatusAndQueue(status).size()

        }
        

        status = ChangeStatus.get(3)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            pendingClarification = ChangeRequest.findAllByCccStatus(status).size()
                
        }else{


            pendingClarification = ChangeRequest.findAllByCccStatusAndQueue(status).size()

        }
        

        def inProgressList = []
        inProgressList << ChangeStatus.get(4)
        inProgressList << ChangeStatus.get(8)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            inProgress = ChangeRequest.findAllByCccStatusInList(inProgressList).size()

        }else{


            inProgress = ChangeRequest.findAllByCccStatusInListAndQueue(inProgressList).size()

        }
        


        def historicList = []
        historicList << ChangeStatus.get(5)
        historicList << ChangeStatus.get(6)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            historic = ChangeRequest.findAllByCccStatusInList(historicList).size()

        }else{


            historic = ChangeRequest.findAllByCccStatusInListAndQueue(historicList).size()

        }
        

        def crqsMap = [:]

        crqsMap.toBeRequested = toBeRequested
        crqsMap.pendingApproval = pendingApproval
        crqsMap.pendingClarification = pendingClarification
        crqsMap.inProgress = inProgress
        crqsMap.historic = historic

        println crqsMap
     
        render crqsMap as JSON
        
    }

    def fetchSCCDashBoardValues ( ) {

        int pendingApproval = 0
        int pendingOPSClarification = 0
        int inProgress = 0
        int historic = 0

        def status = ChangeStatus.get(2)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            pendingApproval = ChangeRequest.findAllByCccStatus(status).size()

        }else{

            pendingApproval = ChangeRequest.findAllByCccStatusAndQueue(status).size()

        }
        

        status = ChangeStatus.get(3)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            pendingOPSClarification = ChangeRequest.findAllByCccStatus(status).size()

        }else{

            pendingOPSClarification = ChangeRequest.findAllByCccStatusAndQueue(status).size()

        }
        

        def inProgressList = []
        inProgressList << ChangeStatus.get(4)
        inProgressList << ChangeStatus.get(8)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

            inProgress = ChangeRequest.findAllByCccStatusInList(inProgressList).size()

        }else{

            inProgress = ChangeRequest.findAllByCccStatusInListAndQueue(inProgressList).size()

        }
        

        def historicList = []
        historicList << ChangeStatus.get(5)
        historicList << ChangeStatus.get(6)
        historicList << ChangeStatus.get(7)

        if(CockpitConfiguration.findByKey('SHOW_QUEUE_CRQ').value == 'N'){

           historic = ChangeRequest.findAllByCccStatusInList(historicList).size()     

        }else{

            historic = ChangeRequest.findAllByCccStatusInListAndQueue(historicList).size()

        }
        


        def crqsMap = [:]

        crqsMap.pendingApproval = pendingApproval
        crqsMap.pendingOPSClarification = pendingOPSClarification
        crqsMap.inProgress = inProgress
        crqsMap.historic = historic

        println crqsMap
     
        render crqsMap as JSON
        
    }

    def fetchPendingSCCApproval()
    {
        def dataToRender = [:]
        dataToRender.aaData = []

        dataToRender.aaData << ["CRQ000000110723",
                                "Apoorv Barwa",
                                "Apoorv Barwa",
                                "Shout2AutoM8",
                                "11-Nov-2016",
                                "13-Nov-2016",
                                "Test Description",
                                "<button class='btn btn-warning crqbtn' value='CRQ000000110723'><span class='glyphicon glyphicon-eye-open'></span></button>"
        ]

        render dataToRender as JSON
    }


}

