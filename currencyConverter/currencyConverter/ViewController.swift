//
//  ViewController.swift
//  currencyConverter
//
//  Created by parvana on 28.06.25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    
    
    @IBOutlet weak var rubLabel: UILabel!
    
    
    @IBOutlet weak var tryLabel: UILabel!
    
    
    @IBOutlet weak var aznLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }

    @IBAction func getratesClicked(_ sender: Any) {
        // 1. request & session
        // 2. response & data
        // 3. parsing & json serialization
       
        
        // 1
        let url  = URL(string: "http://data.fixer.io/api/latest?access_key=ce860ab84f32b2fc7f3794edf9c44298" )
        let session = URLSession.shared //singleton uyarlamasi
        //closures
        let task = session.dataTask(with: url!) { data , response , error in
            if error != nil  {
                let alert = UIAlertController(title: "error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: nil )
                alert.addAction(okButton)
                self.present( alert, animated: true , completion: nil )
                
            } else {
                // 2
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any >
                        //async
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any ] {
                                //    print(rates)
                                if let usd = rates["USD"] as?  Double {
                                    self.usdLabel.text =  " USD : \(usd)"
                                }
                                if let rub = rates["RUB"] as?  Double {
                                    self.rubLabel.text =  " RUB : \(rub)"
                                }
                                 if let tryy = rates["TRY"] as?  Double {
                                    self.tryLabel.text =  " TRY : \(tryy)"
                                }
                                if let azn = rates["AZN"] as?  Double {
                                    self.aznLabel.text =  " AZN : \(azn)"
                                }
                            }
                        }
                    } catch {
                        print ("error")
                    }
                }
            }
        }
        task.resume()
    }
    
}

