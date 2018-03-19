//
//  QuizVC.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/19/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {

    //Outlets
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var optionABtn: UIButton!
    @IBOutlet weak var optionBBtn: UIButton!
    @IBOutlet weak var optionCBtn: UIButton!
    @IBOutlet weak var optionDBtn: UIButton!
    
    //Var
    var questionBank: QuestionBank!
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importQuestionData()
        updateQuestion()
        updateHeader()
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            sender.backgroundColor = UIColor.green
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else{
            sender.backgroundColor = UIColor.red
            ProgressHUD.showError("Incorrect")
        }
        questionNumber += 1
        updateQuestion()
    }
    
    func updateQuestion(){
        if questionNumber <= questionBank.questions.count - 1{
            questionImage.image = UIImage(named:(questionBank.questions[questionNumber].questionImage))
            questionLbl.text = questionBank.questions[questionNumber].question
            optionABtn.setTitle(questionBank.questions[questionNumber].optionA, for: UIControlState.normal)
            optionBBtn.setTitle(questionBank.questions[questionNumber].optionB, for: UIControlState.normal)
            optionCBtn.setTitle(questionBank.questions[questionNumber].optionC, for: UIControlState.normal)
            optionDBtn.setTitle(questionBank.questions[questionNumber].optionD, for: UIControlState.normal)
            selectedAnswer = questionBank.questions[questionNumber].correctAnswer
            resetBackgroundColor()
            updateHeader()
        }else {
            let alert = UIAlertController(title: "Awesome", message: "End of Quiz. Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {action in self.restartQuiz()})
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: {action in self.dismissToHome()})
            alert.addAction(restartAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func dismissToHome(){
        dismiss(animated: true, completion: nil)
    }
    
    func resetBackgroundColor(){
        optionABtn.backgroundColor = UIColor.lightGray
        optionBBtn.backgroundColor = UIColor.lightGray
        optionCBtn.backgroundColor = UIColor.lightGray
        optionDBtn.backgroundColor = UIColor.lightGray
    }
    
    func updateHeader(){
        scoreLbl.text = "Score: \(score)"
        questionCounter.text = "\(questionNumber + 1)/\(questionBank.questions.count)"
        progressView.frame.size.width = (view.frame.size.width / CGFloat(questionBank.questions.count)) * CGFloat(questionNumber + 1)
    }
    
    func restartQuiz(){
        score = 0
        questionNumber = 0
        updateQuestion()
    }
    
    func importQuestionData(){
        let path = Bundle.main.path(forResource: "QuestionBank", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.questionBank = try JSONDecoder().decode(QuestionBank.self, from: data)
        } catch {
            debugPrint(error)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
