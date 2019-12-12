//
//  UtilityCode.swift
//  ReplyChamp
//
//  Created by bhavan ram on 29/01/19.
//  Copyright © 2019 appailus. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


public class UtilityCode {
    
    
    // MARK: - Date Converter
       class func convertDateFormater(_ date: String) -> String{
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
           let getDate = dateFormatter.date(from: date)
           dateFormatter.dateFormat = "MMM d, yyyy || h:mm a"
           return  dateFormatter.string(from: getDate!)
           
       }
    
    class func showActivityIndicater (target: UIViewController, title: String? ,activity : ActivityIndicater) {
        
        target.view.addSubview(activity)
        activity.setAnchor(top: target.view.topAnchor , left: target.view.leftAnchor, bottom: target.view.bottomAnchor, right: target.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        activity.activity.startAnimating()
        activity.label.text = title ?? ""
        
    }
    
    class func hideActivityIndicater (target: UIViewController ,activity : ActivityIndicater) {
        
        activity.label.text = ""
        activity.activity.stopAnimating()
        activity.removeFromSuperview()
       
    }
    
}
extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}
