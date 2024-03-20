//
//  ViewController.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterLabel: UILabel! {
        didSet {
            characterLabel.text = characterResult.description
        }
    }
    var characterResult: Character!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = characterResult.name
                
        fethImage()
        setBackgroundColor()
    }
    
    private func fethImage() {
        networkManager.fetchImage(from:characterResult.image ) { [unowned self] result in
            switch result {
            case .success(let imageData):
                characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        switch characterResult.status {
        case "Alive": 
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
            view.layer.insertSublayer(gradientLayer, at: 0)
            
        case "Dead": 
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkGray.cgColor]
            view.layer.insertSublayer(gradientLayer, at: 0)
        
        default:
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
