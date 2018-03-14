//
//  TableViewCell.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    func configureCell(article: Article){
        titleLbl.text = article.title
        detailLbl.text = article.detail
    }
}
