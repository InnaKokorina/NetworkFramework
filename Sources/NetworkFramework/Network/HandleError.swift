//
//  ConnectionError.swift
//  CleanArchitecture
//
//  Created by Inna Kokorina on 13.10.2022.
//

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(Int?)
    case resolvedNetworkFailure(Error)
    
    public var apiErrorType: String? {
        switch self {
        case .networkFailure(let statusCode):
            guard let statusCode = statusCode else { return nil }
            switch statusCode {
            case 401:
                return Constants.wrongApiKey
            case 402:
                return Constants.exceededRequestsCount
            default:
                return nil
            }
        default:
            return nil
        }
    }
}

enum HandleError {
    case server
    case network
    case coreDataFetch
    case coreDataSave
    case coreDataDelete
    case userDefault
    case unknowed
    
    public var errorsType: String {
        switch self {
        case .server:
            return "Ошибка сервера"
        case .network:
            return "Ошибка соединения, проверьте интернет"
        case .coreDataFetch:
            return "Ошибка загрузки данных из базы данных"
        case .coreDataSave:
            return "Ошибка сохранения в базу данных"
        case .coreDataDelete:
            return "Ошибка удаления из базы данных"
        case .unknowed:
            return "Что то пошло не так, попробуйте позже"
        case.userDefault:
            return "Ошибка загрузки данных из кэша"
        }
    }
}
public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
