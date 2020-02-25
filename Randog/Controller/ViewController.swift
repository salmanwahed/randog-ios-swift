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
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    var currentBreed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        loadDogBreeds()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(){
        if self.currentBreed != nil {
            loadRandomDogImage(dogBreed: currentBreed!)
        }else{
            loadRandomDogImage()
        }
    }
    
    func loadDogBreeds(){
        DogAPI.requestAllBreedList(completionHandler: handleBreedListResponse(breedList:error:))
    }
    
    func loadRandomDogImage(){
        DogAPI.requestRandomImage(completionHandler: handleRandomImgResponse(dogImg:error:))
    }
    
    func loadRandomDogImage(dogBreed breed: String){
        DogAPI.requestRandomImage(breed:breed, completionHandler: handleRandomImgResponse(dogImg:error:))
    }
    
    func handleBreedListResponse(breedList: [String], error: Error?){
        self.breeds = breedList
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
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
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let breedName = breeds[row]
        self.currentBreed = breedName
        print("Current showing breed: \(breedName)")
        loadRandomDogImage(dogBreed: breedName)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
}

