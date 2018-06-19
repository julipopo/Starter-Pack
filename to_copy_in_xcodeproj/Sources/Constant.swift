//
//  Constant.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

struct Constant {
    struct API {
        // URL
        // Todo - replace
        #if RELEASE
        static let url = "https://www.apple.fr/"
        #else
        static let url = "http://dev.apple.fr/"
        #endif
        
        // Todo - replace
        static let dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss.SSSZ"
    }
    
    struct Utils {
        static let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        static let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        static let Width = UIScreen.main.bounds.width
        static let Height = UIScreen.main.bounds.height
    }
    
    struct UDK {
        // Todo - replace
        static let refreshToken =   "udkRefreshToken"
        static let accessToken =    "udkAccessToken"
        static let identifiant =    "udkLoginIdentifiant"
    }
}

extension UIColor {
    // Todo - replace
    static let mainTheme =              UIColor(hex: "35d85b")
    static let grey800 =                UIColor(hex: "424242")
    static let grey600 =                UIColor(hex: "757575")
    static let grey400 =                UIColor(hex: "BDBDBD")
    static let grey300 =                UIColor(hex: "E0E0E0")
    static let grey200 =                UIColor(hex: "EEEEEE")
}
