//
//  MainViewController.swift
//  Weather
//
//  Created by Stanislav Demyanov on 01.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var airPressureLabel: UILabel!
    
    // MARK: - Public properties
    var networkWeatherManager = NetworkWeatherManager()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.fetchCurrentWeather(for: cityName.text!)
    }
    
    // MARK: - IBAction
    @IBAction func searchPressed(_ sender: Any) {
        self.presentSearchController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.networkWeatherManager.fetchCurrentWeather(for: cityName)
        }
    }
    
}

// MARK: -Private methods

extension MainViewController {
    func presentSearchController(withTitle title: String?,
                                 message: String?,
                                 style: UIAlertController.Style,
                                 completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: style)
        alertController.addTextField { textField in
            textField.placeholder = "Shakhty"
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}
