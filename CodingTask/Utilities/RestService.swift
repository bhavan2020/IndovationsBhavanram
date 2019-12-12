//
//  ApiService.swift
//  Task
//
//  Created by Sundeep on 11/12/19.
//  Copyright © 2019 task. All rights reserved.
//

import UIKit

class RestService: NSObject {
    
    // MARK: - For api calling
    static func callPost(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void)
    {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if methodType == "POST"  || methodType == "PUT" {

        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
        var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                } catch {
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                
                if(error != nil)
                {
                    result.message = "Fail Error not null : \(error.debugDescription)"
                }
                else
                {
                    
                    result.message = "Success"
                    result.data = data
                    result.tag = tag
                    
                }
                
                finish(result)
                
            
            }

            }
            task.resume()
            
        }
    }
    
}
