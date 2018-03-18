//
//  ChapterCell.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class ChapterCell: UICollectionViewCell {
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var sectionImage: UIImageView!
    
    func configureCell(section: Section){
        bgImage.image = UIImage(named: section.backgroundImage)
        titleLbl.text = section.sectionTitle
        descriptionLbl.text = section.sectionSubTitle
        sectionImage.image = UIImage(named: section.sectionImage)
        
    }
}
