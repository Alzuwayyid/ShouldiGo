//
//  DataStore.swift
//  ShouldiGo
//
//  Created by Mohammed on 22/12/2020.
//

import UIKit

class DataStore{
    var reviewsData = [Review]()
    var forcastedWheatherHourly = [ForecastHour]()
    var yelpBusinessData = [Business]()
    
    init(){
        let opearionQueue = OperationQueue()
        let operation = SavingLoadingOpearion()
        
        operation.loadReviewsData()
//        operation.loadYelpBusinessData()
        operation.loadForcastedWheatherHourly()
        
        opearionQueue.addOperation(operation)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIApplication.willTerminateNotification, object: nil)
        
    }
    
    func addYelpBusiness(_ data: Business){
        yelpBusinessData.append(data)
    }
    
    func loadYelpData(completion: @escaping ([Business])->()){

        do {
            SavingLoadingOpearion().loadYelpBusinessData {
                (result) in
                DispatchQueue.global(qos: .background).async {
                    completion(result)
                }
            }
            
            print("grwjgmorwload: \(yelpBusinessData)")

            print("All yelpBusinessData items were saved successfully in DataStore")
            
        } catch {
            print("There was an error while saving in DataStore: \(error)")
        }
    }
    
    
    @objc func saveChanges()->Bool{
        do {
            let savingOperation = SavingLoadingOpearion()
            savingOperation.yelpBusinessData = self.yelpBusinessData

            let operationQueue = OperationQueue()
            savingOperation.saveYelpBusinessData()
            print("Direc for yelp saveChanges(): \(savingOperation.yelpBusinessDataArchiveURL)")
            operationQueue.addOperation(savingOperation)

            print("All yelpBusinessData items were saved successfully in DataStore")
            return true

        } catch {
            print("There was an error while saving in DataStore: \(error)")
            return false
        }
        return true
    }
    
}

