//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by stlp on 5/11/21.
//

import UIKit

class AnswerViewController: UIViewController {

    let cat = short_cat[catIndex]
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var directionButton: UIButton!
    let fullData = allData[catIndex]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionData = fullData.questions[questionIndex]
        
        headerLabel.text = questionData.question
        // Do any additional setup after loading the view.
        let correctAns = questionData.answer
        
        if correctAns == selectedAnswer {
            correctLabel.text = "CORRECT!"
            sum += 1
        } else {
            correctLabel.text = "WRONG :( "
        }
        
        let numQ = fullData.questions.count - 1
        if (questionIndex == numQ) {
            // go to finish page
            directionButton.setTitle("FINISH", for: .normal)
        } else {
            // incremenet question index and go to question page
            directionButton.setTitle("next question", for: .normal)
        }
    }
    
    @IBAction func buttonValue() {
        NSLog(String(fullData.questions.count))
        NSLog(String(questionIndex))
        let numQ = fullData.questions.count - 1
        if (questionIndex == numQ) {
            // go to finish page
            let vc = storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishViewController
            self.show(vc, sender: self)
        } else {
            // incremenet question index and go to question page
            questionIndex += 1
            let vc = storyboard?.instantiateViewController(withIdentifier: "question") as! QuestionViewController
            self.show(vc, sender: self)
        }
    }
    

}
