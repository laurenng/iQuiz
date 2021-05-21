//
//  FinishViewController.swift
//  iQuiz
//
//  Created by stlp on 5/11/21.
//

import UIKit

class FinishViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let total = subjectData[catIndex].questions.count
        let score : String = String(sum) + "/" + String(total)
        scoreLabel.text = score
        questionIndex = 0
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {

            case UISwipeGestureRecognizer.Direction.right:
                let vc = storyboard?.instantiateViewController(withIdentifier: "index") as! ViewController
                self.show(vc, sender: self)
                
            default:
                break
            }
        }
    }

}
