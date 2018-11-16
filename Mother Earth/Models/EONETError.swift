//
//  Error.swift
//  Mother_Earth
//
//  Created by Karim Ebrahem on 11/16/18.
//  Copyright © 2018 KarimEbrahem. All rights reserved.
//

import Foundation

enum EONETError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
}
