//
//  ViewController.swift
//  ptb2
//
//  Created by PhongLe on 4/8/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var tfC: UITextField!
    @IBOutlet weak var tfB: UITextField!
    @IBOutlet weak var tfA: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    static var history: [(function: String , result: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cleanHistory(_ sender: UIButton) {
        ViewController.history.removeAll()
        tableView.reloadData()
    }
    @IBAction func btnAction(_ sender: UIButton) {
        
        if validate() {
            let a:Double = Double(tfA.text!)!
            let b:Double = Double(tfB.text!)!
            let c:Double = Double(tfC.text!)!
            lblResult.text = calculate(a: a, b: b, c: c)
        }
    }
    
    func validate() -> Bool {
        if (tfA.text?.isEmpty)! || (tfB.text?.isEmpty)! || (tfC.text?.isEmpty)!{
            print("text field is empty!")
            return false
            
        }
        return true
    }
    
    func calculate(a: Double, b:Double, c:Double) -> String {
        
        var result1: Double!
        var result2: Double!
        
        if (a == 0) {
            result1 = round(((-c)/b) * 1000) / 1000
        }else {
            
            let delta = b * b - 4 * a * c
            if delta < 0 {
                result1 = nil
                result2 = nil
            }else if delta == 0 {
                result1 = (-b / (2 * a))
                result2 = result1
            }else{
                result1 = round( ((-b + sqrt(delta))/(2 * a)) * 1000 )/1000
                result2 = round( ((-b - sqrt(delta))/(2 * a)) * 1000 )/1000
            }
            
        }
        
        if result1 != nil && result2 != nil{
            
            ViewController.history.append((function: "\(tfA.text!)x^2 + \(tfB.text!)x + \(tfC.text!) = 0", result: "x1: \(result1!), x2: \(result2!)"))
            return "Kết quả: x1: \(result1!), x2: \(String(describing: result2!))"
        }else if result1 != nil && result2 == nil{
            ViewController.history.append((function: "\(tfB.text!)x + \(tfC.text!) = 0", result: "x: \(result1!)"))
            return "Kết quả: x: \(result1!)"
        }else{
            ViewController.history.append((function: "\(tfA.text!)x^2 + \(tfB.text!)x + \(tfC.text!) = 0", result: "Vô nghiệm"))
            print("Vô nghiệm")
            return "Vô nghiệm"
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "funcCell", for: indexPath)
        cell.textLabel?.text = ViewController.history[ViewController.history.count - indexPath.row - 1].function
        cell.detailTextLabel?.text = ViewController.history[ViewController.history.count - indexPath.row - 1].result
        return cell
    }
    @IBAction func abc(_ sender: UISwipeGestureRecognizer) {
        tfA.text = makeNegative(num: tfA.text!)
    }
    @IBAction func bNegative(_ sender: UISwipeGestureRecognizer) {
        tfB.text = makeNegative(num: tfB.text!)
    }
    @IBAction func cnegative(_ sender: UISwipeGestureRecognizer) {
        tfC.text = makeNegative(num: tfC.text!)
        
    }
    func makeNegative(num: String) -> String {
        if !num.isEmpty{
            let index = num.index(num.startIndex, offsetBy: 1)
            print("num[0]="+num.substring(to: index))
            if num.substring(to: index) != "-" {
                return "-" + num
            }else{
                var temp = num
                return temp.chomp
            }

        }
        return ""
    }
}
extension String {
    var chomp : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}
