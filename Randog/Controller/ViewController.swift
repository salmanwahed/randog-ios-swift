//
//  ViewController.swift
//  Randog
//
//  Created by Salman Wahed on 2/23/20.
//  Copyright © 2020 Mac Mini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRandomDogImage()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        activityIndicatior.isHidden = false
    }
    
    @objc func imageTapped(){
        activityIndicatior.isHidden = false
        print("Image tap detected!")
        loadRandomDogImage()
    }
    
    func loadRandomDogImage(){
        DogAPI.requestRandomImage(completionHandler: handleRandomImgResponse(dogImg:error:))
    }
    
    func handleRandomImgResponse(dogImg: DogImage?, error: Error?){
        guard let imageURL = URL(string: dogImg!.message) else {
            print("Not valid url")
            return
        }
        DogAPI.requestImgFile(imageURL: imageURL) { (image, error) in
            self.handleImgFileResponse(image: image, error: error)
        }
    }
    
    func handleImgFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
            self.activityIndicatior.isHidden = true
        }
    }
    
    
}

