/*
 * Copyright 2015-2016 IBM Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package packages

import common._
import org.junit.runner.RunWith
import org.scalatest.Matchers
import org.scalatest.junit.JUnitRunner
import spray.json._
import spray.json.DefaultJsonProtocol.StringJsonFormat
import scala.collection.immutable.HashMap
import org.scalatest.FlatSpecLike

@RunWith(classOf[JUnitRunner])
class TemplateTests extends TestHelpers with WskTestHelpers with Matchers {

  implicit val wskprops = WskProps()
  val wsk = new Wsk()

  val credentials = TestUtils.getVCAPcredentials("template_service")
  val apiKey = credentials.get("apiKey");

  behavior of "Template Package"

  "helloworld action" should "return Hello, World!" in {
    val actionName = "/whisk.system/packageTemplate/helloWorld"
    val params = HashMap("name" -> "Openwhisk".toJson);

    withActivation(wsk.activation, wsk.action.invoke(actionName, params)) {
      _.fields("response").toString should include(s""""message":"Hello, Openwhisk!"""")
    }
  }
}
