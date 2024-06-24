//
//  FeedVMProtocol.swift
//  Navigation
//
//  Created by Anastasiya on 13.06.2024.
//

import UIKit
import StorageService

protocol ProfileVMProtocol {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func changeStateIfNeeded()
}

enum State {
    case initial
    case loading
    case loaded([Post])
    case error
}
