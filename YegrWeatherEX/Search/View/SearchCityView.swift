//
//  SearchCityView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit
import SnapKit

final class SearchCityView: BaseView {
    private let backgroundImage = UIImageView()
    let dismissButton = UIButton(type: .system)
    let searchbar = UISearchBar()
    let cityTableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(backgroundImage)
        addSubview(dismissButton)
        addSubview(searchbar)
        addSubview(cityTableView)
    }
    
    override func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.leading.equalTo(safeArea).offset(10)
            $0.width.height.equalTo(30)
        }
        
        searchbar.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea)
        }
        
        cityTableView.snp.makeConstraints {
            $0.top.equalTo(searchbar.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    override func configureUI() {
        backgroundImage.image = UIImage(named: "weatherBackgroundDark")
        
        dismissButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        dismissButton.tintColor = .white
    }
}
