//
//  ContentView.swift
//  innoutAPP
//
//  Created by Eric Bregman on 7/29/22.
//  Copyright © 2022 Sabertech. All rights reserved.
//

import SwiftUI
import Foundation
      #if canImport(FoundationNetworking)
import FoundationNetworking
      #endif

struct ContentView: View {
   @State private var userID: String = ""
   @State private var userPass: String = ""
    var body: some View {
        
        VStack {
            TextField("Username", text: $userID)
            SecureField("Password", text: $userPass).disableAutocorrection(true)
            Button(action: {
                
                self.login()
                
            }) {
                Text("Login")
            }
        }.textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
    
    func login(){

        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=%2FwEPDwUKMTc1NTk3ODQ4MA9kFgJmD2QWAgIDD2QWAgIHD2QWAgIBDxYCHglpbm5lcmh0bWwFBDIwMjJkZJPBmqku3rrzjmVB0CM%2FNXPW9oPC&__VIEWSTATEGENERATOR=CA0B0334&__EVENTVALIDATION=%2FwEdAAkxdEyNYrnWfP%2BB3o8xFTG8jJuJuoUx7HcZnXGSFYtde1%2FUteT%2F1FlG8zLcECMZNk0qlWIrJdTAOLR9iCT%2BsLLhweSyajcB5NIUzQwoZpYUMgIehXwdzgXcc6LchA%2FjzFQf1vHThVkYpfbc21rGBnU4w19%2FEt4D%2BIlXk1hba4TPaOOpLOOmr6thrBMsA7CKQHRvYmkeb6ahpZp0AtcjAr1KskgV6Q%3D%3D&ctl00%24Main%24ctrlLogin%24hdnViewer=1&ctl00%24Main%24ctrlLogin%24hdnVersion=0&ctl00%24Main%24ctrlLogin%24hfToken=&ctl00%24Main%24ctrlLogin%24hdnManifest=itms-services%3A%2F%2F%3Faction%3Ddownload-manifest%26url%3Dhttps%3A%2F%2Fassociate.innout.com%2Fapp%2FprodManifest.plist&ctl00%24Main%24ctrlLogin%24hdnUpdate=3.4.0&ctl00%24Main%24ctrlLogin%24txtAssociateID=\(userID)&ctl00%24Main%24ctrlLogin%24txtPIN=\(userPass)&ctl00%24Main%24ctrlLogin%24btnLogin=Login"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://associate.innout.com/Default.aspx?ReturnUrl=%2f")!,timeoutInterval: Double.infinity)
        request.addValue("associate.innout.com", forHTTPHeaderField: "host")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.addValue("https://associate.innout.com", forHTTPHeaderField: "origin")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "accept-encoding")
        request.addValue("keep-alive", forHTTPHeaderField: "connection")
        request.addValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField: "accept")
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.2 Safari/605.1.15", forHTTPHeaderField: "user-agent")
        request.addValue("https://associate.innout.com/Default.aspx?ReturnUrl=%2f", forHTTPHeaderField: "referer")
        request.addValue("910", forHTTPHeaderField: "content-length")
        request.addValue("en-us", forHTTPHeaderField: "accept-language")
        request.addValue("2585644", forHTTPHeaderField: "x-postman-captr")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

print($userID)
        print($userPass)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
