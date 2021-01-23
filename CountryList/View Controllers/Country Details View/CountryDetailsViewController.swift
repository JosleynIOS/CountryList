//
//  CountryDetailsViewController.swift
//  CountryList
//
//  Created by HiveMacBook2012 on 1/1/20.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var alphaCodeLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.backgroundColor = .systemTeal
        self.title = country.name
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        alphaCodeLabel.text = country.alphaCode
        populationLabel.text = country.population
        let url = URL(string: country.flag)
        DispatchQueue.main.async {
            self.flagImageView.sd_setImage(with: url)
        }
    }
}
