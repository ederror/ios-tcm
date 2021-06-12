//
//  NMapViewModel.swift
//  NMAPSWIFTUI
//
//  Created by 백인찬 on 2021/06/07.
//

import Foundation
import NMapsMap
import Alamofire
import UIKit

class NMapViewModel :ObservableObject {
    var coord = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
    var NAVER_CLIENT_ID = "h3rb8msxcn"
    var NAVER_CLIENT_SECRET = "IKP3DF4F0p0QoESjWvGt6zDRdJ0m3eMgbn3Q0iJT"
    var NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    var myAddress = "서울시 강서구 화곡동 24-80"
    var myAddressCoord: NMGLatLng!
    var marker = NMFMarker()
    @Published var mapView = NMFNaverMapView()
    
    func makeMapView() -> NMFNaverMapView {
        
        mapView.showCompass = true
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        mapView.showScaleBar = true
        mapView.mapView.positionMode = .direction
        
//        let encodeAddress = myAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//        let header1 = HTTPHeader(name:"X-NCP-APIGW-API-KEY-ID", value: self.NAVER_CLIENT_ID)
//        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: self.NAVER_CLIENT_SECRET)
//        let headers = HTTPHeaders([header1, header2])
//
//        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get, headers: headers)
//            .validate()
//            .responseJSON {
//                response in
//                switch response.result {
//                case .success(let value as [String:Any]):
//                    do {
//
//                        let DATA = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
//                        let decoded = try JSONDecoder().decode(Addresses.self, from: DATA)
//
//                        let lat = Double(decoded.addresses[0].y)!
//                        let lng = Double(decoded.addresses[0].x)!
//
//                        self.myAddressCoord = NMGLatLng(lat: lat, lng: lng)
//                        self.marker.position = self.myAddressCoord
//                        self.marker.mapView = self.mapView.mapView
//
//                        let cameraUpdate = NMFCameraUpdate(scrollTo: self.myAddressCoord)
//                        self.mapView.mapView.moveCamera(cameraUpdate)
//                        self.mapView.mapView.allowsZooming = true
//                        self.mapView.mapView.mapType = .basic
//                        self.mapView.mapView.isIndoorMapEnabled = true
//
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                case .failure(let error):
//                    print(error.errorDescription ?? "")
//                default:
//                    print("something wrong")
//                    }
//                }

        return mapView
    }
    
}
