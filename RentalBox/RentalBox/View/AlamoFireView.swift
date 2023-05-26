//
//  AlamoFireView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/23.
//

import SwiftUI

struct AlamofireView: View {
    @ObservedObject var networking = networkingClass()
    let url = "https://randomuser.me/api/?results=50&inc=name,email"
    
    init() {
        networking.alamofireNetworking(url: url)
    }
    
    var body: some View {
        List(networking.randomUser) { datas in
            ListView(datas)
        }
    }
}
struct SessionView: View {
    @ObservedObject var networking = networkingClass()
    let url = "https://randomuser.me/api/?results=50&inc=name,email"
    
    init() {
        networking.urlSessionNetworking(url: url)
    }
    
    var body: some View {
        List(networking.randomUser) { datas in
            ListView(datas)
        }
    }
}
