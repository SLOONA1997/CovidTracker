//
//  CTMapStatController.swift
//  CovidTracker
//
//  Created by Sahil Luna on 26/04/20.
//  Copyright © 2020 Lunaz. All rights reserved.
//

import UIKit
import MapKit

class CTMapStatController: CTBaseViewController,MKMapViewDelegate {
    //MARK:-Outlets
    @IBOutlet weak var mapView: MKMapView?
    
    //View model
    let mapStatVM = CTMapStatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapStatVM.delegate = self
        mapStatVM.fetchMapData()
        mapView?.showsUserLocation = true
        mapView?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoader(status: "Loading map")
    }
    
    /// to configure data on map
    func configureDataOnMap() {
        if let annots = mapStatVM.getAnnotationsOnMap() {
            self.mapView?.addAnnotations(annots)
        }
        let geomatries = mapStatVM.getPolygonsOnMap()
        self.mapView?.addOverlays(geomatries)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKMultiPolygon {
            let multiPolygonRander = MKMultiPolygonRenderer.init(overlay: overlay)
            multiPolygonRander.fillColor = UIColor.red.withAlphaComponent(0.5)
            multiPolygonRander.strokeColor = UIColor.white
            multiPolygonRander.lineWidth = 2.0
            return multiPolygonRander
        }
        if overlay is MKPolygon {
            let polygonRander = MKPolygonRenderer.init(overlay: overlay)
            polygonRander.fillColor = UIColor.red.withAlphaComponent(0.5)
            polygonRander.strokeColor = UIColor.white
            polygonRander.lineWidth = 2.0
            return polygonRander
        }
        return MKOverlayRenderer.init(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        let annotView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "CovidMapPin")
        if let resizedImage = #imageLiteral(resourceName: "pin").getResizedImage() {
            annotView.image = resizedImage
        }
        let subTitle = UILabel()
        subTitle.text = annotation.subtitle ?? "Nothing to show"
        subTitle.numberOfLines = 0
        subTitle.textColor = UIColor.darkGray
        subTitle.font = UIFont.init(name: AppConstants.FontName.openSans_Light,
                                    size: 15.0)
        annotView.detailCalloutAccessoryView = subTitle
//        annotation.subtitle = annotation
        annotView.canShowCallout = true
        return annotView
    }
    
    /// to go back to dashboard
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- CTMap Stat view model delegates
extension CTMapStatController : CTMapStatViewModelDelegate {
    func mapDataFetchedSuccessfully() {
        stopLoader()
        self.configureDataOnMap()
    }
    
    func errInFetchingMapData(error: String) {
        print(error)
    }
}
