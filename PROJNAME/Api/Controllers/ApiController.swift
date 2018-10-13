//
//  ApiController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/1/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Alamofire

class ApiController: NSObject {

    public class func getApi(completion: @escaping (BoolContract?, ErrorContract?) -> Void) {
        Alamofire.request(UrlFactory.api()).responseJSON { response in
            if let data = response.data {
                print(data)
                let error: ErrorContract? = try? JSONDecoder().decode(ErrorContract.self, from: data)
                let result: BoolContract? = try? JSONDecoder().decode(BoolContract.self, from: data)
                completion(result, error)
            }
        }
    }
    
}
