//
//  Object+WS.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import Foundation

// Todo - replace
private struct ParentJSONForMessages: Codable {
    let data: [Message]
}

// Todo - replace
struct ObjectWS {
    
    static func testAPICall(userId: String, success: @escaping ([Message]) -> Void, failure: @escaping (String) -> Void) {
        
        let testURL = Constant.API.url + "foo/"
        
        let parameters: HTTPParameters = ["param1": userId,
                                          "param2": "\(false)",
                                          "param3": "\(10)"]
        
        API.request(root: testURL, method: .GET, parameters: parameters, body: nil, model: ParentJSONForMessages.self, success: { (JSON) in
            success(JSON.data)
        }) { (error) in
            failure(error.message())
        }
    }
    
}
