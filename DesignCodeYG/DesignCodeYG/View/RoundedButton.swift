//
//  RoundedButton.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/14/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
