//
//  ViewController.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 11.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var radioWebService : RadioWebService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reload() {
        func updateWithStations(_ stations: [RadioStation]) {
            
        }
        radioWebService = RadioBrowserInfoWebService();
        radioWebService!.radioStationsForCountry("switzerland", completion: updateWithStations)
    }
}

