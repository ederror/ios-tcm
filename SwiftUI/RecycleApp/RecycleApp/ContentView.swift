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
    let initVar = DataManager()
    var locationManager = CLLocationManager()
    @ObservedObject var viewModel = NMapViewModel()
    
    var body: some View {
        ZStack {
            NMapView()
            
            Button(action: {
                let coor = locationManager.location?.coordinate
                print(coor?.latitude)
                print(coor?.longitude)
            }) {
                Text("click")
            }
        }
        .onAppear{
            locationManager.requestWhenInUseAuthorization()
            self.initVar.dataLoad()
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
        viewModel.mapView.showCompass = true
        viewModel.mapView.showZoomControls = true
        viewModel.mapView.showLocationButton = true
        viewModel.mapView.showScaleBar = true
        viewModel.mapView.mapView.positionMode = .compass
        
        let LO = viewModel.mapView.mapView.locationOverlay
        LO.hidden = false
        
//        mapView.mapView.moveCamera(CU)

        return viewModel.mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
    
    
}
