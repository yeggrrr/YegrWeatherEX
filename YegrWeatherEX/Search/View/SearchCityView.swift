//
//  SearchCityView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit

class SearchCityView: UIView {
    let dismissButton = UIButton(type: .system)
    let searchbar = UISearchBar()
    let cityTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(dismissButton)
        addSubview(searchbar)
        addSubview(cityTableView)
    }
    
    func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
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
    
    func configureUI() {
        dismissButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        dismissButton.tintColor = .white
    }
}
