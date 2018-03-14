//
//  DataService.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    func importHeaderData(completion: @escaping (_ header: Header?) -> () ){
        var header : Header!
        let path = Bundle.main.path(forResource: "Header", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            header = try JSONDecoder().decode(Header.self, from: data)
            completion(header)
        } catch {
            debugPrint(error)
            completion(nil)
        }
    }
    
    func importMiddleViewData(completion: @escaping (_ middleView: MiddleView?) -> () ){
        var middleView : MiddleView!
        let path = Bundle.main.path(forResource: "MiddleView", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            middleView = try JSONDecoder().decode(MiddleView.self, from: data)
            completion(middleView)
        } catch {
            debugPrint(error)
            completion(nil)
        }
    }
    
    func importChapterData(completion: @escaping (_ chapter: Chapter?) -> () ){
        let chapter : Chapter!
        let path = Bundle.main.path(forResource: "ChapterView", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            chapter = try JSONDecoder().decode(Chapter.self, from: data)
            completion(chapter)
        } catch {
            debugPrint(error)
            completion(nil)
        }
    }
}
