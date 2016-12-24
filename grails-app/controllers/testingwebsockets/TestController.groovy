package testingwebsockets
import grails.plugin.springsecurity.annotation.Secured

class TestController {

	@Secured(['IS_AUTHENTICATED_FULLY'])
    def index() { render "Test Controller" }

}