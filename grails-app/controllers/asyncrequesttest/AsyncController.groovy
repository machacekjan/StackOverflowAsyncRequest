package asyncrequesttest

import grails.converters.JSON

import static grails.async.Promises.task

class AsyncController {

	def index() { }

	def longTerm() {
		session.longTerm = 0
		session.longTermDone = false

		task {
			for (int i; i < 10; i++ ) {
				try {
					sleep(3000) //NOT WORKING
					println "  TASK: sessionID ${session.id} value ${session.longTerm++}"
					//sleep(3000) //WORKING
				} catch (e) {
					println(e.class.name)
				}
			}

			session.longTermDone = true
		}
		render(text: [] as JSON, status: 200)
	}

	def longTermStatus() {
		println "STATUS: sessionID ${session.id} value ${session.longTerm}"
		render(text: [successCount: session.longTerm, done: session.longTermDone] as JSON, status: 200)
	}
}
