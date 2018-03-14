//
//  Chapter.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

struct Chapter: Decodable {
    public private(set) var chapterNum : Int!
    public private(set) var numberOfsections : Int!
    public private(set) var sections = [Section]()
}
