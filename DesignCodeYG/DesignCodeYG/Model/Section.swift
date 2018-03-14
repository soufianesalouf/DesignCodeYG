//
//  Section.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

struct Section: Decodable {
    public private(set) var sectionNum : Int!
    public private(set) var backgroundImage : String!
    public private(set) var sectionImage : String!
    public private(set) var sectionTitle : String!
    public private(set) var sectionSubTitle : String!
    public private(set) var article = [Article]()
}
