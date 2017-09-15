//
//  FileHandler.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class FileHandler {
    
    func readJson (file: String) -> [String: Any]{
        do {
            if let file = Bundle.main.url(forResource: file, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                return json as! [String : Any]
            }
        } catch {
            print(error.localizedDescription)
        }
        return [String : Any]()
    }

}
