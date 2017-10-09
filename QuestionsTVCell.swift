//
//  QuestionsTVCell.swift
//  Vaza
//
//  Created by Anderson Oliveira on 10/2/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit

class QuestionsTVCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var questionOptions: UIPickerView!
    
    var questionOptionsData = [String]()
    var answer: String?
    var field: Field?
    
//    init(questionsOptionsArray: [String]){
//        self.questionOptionsData.append(questionsOptionsArray)
//    }
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        
     //   print ("eita")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        questionOptions.reloadAllComponents()
        super.setSelected(selected, animated: animated)
        
     //   print ("eitaaaaaaa")
        
        questionOptions.delegate = self
        questionOptions.dataSource = self
        
    //    questionOptions.reloadAllComponents()

        // Configure the view for the selected state
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  //      print (questionOptionsData[row])
        return questionOptionsData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questionOptionsData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        answer = questionOptionsData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}
