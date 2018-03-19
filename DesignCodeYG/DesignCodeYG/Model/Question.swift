//
//  Question.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/19/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

struct Question : Decodable {
    public private(set) var questionImage: String!
    public private(set) var question: String!
    public private(set) var optionA: String!
    public private(set) var optionB: String!
    public private(set) var optionC: String!
    public private(set) var optionD: String!
    public private(set) var correctAnswer: Int!
}
