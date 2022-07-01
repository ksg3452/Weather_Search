//
//  SummaryViewVC.swift
//  Weather_Search
//
//  Created by Sean Kim on 2022/06/26.
//

import UIKit

class SummaryViewVC: UIViewController {
    static let identifier = "SummaryViewVC"
    
    let summaryTableView = SummaryViewSettingForUI().summaryTableView
    var saveWeather = [String:WeatherModel]()
    let cityArray = ["Seoul", "Incheon", "Sejong", "Daejeon", "Gwangju", "Ulsan", "Daegu", "Busan", "Jeju"]
    var tableViewRow: Int = 0
    var currentTempDict = [String:Double]()
    var currentHumiDict = [String:Double]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad_called")
        self.initView()
        self.summaryTableView.delegate = self
        self.summaryTableView.dataSource = self
    }
    
    
    func initView() {
        print("initView_called")
        self.view.backgroundColor = .white
        self.view.addSubview(summaryTableView)
        
        NSLayoutConstraint.activate([
            summaryTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            summaryTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            summaryTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            summaryTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            summaryTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0 ..< cityArray.count {
            self.apiGet(cityName: self.cityArray[i])
        }
    }
    
    
    func apiGet(cityName: String){
        let urlString: String = "https://api.openweathermap.org/data/2.5/weather?"
        
        let totalURL: String = "\(urlString)appid=\(apiKey)&q=\(cityName)"
        
        guard let url = URL(string: totalURL) else {return}
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200 ..< 300)
            guard let data = data, error == nil else {return}
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherModel.self, from: data) else {
                    return}
                DispatchQueue.main.async {
                    if self?.saveWeather[cityName] != nil {
                        self?.saveWeather.removeValue(forKey: cityName)
                        self?.currentTempDict.removeValue(forKey: cityName)
                        self?.currentHumiDict.removeValue(forKey: cityName)
                    } else{
                        self?.tableViewRow += 1
                    }
                    self?.saveWeather[cityName] = weatherInformation
                    self?.currentTempDict[cityName] = weatherInformation.temp.temp
                    self?.currentHumiDict[cityName] = weatherInformation.temp.humidity
                    
                    if self?.tableViewRow == self?.cityArray.count {
                        self?.summaryTableView.reloadData()
                    }
                    
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else {
                    return}
                print(errorMessage)
            }
        }.resume()
        
    }
    
}
extension SummaryViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let viewController = DetailViewVC()
        viewController.modalPresentationStyle = .fullScreen
        viewController.cityName = self.cityArray[indexPath.item]
        self.present(viewController, animated: true, completion: {
            viewController.indexPathItem = indexPath.item
        })
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier,for: indexPath) as? SummaryTableViewCell else { return SummaryTableViewCell() }
        cell.cityName = self.cityArray[indexPath.item]
        cell.currentTemp = round((self.currentTempDict[cityArray[indexPath.item]] ?? 0) - 273.1)
        cell.currentHumi = self.currentHumiDict[cityArray[indexPath.item]] ?? 0
        cell.setConstraint()
        
        return cell
        
        
    }
}
