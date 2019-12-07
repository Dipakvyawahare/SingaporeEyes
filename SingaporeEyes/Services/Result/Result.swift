//
//  Result.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
