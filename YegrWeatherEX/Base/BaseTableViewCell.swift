//
//  BaseTableViewCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureUI() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
