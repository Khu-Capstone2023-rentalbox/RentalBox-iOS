//
//  APIClient.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Alamofire

final class ApiClient {
    
    static let shared = ApiClient()
    
    static let BASE_URL = "http://www.rentalbox.store/users/"
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
}
