//
//  RadioBrowserInfoWebService.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 11.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit
import Alamofire

class RadioBrowserInfoWebService: RadioWebService {

    override func radioStationsForCountry(_ country : String, completion : @escaping ([RadioStation]) -> ()) {

        Alamofire.request("https://www.radio-browser.info/webservice/json/stations/bycountry/" + country, withMethod:.get)
            .validate()
            .responseJSON(completionHandler: { (response) in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                var result = Array<RadioStation>()
                for dict in response.result.value as! [Dictionary<String, String>] {
                    
                    if let name = dict["name"], let urlString = dict["url"] , let favicon = dict["favicon"] {
                        print(name + " " + urlString + " " + favicon)
                        let station = RadioStation()
                        station.name = name
                        station.streamUrl = URL(string : urlString)
                        station.logoUrl = URL(string : favicon)
                        result.append(station)
                    }
                }
                completion(result)

            })
    }
    

}
