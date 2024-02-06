//
//  DailySearchCache.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 06/02/24.
//

import Foundation

struct DailySearchCache {
    private static let defaults = UserDefaults.standard
    private static let searchCountKey = "userSearchCountToday"
    private static let lastSearchDateKey = "dateOfLastSearch"

    private static func getCurrentDaySearchCount() -> Int {
        guard let lastSearchDate = defaults.object(forKey: lastSearchDateKey) as? Date,
              Calendar.current.isDateInToday(lastSearchDate) else {
            resetSearchCountForNewDay()
            return 0
        }
        return defaults.integer(forKey: searchCountKey)
    }

    private static func resetSearchCountForNewDay() {
        defaults.set(0, forKey: searchCountKey)
        defaults.set(Calendar.current.startOfDay(for: Date()), forKey: lastSearchDateKey)
    }
    
    static func incrementSearchCounter() {
        let today = Calendar.current.startOfDay(for: Date())
        let count = getCurrentDaySearchCount() + 1
        defaults.set(count, forKey: searchCountKey)
        defaults.set(today, forKey: lastSearchDateKey)
    }
    
    static func isFreeSearchAvailable() -> Bool {
        return getCurrentDaySearchCount() < 5
    }
}
