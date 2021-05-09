//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/5/21.
//

import UIKit

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
    
}
class categorySource: NSObject, UITableViewDataSource {
    let category = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descrip = ["add, multiply, divide, and fun", "zap an de doo da! Iron Man is my favorite", "physics is confusing, hope you have fun"]
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
