//
//  ViewController.swift
//  ConsumeWebService
//
//  Created by jose manuel on 11/29/16.
//  Copyright © 2016 io.github.jdebu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var TvNaves: UILabel!
    
    @IBAction func ConsumirServicio(_ sender: Any) {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://swapi.co/api/people/1/")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        let nombre = json["name"] as! String
                        print(nombre)
                        
                        let naveArray = json["starships"]
                        if let jsonArray = naveArray as? NSArray{
                            jsonArray.enumerateObjects({ object, index, stop in
                                if let model = jsonArray[index] as? String{
                                    self.TvNaves.text =  self.TvNaves.text! + model
                                    
                                }
                                
                            })
                        }
                        print(self.TvNaves.text)
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sol.jpeg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

