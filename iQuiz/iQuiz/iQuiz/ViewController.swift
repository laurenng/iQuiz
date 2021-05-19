//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/5/21.
//

import UIKit

var catIndex = 0;
var questionIndex = 0;
var selectedAnswer = 0;
var sum = 0

let category = ["Mathematics", "Marvel Super Heroes", "Science"]
let descrip = ["add, multiply, divide, and fun", "zap an de doo da! Iron Man is my favorite", "physics is confusing, hope you have fun"]
let short_cat = ["math", "marvel", "sci"]

var finishResponse = "empty"

let allData: [Subject] = [
    Subject(s: "Mathematics", q: [
        Question(q: "What is 2 + 2?", a: 1, one: "4", two: "5", three: "6", four: "8"),
        Question(q: "What is 2 + 4?", a: 3, one: "3", two: "5", three: "6", four: "8"),
        Question(q: "What is 1?", a: 2, one: "4", two: "1", three: "6", four: "8"),
    ], d: "Take a Math test!"),
    Subject(s: "Marvel", q: [
        Question(q: "Why do you suck?", a: 1, one: "33", two: "2", three: "234 ", four: "last"),
        Question(q: "What is 2 + 4?", a: 3, one: "3", two: "5", three: "6", four: "8"),
        Question(q: "What is 1?", a:2, one: "4", two: "1", three: "6", four: "8"),
    ], d: "Pew Pew Pew"),
    Subject(s: "Science", q: [
        Question(q: "What is 2 + 2?", a:1, one: "4", two: "5", three: "6", four: "8"),
        Question(q: "What is 2 + 4?", a: 1, one: "3", two: "5", three: "6", four: "8"),
        Question(q: "What is 1?", a: 1, one: "4", two: "1", three: "6", four: "8"),
    ], d: "I'm Albert Einstein")
    
]

class Question {
    let question : String
    let answer : Int
    let option1 : String
    let option2 : String
    let option3 : String
    let option4 : String
    
    init(q : String, a : Int, one : String, two: String, three: String, four: String) {
        question = q
        answer = a
        option1 = one
        option2 =  two
        option3 =  three
        option4 = four
    }
}

class Subject {
    let subject : String
    let questions : [Question]
    let desc : String
    
    init(s : String, q : [Question], d: String) {
        subject = s
        questions = q
        desc = d
    }
}

let questions: [String: Any] = [
    "math1Q": "What is 2 + 2?",
    "math1O" : ["4", "2", "0", "10"],
    "math1A" : "4",
    
    "math2Q": "What is 2 + 3?",
    "math2O" : ["2", "5", "1", "8"],
    "math2A" : "4",
    
    "marvel1Q": "Who is not an Avenger?",
    "marvel1O" : ["Captain  America", "IronMan", "Batman", "Hulk"],
    "marvel1A" : "Batman",
    
    "sci1Q": "What is the scientific term for your fingers",
    "sci1O" : ["thumb", "phalanges", "fingy", "hand"],
    "sci1A" : "phalanges"
]

class ViewController: UIViewController, UITableViewDelegate {
    
    let data = categorySource()
    
    @IBAction func settingAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Settings go here", message: "will reroute later", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // wiring up table with data
        tableView.dataSource = data
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        NSLog("heello sir")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        catIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
        return indexPath
    }
    
}
class categorySource: NSObject, UITableViewDataSource {
    static let CELL_STYLE = "BasicStyle"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categorySource.CELL_STYLE, for: indexPath)
        
        cell.textLabel?.text = category[indexPath.row]
        cell.detailTextLabel?.text = descrip[indexPath.row]
        cell.imageView?.image = UIImage(named: category[indexPath.row])
        
        return cell
    }
    
}
