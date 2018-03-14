//
//  ViewController.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/13/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    //outlets
        //Header
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
        //firstStack
    @IBOutlet weak var firstStackTitle: UILabel!
    @IBOutlet weak var firstStackInfo: UILabel!
    @IBOutlet weak var firstStackDescription: UILabel!
        //secondStack
    @IBOutlet weak var secondStackTitle: UILabel!
    @IBOutlet weak var secondStackInfo: UILabel!
    @IBOutlet weak var secondStackDescription: UILabel!
        //MiddleView
    @IBOutlet weak var middleViewLogo: UIImageView!
    @IBOutlet weak var middleViewTitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
        //chapter
    @IBOutlet weak var chapterNumAndNumberOfSectionsLbl: UILabel!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    
    
    //Var
    var header: Header!
    var middleView: MiddleView!
    var chapter: Chapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importHeaderData()
        importMiddleViewData()
        importChapterData()
        
        setupView()
        
        chapterCollectionView.delegate = self
        chapterCollectionView.dataSource = self
    }
    
    func setupView(){
        
        //Header
        headerBackgroundImage.image = UIImage(named: header.backgroundImage)
        headerTitle.text = header.title
        headerImage.image = UIImage(named: header.itemImage)
        
        //firstStack
        firstStackTitle.text = header.firstStackTitle
        firstStackInfo.text = header.firstStackInfo
        firstStackDescription.text = header.firstStackDescription
        
        //secondStack
        secondStackTitle.text = header.secondStackTitle
        secondStackInfo.text = header.secondStackInfo
        secondStackDescription.text = header.secondStackDescription
        
        //MiddleView
        middleViewLogo.image = UIImage(named: middleView.logo)
        middleViewTitleLbl.text = middleView.title
        subTitleLbl.text = middleView.subTitle
        
        //chapter
        chapterNumAndNumberOfSectionsLbl.text = "CHAPTER \(chapter.chapterNum!): \(chapter.numberOfsections!) SECTIONS"
    }
    
    
    func importHeaderData(){
        let path = Bundle.main.path(forResource: "Header", ofType: "json")
        let url
            = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.header = try JSONDecoder().decode(Header.self, from: data)
        } catch {
            debugPrint(error)
        }
    }
    
    func importMiddleViewData(){
        let path = Bundle.main.path(forResource: "MiddleView", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.middleView = try JSONDecoder().decode(MiddleView.self, from: data)
        } catch {
            debugPrint(error)
        }
    }
    
    func importChapterData(){
        let path = Bundle.main.path(forResource: "ChapterView", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.chapter = try JSONDecoder().decode(Chapter.self, from: data)
        } catch {
            debugPrint(error)
        }
    }
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapter.numberOfsections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let chapterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath) as? ChapterCell {
            chapterCell.configureCell(section: self.chapter.sections[indexPath.row])
            return chapterCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.chapter.sections[indexPath.row]
        performSegue(withIdentifier: "ArticleVC", sender: section)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let articleVC = segue.destination as? ArticleVC {
            assert(sender as? Section != nil)
            articleVC.initSection(section: sender as! Section)
        }
    }
    
}

