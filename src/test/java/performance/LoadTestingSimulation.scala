package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class LoadTestingSimulation extends Simulation {

  val getTransactions = scenario("GitLab issues").exec(karateFeature("classpath:new-issue-test.feature"))
  setUp(
    getTransactions.inject(rampUsers(50) during  (60 seconds))
  )

}
