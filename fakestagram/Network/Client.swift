//
//  Client.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

typealias completionHandler = (HTTPURLResponse, Data?) -> Void
typealias errorHandler = (Error?) -> Void

struct Client {
    let baseURLComponents: URLComponents

    func get(path: String, completionHandler: completionHandler?) {
        get(path: path, body: nil, completionHandler: completionHandler, errorHandler: nil)
    }
    func get(path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        get(path: path, body: body, cache: true, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func get(path: String, body: Data?, cache: Bool, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request("GET", path: path, body: body, cache: cache, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func post(path: String, body: Data?, completionHandler: completionHandler?) {
        post(path: path, body: body, completionHandler: completionHandler, errorHandler: nil)
    }
    func post(path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request("POST", path: path, body: body, cache: false, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func put(path: String, body: Data?, completionHandler: completionHandler?) {
        put(path: path, body: body, completionHandler: completionHandler, errorHandler: nil)
    }
    func put(path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request("PUT", path: path, body: body, cache: false, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func patch(path: String, body: Data?, completionHandler: completionHandler?) {
        patch(path: path, body: body, completionHandler: completionHandler, errorHandler: nil)
    }
    func patch(path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request("PATCH", path: path, body: body, cache: false, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func delete(path: String, completionHandler: completionHandler?) {
        delete(path: path, body: nil, completionHandler: completionHandler, errorHandler: nil)
    }
    func delete(path: String, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        delete(path: path, body: nil, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    func delete(path: String, body: Data?, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        request("DELETE", path: path, body: body, cache: false, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func request(_ method: String, path: String, body: Data?, cache: Bool, completionHandler: completionHandler?, errorHandler: errorHandler?) {
        var requestURLComponents = baseURLComponents
        requestURLComponents.path = path
        guard let url = requestURLComponents.url else {
            print("[ERROR] Invalid path: \(path)")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        if let token = Secrets.uuid.value {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                errorHandler?(error)
                return
            }
            let httpResponse = response as! HTTPURLResponse
            completionHandler?(httpResponse, data)
        }
        task.resume()
    }
}
