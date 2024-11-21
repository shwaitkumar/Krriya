//
//  OnboardingItem.swift
//  Krriya
//
//  Created by Shwait Kumar on 21/11/24.
//

import Foundation

struct OnboardingCardItem: Equatable {
    let id: Int
    let title: String
    let subtitle: String?
    let body: String?
    let example: String?
    let quote: String?
    let fact: String?
}
