import UIKit
import FacebookCore
import FacebookLogin
import SwiftyJSON

typealias FacebookResponseHandler = (_ response:FBResponseModel?, _ errorMessage:String?) -> Void

class FacebookHelper: NSObject {
    class func login(fromViewControler:UIViewController, returnBlock:@escaping FacebookResponseHandler) {
        LoginManager().logIn(readPermissions: [.publicProfile, .email, .custom("user_birthday")], viewController: fromViewControler) { (loginResult) in
            
            switch loginResult {
            case .failed(let error):
                print("facebook login failed with error: ",error.localizedDescription)
                break
            case .cancelled:
                print("facebook login canceld by user")
                break
            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
                print("facebook login success!")
                let params = ["fields" : "email,name,first_name,last_name,birthday,gender"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params)
                
                graphRequest.start {
                    (urlResponse, requestResult) in
                    switch requestResult {
                    case .failed(let error):
                        returnBlock(nil, error.localizedDescription)
                        break
                    case .success(let graphResponse):
                        if var responseDictionary = graphResponse.dictionaryValue {
                            responseDictionary["accessToken"] = accessToken.authenticationToken
                            let fbResponse = FBResponseModel.init(input: responseDictionary)
                            returnBlock(fbResponse, nil)
                        }
                    }
                }
                break
            }
        }
    }
    
    class func logout() {
        LoginManager().logOut()
    }
}
