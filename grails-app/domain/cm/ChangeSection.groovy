package cm

class ChangeSection {

    static constraints = {

    name blank:false, nullable:false

    }

    static mapping = {

    	table name:'cm_section'

    	status sqlType:'varchar(30)'
    	version true
    }

    String name

}
