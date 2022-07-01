//
//  UIinitSetting.swift
//  Weather_Search
//
//  Created by Sean Kim on 2022/06/26.
//

import UIKit

struct SummaryViewSettingForUI {
    var summaryTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UITableView.automaticDimension
        //        tv.backgroundColor = .lightGray
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    
    var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
}

struct SummaryTableCellSettingForUI {
    var imgIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    var lblCityName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 23)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var lblCurrentTemp: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    
    var lblCurrentHumi: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    
    var lblTempExplain: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        lbl.text = "현재 온도 :"
        return lbl
    }()
    
    var lblHumiExplain: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        lbl.text = "현재 습도 :"
        return lbl
    }()
}

struct DetailviewSettingForUI {
    var btnback: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.lightGray
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.red, for: .highlighted)
        return btn
    }()
    
    var lblCityName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 30)
        return lbl
    }()
    var lblfeelsLikeTemp: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    var lblMinTemp: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    var lblMaxTemp: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    var lblPressure: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    var lblWind: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
}
