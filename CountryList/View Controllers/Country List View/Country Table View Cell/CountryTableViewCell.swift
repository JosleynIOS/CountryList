//
//  CountryTableViewCell.swift
//  CountryList
//
//  Created by HiveMacBook2012 on 1/1/20.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ciocLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupViews(_ country: Country) {
        nameLabel.text = country.name
        ciocLabel.text = country.cioc
        // loading URL for flag image but imageView doesnt support svg files. I'm not sure if I can use third party libraries so I left it like this.
        let url = URL(string: country.flag)
        DispatchQueue.main.async {
            self.flagImageView.sd_setImage(with: url)
        }
    }
}
