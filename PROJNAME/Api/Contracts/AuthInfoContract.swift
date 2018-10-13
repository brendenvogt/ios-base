//
//  AuthInfoContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

//https://medium.com/whoknows-swift/swift-4-decodable-encodable-3085305a9618
//https://medium.com/@phillfarrugia/encoding-and-decoding-json-with-swift-4-3832bf21c9a8

public struct AuthInfoContract: Codable {
    static var SampleData = AuthInfoContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "token": "eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0.7IbN4WHGSVbVPI-BdeOCtDRQWerVzvk-Vq2T3SJGid9BdD2hXIrQ4HbM8SBf6SoCaskUKdJIMrzHaZXA9RlVKGq1jWOTy9Dm.zC0IjPi6cvdeXAsppOkvEA.rAqr46WpKdaNaQVXV1OWzFaxvnecXZ3ogTlzUZwio2HGs1Aux5t_2gOEhTSEU4g2cADQlhJYt_XGedemh-Ii_KpcxMNn5zLlbat03InhOUHIgz3spEs1vjGPymvvCBo1k2r5XeMFw5V0CU6tNuLUy55gXQsOZwNKVXXgQEOrMdNr7JvSBLZ41C0w0ylXpCVLhoj7tdidWBhjdSfANwc4cyvZLYKBPX9THA0X_h3kQLiO-lXYoPQ0hLaZCrtsZrY8u2QM8daFz6CLKh1TdAp6GX8vJcJoIUdRsqQPeOTC_ScR5wBug7oYPy8xmIPhzXVpfS3K0qjq-YZ5ma2b--ST6OoyP4x12yYlXYSfCchqRYKN9ByMiOyix5lhiMx1n_16EejLE6eEqMmNj-7AbbvcGQ.YymxYdU-uaSJjXXRkCBro1XffNYMYT-84dtBzu-CLUk",
            "expiration": "2018-10-20T09:27:34.763704Z"
        }
        """

    public var token: String?
    public var expiration: Date?
    
    public init(token: String, expiration: Date) {
        self.token = token
        self.expiration = expiration
    }
    
    enum CodingKeys: String, CodingKey {
        case token, expiration
    }
}

//
//{
//    "user": {
//        "email": "test@gmail.com",
//        "username": null,
//        "emailCandidate": "test@gmail.com",
//        "emailConfirmed": false,
//        "bearerToken": "eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0.7IbN4WHGSVbVPI-BdeOCtDRQWerVzvk-Vq2T3SJGid9BdD2hXIrQ4HbM8SBf6SoCaskUKdJIMrzHaZXA9RlVKGq1jWOTy9Dm.zC0IjPi6cvdeXAsppOkvEA.rAqr46WpKdaNaQVXV1OWzFaxvnecXZ3ogTlzUZwio2HGs1Aux5t_2gOEhTSEU4g2cADQlhJYt_XGedemh-Ii_KpcxMNn5zLlbat03InhOUHIgz3spEs1vjGPymvvCBo1k2r5XeMFw5V0CU6tNuLUy55gXQsOZwNKVXXgQEOrMdNr7JvSBLZ41C0w0ylXpCVLhoj7tdidWBhjdSfANwc4cyvZLYKBPX9THA0X_h3kQLiO-lXYoPQ0hLaZCrtsZrY8u2QM8daFz6CLKh1TdAp6GX8vJcJoIUdRsqQPeOTC_ScR5wBug7oYPy8xmIPhzXVpfS3K0qjq-YZ5ma2b--ST6OoyP4x12yYlXYSfCchqRYKN9ByMiOyix5lhiMx1n_16EejLE6eEqMmNj-7AbbvcGQ.YymxYdU-uaSJjXXRkCBro1XffNYMYT-84dtBzu-CLUk",
//        "dateJoined": "2018-10-13T09:27:34.778008+00:00"
//    },
//    "authInfo": {
//        "token": "eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0.7IbN4WHGSVbVPI-BdeOCtDRQWerVzvk-Vq2T3SJGid9BdD2hXIrQ4HbM8SBf6SoCaskUKdJIMrzHaZXA9RlVKGq1jWOTy9Dm.zC0IjPi6cvdeXAsppOkvEA.rAqr46WpKdaNaQVXV1OWzFaxvnecXZ3ogTlzUZwio2HGs1Aux5t_2gOEhTSEU4g2cADQlhJYt_XGedemh-Ii_KpcxMNn5zLlbat03InhOUHIgz3spEs1vjGPymvvCBo1k2r5XeMFw5V0CU6tNuLUy55gXQsOZwNKVXXgQEOrMdNr7JvSBLZ41C0w0ylXpCVLhoj7tdidWBhjdSfANwc4cyvZLYKBPX9THA0X_h3kQLiO-lXYoPQ0hLaZCrtsZrY8u2QM8daFz6CLKh1TdAp6GX8vJcJoIUdRsqQPeOTC_ScR5wBug7oYPy8xmIPhzXVpfS3K0qjq-YZ5ma2b--ST6OoyP4x12yYlXYSfCchqRYKN9ByMiOyix5lhiMx1n_16EejLE6eEqMmNj-7AbbvcGQ.YymxYdU-uaSJjXXRkCBro1XffNYMYT-84dtBzu-CLUk",
//        "expiration": "2018-10-20T09:27:34.763704Z"
//    }
//}
