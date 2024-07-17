//
//  SearchCityViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import UIKit
import SnapKit

final class SearchCityViewController: BaseViewController {
    private let searchCityViewModel = SearchCityViewModel()
    private let searchCityView = SearchCityView()
    
    private var cityList: [City] = []
    
    weak var delegate: CityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchBar()
        getCityList()
        bindData()
    }
    
    deinit {
        print(">>> SearchCityViewController deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.reloadCityInfo()
    }
    
    override func configureHierarchy() {
        view.addSubview(searchCityView)
    }
    
    override func configureLayout() {
        searchCityView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        searchCityView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    private func bindData() {
        searchCityViewModel.outputSearhList.bind { [weak self] _ in
            self?.searchCityView.cityTableView.reloadData()
        }
    }
    
    private func configureSearchBar() {
        searchCityView.searchbar.delegate = self
        searchCityView.searchbar.setUI(placeholder: "Search for a city")
    }
    
    private func configureTableView() {
        searchCityView.cityTableView.delegate = self
        searchCityView.cityTableView.dataSource = self
        searchCityView.cityTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        searchCityView.cityTableView.setUI()
    }
    
    private func load() -> Data? {
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
    
    private func getCityList() {
        guard let data = load() else { return }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([City].self, from: data)
            searchCityViewModel.inputSearchList.value = result
            cityList = result
        } catch {
            print(error)
        }
    }
    
    private func dismissKeyboard() {
        searchCityView.searchbar.resignFirstResponder()
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
        return  searchCityViewModel.outputSearhList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        let item = searchCityViewModel.outputSearhList.value[indexPath.row]
        cell.countryLabel.text = item.country
        cell.regionLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchCityView.cityTableView.deselectRow(at: indexPath, animated: true)
        
        let objects = CityRepository.shared.fetch()
        let selectedCity = searchCityViewModel.outputSearhList.value[indexPath.row]
        if objects.isEmpty {
            let newCity = CityRealmModel(
                cityId: selectedCity.id,
                name: selectedCity.name,
                state: selectedCity.state,
                country: selectedCity.country,
                coordLon: selectedCity.coord.lon,
                coordLat: selectedCity.coord.lat)
            CityRepository.shared.add(item: newCity)
        } else {
            CityRepository.shared.update(item: selectedCity)
        }
        
        dismiss(animated: true) {
            self.delegate?.reloadCityInfo()
        }
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchCityViewModel.inputSearchList.value.isEmpty {
            searchCityViewModel.inputSearchList.value = cityList
        } else {
            searchCityViewModel.inputSearchList.value = cityList.filter { $0.name.contains(searchText.lowercased()) }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
}

protocol CityDelegate: AnyObject {
    func reloadCityInfo()
}
