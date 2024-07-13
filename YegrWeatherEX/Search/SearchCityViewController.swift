//
//  SearchCityViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import UIKit
import SnapKit

class SearchCityViewController: BaseViewController {
    let backgroundImage = UIImageView()
    let dismissButton = UIButton(type: .system)
    let searchbar = UISearchBar()
    let cityTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func configureHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(dismissButton)
        view.addSubview(searchbar)
        view.addSubview(cityTableView)
    }
    
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
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
        
        searchbar.searchBarStyle = .minimal
        searchbar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a city", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchbar.searchTextField.leftView?.tintColor = .white
        searchbar.searchTextField.textColor = .white
        
        dismissButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        dismissButton.tintColor = .white
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    func configureTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        cityTableView.backgroundColor = .clear
        cityTableView.separatorStyle = .singleLine
        cityTableView.separatorColor = .white
        cityTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func load() -> Data? {
        let fileName = "CityList"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityTableView.deselectRow(at: indexPath, animated: true)
    }
}
