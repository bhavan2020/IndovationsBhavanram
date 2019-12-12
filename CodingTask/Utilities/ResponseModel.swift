//
//  ResponseModel.swift
//  Task
//
//  Created by Sundeep on 11/12/19.
//  Copyright © 2019 task. All rights reserved.
//

import UIKit


struct PostsResponse : Decodable {
    
    let hits : [PostResponseResult]
    let nbHits : Int?
    let page : Int?
    let nbPages : Int?
    let hitsPerPage : Int?
    let processingTimeMS : Int?
    let exhaustiveNbHits : Bool?
    let query : String?
    let params : String?

}

struct PostResponseResult : Decodable {
    
    let created_at : String?
    let title : String?
    let url : String?
    let author : String?
    let points : Int?
    let story_text : String?
    let comment_text : String?
    let num_comments : Int?
    let story_id : String?
    let story_title : String?
    let story_url : String?
    let parent_id : String?
    let created_at_i : Int?
    let relevancy_score : Int?
    let _tags : TagsResult?
    let objectID : String?
    let _highlightResult : HighlightResult?
    
}

struct HighlightResult : Decodable {

}

struct TagsResult : Decodable {
    
}
