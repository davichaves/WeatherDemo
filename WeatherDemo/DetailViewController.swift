//
//  DetailViewController.swift
//  WeatherDemo
//
//  Created by Davi Chaves on 7/17/20.
//  Copyright © 2020 Davi Chaves. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var weatherResult: Dictionary<String, Any>?
    var location: CLLocationCoordinate2D?
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkCommunicator.shared.setLatitude(Double(location?.latitude ?? 0))
        NetworkCommunicator.shared.setLongitude(Double(location?.longitude ?? 0))
        getWeather()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getWeather() {
        NetworkCommunicator.shared.getWeather(onSuccess: { (result) in
            self.weatherResult = result
            
            self.updateViews()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateViews() {
        self.locationName.text = self.weatherResult?["name"] as? String
        let main = self.weatherResult?["main"] as? Dictionary<String, Any>?
        self.currentTempLabel.text = "\(main!!["temp"]!) F"
        print(main!!["temp_max"])
    }

}
