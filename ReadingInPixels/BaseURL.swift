//
//  BaseURL.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 15.04.2024.
//

import Foundation

struct API {
    static var baseURL = ProcessInfo.processInfo.environment["HOST_URL"]!
}
