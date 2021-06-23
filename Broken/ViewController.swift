//
//  ViewController.swift
//  Broken
//
//  Created by Garam on 2021/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func checkJailbroken(_ sender: Any) {
        if isJailbroken() {
            let alert = UIAlertController.init(title: "알림", message: "탈옥 단말입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// 탈옥여부 체크하기.
    func isJailbroken() -> Bool {
        #if targetEnvironment(simulator)
        print("iOS Simulator")
        return false
        #else
        if FileManager.default.fileExists(atPath:"/Applications/Cydia.app") ||
            FileManager.default.fileExists(atPath:"/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            FileManager.default.fileExists(atPath:"/bin/bash") ||
            FileManager.default.fileExists(atPath:"/usr/sbin/sshd") ||
            FileManager.default.fileExists(atPath:"/etc/apt") ||
            FileManager.default.fileExists(atPath:"/etc/master.passwd") ||
            FileManager.default.fileExists(atPath:"/var/log/apt/term.log") ||
            FileManager.default.fileExists(atPath:"/private/var/lib/apt/") {
            return true
        }
        
        guard let cydiaURL = URL.init(string: "cydia://package/com.example.package") else {
            return false
        }
        
        if UIApplication.shared.canOpenURL(cydiaURL) {
            return true
        }
        
        return false
        #endif
    }
}

