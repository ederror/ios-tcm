//
//  ContentView.swift
//  RecycleApp
//
//  Created by 백인찬 on 2021/05/08.
//

import SwiftUI
import CoreData
import SwiftCSV

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
    var body: some View {
        Text("Hello, world!")
            .padding()
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
