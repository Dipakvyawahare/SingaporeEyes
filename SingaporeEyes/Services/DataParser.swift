//
//  DataParser.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import UIKit

protocol DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult>
}

extension DataParser {
    func parse<T: Decodable>(data: Data?) -> Result<T, ErrorResult> {
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = TrafficCameraDateFormatter.request.rawValue
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            if let data = data {
                let model = try decoder.decode(T.self,
                                               from: data)
                return .success(model)
            } else {
                return .failure(ErrorResult.parser(string: "No Json data"))
            }
            
        } catch _ {
            return .failure(ErrorResult.parser(string: "Error while parsing json data"))
        }
    }
}
