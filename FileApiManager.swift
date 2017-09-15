//
//  FileApiManager.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/8/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class FileApiManager {
    
    let filemgr = FileManager.default
    
    
    func checkFile (){
        if filemgr.fileExists(atPath: " /Users/andersonjso/Downloads/tweet.json") {
            print("File exists")
        } else {
            print("File not found")
        }
    }
}
