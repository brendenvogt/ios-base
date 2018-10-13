//
//  UserController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/1/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Alamofire

class UserController: NSObject {
    
    public class func userLogin(login:LoginRequestContract, completion: @escaping (AuthInfoContract?, ErrorContract?) -> Void) {
        Alamofire.request(UrlFactory.userLogin(), method: .post, parameters: login.dictionary, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if let data = response.data {
                let error: ErrorContract? = try? JSONDecoderAdv().decode(ErrorContract.self, from: data)
                let result: AuthInfoContract? = try? JSONDecoderAdv().decode(AuthInfoContract.self, from: data)
                completion(result, error)
            }
        }
    }

    public class func userSignup(signup:SignupRequestContract, completion: @escaping (AuthInfoContract?, ErrorContract?) -> Void) {
        Alamofire.request(UrlFactory.userSignup(), method: .post, parameters: signup.dictionary, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print(response)
            if let data = response.data {
                let error: ErrorContract? = try? JSONDecoderAdv().decode(ErrorContract.self, from: data)
                let result: AuthInfoContract? = try? JSONDecoderAdv().decode(AuthInfoContract.self, from: data)
                completion(result, error)
            }
        }
    }

}
