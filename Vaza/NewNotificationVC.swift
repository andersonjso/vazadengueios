//
//  NewNotificationVC.swift
//  Vaza
//
//  Created by Anderson Oliveira on 9/17/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit

class NewNotificationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource,
    UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    struct QuestionData{
        var field: Field
        var questionOptions = [String]()
    }
    
    struct FieldAnswer{
        var field: Field
        var answer: String
    }
    
    @IBOutlet weak var notificationTypes: UIPickerView!
    @IBOutlet weak var tableQuestions: UITableView!
    @IBOutlet weak var question: UILabel!
    var imagePicker: UIImagePickerController!
    var poi: PointOfInterest!
    
   
    
    @IBOutlet weak var descriptionNotification: UITextView!
    @IBOutlet weak var imageNotification: UIImageView!
    var tableData: [QuestionData] = []
    var cellsList: [QuestionsTVCell] = []


    @IBOutlet weak var titleNotification: UITextField!
    
    var notificationTypesData = [Notification]()
    var selectedNotification: Notification?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationTypes.delegate = self
        notificationTypes.dataSource = self
        tableQuestions.delegate = self
        tableQuestions.dataSource = self
        titleNotification.delegate = self
        
        self.tableQuestions.reloadData()
        //     selectedNotification = notificationTypesData[0]
        //self.titleNotification.becomeFirstResponder()
        

        
        poi = PointOfInterest()
    }
    
    @IBAction func takePicture(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageNotification.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return notificationTypesData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notificationTypesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (notificationTypesData.count > 0){
            //           print ("step 1")
            tableData.removeAll()
            cellsList.removeAll()
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
                
                let question = QuestionData(field: field, questionOptions: options)
                
                tableData.append(question)
          //      print ("step 2")
                
           //     print ("step 3")
            }
            self.tableQuestions.reloadData()
         //   print ("step 4")
            
            
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

        print("entrei table view: " + String(cellsList.count))

        let cell = tableView.dequeueReusableCell(withIdentifier: "questionsCells", for: indexPath) as! QuestionsTVCell
        cell.questionOptions.reloadAllComponents()

        cell.questionName.text = tableData[indexPath.row].field.name
        cell.field = tableData[indexPath.row].field
        cell.questionOptionsData.removeAll()
        cell.questionOptionsData.append(contentsOf: tableData[indexPath.row].questionOptions)
        
        cell.answer = cell.questionOptionsData[0]
        
       
        cellsList.append(cell)
        return cell
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
              // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }

    @IBAction func send(_ sender: Any) {
       
        if verifyTitle(){
            
            poi.title = titleNotification.text
            poi.descriptionPOI = descriptionNotification.text
            poi.published = true
            //let camera = GMSCameraPosition.camera(withLatitude:  -37.1886, longitude: 145.708, zoom: 0.3)
            
            let location = GeoLocation(lat: 64.244, lng: 96.064)
            poi.location = location
            poi.type = PoiType(id: (selectedNotification?.id)!, name: (selectedNotification?.name)!)
            // poi.date = date
            
            var fieldValues = [FieldValue]()
            for cell in cellsList{
                let fieldValue = FieldValue(value: cell.answer!, field: cell.field!)
                
                fieldValues.append(fieldValue)
                
                
            }
            
            poi.fieldValues = fieldValues
            
            for poiFV in poi.fieldValues{
                print ((poiFV.field?.name)! + ": " + poiFV.value!)
            }
            
            
            let jsonData = poi.jsonRepresentation
            
            //let data = try! JSONSerialization.data(withJSONObject: jsonData, options: [])
            let opa = String(data: jsonData, encoding:.utf8)!
            
            print (opa)
            let url = URL(string: "http://httpbin.org/post")!
            //let url = URL(string: "http://dengue.les.inf.puc-rio.br/api/poi")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()
        }
        
        
    }
    
    func verifyTitle() -> Bool{
        if (titleNotification.text?.isEmpty)!{
            titleNotification.backgroundColor = UIColor.yellow
            titleNotification.placeholder = "Por favor, preencha o título"
            
            return false
        }
        return true
    }
    
    func notPrettyString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return nil
    }

}

extension NewNotificationVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         titleNotification.placeholder = "Título"
    }

    
}
