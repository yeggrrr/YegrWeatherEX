//
//  BaseView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/16/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
