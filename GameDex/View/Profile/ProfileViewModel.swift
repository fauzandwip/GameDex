//
//  ProfileViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var showSheet = false
    
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    
    @Published var description: String {
        didSet {
            UserDefaults.standard.set(description, forKey: "description")
        }
    }
    
    init() {
        let nameLocal = UserDefaults.standard.string(forKey: "name") ?? ""
        self.name = nameLocal.isEmpty ? "Fauzan Dwi Prasetyo" : nameLocal
        
        let descriptionLocal = UserDefaults.standard.string(forKey: "description") ?? ""
        self.description = descriptionLocal.isEmpty ? "iOS Development Enthusiast" : descriptionLocal
    }
}
