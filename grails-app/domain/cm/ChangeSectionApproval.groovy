package cm

class ChangeSectionApproval {

    static belongsTo = [cr:ChangeRequest,cs:ChangeSection]

    static constraints = {

    	updatedAt blank:false, nullable:false
    	updatedBy blank:false, nullable:false
    	status blank:false, nullable:false	

    }

    static mapping = {

        table name:'cm_section_approval'
        
    	updatedAt sqlType:'number(15)'
    	updatedBy sqlType:'varchar(15)'
    	status sqlType:'varchar(4000)'

    	version true

    }

    String status 
    Long updatedAt
    String updatedBy

}
