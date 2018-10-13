//
//  EncodableExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/13/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
