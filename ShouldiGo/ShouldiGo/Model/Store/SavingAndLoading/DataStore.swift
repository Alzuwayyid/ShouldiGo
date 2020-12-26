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
    var forcastedWheatherDay = [Forecastday]()

    
    init(){
        let opearionQueue = OperationQueue()
        let operation = SavingLoadingOpearion()
        
        operation.loadReviewsData()
        
        opearionQueue.addOperation(operation)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChangesToYelp), name: UIScene.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChangesToYelp), name: UIApplication.willTerminateNotification, object: nil)
        
    }
    
    public func loadingBasedOnURL(forKey key: String) -> URL {
        
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
            in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
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
    
    func loadForcastedData(completion: @escaping ([ForecastHour])->()){

        do {
            SavingLoadingOpearion().loadForcastedWheatherHourly {
                (result) in
                DispatchQueue.global(qos: .background).async {
                    completion(result)
                }
            }

            print("All yelpBusinessData items were saved successfully in DataStore")
            
        } catch {
            print("There was an error while saving in DataStore: \(error)")
        }
    }
    
    func loadForcastedDailyData(completion: @escaping ([Forecastday])->()){

        do {
            SavingLoadingOpearion().loadForcastedWheatherDay {
                (result) in
                DispatchQueue.global(qos: .background).async {
                    completion(result)
                }
            }

            
        } catch {
            print("There was an error while saving in DataStore: \(error)")
        }
    }
    
    
    @objc func saveChangesToYelp()->Bool{
        do {
            let savingOperation = SavingLoadingOpearion()
            savingOperation.yelpBusinessData = self.yelpBusinessData
            savingOperation.forcastedWheatherHourly = self.forcastedWheatherHourly
            savingOperation.reviewsData = self.reviewsData
            savingOperation.forcastedWheatherDay = self.forcastedWheatherDay
            

            let operationQueue = OperationQueue()
            savingOperation.saveYelpBusinessData()
            savingOperation.saveReviewsDataArchive()
            savingOperation.saveForcastedWheatherHourly()
            savingOperation.saveForcastedWheatherDay()
            
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
    
    @objc func saveChangesToWheather()->Bool{
        do {
            let savingOperation = SavingLoadingOpearion()
            savingOperation.forcastedWheatherDay = self.forcastedWheatherDay
            

            let operationQueue = OperationQueue()

            savingOperation.saveForcastedWheatherDay()
            
            print("Direc for yelp saveChanges(): \(savingOperation.forcastedWheatherDayURL)")
            operationQueue.addOperation(savingOperation)

            return true

        } catch {
            print("There was an error while saving in DataStore: \(error)")
            return false
        }
        return true
    }
}

