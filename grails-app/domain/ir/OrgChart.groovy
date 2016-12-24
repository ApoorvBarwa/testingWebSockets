package ir

class OrgChart {

	static constraints = {
		name blank: false, nullable: false
		displayName blank: false, nullable: false
		gid blank: false, nullable: false
		mgid blank: false, nullable: false
		role blank: false, nullable: false
		rootPath blank:true, nullable: true
		email blank: false, nullable: false
	}

	static mapping = {

		table name: "org_chart.org_chart_new"
		name sqlType: "varchar(250)"
		displayName sqlType: "varchar(250)"
		gid sqlType: "varchar(20)"
		mgid sqlType: "varchar(20)"
		role sqlType: "varchar(20)"
		disabled sqlType: "varchar(1)"
		rootPath sqlType: "varchar(1000)"
		email sqlType: "varchar(250)"
		id generator:'sequence', params:[sequence:'ORG_CHART_SEQ']
		version false
	}

	String name
	String displayName
	String gid
	String mgid
	String role
	String disabled
	String rootPath
	String email
}
