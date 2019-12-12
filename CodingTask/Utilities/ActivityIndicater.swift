//
//  ActivityIndicater.swift
//  ReplyChamp
//
//  Created by bhavan ram on 08/02/19.
//  Copyright © 2019 appailus. All rights reserved.
//

import UIKit

class ActivityIndicater: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    let activityView : UIView = {
        let view = UIView()
        view.backgroundColor=UIColor (red: 0/255.0, green: 131/255.0, blue: 0/255.0, alpha: 1)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    let activity : UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.contentMode = .scaleAspectFill
        indicatorView.clipsToBounds = true
        indicatorView.style = .whiteLarge
        indicatorView.color = .white
        return indicatorView
    }()
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont.systemFont(ofSize: 15.0)
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.addSubview(view)
        view.addSubview(activityView)
        activityView.addSubview(activity)
        activityView.addSubview(label)
        
        view.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        view.heightAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        activityView.setAnchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

        
        activity.setAnchor(top: activityView.topAnchor, left: activityView.leftAnchor, bottom: nil, right: activityView.rightAnchor, paddingTop: 8, paddingLeft: 8 , paddingBottom: 0, paddingRight: 8)
        activity.centerXAnchor.constraint(equalTo: activityView.centerXAnchor).isActive = true
        
        
        label.setAnchor(top: activity.bottomAnchor, left: activityView.leftAnchor, bottom: activityView.bottomAnchor, right: activityView.rightAnchor, paddingTop: 2, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func hideActivityIndicater () {
        
        self.label.text = ""
        self.activity.stopAnimating()
        self.removeFromSuperview()
    }

    
}
