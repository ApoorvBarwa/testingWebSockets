package cm

import grails.transaction.Transactional
import org.springframework.messaging.simp.SimpMessagingTemplate

@Transactional
class UpdateService {
    SimpMessagingTemplate brokerMessagingTemplate

    def serverUpdate() {
    	def message = "Hello From Server"
    	brokerMessagingTemplate.convertAndSend "/topic/update" + message
    }
}
