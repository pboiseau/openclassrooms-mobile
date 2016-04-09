//
//  MainViewController.swift
//  Openclassroom
//
//  Created by Paul on 02/03/2016.
//  Copyright © 2016 paulboiseau. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - IB Outlet
    
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    
    // MARK: - Instance variable
    
    lazy var cards: [Card] = [Card]()
    
    // MARK: - UIViewController Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        registerCustomCell()
        
        initializeCards()
    }
    
    override func viewWillAppear(animated: Bool) {
        tasksCollectionView.pagingEnabled = true
    }
    
    // MARK: - Cards methods
    
    private func initializeCards() {
        let todayCards = getStaticLecons()
        
        let firstCard = Card(id: 0, title: "Jour 1 sur 20", time: 0, type: .None, cardType: .Start)
        firstCard.subtitle = "Vous avez \(todayCards.count) cours aujourd'hui"
        
        let lastCard = Card(id: todayCards.count + 1, title: "Journée non terminée", time: 0, type: .None, cardType: .Finish)
        
        cards.append(firstCard)
        cards += todayCards
        cards.append(lastCard)
    }
    
    /**
     Register Custom Card Cell
     */
    private func registerCustomCell() {
        tasksCollectionView.registerClass(ActiveCell.self, forCellWithReuseIdentifier: ActiveCell.cellIdentifier())
        tasksCollectionView.registerClass(StartCell.self, forCellWithReuseIdentifier: StartCell.cellIdentifier())
        tasksCollectionView.registerClass(DisableCell.self, forCellWithReuseIdentifier: DisableCell.cellIdentifier())
        tasksCollectionView.registerClass(FinishCell.self, forCellWithReuseIdentifier: FinishCell.cellIdentifier())
    }
    
    func getStaticLecons() -> [Card] {
        var lecons: [Card] = [Card]()
        
        if let cards = Card.getData() {
            for (index, json) in cards["cards"].enumerate() {
                let type: LeconType = LeconType.stringToEnum(json.1["type"].string!)
                let cardType: CardType = index == 0 ? .Active : .Disable
            
                let card = Card(id: index,
                                title: json.1["title"].string!,
                                time: json.1["time"].int!,
                                type: type,
                                cardType: cardType)
                
                lecons.append(card)
            }
        }
        
        return lecons
    }
    
    
    // MARK: - Collection view
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let currentCard = cards[indexPath.row]
        let cell = CardsFactory.createCard(currentCard.cardType, collection: collectionView, indexPath: indexPath)!
        
        cell.setup()
        cell.content(currentCard)
        
        return cell as! UICollectionViewCell
    }
    
    // MARK: - CollectionView Flow Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(tasksCollectionView.bounds.width, tasksCollectionView.bounds.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}
