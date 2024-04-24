//
//  OrderTrackerAppBundle.swift
//  OrderTrackerApp
//
//  Created by mcbook on 4/24/24.
//

import WidgetKit
import SwiftUI

@main
struct OrderTrackerAppBundle: WidgetBundle {
    var body: some Widget {
        OrderTrackerApp()
        OrderTrackerAppLiveActivity()
    }
}
