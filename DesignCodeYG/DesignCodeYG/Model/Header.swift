//
//  Header.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

struct Header: Decodable {
    public private(set) var backgroundImage : String!
    public private(set) var title : String!
    public private(set) var itemImage : String!
    public private(set) var firstStackTitle : String!
    public private(set) var firstStackInfo : String!
    public private(set) var firstStackDescription : String!
    public private(set) var secondStackTitle : String!
    public private(set) var secondStackInfo : String!
    public private(set) var secondStackDescription : String!
}
