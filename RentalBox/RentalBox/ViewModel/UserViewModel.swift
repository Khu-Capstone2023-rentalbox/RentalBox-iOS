//
//  UserViewModel.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/22.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var isAuthenticated: Bool?
    @Published var user: User?
    
    func login() {
        let defaults = UserDefaults.standard
        
        
    }
}
