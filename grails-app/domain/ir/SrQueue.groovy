package ir

class SrQueue {

	static constraints = {
		name blank: false, nullable: false
		owner blank: false, nullable: false
		supportOrganization blank: false, nullable: false
		forSr blank: false, nullable: false
	}
	static mapping = {

		datasource 'srqueue'
		table name: "org_chart.sr_queue"
		name sqlType: "varchar(250)"
		owner sqlType: "varchar(200)"
		supportOrganization sqlType: "varchar(100)"
		forSr sqlType: "varchar(1)"
		id generator:'sequence', params:[sequence:'SR_QUEUE_SEQ']
		version false
	}

	String name
	String owner
	String supportOrganization
	String forSr
	String members

}
