//
//  Geomatry.swift
//  CovidTracker
//
//  Created by Sahil Luna on 07/05/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//
import MapKit

enum GeomatryType: String {
    case polygon = "Polygon",multiPolygon = "MultiPolygon",point = "Point"
}

class Geomatry {
    //Type of geomary and all geometry
    var polygon: MKPolygon?
    var multiPolygon: MKMultiPolygon?
    var point : MKPointAnnotation?
    var type: GeomatryType?
    
    init(geomaryJson:[String:Any]) {
        guard let type = geomaryJson["type"] as? String,let coordsArr = geomaryJson["coordinates"] as? [Any] else { return }
        
        switch GeomatryType(rawValue: type) {
        case .point:
            point = getPointObject(coordinatesArray: coordsArr)
            self.type = .point
        case .polygon:
            self.polygon = getPolygonObject(coordinateArr: coordsArr)
            self.type = .polygon
        case .multiPolygon:
            self.multiPolygon = getMultiPolygon(coordinatesArr: coordsArr)
            self.type = .multiPolygon
        default:
            break
        }
    }
    
    /// tom get mkpoint annotation object
    /// - Parameter coordinatesArray: coordinate array
    func getPointObject(coordinatesArray:[Any]) -> MKPointAnnotation {
        let pointAnnot = MKPointAnnotation.init()
        if let coordinates = coordinatesArray as? [Double],coordinates.count > 1 {
            pointAnnot.coordinate = CLLocationCoordinate2D.init(latitude: coordinates[1],
                                                                longitude: coordinates[0])
        }
        return pointAnnot
    }
    
    /// to get polygon object with all assigned coordinates
    /// - Parameter coordinateArr: coordinates array
    func getPolygonObject(coordinateArr:[Any]) -> MKPolygon {
        var polyCoords = [CLLocationCoordinate2D]()
        if let coordinates = coordinateArr.first as? [[Double]] {
            for coordinate in coordinates {
                polyCoords.append(CLLocationCoordinate2D.init(latitude: coordinate[1],
                                                                   longitude: coordinate[0]))
            }
        }
        return MKPolygon.init(coordinates: polyCoords,
                              count: polyCoords.count)
    }
    
    /// to get multipolygons
    /// - Parameter coordinatesArr: to get array of multiple plygons
    func getMultiPolygon(coordinatesArr:[Any]) -> MKMultiPolygon {
        var polygons = [MKPolygon]()
        for poolygonCoords in coordinatesArr as! [[[[Double]]]] {
            polygons.append(getPolygonObject(coordinateArr: poolygonCoords))
        }
        return MKMultiPolygon.init(polygons)
    }
    
    
}
