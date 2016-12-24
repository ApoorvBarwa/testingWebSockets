package cm

class ChangeRequest {

	static hasMany = [cru:ChangeRequestUpdates,csa:ChangeSectionApproval]

	static belongsTo = [cccStatus:ChangeStatus]

    static constraints = {

    	crqNumber blank:false, nullable:false
    	crqOwner blank:false, nullable:false
    	changeCoordinator blank:false, nullable:false
    	product blank:false, nullable:false
    	scheduledStartTime blank:false, nullable:false
    	scheduledEndTime blank:false, nullable:false
    	description blank:true, nullable:true
    	swiftStatus blank:false, nullable:false
    	crqLocation blank:false, nullable:false
		site blank:true, nullable:true
        randomString blank:true, nullable:true
        asgrp blank:true, nullable:true
        lockedBy blank:true, nullable:true
        lockedAt blank:true, nullable:true
    }


    static mapping = {

    	cru cascade : "all-delete-orphan"

    	table name:'cm_change_request'

    	crqNumber sqlType:'varchar(20)'
    	crqOwner sqlType:'varchar(100)'
    	changeCoordinator sqlType:'varchar(100)'
    	product sqlType:'varchar(50)'
    	scheduledStartTime sqlType:'number(15)'
    	scheduledEndTime sqlType:'number(15)'
    	description sqlType:'varchar(4000)'
    	swiftStatus sqlType:'varchar(20)'
    	crqLocation sqlType:'varchar(1000)'
		site sqlType:'varchar(1000)'
        randomString sqlType: 'varchar(1000)'
        asgrp sqlType: 'varchar(200)'
        lockedBy sqlType: 'varchar(10)'
        lockedAt sqlType: 'number(20)'

    	version true

    }

    String crqNumber
    String crqOwner
    String changeCoordinator
    String product
    Long scheduledStartTime
    Long scheduledEndTime
    String description
    String swiftStatus
    String crqLocation
	String site
    String randomString
    String asgrp
    String swiftApprovalLog
    Long lockedAt
    String lockedBy

}

