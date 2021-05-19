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
        
        let total = allData[catIndex].questions.count
        let score : String = String(sum) + "/" + String(total)
        scoreLabel.text = score
    }
    

}
