//
//  ViewController.swift
//  whats the weather
//
//  Created by Ankit Malik on 09/06/18.
//  Copyright © 2018 Ankit Malik. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
   
    @IBOutlet weak var cityTextfield: UITextField!
    
    @IBOutlet weak var getWeather: UILabel!
    
    @IBAction func deleteButton(_ sender: Any) {
        
        cityTextfield.text = ""
        getWeather.text = ""
        
    }
    @IBAction func submitButton(_ sender: Any) {
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "emanuel-hahn-200491-unsplash.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityTextfield.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
            data, response, error in
            
            var message = ""
            //</h2>(1&ndash;3 days)</span><p class="b-forecast__table-description-content"><span class="phrase">
            if let error = error {
                
                print(error)
                
                
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    let stringSeperator = "</h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeperator){
                        
                        if contentArray.count > 1 {
                            let stringSeperator = "</span>"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            if newContentArray.count > 1{
                                message = newContentArray[0].replacingOccurrences(of: "&deg;C", with: "°")
                                print(message)
                                
                            }
                        }
                        
                        
                    }
                }
                
            }
            if message == "" {
                message = "please try again!"
            }
            DispatchQueue.main.sync(execute: {
                
                self.getWeather.text = message
                
            })
            
        }
        task.resume()
    }
        else {
            
            getWeather.text = "try again fella!!"
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

