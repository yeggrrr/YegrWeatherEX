//
//  MainController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        mainView.snp.makeConstraints {
            $0.verticalEdges.equalTo(view)
            $0.horizontalEdges.equalTo(safeArea)
        }
    }
    
    override func configureUI() {
        view.backgroundColor = .white
    }
}


