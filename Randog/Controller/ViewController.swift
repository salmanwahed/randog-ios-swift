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
        let randomImgEndpoint = DogAPI.Endpoint.randomImgFromAllDogsCollection.url
        let task = URLSession.shared.dataTask(with: randomImgEndpoint){ (data, response, error) in
            guard let data = data else {
                print("No data or there was an error")
                return
            }
            let decoder = JSONDecoder()
            do{
                let dogImg = try decoder.decode(DogImage.self, from: data)
                guard let imageURL = URL(string: dogImg.message) else {
                    print("Not valid url")
                    return
                }
                
                DogAPI.requestImgFile(imageURL: imageURL) { (image, error) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.activityIndicatior.isHidden = true
                    }
                }
                
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
}

