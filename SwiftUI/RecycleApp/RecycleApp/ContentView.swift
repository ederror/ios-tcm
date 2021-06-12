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
    @ObservedObject var viewModel = NMapViewModel()
    let initVar = DataManager()
    
    var body: some View {
        ZStack {
            NMapView()
        }
        .onAppear{
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
        return viewModel.makeMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
    
    
}
