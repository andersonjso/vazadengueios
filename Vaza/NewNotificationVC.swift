//
//  NewNotificationVC.swift
//  Vaza
//
//  Created by Anderson Oliveira on 9/17/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit

class NewNotificationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    struct QuestionData{
        var questionName:String
        var questionOptions = [String]()
    }
    
    @IBOutlet weak var notificationTypes: UIPickerView!
    @IBOutlet weak var tableQuestions: UITableView!
    @IBOutlet weak var question: UILabel!
    
    var tableData: [QuestionData] = []

    
    var notificationTypesData = [Notification]()
    var selectedNotification: Notification?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationTypes.delegate = self
        notificationTypes.dataSource = self
        tableQuestions.delegate = self
        tableQuestions.dataSource = self
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return notificationTypesData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notificationTypesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (notificationTypesData.count > 0){
            tableData.removeAll()
            selectedNotification = notificationTypesData[row]

        //    print (notificationTypesData[row].id)
            
            for field in notificationTypesData[row].fields {
                var options = [String]()
                if (field.type?.name == "Number"){
                    for age in 6...110{
                        options.append(String(age))
                    }
                }else{
                    for option in field.options{
                        options.append(option.label!)
                    }
                }
                
                let question = QuestionData(questionName: field.name!, questionOptions: options)
                
                tableData.append(question)
            }
            
            self.tableQuestions.reloadData()
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let actualNotification = selectedNotification{
            return 1
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let actualNotification = selectedNotification{
//         //   print (selectedNotification?.name!)
//            question.text = "question" + String(describing: selectedNotification?.fields.count)
//            print (selectedNotification?.fields.count)
//            return (selectedNotification?.fields.count)!
//        }
//        else{
//            return 0
//        }
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionsCells", for: indexPath) as! QuestionsTVCell
        cell.questionOptions.reloadAllComponents()

        cell.questionName.text = tableData[indexPath.row].questionName
        cell.questionOptionsData.removeAll()
        cell.questionOptionsData.append(contentsOf: tableData[indexPath.row].questionOptions)
        
       
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
              // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }


}
