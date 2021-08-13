//
//  EnvironmentConfig.swift
//  Pokemon-SwiftUI
//
//  Created by July on 4/08/21.
//

import Foundation

public enum EnvironmentConfig {
    // MARK: - Keys

    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
        }
    }

    // MARK: - Plist

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values

    static var rootURL: URL = {
        guard let rootURLstring = EnvironmentConfig.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
}
