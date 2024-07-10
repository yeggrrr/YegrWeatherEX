//
//  MainController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    override func configureUI() {
        view.backgroundColor = .systemBrown
    }
}


