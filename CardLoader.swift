//
//  CardLoader.swift
//  Battle Arena
//
//  Created by Felipe Borges on 30/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardLoader {
    
    let scene: BattleScene
    
    init(scene: BattleScene) {
        self.scene = scene
    }
    
    func load(name: String, type: CardType) -> Card? {
        let url = Bundle.main.url(forResource: name, withExtension: ".json")
        
        if let url = url {
            
            var data: Data?
            
            do {
                data =
                    try Data(contentsOf: url)
                
            } catch let error {
                print("Got an error while loading the URL: \(error.localizedDescription)")
            }
            
            if let data = data {
                let json = JSON(data)
                do {
                    return try setCardAttributes(with: json, for: type)
                } catch let error {
                    print("Got an error while unpacking the JSON: \(error.localizedDescription)")
                }
            }
            return nil
            
        } else {
            return nil
        }
    }
    
    fileprivate func setCardAttributes(with json: JSON, for type: CardType) throws -> Card {
        
        var card: Card
        
        guard let name = json["name"].string,
              let description = json["description"].string,
              let manaCost = json["manacost"].int,
              let summoningTime = json["summoningtime"].int
                else {
               throw NSException(name: NSExceptionName(rawValue: "No Card Exception"), reason: "The card could not be initialized with the current info - first exit", userInfo: nil) as! Error
        }
        
        switch type {
        case .character:
            guard let attackPoints = json["attack_points"].int,
                  let attackSpeed = json["attack_speed"].float,
                  let attackArea = json["attack_area"].int,
                  let attackRange = json["attack_range"].float,
                  let speed = json["movement_speed"].int,
<<<<<<< HEAD
                  let healthPoints = json["hp"].int else {
=======
                  let healthPoints = json["hp"].int,
                  let imageName = json["image"].string
                        else {
>>>>>>> b9e11ec14434bd4d07b93ca88238fa2f74186917
                    throw NSException(name: NSExceptionName(rawValue: "No Info Exception"), reason: "The Character card could not be loaded with the current info", userInfo: nil) as! Error
            }
            
            card = CharacterCard(image: UIImage(named: imageName)!,
                                         name: name,
                                         cardDescription: description,
                                         manaCost: manaCost,
                                         summoningTime: summoningTime,
                                         level: 1,
                                         xp: 1,
                                         atackPoints: attackPoints,
                                         atackSpeed: CGFloat(attackSpeed),
                                         atackArea: attackArea,
                                         atackRange: CGFloat(attackRange),
                                         speed: speed,
                                         healthPoints: healthPoints,
                                         battleScene: scene,
                                         teamId: 1)
            break
        default:
            card = Card(image: UIImage(named: "character")!, name: name, cardDescription: description, manaCost: manaCost, summoningTime: summoningTime, level: 1, xp: 1)
            break
        }
        
        return card
    }
    
}

enum CardType {
    case character
    case magic
    case construction
}
