//
//  SummaryTableViewCell.swift
//  Weather_Search
//
//  Created by Sean Kim on 2022/06/26.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    static let identifier = "SummaryTableViewCell"
    
    let setForUI = SummaryTableCellSettingForUI()
    var cityName: String = ""
    var currentTemp: Double = 0
    var currentHumi: Double = 0
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraint() {
        let imgIcon = setForUI.imgIcon
        let lblArray = [setForUI.lblCityName, setForUI.lblTempExplain, setForUI.lblCurrentTemp, setForUI.lblHumiExplain, setForUI.lblCurrentHumi]
        
        contentView.addSubview(imgIcon)
        contentView.addSubview(lblArray[0])
        contentView.addSubview(lblArray[1])
        contentView.addSubview(lblArray[2])
        contentView.addSubview(lblArray[3])
        contentView.addSubview(lblArray[4])
        
        
        let imgURL = URL(string: "http://openweathermap.org/img/wn/04n.png")
        let data = try? Data(contentsOf: imgURL!)
        
        if let data = data {
            imgIcon.image = UIImage(data: data)
        }
        
        lblArray[0].text = self.cityName
        
        lblArray[2].text = "\(currentTemp)℃"
        lblArray[4].text = "\(currentHumi)%"

//        lblArray[0].backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            imgIcon.widthAnchor.constraint(equalToConstant: 64),
            imgIcon.heightAnchor.constraint(equalToConstant: 64),
            imgIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            imgIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            imgIcon.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

            lblArray[0].centerYAnchor.constraint(equalTo: imgIcon.centerYAnchor),
            lblArray[0].leadingAnchor.constraint(equalTo: imgIcon.trailingAnchor, constant: 20),
            
            lblArray[0].widthAnchor.constraint(equalToConstant: 100),
            lblArray[0].heightAnchor.constraint(equalToConstant: 40),
//
            
            
            lblArray[1].centerYAnchor.constraint(equalTo: imgIcon.centerYAnchor, constant: -15),
            lblArray[1].leadingAnchor.constraint(equalTo: lblArray[0].trailingAnchor, constant: 20),
            lblArray[2].topAnchor.constraint(equalTo: lblArray[1].topAnchor),
            lblArray[2].leadingAnchor.constraint(equalTo: lblArray[1].trailingAnchor, constant: 10),
            
            lblArray[3].centerYAnchor.constraint(equalTo: imgIcon.centerYAnchor, constant: 15),
            lblArray[3].leadingAnchor.constraint(equalTo: lblArray[0].trailingAnchor, constant: 20),
            lblArray[4].topAnchor.constraint(equalTo: lblArray[3].topAnchor),
            lblArray[4].leadingAnchor.constraint(equalTo: lblArray[3].trailingAnchor, constant: 10),
            
        ])
    }

}
