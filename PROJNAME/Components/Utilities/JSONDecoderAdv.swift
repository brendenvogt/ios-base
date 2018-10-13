//
//  JSONDecoderAdv.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/13/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class JSONDecoderAdv: JSONDecoder {
    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(.iso8601Full)
    }
}
