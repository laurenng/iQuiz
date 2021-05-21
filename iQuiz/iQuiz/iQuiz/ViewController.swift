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
var subjectData : [Topic] = []

var jsonURL : String  = "http://tednewardsandbox.site44.com/questions.json"
//var finishResponse = "empty"

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

class Topic {
    let subject : String
    let questions : [Question]
    let desc : String
    
    init(s : String, q : [Question], d: String) {
        subject = s
        questions = q
        desc = d
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    let data = categorySource()
    private let refreshControl = UIRefreshControl()
    var newurl = UITextField()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // wiring up table with data
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching quiz Data ...")
        
        tableView.dataSource = data
        tableView.delegate = self
        
        getData(url: jsonURL)
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        getData(url: jsonURL)
    }
    
    // settings and text configurations
    @IBAction func settingAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Use different Dataset", message: "Add URL below", preferredStyle: .alert)

        alert.addTextField(configurationHandler: configureURL)
        
        alert.addAction(UIAlertAction(title: "Check now", style: .default, handler: self.checkNow))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    func configureURL(textField: UITextField!){
        newurl = textField
        newurl.placeholder = "URL"
        jsonURL = newurl.text!
    }
    
    func checkNow(alert: UIAlertAction!) {
        getData(url: newurl.text!)
    }
    
    // PULLING REMOTE DATA
    func getData(url: String){
        print("GETTING NEW DATA")
        print(url)
        let thisURL = URL(string: url)
        
        guard URL(string: url) != nil else{
            let alerts = UIAlertController(title: "Alert!", message: "Invalid URL!", preferredStyle: .alert)
            alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alerts, animated: true)
            return
        }

        
        if(thisURL != nil){
            // emptying data
            subjectData = []
            
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: thisURL!) { data, response, error in
                    guard let data = data else {return}
                    if error != nil {
                        let alerts = UIAlertController(title: "Alert!", message: "No Network!", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                        return
                    }
                    do{
                        let questions = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        for topics in (questions as! Array<Any>){
                            
                            // general topic title, description and settong question array
                            let titles = (topics as! Dictionary<String, Any>)["title"]!
                            let desc = (topics as! Dictionary<String, Any>)["desc"]!
                            var questArr : [Question] = []
                            
                            // iterating through questions
                            let ques = (topics as! Dictionary<String, Any>)["questions"]!
                            for questionDetails in (ques as! Array<Any>){
                                
                                // defining question name and answer
                                let questionName : String = (questionDetails as! Dictionary<String, Any>)["text"]! as! String
                                let questionAnswer : Int = Int((questionDetails as! Dictionary<String, Any>)["answer"]! as! String)!
                                
                                // setting options
                                let options = (questionDetails as! Dictionary<String, Any>)["answers"]!
                                let o1 = (options as! Array<Any>)[0] as! String
                                let o2 = (options as! Array<Any>)[1] as! String
                                let o3 = (options as! Array<Any>)[2] as! String
                                let o4 = (options as! Array<Any>)[3] as! String
                                
                                // appending question obj into questArr
                                let newQuest = Question(q: questionName, a: questionAnswer, one: o1, two: o2, three: o3, four: o4)
                                questArr.append(newQuest)
                            }
                            subjectData.append(Topic(s: titles as! String, q: questArr , d: desc as! String))
                        }
                    }catch {
                        let alerts = UIAlertController(title: "Alert!", message: "Try again later!", preferredStyle: .alert)
                        alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alerts, animated: true)
                    }
                }.resume()
                
            }
            
            Thread.sleep(forTimeInterval: 0.1)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        } else {
            let alerts = UIAlertController(title: "Alert!", message: "Please enter a url", preferredStyle: .alert)
            alerts.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alerts, animated: true)
        }
            
    }
    
    // table view edits
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
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
        
        return subjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categorySource.CELL_STYLE, for: indexPath)
        
        cell.textLabel?.text = subjectData[indexPath.row].subject
        cell.detailTextLabel?.text = subjectData[indexPath.row].desc
        cell.imageView?.image = UIImage(named: subjectData[indexPath.row].subject)
        
        return cell
    }
    
}
