//
//  FifthChildViewController.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/06/16.
//

import UIKit
import NMapsMap
import Alamofire

class FourthChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFNaverMapView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y,
                                                    width: 343.0, height: 516.0))
        
        mapView.showCompass = true
        mapView.showScaleBar = true
        mapView.showZoomControls = true
        
        let LO = mapView.mapView.locationOverlay
        LO.hidden = false
        LO.location = NMGLatLng(lat: 37.65893337125361, lng: 127.0414481846587)
        
        let CU = NMFCameraUpdate(scrollTo: LO.location)
        mapView.mapView.moveCamera(CU)
        
        let lat_left = LO.location.lat - 0.005
        let lat_right = LO.location.lat + 0.005
        let lng_top = LO.location.lng + 0.006
        let lng_bot = LO.location.lng - 0.006
        let url = "http://192.168.0.2:3654/can"
        
        var targets: [NMGLatLng] = []
        var addrs: [String] = []
        
        getCoords(url: url, trash_type: "아이스팩",handler: { jsonList in
            for json in jsonList{
                let item = json as? NSDictionary
                let lat = item!["latitude"] as! Double
                let lng = item!["longitude"] as! Double
                
                if lat == 0.0 {
                    continue
                }
                if lat <= lat_right && lat >= lat_left && lng <= lng_top && lng >= lng_bot {
                    let target = NMGLatLng(lat: lat, lng: lng)
                    let addr = "\(String(describing: item!["addr"]!)) \(String(describing: item!["detail_addr"]!))"
                    addrs.append(addr)
                    targets.append(target)
                }
                
            }
            
            self.markOnMap(coords: targets, addrs: addrs, mapView: mapView)
        })
        
        view.addSubview(mapView)
        view.bringSubviewToFront(mapView)
    }
    
    func markOnMap(coords: [NMGLatLng], addrs: [String], mapView: NMFNaverMapView) -> Void {
        var i = 0
        
        for target in coords {
            let mk = NMFMarker()
            mk.position = target
            mk.iconImage = NMF_MARKER_IMAGE_BLACK
            mk.iconTintColor = UIColor.blue
            mk.width = 25
            mk.height = 40
            mk.mapView = mapView.mapView
            
            mk.userInfo = ["tag" : addrs[i]]
            
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
            i += 1
        }
    }
    
    func getCoords(url: String, trash_type: String, handler: @escaping (NSArray) -> Void){
        AF.request(url,
                   method: .get,
                   parameters: ["trash_type": trash_type],
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseJSON { response in
                switch response.result{
                case .success(let ret):
                    let jsonList = ret as? NSArray
                    handler(jsonList!)
                    
                case .failure(_):
                    print("error")
                }
            }
        
    }
}
