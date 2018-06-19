//
//  Fundation+Extension.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Dictionary {
    public func map<T: Hashable, U>( transform: (Key, Value) -> (T, U)) -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let (transformedKey, transformedValue) = transform(key, value)
            result[transformedKey] = transformedValue
        }
        return result
    }
    
    public func map<T: Hashable, U>( transform: (Key, Value) throws -> (T, U)) rethrows -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let (transformedKey, transformedValue) = try transform(key, value)
            result[transformedKey] = transformedValue
        }
        return result
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data?) -> Self? {
        if let data = data {
            if let decoded = try? decoder.decode(Self.self, from: data) {
                return decoded
            }
        }
        return nil
    }
}

extension URL {
    func withQueries(_ queries: HTTPParameters?) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate(format: String) -> Date? {
        let date = DateFormatter(format: format).date(from: self)
        return date
    }
}

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale(identifier: "fr_FR")
    }
}

extension Date {
    init(withFormat: String, andValue: String, GMT: Bool) {
        let dateFormatter = DateFormatter()
        if GMT {
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
        }
        dateFormatter.dateFormat = withFormat
        let d = dateFormatter.date(from: andValue)
        self.init(timeInterval: 0, since: d!)
    }
    
    func toString(format: String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}


