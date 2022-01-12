//
//  ViewController.swift
//  RetailAppPOC
//
//  Created by Sai Sameer on 08/01/22.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var tmoLogo: UIImageView!
    @IBOutlet weak var salesRepID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.cornerRadius = 10
        tmoLogo.layer.cornerRadius = 10
        salesRepID.layer.cornerRadius = 10
        password.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.text = "LOGIN"
        
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let salesRepID = salesRepID.text ,  let password = password.text{
            // need to encrypt pwd and send
            
            let Url = String(format: "http://tvmki884.test.sprint.com:8280/RmsRestService/loginService/userLoginAccess")
                guard let serviceUrl = URL(string: Url) else { return }
                let parameters: [String: Any] = ["header":["applPassword":"RASHMI","appId":"RMS","applUserId":"RASHMI"],"loginId":"RASHMI","locBaId":8,"pwd":"7nyfkq80"]
                
                var request = URLRequest(url: serviceUrl)
                request.httpMethod = "POST"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                    return
                }
                request.httpBody = httpBody
                request.timeoutInterval = 50
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        print(data)
                        let decoder  = JSONDecoder()
                        do {
                            print(3)
                            let decodedResponse = try decoder.decode(LoginResponse.self, from: data)
                            print(decodedResponse)
                            //let json = try JSONSerialization.jsonObject(with: data, options: [])
                    

                        } catch {
                           
                            print(error)
                        }
                    }
                }.resume()
            
        }
    }
    
}

