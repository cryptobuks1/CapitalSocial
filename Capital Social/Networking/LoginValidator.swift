//
//  LoginValidator.swift
//  Capital Social
//
//  Created by Jose Vargas on 05/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import Foundation

protocol loginValidatorDelegate: class {
    func loginValidated(response: Bool, message: String)
}

class LoginValidator: NSObject {
    weak var delegate: loginValidatorDelegate!
    
    func validateUserPass(username: String) {
        print("Sending Request for User and Pass validation...")
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(AUTHORIZATION_BASIC)"
        ]
        let password = "a0700af71a183b82aa4d79682475b151161bf91138d77f6f10937240f40814bd"
        let body = "grant_type=\(grant_type)&username=\(username)&password=\(password)"
        let bodyPost = body.data(using: .ascii, allowLossyConversion: true)
        
        let request = NSMutableURLRequest(url: URL(string: URL_OAUTH_TOKEN)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = bodyPost
                    
        let sessionConfig = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let uploadTask = urlSession.uploadTask(with: request as URLRequest, from: bodyPost!)
        uploadTask.resume()
    
    }
    
    func jsonSerialization(_ data: Data) {
        var jsonResult = NSDictionary()
        do {
        jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            if let _ = jsonResult["access_token"] as? String {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.delegate.loginValidated(response: true, message: "Authentication Successful!")
                })
            } else {
                if let error = jsonResult["error"] as? String {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.delegate.loginValidated(response: false, message: "\(error)")
                    })
                }
            }
        } catch let error as NSError {
            print("LoginValidator - Error in JSON Serialization Process: \(error.localizedDescription)")
            DispatchQueue.main.async(execute: { () -> Void in
                self.delegate.loginValidated(response: false, message: "\(error)")
            })
        }
    }
}

extension LoginValidator: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // We've got a URLAuthenticationChallenge - we simply trust the HTTPS server and we proceed
        print("LoginValidator - didReceive challenge")
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        // We've got an error
        if let err = error {
            print("Error: \(err.localizedDescription)")
        }
    }
}

extension LoginValidator: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("LoginValidator - BytesSent: \(bytesSent), Total sent: \(totalBytesSent), totalBytesExpectedToSend: \(totalBytesExpectedToSend)")
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
        print("LoginValidator - URLSessionDataDelegate: didReceive response")
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("LoginValidator - Data downloaded")
        print("LoginValidator - URLSessionDataDelegate: didReceiveData")
        print("LoginValidator - Data size: \(data)")
        jsonSerialization(data)
    }

}
