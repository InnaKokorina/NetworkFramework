//
//  ApiKeyModel.swift
//  CleanArchitecture
//
//  Created by Inna Kokorina on 12.01.2023.
//

import Foundation

public struct ApiKeyModel: Encodable {
   public var key: String
    
    public init(key: String) {
        self.key = key
    }
}
