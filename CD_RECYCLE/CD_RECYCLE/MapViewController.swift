//
//  MapViewController.swift
//  CD_RECYCLE
//
//  Created by 강다연 on 2021/06/09.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet weak var viewContainer: UIView!
    var itemName: String?
    
    /*
     예시로 만든 두 개의 ViewController입니다.
     구분이 되도록 배경 색상을 다르게 했는데요.
     firstVC는 파란색 배경, secondVC는 빨간색 배경입니다.
     각 VC에 해당되는 파일은 FirstChildViewController.swift , Second~.swift 입니다.
     */
    let firstVC = FirstChildViewController()
    let secondVC = SecondChildViewController()
    let thirdVC = ThirdChildViewController()
    let fourthVC = FourthChildViewController()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.bringSubviewToFront(viewContainer)
        
        viewContainer.addSubview(firstVC.view)
        viewContainer.addSubview(secondVC.view)
        viewContainer.addSubview(thirdVC.view)
        viewContainer.addSubview(fourthVC.view)
        
        /*
         어떤 항목을 선택했는지 인덱스는
         segControl.selectedSegmentIndex 에 저장됩니다.
         일반쓰레기 = 0  ~  헌 옷 = 4
         
         처음 인덱스를 아래와 같이 임의로 설정할 수 있는데요.
         그래서 검색 결과 화면에서 넘어올 때
         일반쓰레기면 0으로, 폐건전지면 2로 설정되는 방식으로
         구현할 수 있을 것 같습니다.
         */
        
        segControl.selectedSegmentIndex = 1
        
        viewContainer.bringSubviewToFront(secondVC.view)
    }
    
    // segControl에서 선택된 항목이 변경되면 호출되는 함수입니다.
    @IBAction func segSelect(_ sender: Any) {
        
//        lbl.text = "현재선택은 \(String(describing: segControl.titleForSegment(at: segControl.selectedSegmentIndex))) 입니다."
        
        /*
         인덱스를 이용해 아래와 같이 조건문을 이용할 수 있습니다.
         이 예시에서는 '일반쓰레기'와 '분리수거'항목을 선택할 때,
         그에 맞는 view로 바뀌도록 했습니다.
         */
        
        // 첫번째 항목을 선택한 경우
        if segControl.selectedSegmentIndex == 0 {
            viewContainer.bringSubviewToFront(firstVC.view)
        }
        // 두번째 항목을 선택한 경우
        else if segControl.selectedSegmentIndex == 1{
            viewContainer.bringSubviewToFront(secondVC.view)
        }
        else if segControl.selectedSegmentIndex == 2 {
            viewContainer.bringSubviewToFront(thirdVC.view)
        }
        else if segControl.selectedSegmentIndex == 3 {
            viewContainer.bringSubviewToFront(fourthVC.view)
        }

        /*
         5개 항목 각각에 따로 ViewController를 만들 수 있어서,
         만약 첫번째 VC에는 일반쓰레기, 세번째 VC는 폐건전지 수거함이 표시된 지도 등을
         따로 따로 구현이 가능하다면
         
         각 항목을 선택했을 때 그에 맞는 지도가 나타나는 건
         위와 같이 조건문으로도 구현할 수 있을 것 같습니다.
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //label.text = itemName
        
    }
    
}
