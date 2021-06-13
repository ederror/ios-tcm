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

struct RecycleItem {
    public var name: String?
    public var id: Int16
    public var material: String?
    public var recycleWay: String?
    public var classId: Int16
    public var classification: String?
}

struct LightAndBatteryItem {
    public var boroughId: Int16
    public var borough: String?
    public var latitude: Double
    public var longitude: Double
    public var address: String?
    public var detailAddress: String?
    public var type: String?
}


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
        
//        for target in targets["형광등"]! {
//            let mk = NMFMarker()
//            mk.position = target
//            mk.iconImage = NMF_MARKER_IMAGE_BLACK
//            mk.iconTintColor = UIColor.blue
//            print(mk.width)
//            print(mk.height)
//            mk.mapView = viewModel.mapView.mapView
//        }
        
        for target in targets["건전지"]! {
            let mk = NMFMarker()
            mk.position = target
            mk.iconImage = NMF_MARKER_IMAGE_BLACK
            mk.iconTintColor = UIColor.blue
            mk.width = 25
            mk.height = 40
            mk.mapView = viewModel.mapView.mapView
        }
        
        return viewModel.mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
    
    
}
