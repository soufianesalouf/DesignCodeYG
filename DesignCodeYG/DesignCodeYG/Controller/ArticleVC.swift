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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func initSection(section: Section){
        self.section = section
    }
    
    func setupView(){
        self.navigationController?.isNavigationBarHidden = false
        backgroundImage.image = UIImage(named: section.backgroundImage)
        sectionTitleLbl.text = section.sectionTitle
        sectionSubTitleLbl.text = section.sectionSubTitle
        sectionItemImage.image = UIImage(named: section.sectionImage)
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

extension ArticleVC: ZoomingViewController {
    func ZoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return sectionItemImage
    }
    
    func ZoomingTitle(for transition: ZoomTransitioningDelegate) -> UILabel? {
        return sectionTitleLbl
    }
    
    func ZoomingSubTitle(for transition: ZoomTransitioningDelegate) -> UILabel? {
        return sectionSubTitleLbl
    }
    
    func ZoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return backgroundImage
    }
    
    
}

