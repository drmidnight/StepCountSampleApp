//
//  StepsProvider.swift
//  Steps
//
//  Created by Corey Morello on 7/13/20.
//  Copyright © 2020 Corey Morello. All rights reserved.
//

import Foundation
import HealthKit

public typealias UpdateHandler = (([StepData]) -> Void)
public class StepsProvider {
    private let healthStore: HKHealthStore
    public var dataSetTypes: Set<HKQuantityType> = Set()
    
    init() {
        if let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) {
            self.dataSetTypes.insert(stepType)
        }

        self.healthStore = HKHealthStore()
    }

    public var dataUpdatedHandler: UpdateHandler?

    public func fetchSteps() {
        self.askPermissionIfNeeded { [weak self] success in
            // success will be true if permissions were allowed and then turned off in settings
            if success {
                self?.getHKStepData(for: .stepCount, startDate: Date(), numDaysBack: 14) { result in
                    switch result {
                    case .success(let steps):
                        print("Fetched steps, updating.....")
                        if let handler = self?.dataUpdatedHandler {
                            handler(steps)
                        }
                    case .failure(let error):
                        print("Failed to fetch steps: \(error.localizedDescription)")
                    }

                }
            }

        }
    }

    private func askPermissionIfNeeded(_ completion: @escaping (Bool) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorization(toShare: [], read: self.dataSetTypes) { (success, error) in
                if success {
                    print("Healthkit Authorization: Success")
                } else {
                    print("Healthkit Authorization: Failed")
                }
                completion(success)
            }
        } else {
            print("No healthkit data to fetch. Check permissions.")
        }
    }

    // TODO: Make this generic for other quantity types so you can fetch distance etc.
    private func getHKStepData(for queryType: HKQuantityTypeIdentifier, startDate: Date, numDaysBack: Int, completion: @escaping (Result<[StepData], Error>) -> Void) {
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: queryType) else { return }

        let calendar = Calendar.current
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)

        var day = DateComponents()
        day.day = 1

        let query = HKStatisticsCollectionQuery(quantityType: stepsQuantityType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: startOfDay, intervalComponents: day)

        var resultData = [StepData]()

        query.initialResultsHandler = { query, results, error in
            guard let statsCollection = results else {
                print("Error occured: \(error.debugDescription)")
                return
            }

            let endDate = startDate

            guard let startDate = calendar.date(byAdding: .day, value: -numDaysBack, to: endDate) else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }

            statsCollection.enumerateStatistics(from: startDate, to: endDate) { stat, stop in
                if let valueQuantity = stat.sumQuantity() {
                    let date = stat.startDate
                    let value = valueQuantity.doubleValue(for: HKUnit.count())
                    let stepData = StepData(count: value, date:date)
                    resultData.append(stepData)
                }
            }

            // reverse the data so we end up with the most recent at index 0
            completion(.success(resultData.reversed()))
        }

        healthStore.execute(query)
    }
}
