//
//  StationsTableViewModel.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 23.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire
import RxSwift

class StationsTableViewModel: NSObject {

    let title = "Stations"
    
    var radioWebService : RadioWebService?
    var radioStations : Array<RadioStation>?
    var player : AVPlayer?
    let needsReload = Variable(false)
    
    let observable : Observable<Bool>
    
    override init() {
        observable = Observable.create { (observer) -> Disposable in
            
            observer.onNext(true)
            
            return Disposables.create() {}
        }

    }
    
    func didSelectRightBarButton() {
        RadioPlayer.sharedInstance().stop()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numbersOfRowsInSection(section: Int) -> Int {
        if radioStations != nil {
            return radioStations!.count
        }
        return 0
    }
    
    func itemForIndexPath(indexPath: IndexPath) -> Item? {
        
        if let station = radioStations?[indexPath.row] {
            let item = Item()
            item.title = station.name!
            item.imageUrl = station.logoUrl!.absoluteString
            return item
        }
        return nil
    }
    
    func didSelectIndexPath(indexPath: IndexPath) {
        let station = radioStations?[indexPath.row]
        if station != nil && station!.streamUrl != nil {
            RadioPlayer.sharedInstance().startWithUrl(station!.streamUrl!)
        }
    }
    
    func reload() {
        func updateWithStations(_ stations: [RadioStation]) {
            radioStations = stations
            needsReload.value = true
            
        }
        radioWebService = RadioBrowserInfoWebService();
        radioWebService!.radioStationsForCountry("switzerland", completion: updateWithStations)
    }
    
    class Item {
        var title: String = ""
        var imageUrl: String = ""
    }
}
