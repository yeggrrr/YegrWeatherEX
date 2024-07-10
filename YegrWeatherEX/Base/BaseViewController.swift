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
    
    func configureUI() { 
        view.backgroundColor = .darkGray
    }
    
    func configureLayout() { }
}
