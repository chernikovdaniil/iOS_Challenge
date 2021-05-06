//
//  SwiftyReduxBridging.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import SwiftyRedux

typealias GetState<State> = SwiftyRedux.GetState<State>
typealias Dispatch = SwiftyRedux.Dispatch
typealias Store<State> = SwiftyRedux.Store<State>
typealias Disposable = SwiftyRedux.Disposable
typealias Middleware<State> = SwiftyRedux.Middleware<State>
typealias Action = SwiftyRedux.Action
typealias BatchAction = SwiftyRedux.BatchAction

func createMiddleware<State>(_ middleware: @escaping Middleware<State>) -> Middleware<State> {
    return SwiftyRedux.createMiddleware(middleware)
}

func batchDispatchMiddleware<State>() -> Middleware<State> {
    return SwiftyRedux.batchDispatchMiddleware()
}
