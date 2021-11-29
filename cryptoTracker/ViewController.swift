//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Alan Díaz on 11/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    
    
        if let symbol = textField.text {
        
        getData(symbol : symbol)
        
        }
        
        
    }
    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    
    func getData(symbol : String){
        
        url = "\(url)&fsym=\(symbol)"
        
        // 1. Initialize the URL
        
        guard let url = URL(string: url) else {return}
        
    //2. Initialize task and URL Session
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // 3. Check Optional
            guard let data = data, error == nil else {return}
            
            print("Data Received")
            
            do{
                
                let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                
                print(Result.USD)
                
                DispatchQueue.main.async {
                
                self.outputLabel.text = "\(Result.USD)"
                
                }
                    
            } catch {
                
                print(error.localizedDescription)
                
            }
     
        }
        
        // Resume the task
        task.resume()

        
            // CLOSURE - create a function with function within function
    }
    
    // 5. Create a structure and mention what the parameters are
    
    struct APIResponse : Codable {
        
        let USD : Float
        
        
    }
    

}


