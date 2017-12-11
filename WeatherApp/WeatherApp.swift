//
// Created by Huy Vo on 12/8/17.
// Copyright (c) 2017 Huy Vo. All rights reserved.
//

import Foundation

final class WeatherApp: NSObject {
    private var delegates = [WeatherAppDelegate]()
    
    var delegate: WeatherAppDelegate?
    var places = [Place]()
    
    var todayWeatherDict = [LatLon: TodayWeatherPackage]()
    var forecastDict = [LatLon: ForecastPackage]()
    var threeHoursDict = [LatLon: ThreeHoursPackage]()
    
    private var _today = [Place: WeatherModel]()
    private var _three = [Place: [WeatherModel]]()
    private var _forecast = [Place: [WeatherModel]]()

    static let shared = WeatherApp()

    override private init (){}
    
    func delete(place: Place){
        self._today[place] = nil
        self._three[place] = nil
        self._forecast[place] = nil
        
    }
    
    func addPlace(_ place: Place){
    
        if places.doContains(obj: place){
            return
        }else{
            places.append(place)
            self.fetchWeather(place: place)
            self.fetchForecast(place: place)
            self.fetchThreeHours(place: place)
            
        }
        
    }
    
    private func fetchWeather(place: Place){
        let queue = DispatchQueue.global()
        
        queue.async{
            // string format for weather
            let location = place.openWeatherLocation
            
            ApiService.fetchWeather(latlng: location, completion:
                {(weatherModel: WeatherModel) -> Void in
                    
                    weatherModel.city = place.city
                    weatherModel.lat = place.latitude
                    weatherModel.lng = place.longitude
                    
                    let location = place.googleLocation
                    ApiService.fetchTimeZone(googleFormatted: location, completion: {
                        (timeModel: TimeModel) -> Void in
                       
                        weatherModel.time_zone_id = timeModel.timeZoneId
                       
                        self._today[place] = weatherModel
                        
                        self.updateListeners()
                    })
            })
        }
    }
    
    private func fetchThreeHours(place: Place){
        
        let queue = DispatchQueue.global()
        
        queue.async{
            let location = place.openWeatherLocation
            ApiService.fetchThreeHours(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in
                self._three[place] = weatherModels
            })
        }
    }
 
    private func fetchForecast(place: Place){
        
        let queue = DispatchQueue.global()
        
        queue.async{
            // string format for weather
            let location = place.openWeatherLocation
            
            ApiService.fetchForecast(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in
                
                self._forecast[place] = weatherModels
                
            })
        }
    }
    
    func fetchWeather(latlon: LatLon, city: String ){
        let queue = DispatchQueue.global()

        queue.async{
            // string format for weather
            let location = latlon.openWeatherLocation

            ApiService.fetchWeather(latlng: location, completion:
            {(weatherModel: WeatherModel) -> Void in

                weatherModel.city = city
                weatherModel.lat = latlon.latitude
                weatherModel.lng = latlon.longitude

                let location = latlon.googleLocation
                ApiService.fetchTimeZone(googleFormatted: location, completion: {
                    (timeModel: TimeModel) -> Void in
                    weatherModel.time_zone_id = timeModel.timeZoneId

                    self.todayWeatherDict[latlon] = TodayWeatherPackage(today: weatherModel)

                })
            })
        }
    }

    func fetchThreeHoursWeather(latlon: LatLon, city: String){
        let queue = DispatchQueue.global()

        queue.async{
            let location = latlon.openWeatherLocation
            ApiService.fetchThreeHours(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in

                self.threeHoursDict[latlon] = ThreeHoursPackage(threehours: weatherModels)

            })
        }
    }

    func fetchForecast(latlon: LatLon, city: String){

        let queue = DispatchQueue.global()

        queue.async{
            // string format for weather
            let location = latlon.openWeatherLocation

            ApiService.fetchForecast(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in

                self.forecastDict[latlon] = ForecastPackage(weatherModels: weatherModels)

            })
        }
    }


    func updateListeners(){
        print("updateListeners")
        let queue = DispatchQueue.global()
        queue.async{
            
            for place in self.places{
             
                if let today = self._today[place] {
                   
                    for delegate in self.delegates{
                        
                        
                        
                        DispatchQueue.main.async {
                            delegate.load(weather: today)
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            if let three = self._three[place]{
                                if let forecast = self._forecast[place]{
                                    let weather = Weather(todayWeather: today, threeHoursWeather: three, forecastWeather: forecast)
                                
                                    delegate.load(weather: weather)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }

    public func remove(delegate: WeatherAppDelegate){
        if let index = delegates.index(where: { $0 === delegate }) {
            delegates.remove(at: index)
        }
    }

    public func add(delegate: WeatherAppDelegate){
        delegates.append(delegate)
        self.updateListeners()
    }

    struct ForecastPackage{
        var weatherModels: [WeatherModel]
        var timestamp: TimeInterval

        init(weatherModels: [WeatherModel]) {
            self.weatherModels = weatherModels
            self.timestamp = Date().timeIntervalSince1970
        }
    }


   
    struct TodayWeatherPackage{
        var weatherModel: WeatherModel
        var timestamp: TimeInterval

        init(today weatherModel: WeatherModel){
            self.weatherModel = weatherModel
            self.timestamp = Date().timeIntervalSince1970

        }

    }

    struct ThreeHoursPackage{

        var weatherModels: [WeatherModel]
        var timestamp: TimeInterval

        init(threehours weatherModels: [WeatherModel]){
            self.weatherModels = weatherModels
            self.timestamp = Date().timeIntervalSince1970
        }
    }
}

class Weather{
    
    var todayWeather: WeatherModel
    var threeHoursWeather: [WeatherModel]
    var forecastWeather: [WeatherModel]
    
    init(todayWeather: WeatherModel, threeHoursWeather: [WeatherModel], forecastWeather: [WeatherModel]) {
        self.todayWeather = todayWeather
        self.threeHoursWeather = threeHoursWeather
        self.forecastWeather = forecastWeather
    }
    
    var city: String?{
        return todayWeather.city
    }
}

protocol WeatherAppDelegate: class{
    func load(weather: Weather)
    
    func load(weather: WeatherModel)

    func loadTodayWeather(weatherModels: [WeatherModel])
    
    func loadWeather(weather: WeatherModel)

}



