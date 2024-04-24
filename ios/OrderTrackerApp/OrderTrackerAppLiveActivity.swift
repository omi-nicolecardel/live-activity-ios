//
//  OrderTrackerAppLiveActivity.swift
//  OrderTrackerApp
//
//  Created by mcbook on 4/24/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState // don't forget to add this line, otherwise, live activity will not display it.

  public struct ContentState: Codable, Hashable { }

  var id = UUID()
}

let sharedDefault = UserDefaults(suiteName: "group.ordertracker")!

struct OrderTrackerAppLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // Lock screen/banner UI goes here
            Spacer().frame(height: 30)
            VStack {
                let status = sharedDefault.string(forKey: context.attributes.prefixedKey("status"))!
                Text(status).bold().foregroundColor(.black).padding(.bottom, 15)
                CustomProgressIndicator(progressValue: sharedDefault.double(forKey: context.attributes.prefixedKey("progressValue"))).padding(.horizontal, 20)
            }
            Spacer().frame(height: 30)
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Spacer().frame(height: 15)
                        let status = sharedDefault.string(forKey: context.attributes.prefixedKey("status"))!
                        Text(status).padding(.leading, 20).bold()
                        
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    let time = sharedDefault.string(forKey: context.attributes.prefixedKey("time"))!
                    
                    Spacer().frame(height: 15)
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2).frame(width: 100, height: 36).padding(.trailing, 20)
                        Text(time).font(.body).foregroundColor(.white).padding(.trailing, 20)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    CustomProgressIndicator(progressValue: sharedDefault.double(forKey: context.attributes.prefixedKey("progressValue"))).padding(.vertical, 20)
                    // more content
                }
            } compactLeading: {
                Text("App")
            } compactTrailing: {
                Text("45m")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct CustomProgressIndicator: View {
    var progressValue: Double
    
    var body: some View {
        ProgressView(value: progressValue)
            .progressViewStyle(LinearProgressViewStyle())
            .padding(.horizontal, 20)
            .foregroundColor(Color.purple)
            .scaleEffect(x: 1, y: 3)
            
    }
}



extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}
