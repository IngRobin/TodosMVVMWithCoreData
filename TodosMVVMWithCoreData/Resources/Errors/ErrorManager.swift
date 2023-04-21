//
//  ErrorManager.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 17/04/23.
//

import Foundation

enum CoreDataError: Error {
    case unknowmError (Error)
    case corruptedDataError
    case fetchError (Error)
    case fetchFirstError (Error)
    case saveDataError (Error)
    
    var errorDescription: String {
        switch self {
            
        case .unknowmError(let error):
            return "Error desconocido \(error)"
        case .corruptedDataError:
            return "Error de data corrupta"
        case .fetchError(let error):
            return "Error obteniendo data \(error)"
        case .fetchFirstError(let error):
            return "Error obteniendo data unitaria \(error)"
        case .saveDataError(let error):
            return "Error guardando data \(error)"
        }
        
    }
}


