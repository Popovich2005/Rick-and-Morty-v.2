//
//  CharacterCell.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterDetailsLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.cyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        if let sublayers = layer.sublayers, sublayers.contains(where: {
            $0 is CAGradientLayer
        }) {
            layer.replaceSublayer(
                sublayers.first(where: {
                    $0 is CAGradientLayer
                })!,
                with: gradientLayer
            )
        } else {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    func configure(with character: Character) {
        characterDetailsLabel.text = character.name
        networkManager.fetchImage(from: character.image) { [unowned self] result in
            switch result {
            case .success(let imageData):
                characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
