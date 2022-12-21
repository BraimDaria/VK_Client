//
//  Singleton.swift
//  VK_Client
//
//  Created by  Daria on 25.11.2022.
//

import Foundation

class Session {
    
    static let shared = Session()
    private init() {
        
    }
    
    var token = ""
    var userId = 0
    
    func getToken() {
        self.token = UUID().uuidString
        
    }
    
    
}
