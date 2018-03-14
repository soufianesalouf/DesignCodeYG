//
//  ArticleVC.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/13/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class ArticleVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sectionSubTitleLbl: UILabel!
    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var sectionItemImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //variable
    public private(set) var section: Section!

    override func viewDidLoad() {
        super.viewDidLoad()
//        articleTableView.delegate = self
//        articleTableView.dataSource = self
//        articleTableView.estimatedRowHeight = 97
//        articleTableView.rowHeight = UITableViewAutomaticDimension
        setupView()
    }
    
    func initSection(section: Section){
        self.section = section
    }
    
    func setupView(){
        backgroundImage.image = UIImage(named: section.backgroundImage)
        sectionTitleLbl.text = section.sectionTitle
        sectionSubTitleLbl.text = section.sectionSubTitle
        sectionItemImage.image = UIImage(named: section.sectionImage)
        
//        for index in 0 ..< section.article.count {
//            let article = section.article[index]
//                     self.containerView.addSubview(articleView!)
//
//        }
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}


class ArticleView: UIView {
    var title : String!
    var detail: String!
    
    init(frame: CGRect, title: String, detail: String) {
        super.init(frame: frame)
        self.title = title
        self.detail = detail
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        let titleLbl = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 23))
        titleLbl.text = self.title
        addSubview(titleLbl)
        
        
    }
}

//extension ArticleVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.section.article.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as?
//            ArticleCell {
//            cell.configureCell(article: self.section.article[indexPath.row])
//            return cell
//        }
//        return UITableViewCell()
//    }
//}

