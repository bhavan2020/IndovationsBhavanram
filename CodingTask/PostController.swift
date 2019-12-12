//
//  PostController.swift
//  CodingTask
//
//  Created by bhavan on 12/12/19.
//  Copyright © 2019 bhavan. All rights reserved.
//

import UIKit

class PostController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // MARK: - Cell Identifier
    let postsCell = "PostsCell"
    
    // MARK: - Refreshing Object
    let refreshControl = UIRefreshControl()
    
    // MARK: - Respones Object
    var postResponseResult = [PostResponseResult]()
    
    var forToggelSwith = [PostResponseResult]()

    let activityIndicater = ActivityIndicater()

    var page = 1

    // MARK: - TableView Object
    lazy var postsTV:UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = true
        table.backgroundColor = .clear
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        refreshControl.addTarget(self, action: #selector(postsRefreshAction), for: .valueChanged)
        table.refreshControl = refreshControl
        return table
    }()
    
    // MARK: - Count Button
    lazy var countBT : UIButton = {
        let ba = UIButton()
        ba.clipsToBounds = true
        ba.frame = CGRect(x: 0, y: 0, width: 100, height: 64)
        ba.setTitle("0", for: .normal)
        ba.setTitleColor(UIColor.white, for: .normal)
        return ba
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "POSTS"
        
        view.backgroundColor = .white
        
        view.addSubview(postsTV)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: countBT)

        
        postsTV.setAnchor(top: view.safeTopAnchor, left: view.safeLeftAnchor , bottom: view.safeBottomAnchor  , right: view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        let url = ApiInterface.getPostsData+String(page)
        
        RestService.callPost(url:url, params:"" ,methodType:"GET",tag: "getPosts" ,finish: finishPost)

        UtilityCode.showActivityIndicater (target: self, title: "Loding..." ,activity : activityIndicater)

        
        registerCells()
        
    }
    
    // MARK: - Registering Table View Cell
    fileprivate func registerCells() {
        
        postsTV.estimatedRowHeight = 75
        postsTV.rowHeight = UITableView.automaticDimension
        postsTV.register(PostsCell.self, forCellReuseIdentifier: postsCell)
        
    }
    
    // MARK: - Api Calling Result
    func finishPost (message:String, data:Data? , tag: String) -> Void
    {
        do
        {
            if let jsonData = data
            {
                
                UtilityCode.hideActivityIndicater(target: self, activity: activityIndicater)
                
                if tag == "getPosts" {
                    
                    refreshControl.endRefreshing()
                    
                    let parsedData = try JSONDecoder().decode(PostsResponse.self, from: jsonData)
                    print(parsedData)
                    
                    if parsedData.hits.count > 0{
                        
                        if page == 1 {
                            
                            postResponseResult.removeAll()
                            
                        }
                        
                        postResponseResult.append(contentsOf:parsedData.hits)
                        postsTV.reloadData()
                    
                    }
                }
            }
            
        }
        catch
        {
        
            print("Parse Error: \(error)")
            
        }
    }
    
    // MARK: - Page Refreshing
    @objc func postsRefreshAction(){
        
        forToggelSwith.removeAll()

        countBT.setTitle(String(forToggelSwith.count), for: .normal)

        page = 1
        
        let url = ApiInterface.getPostsData+String(page)

        RestService.callPost(url:url, params:"" ,methodType:"GET",tag: "getPosts" ,finish: finishPost)
        
    }
    
    
    // MARK: - Table View Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postResponseResult.count
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postsTV.dequeueReusableCell(withIdentifier: postsCell, for: indexPath) as! PostsCell
        
        let index = postResponseResult[indexPath.row]

        cell.postResponseResult = index
        
        cell.toggle.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        
        
        if forToggelSwith.contains(where: { $0.objectID == index.objectID }) {
                   
                
            cell.toggle.setOn(true, animated: true)
                
        }else {
                   
        
            cell.toggle.setOn(false, animated: true)

        }
        
        if indexPath.row == postResponseResult.count-1 {
            
            lodeMoreData()
            
        }
    
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let index = postResponseResult[indexPath.row]

        if let index = forToggelSwith.firstIndex(where: { $0.objectID == index.objectID }) {

            self.forToggelSwith.remove(at: index)

        
        }else{
            
            self.forToggelSwith.append(index)

            
        }
        
        
        postsTV.reloadData()
        
        countBT.setTitle(String(forToggelSwith.count), for: .normal)

        
    }
    
    // MARK: - Pagenation
    func lodeMoreData(){

        page = page+1
        
        let url = ApiInterface.getPostsData+String(page)
        
        RestService.callPost(url:url, params:"" ,methodType:"GET",tag: "getPosts" ,finish: finishPost)

        
    }
    
    @objc func toggleSwitch(sender: UISwitch) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.postsTV)
              
        let indexPath = self.postsTV.indexPathForRow(at: buttonPosition)
               
              
        let index = postResponseResult[(indexPath?.row)!]
        
        
        if let index = forToggelSwith.firstIndex(where: { $0.objectID == index.objectID }) {

            self.forToggelSwith.remove(at: index)

        }else{
                   
            self.forToggelSwith.append(index)

        }
               
        postsTV.reloadData()
        
        countBT.setTitle(String(forToggelSwith.count), for: .normal)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
