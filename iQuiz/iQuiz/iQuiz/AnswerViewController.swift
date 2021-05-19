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
        
        // Setting swipes
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {

            case UISwipeGestureRecognizer.Direction.left:
                //change view controllers
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
            case UISwipeGestureRecognizer.Direction.right:
                let vc = storyboard?.instantiateViewController(withIdentifier: "index") as! ViewController
                self.show(vc, sender: self)
                
            default:
                break
            }
        }
    }
    
    @IBAction func buttonValue() {
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
