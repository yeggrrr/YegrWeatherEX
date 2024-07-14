//
//  BaseViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
     
    func configureHierarchy() { }
    
    func configureUI() { }
    
    func configureLayout() { }
    
    func alert(title: String, message: String, cancelHandler: UIAlertAction, okHandler: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = okHandler
        let cancelButtion = cancelHandler
        
        alert.addAction(okButton)
        alert.addAction(cancelButtion)
        present(alert, animated: true)
    }
}
