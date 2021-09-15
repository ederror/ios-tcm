//
//  PredictionResultViewController.swift
//  CD_RECYCLE
//
//  Created by 황선애 on 2021/06/18.
//

import UIKit
import Alamofire

class PredictionResultViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recyclewayLabel: UILabel!
    var inputimg: UIImage?
    var resultName: String?
    var resultRecycleWay: String?
    var resultIdx: Int16?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // 이미지 화면에 표시
        imageView.image = inputimg
        nameLabel.text = "이 물건은 \(resultName ?? "...")입니다."
        
        // REST Api 호출해서 예측 결과 받아오기
        let url = "http://192.168.0.2:3654/upload"
        postImage(url: url, inputimg: inputimg!, handler: { nsdic in
            
            self.resultName = nsdic["tname"] as? String
            self.nameLabel.text = "이 물건은 \(self.resultName ?? "...")입니다."
            self.recyclewayLabel.text = nsdic["thowto"] as? String
            self.resultIdx = nsdic["thowtoid"] as? Int16
        })
        
    }
    
    // 다음 viewController(지도)로 이동할 때 호출됩니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MapViewController
        nextVC.segIdx = resultIdx
    }
    
    func postImage(url: String, inputimg: UIImage, handler: @escaping (NSDictionary) -> Void) {
        let imgData = inputimg.jpegData(compressionQuality: 1)!
      
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData, withName: "inputimg", fileName: "test.jpg", mimeType: "image/jpg")
        }, to: url)
        .responseJSON { response in
            switch response.result {
            case .success(let res):
                print(response)
                let jsonObj = res as? NSDictionary
                print(jsonObj!)
                handler(jsonObj!)
                
            case .failure(_):
                print("fail")
            }
        }
    }
}

