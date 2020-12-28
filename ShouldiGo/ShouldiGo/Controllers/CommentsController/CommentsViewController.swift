//
//  CommentsViewController.swift
//  ShouldiGo
//
//  Created by Mohammed on 21/12/2020.
//

import UIKit

class CommentsViewController: UIViewController{
    
    // MARK: - Properties
    var busID = ""
    var yelpFetcher = YelpFetcher()
    let commentsCollectionViewDataSource = CommentsCollectionView()
    
    // MARK: - IBOutlet
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        collectionView.dataSource = commentsCollectionViewDataSource
        
        let reviewsURL = getReviewsURL(id: busID)
        yelpFetcher.fetchYelpReviewsResults(url: reviewsURL) { (result, error) in
            self.commentsCollectionViewDataSource.reviewsData = result!.reviews
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
}
