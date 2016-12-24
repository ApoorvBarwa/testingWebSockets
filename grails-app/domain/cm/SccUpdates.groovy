package cm

class SccUpdates {

	static belongsTo = [ crupdate:ChangeRequestUpdates]

    static constraints = {

    	section blank:false, nullable:false	
    	approved blank:false, nullable:false	
    	description blank:false, nullable:false	
    	updatedAt blank:false, nullable:false	
    	updatedBy blank:false, nullable:false	

    }

    static mapping = {

    	section sqlType:'varchar(4000)'
    	approved sqlType:'varchar(4000)'
    	updatedAt sqlType:'number(15)'
    	updatedBy sqlType: 'varchar(2000)'
    	description sqlType:'varchar(4000)'

    	version true

    }

    String section
    String approved
    Long updatedAt
    String updatedBy
    String description
}
