//
//  CTMapStatViewModel.swift
//  CovidTracker
//
//  Created by Sahil Luna on 09/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol CTMapStatViewModelDelegate {
    func mapDataFetchedSuccessfully()
    func errInFetchingMapData(error:String)
}

class CTMapStatViewModel {
    //Data
    var featureCollection: GeoJsonFeatureCollection?
    
    //Delegate
    var delegate:CTMapStatViewModelDelegate?
    
    func getPolygonsOnMap() -> [MKOverlay] {
        guard let featureCollection = featureCollection else { return [MKOverlay]() }
        
        let geometries = featureCollection.features.compactMap { $0.geomatry }
        var overlays = [MKOverlay]()
        for geomatry in geometries {
            switch geomatry.type {
            case .multiPolygon:
                overlays.append(geomatry.multiPolygon!)
            case .polygon:
                overlays.append(geomatry.polygon!)
            default:
                break
            }
        }
        return overlays
    }
    func getAnnotationsOnMap() -> [MKPointAnnotation]? {
        let annotPoints = featureCollection?.features.compactMap { $0.properties?.annotationPoint }
        return annotPoints
    }
    
    /// to fetch map data
    func fetchMapData() {
        APIManager.shared.fetchCovidMapGeoJsonData { (isSuccess, mapFeatureCollection, error) in
            if isSuccess,let mapFeatureCollection = mapFeatureCollection {
                self.featureCollection = mapFeatureCollection
                self.delegate?.mapDataFetchedSuccessfully()
            } else {
                self.delegate?.errInFetchingMapData(error: error ?? "")
            }
        }
    }
    
}
