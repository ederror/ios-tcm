//
//  ContentView.swift
//  RecycleApp
//
//  Created by 백인찬 on 2021/05/08.
//

import SwiftUI
import CoreData
import SwiftCSV
import NMapsMap
import CoreLocation

struct ContentView: View {
    var locationManager = CLLocationManager()
    @ObservedObject var viewModel = NMapViewModel()
    
    var body: some View {
        ZStack {
            NMapView()
        }
        .onAppear{
            locationManager.requestWhenInUseAuthorization()  
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NMapView : UIViewRepresentable {
    
    typealias UIViewType = NMFNaverMapView
    @ObservedObject var viewModel = NMapViewModel()

    func makeUIView(context: Context) -> NMFNaverMapView {
        let DM = DataManager()
        DM.dataLoad()
        
        viewModel.mapView.showCompass = true
        viewModel.mapView.showZoomControls = true
        viewModel.mapView.showLocationButton = true
        viewModel.mapView.showScaleBar = true
        viewModel.mapView.mapView.positionMode = .compass
        
        let LO = viewModel.mapView.mapView.locationOverlay
        LO.hidden = false
        LO.location = NMGLatLng(lat: 37.65893337125361, lng: 127.0414481846587)
        
        let CU = NMFCameraUpdate(scrollTo: LO.location)
        viewModel.mapView.mapView.moveCamera(CU)

        let marker = NMFMarker()
        
        marker.position = LO.location
        marker.mapView = viewModel.mapView.mapView
        
        let targets = viewModel.getNearLB(current: LO.location)
        let coords = targets.0
        let addrs = targets.1["주소"]!

        
//        for target in targets["형광등"]! {
//            let mk = NMFMarker()
//            mk.position = target
//            mk.iconImage = NMF_MARKER_IMAGE_BLACK
//            mk.iconTintColor = UIColor.blue
//            print(mk.width)
//            print(mk.height)
//            mk.mapView = viewModel.mapView.mapView
//        }
        var n = 0
        for target in coords["건전지"]! {
            let mk = NMFMarker()
            mk.position = target
            mk.iconImage = NMF_MARKER_IMAGE_BLACK
            mk.iconTintColor = UIColor.blue
            mk.width = 25
            mk.height = 40
            mk.mapView = viewModel.mapView.mapView
            
            mk.userInfo = ["tag" : addrs[n]]
            
            mk.touchHandler = { (overlay) -> Bool in
                if let MARKER = overlay as? NMFMarker {
                    if MARKER.infoWindow == nil {
                        let dataSource = NMFInfoWindowDefaultTextSource.data()
                        dataSource.title = MARKER.userInfo["tag"] as! String
                        let infoWindow = NMFInfoWindow()
                        infoWindow.dataSource = dataSource
                        infoWindow.open(with: MARKER)
                    }
                    else {
                        MARKER.infoWindow?.close()
                    }
                }
                return true
            }

            n += 1
        }
        
        return viewModel.mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
    
    
}
