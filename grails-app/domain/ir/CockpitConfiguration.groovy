package ir

class CockpitConfiguration {

	String key
	String value
	String description

    static constraints = {
		key blank: false, nullable: false
		value blank: false, nullable: false
		description blank: true, nullable: true
    }
	
	static mapping ={
		
		key sqlType: "varchar(300)"
		value sqlType: "varchar(300)"		
		description sqlType: "varchar(1000)"								
		version false
		id generator:'sequence', params:[sequence:'CCC_CONFIGURATION_SEQ']
	}
}
