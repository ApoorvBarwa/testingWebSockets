package cm

class ChangeStatus {

	static hasMany = [cr:ChangeRequest]

    static constraints = {

    	status blank:false, nullable:false

    }

    static mapping = {

    	table name:'cm_change_status'

    	status sqlType:'varchar(30)'
    	version true
    }

    String status

}
