//
//  DetailViewVC.swift
//  Weather_Search
//
//  Created by Sean Kim on 2022/06/28.
//

import UIKit

class DetailViewVC: UIViewController {
    static let identifier = "DetailViewVC"
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find that File")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "OPENWEATHERMAP_KEY") as? String else {
                fatalError("Couldn't find that KEY")
            }
            return value
        }
    }
    
    let btnBack = DetailviewSettingForUI().btnback
    let lblCityName = DetailviewSettingForUI().lblCityName
    let lblfeelsLikeTemp = DetailviewSettingForUI().lblfeelsLikeTemp
    let lblMinTemp = DetailviewSettingForUI().lblMinTemp
    let lblMaxTemp = DetailviewSettingForUI().lblMaxTemp
    let lblPressure = DetailviewSettingForUI().lblPressure
    let lblWind = DetailviewSettingForUI().lblWind
    
//    var saveWeather = [String:WeatherModel]()
    var cityName: String = ""
    
    var saveWeather : WeatherModel?
    
    var indexPathItem: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiGet(cityName: self.cityName)
        self.initUI()
    }
    
    func initUI() {

        self.view.backgroundColor = .white
        
        self.view.addSubview(btnBack)
        self.view.addSubview(lblCityName)
        self.view.addSubview(lblfeelsLikeTemp)
        self.view.addSubview(lblMinTemp)
        self.view.addSubview(lblMaxTemp)
        self.view.addSubview(lblPressure)
        self.view.addSubview(lblWind)
        
        guard let saveWeather = self.saveWeather else {return}
        
        btnBack.addTarget(self, action: #selector(backToPage), for: .touchUpInside)
        lblCityName.text = self.cityName
        lblfeelsLikeTemp.text = "체감온도: \(round(saveWeather.temp.feelsLike - 273.1))℃"
        lblMinTemp.text = "최저기온: \(round(saveWeather.temp.minTemp - 273.1))℃"
        lblMaxTemp.text = "최고기온: \(round(saveWeather.temp.maxTemp - 273.1))℃"
        lblPressure.text = "기압: \(saveWeather.temp.pressure)"
        lblWind.text = "풍속: \(saveWeather.wind.speed)"
        
        
        NSLayoutConstraint.activate([
            lblCityName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblCityName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            lblfeelsLikeTemp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblfeelsLikeTemp.topAnchor.constraint(equalTo: self.lblCityName.bottomAnchor, constant: 50),
            
            lblMinTemp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblMinTemp.topAnchor.constraint(equalTo: self.lblfeelsLikeTemp.bottomAnchor, constant: 20),
            
            lblMaxTemp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblMaxTemp.topAnchor.constraint(equalTo: self.lblMinTemp.bottomAnchor, constant: 20),
            
            lblPressure.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblPressure.topAnchor.constraint(equalTo: self.lblMaxTemp.bottomAnchor, constant: 20),
            
            lblWind.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblWind.topAnchor.constraint(equalTo: self.lblPressure.bottomAnchor, constant: 20),
            
            btnBack.widthAnchor.constraint(equalToConstant: 100),
            btnBack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnBack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 150)
        ])
    }
    func apiGet(cityName: String){
        let urlString: String = "https://api.openweathermap.org/data/2.5/weather?"
        let totalURL: String = "\(urlString)appid=\(apiKey)&q=\(cityName)"
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: totalURL) else {return}
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200 ..< 300)
            guard let data = data, error == nil else {
                semaphore.signal()
                return }
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherModel.self, from: data) else {
                    semaphore.signal()
                    return }
                self?.saveWeather = weatherInformation
                semaphore.signal()
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else {
                    semaphore.signal()
                    return}
                print(errorMessage)
                semaphore.signal()
            }
        }.resume()
        semaphore.wait()
    }
    
    @objc func backToPage(){
        print(indexPathItem)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
    
