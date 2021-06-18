//
//  ThirdChildViewController.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/06/16.
//

import UIKit
import NMapsMap
import CoreData

class SecondChildViewController: UIViewController { // 폐건전지

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFNaverMapView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y,
                                                    width: 343.0, height: 516.0))
        
        // Do any additional setup after loading the view.
        
        mapView.showCompass = true
        mapView.showScaleBar = true
        mapView.showZoomControls = true
        
        let LO = mapView.mapView.locationOverlay
        LO.hidden = false
        LO.location = NMGLatLng(lat: 37.65893337125361, lng: 127.0414481846587)
        
        let CU = NMFCameraUpdate(scrollTo: LO.location)
        mapView.mapView.moveCamera(CU)
        
        let targets = self.getNearB(current: LO.location)
        let coords = targets.0
        let addrs = targets.1["주소"]!
        
        var n = 0
        for target in coords {
            let mk = NMFMarker()
            mk.position = target
            mk.iconImage = NMF_MARKER_IMAGE_BLACK
            mk.iconTintColor = UIColor.blue
            mk.width = 25
            mk.height = 40
            mk.mapView = mapView.mapView
            
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
        } // End of for loop
        
        view.addSubview(mapView)
        view.bringSubviewToFront(mapView)
    }
    
    func getNearB(current: NMGLatLng) -> ([NMGLatLng], [String : [String]]) {
        let LBrequest: NSFetchRequest<LightAndBattery> = LightAndBattery.fetchRequest()
        let LBfetchResult = PersistenceManager.shared.fetch(request: LBrequest)
        
        let lat_left = current.lat - 0.005
        let lat_right = current.lat + 0.005
        let lng_top = current.lng + 0.006
        let lng_bot = current.lng - 0.006
        
        var targets_addr: [String : [String]] = [ : ]
        var addrs: [String] = []
        var Btargets: [NMGLatLng] = []
        
        for item in LBfetchResult {
            if item.latitude == 0.0 {
                continue
            }
            if item.latitude <= lat_right && item.latitude >= lat_left {
                if item.longitude <= lng_top && item.longitude >= lng_bot {
                    let target = NMGLatLng(lat: item.latitude, lng: item.longitude)
                    let addr = "\(String(describing: item.address!)) \(String(describing: item.detailAddress!))"
                    addrs.append(addr)
                    if item.type == "폐건전지" {
                        Btargets.append(target)
                    }
                }
            }
        }
        
        targets_addr["주소"] = addrs
        
        return (Btargets, targets_addr)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
