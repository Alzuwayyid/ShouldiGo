//
//  Extensions+DetailedController.swift
//  ShouldiGo
//
//  Created by Mohammed on 28/12/2020.
//

import UIKit
import Kingfisher
import MapKit
import Alamofire

// MARK: - CollectionView Delegate
extension DetailedViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ForcastTodayURL = getForcastedWheatherURL(lon: longitude, lat: latitude ,days: 3)
        
        wheatherFetcher.fetchForcatedWheatherResults(url: ForcastTodayURL) { (result, error) in
            
            var forecast = [ForecastHour]()
            // will avoid crashing in offline mode if no value was passed from forcaste api to a partircular business, by unrawpping and checking emptiness.
            if let result = result{
                if !result.isEmpty{
                    forecast.append(contentsOf: result[indexPath.row].hour)
                    self.dayDetailsCollectionViewDD.details = forecast
                    self.daysCollectionViewDD.details = result
                    DispatchQueue.main.async {
                        self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
                    }
                }
            }
        }
    }
}

// MARK: - Prepare for segue
extension DetailedViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            case "commentSegue":
                let decVC = segue.destination as! CommentsViewController
                decVC.busID = busID
            default:
                print("Could not prefrom segue")
        }
    }
}


// MARK: - Methods
extension DetailedViewController{
    func animateViews(){
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = view.bounds.size.width - 440
        animation.toValue = CGPoint(x: 45, y: 45)
        animation.duration = 0.6
        animation.beginTime = CACurrentMediaTime() + 0.0
        animation.repeatCount = 1
        animation.autoreverses = false
        
        let hiddenAnimation = CABasicAnimation(keyPath: "hidden")
        hiddenAnimation.fromValue = 1
        hiddenAnimation.toValue = 0
        hiddenAnimation.duration = 1.1
        hiddenAnimation.beginTime = CACurrentMediaTime() + 0.1
        hiddenAnimation.repeatCount = 1
        hiddenAnimation.autoreverses = false
        
        phoneLogoImage.layer.add(animation, forKey: nil)
        addressLogoImage.layer.add(animation, forKey: nil)
        ratingLogoImage.layer.add(animation, forKey: nil)
        phoneNumber.layer.add(hiddenAnimation, forKey: nil)
        ratingLabel.layer.add(hiddenAnimation, forKey: nil)
        addressLabel.layer.add(hiddenAnimation, forKey: nil)
        titleLabel.layer.add(hiddenAnimation, forKey: nil)
        categoryLabel.layer.add(hiddenAnimation, forKey: nil)
        daysCollectionView.layer.add(hiddenAnimation, forKey: nil)
        daysDetailsCollectionView.layer.add(hiddenAnimation, forKey: nil)
        
        let jump = CASpringAnimation(keyPath: "transform.scale")
        jump.damping = 9
        jump.mass = 1
        jump.initialVelocity = 50
        jump.stiffness = 500.0
        jump.fromValue = 4.0
        jump.toValue = 1.0
        jump.duration = jump.settlingDuration
        largeImage.layer.add(jump, forKey: nil)
    }
    
    // Drawing lines in the super view
    func addLines(){
        let arrOfLines = [UIView(frame: CGRect(x: 50, y: 265, width: 273, height: 1.0)), UIView(frame: CGRect(x: 40, y: 340, width: 300, height: 1.0)), UIView(frame: CGRect(x: 180, y: 275, width: 1, height: 55.0))]
        
        for line in arrOfLines{
            line.layer.borderWidth = 1.0
            line.layer.borderColor = UIColor.white.cgColor
            self.view.addSubview(line)
        }
    }
}
