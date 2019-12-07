//
//  URLExtensions.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation

extension URL {
    func appendParameters(params: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += params.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
}
