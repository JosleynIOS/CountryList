//
//  CountryListViewController.swift
//  CountryList
//
//  Created by HiveMacBook2012 on 1/1/20.
//

import UIKit

class CountryListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var noCountriesFoundLabel: UILabel!
    
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    let session = URLSession.shared
    
    var countriesArray = [Country]()
    var searchedCountriesArray = [Country]()
    var isFetching = true
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        headerView.backgroundColor = .systemTeal
        searchBar.barTintColor = .systemTeal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        // make cancel button white
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], for: .normal)
        
        noCountriesFoundLabel.isHidden = true
        
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchCountries()
    }
    
    private func fetchCountries() {
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]]
                guard let countriesDictArray = json else { return }
                var countriesHolder = [Country]()
                for countryDict in countriesDictArray {
                    let country = Country(countryDict)
                    countriesHolder.append(country)
                }
                self.countriesArray = countriesHolder
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func navigateToCountryDetails(_ country: Country) {
        let countryDetailsVC = CountryDetailsViewController()
        countryDetailsVC.country = country
        self.navigationController?.pushViewController(countryDetailsVC, animated: true)
    }
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            isSearching = false
            tableView.reloadData()
            return
        }
        isSearching = true
        let searchCountriesHolder = countriesArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        searchedCountriesArray = searchCountriesHolder
        tableView.reloadData()
        
        noCountriesFoundLabel.isHidden = searchedCountriesArray.count > 0
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        noCountriesFoundLabel.isHidden = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedCountriesArray.count : countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as! CountryTableViewCell
        let country = isSearching ? searchedCountriesArray[indexPath.row] : countriesArray[indexPath.row]
        cell.setupViews(country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = isSearching ? searchedCountriesArray[indexPath.row] : countriesArray[indexPath.row]
        self.navigateToCountryDetails(country)
    }
}
