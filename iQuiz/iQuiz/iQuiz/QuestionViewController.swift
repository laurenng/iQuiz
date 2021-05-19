//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by stlp on 5/18/21.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var B4: UIButton!
    @IBOutlet weak var O1: UILabel!
    @IBOutlet weak var O2: UILabel!
    @IBOutlet weak var O3: UILabel!
    @IBOutlet weak var O4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullData = allData[catIndex]
        let questionData = fullData.questions[questionIndex]
        
        question.text = questionData.question
        O1.text = questionData.option1
        O2.text = questionData.option2
        O3.text = questionData.option3
        O4.text = questionData.option4
        // Do any additional setup after loading the view.
        
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
                let vc = storyboard?.instantiateViewController(withIdentifier: "answer") as! AnswerViewController
                self.show(vc, sender: self)
            case UISwipeGestureRecognizer.Direction.right:
                let vc = storyboard?.instantiateViewController(withIdentifier: "index") as! ViewController
                self.show(vc, sender: self)
            default:
                break
            }
        }
    }
    
    @IBAction func selectedButton1(_ sender: Any) {
        
        B1.backgroundColor = UIColor.systemBlue
        B2.backgroundColor = UIColor.lightGray
        B3.backgroundColor = UIColor.lightGray
        B4.backgroundColor = UIColor.lightGray
        
        NSLog("index selected 1")
        selectedAnswer = 1
    }
    
    @IBAction func selectedButton2(_ sender: Any) {
        B2.backgroundColor = UIColor.systemBlue
        B1.backgroundColor = UIColor.lightGray
        B3.backgroundColor = UIColor.lightGray
        B4.backgroundColor = UIColor.lightGray
        
        NSLog("index 2")
        selectedAnswer = 2
    }
    
    @IBAction func selectedButton3(_ sender: Any) {
        
        B3.backgroundColor = UIColor.systemBlue
        B2.backgroundColor = UIColor.lightGray
        B1.backgroundColor = UIColor.lightGray
        B4.backgroundColor = UIColor.lightGray
        
        NSLog("index 3")
        selectedAnswer = 3
    }
    
    @IBAction func selectedButton4(_ sender: Any) {
        
        B4.backgroundColor = UIColor.systemBlue
        B2.backgroundColor = UIColor.lightGray
        B3.backgroundColor = UIColor.lightGray
        B1.backgroundColor = UIColor.lightGray
        
        NSLog("index 4")
        selectedAnswer = 4
    }
    
    
}
