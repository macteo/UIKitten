//
//  Print.swift
//  UIKitten
//
//  Created by Matteo Gavagnin on 06/03/17.
//  Copyright © 2017 Dolomate. All rights reserved.
//

import Foundation

func json(_ object: AnyObject?, log: Bool) -> String {
    guard let object = object else {
        return "Object is nil"
    }
    do {
        let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        let string = String(data: data, encoding: String.Encoding.utf8)
        if let string = string {
            if log {
                NSLog("\n%@", string)
            }
            return string
        }
        return "Cannot parse string"
    } catch let error {
        return "Cannot serialize \(error)"
    }
}

func json(_ object: AnyObject?) -> String {
    return json(object, log: true)
}

func string(_ data: Data?) -> String {
    guard let data = data else { return "" }
    if let string = String(data: data, encoding: String.Encoding.utf8) {
        NSLog("\n%@", string)
        return string
    }
    return ""
}

extension Dictionary {
    var json : String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let string = String(data: data, encoding: .utf8)
        return string
    }
}
