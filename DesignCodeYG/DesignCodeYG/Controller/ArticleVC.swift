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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sectionSubTitleLbl: UILabel!
    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var sectionItemImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //variable
    public private(set) var section: Section!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 97
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.isUserInteractionEnabled = false
        scrollView.resignFirstResponder()
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
    }
    
    @IBAction func QuizBtnWasPessed(_ sender: Any) {
//        performSegue(withIdentifier: "QuizVC", sender: nil)
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ArticleVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section.article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as?
            ArticleCell {
            cell.configureCell(article: self.section.article[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.intersects(self.headerView.bounds) == true {
            if tableView.contentOffset.y == 0 {
                tableView.isUserInteractionEnabled = false
                tableView.resignFirstResponder()
                
            } else {
                tableView.isUserInteractionEnabled = true
                scrollView.resignFirstResponder()
            }
        } else {
            tableView.isUserInteractionEnabled = true
            scrollView.resignFirstResponder()
        }
    }
}
