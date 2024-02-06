//
//  GenericCache.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 06/02/24.
//

import Foundation

struct GenericCache {
    private static let userDefaults = UserDefaults.standard

    static func setCache<Value: Codable>(value: Value, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            userDefaults.set(encoded, forKey: key)
        }
    }

    static func getValue<Value: Codable>(forKey key: String) -> Value? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Value.self, from: data)
    }
}
