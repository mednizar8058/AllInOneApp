//
//  WeatherViewController.swift
//  AllInOne
//
//  Created by MNizar on 6/28/21.
//  Copyright © 2021 MNizar. All rights reserved.
//

import UIKit
class WeatherViewController: UIViewController {

    var night = false
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var max_min_temp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var citySearch: UISearchBar!
    
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var grndLevel: UILabel!
    
    @IBOutlet weak var myview: UIView!
    
    @IBAction func search(_ sender: UIButton) {
        getThingsDone()
    }
    
    func getThingsDone(){
        var url = ""
        if citySearch.text == ""{
            url = "https://api.openweathermap.org/data/2.5/weather?q=settat&appid=87858ccb9bd3d52f917492c8aaaf9697&units=metric"
        }else{
            
            if (citySearch.text?.contains(" "))!{
                print("string contains white spave")
                citySearch.text = (citySearch.text?.replacingOccurrences(of: " ", with: "%20"))!
            }
            
            url = "https://api.openweathermap.org/data/2.5/weather?q=\(citySearch.text!)&appid=87858ccb9bd3d52f917492c8aaaf9697&units=metric"
            citySearch.text = ""
        }
        print(url)
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            
            var json: Weather?
            
            do {
                json = try JSONDecoder().decode(Weather.self, from: data)
            }catch {
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Aie Aaie Aie", message: "City not found", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                  self.present(alert, animated: true)
                    
                  
                }
            }
            
            guard let result = json else {
                return
            }
            print(result.weather[0].description)
            
            DispatchQueue.main.async {
                //self.checkTime(x1: result.sys.sunrise, x2: result.sys.sunset)
                self.weatherDescription.text = result.weather[0].description
                self.feelsLike.text = "Feels like \(Int(result.main.feels_like))°"
                self.currentTemp.text = "\(Int(result.main.temp))°C"
                self.max_min_temp.text = "Max \(Int(result.main.temp_max))° | Min \(Int(result.main.temp_min))°"
                self.cityName.text = result.name
                self.wind.text = "\(result.wind.speed) km/s"
                self.humidity.text = "\(Int(result.main.humidity)) %"
                self.visibility.text = "\(result.visibility/1000) km"
                self.sunrise.text = self.getHoursFromDate(timestamp: result.sys.sunrise)
                self.sunset.text = self.getHoursFromDate(timestamp: result.sys.sunset)
                self.weatherIcon.image = self.getRightImage(str: result.weather[0].description)
                self.pressure.text = "\(result.main.pressure)"
                
                if(result.main.sea_level == nil){
                    self.seaLevel.isHidden = true
                }
                else{
                    self.seaLevel.isHidden = false
                    self.seaLevel.text = "\(result.main.sea_level!)"
                }
                if(result.main.grnd_level == nil){
                    self.grndLevel.isHidden = true
                }
                else{
                    self.grndLevel.isHidden = false
                    self.grndLevel.text = "\(result.main.grnd_level!)"
                }
                
                
            }
        }.resume()
    }
    
    func checkTime(x1: u_long, x2:u_long){
        let timestamp = NSDate().timeIntervalSince1970
        if timestamp > Double(x2) || timestamp < Double(x1) {
            overrideUserInterfaceStyle = .dark
            night = true
        }else {
            overrideUserInterfaceStyle = .light
            night = false
        }
    }
    func getHoursFromDate(timestamp: u_long) -> String{
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
    
    func getRightImage(str: String)-> UIImage {
        if str.contains("rain") {
            return UIImage(systemName: "cloud.rain")!
        }
        if str.contains("sun"){
            return UIImage(systemName: "sun.max")!
        }
        if str.contains("snow"){
            return UIImage(systemName: "cloud.snow")!
        }
        if str.contains("cloud"){
            return UIImage(systemName: "cloud")!
        }
        if str.contains("clear"){
            if night {
                return UIImage(systemName: "moon")!
            }
            return UIImage(systemName: "sun.max")!
        }
        return UIImage(systemName: "sun.max")!
     }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        
        
        myview.layer.cornerRadius = 40
        myview.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        citySearch.barTintColor = UIColor.clear
        citySearch.backgroundColor = UIColor.clear
        citySearch.isTranslucent = true
        citySearch.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame = view.bounds
        gradiantLayer.colors = [UIColor.systemBlue.cgColor,UIColor.white.cgColor]
        view.subviews[0].layer.insertSublayer(gradiantLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getThingsDone()
    }

}

struct Weather: Codable {
    var timezone : Int
    var id: Int
    var name: String
    var cod: Int
    var visibility: Float
    var main: Main
    var weather: [TheWeather]
    var wind: Wind
    var sys: Sys
}

struct Main: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Float
    var humidity: Float
    var sea_level: Float?
    var grnd_level: Float?
}

struct TheWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Wind:Codable {
    var speed: Float
    var deg: Int
}

struct Sys:Codable {
    var country: String
    var sunrise: u_long
    var sunset: u_long
}

