//
//  CameraViewController.swift
//  CD_RECYCLE
//
//  Created by 강다연 on 2021/06/05.
//

import CoreML
import UIKit
import Photos

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var cameraPreview: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var itemName: UILabel!
    
    var imagePickerController = UIImagePickerController()
    
    var selectedImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera"
        imagePickerController.delegate = self
        checkPermissions()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! PredictionResultViewController
        nextVC.inputimg = selectedImg
        
    }
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func tappedPhotoButton(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func checkPermissions(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("Access granted to use Photo Library")
        } else {
            print("we don't have access to your Photos.")
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        cameraPreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        selectedImg = cameraPreview?.image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
