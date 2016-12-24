package cm

class ChangeRequestUpdates {

    static belongsTo = [cr:ChangeRequest,oldStatus:ChangeStatus,newStatus:ChangeStatus]
    static hasMany = [sccUpdates:SccUpdates]

    static constraints = {

    	crqNumber blank:false, nullable:false
    	updatedAt blank:false, nullable:false
    	updatedBy blank:false, nullable:false
    	description blank:false, nullable:false	

    }

    static mapping = {

        table name:'cm_change_request_updates'
        
    	crqNumber sqlType:'varchar(20)'
    	updatedAt sqlType:'number(15)'
    	updatedBy sqlType:'varchar(15)'
    	description sqlType:'varchar(4000)'

    	version true

    }

    String crqNumber
    Long updatedAt
    String updatedBy
    String description
}

