//
//  Alerts.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 19/04/23.
//

import SwiftUI
import Foundation



/// Enum for choise the type of the alert for show in View
enum AlertType{
    case success
    case error
}

extension View{
    /// Function for define and create the type of alert for show to View
    /// - Parameters:
    ///   - alertType: Type of alert defined in above protocol
    ///   - action: If the type of alert is for error, it's possible makean action with this parameter
    /// - Returns: Object Alert created for show in View
    func getAlert(alertType: AlertType?, action: @escaping () -> Void) -> Alert{
        switch alertType{
        case .success:
            return Alert(title: Text("Operación realizada"))
        case .error:
            return Alert(title: Text("Error en la operación"), dismissButton: .default(Text("Reintentar"), action: action))
        case .none:
            return Alert(title: Text("Error desconocido"))
        }
    }
}
