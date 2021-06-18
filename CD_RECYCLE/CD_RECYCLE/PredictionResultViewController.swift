//
//  PredictionResultViewController.swift
//  CD_RECYCLE
//
//  Created by 황선애 on 2021/06/18.
//

import CoreML
import CoreData
import UIKit

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
        
        // 예측 수행 (결과 라벨(ex. "아이스팩") -> resultName에 저장)
        analyzeImage(image: inputimg)
        
        nameLabel.text = "이 물건은 \(resultName ?? "...")입니다."
        
        // TODO: resultName을 이용해 coreData에서 일치하는 항목 확인
        // 해당 항목의 recycleWay property를 resultRecycleWay에 저장
        // classId property는 resultIdx에 저장 (MapViewController로 전달)
        let RCrequest: NSFetchRequest<Recycle> = Recycle.fetchRequest()
        let RCfetchResult = PersistenceManager.shared.fetch(request: RCrequest)
        
        for item in RCfetchResult {
            if item.name == resultName {
                resultRecycleWay = item.recycleWay
                resultIdx = item.classId
                break
            }
        }
        
        // Label에 출력
        recyclewayLabel.text = resultRecycleWay
    }
    
    // 다음 viewController(지도)로 이동할 때 호출됩니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MapViewController
        nextVC.segIdx = resultIdx
    }
    
    // UIImage 타입의 input을 받아서, 모델에 입력값으로 넣어 예측을 수행
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?
                .getCVPixelBuffer() else {
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try TrashClassificationModel(configuration: config)
            let input = TrashClassificationModelInput(InputImg: buffer)
            
            let output = try model.prediction(input: input)

            resultName = output.classLabel
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

