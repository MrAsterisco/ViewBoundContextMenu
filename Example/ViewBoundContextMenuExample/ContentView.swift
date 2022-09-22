//
//  ContentView.swift
//  ViewBoundContextMenuExample
//
//  Created by Alessio Moiso on 21.09.22.
//

import SwiftUI
import ViewBoundContextMenu

struct ContentView: View {
  @State private var selectedAction = "None"
  
  var body: some View {
    List {
      Section {
        Text("This simple app demonstrates the problem that SwiftUI has with context menus in Lists.")
        Text("Long-press or right-click on the labels in the first section to see how SwiftUI behaves.")
        Text("Then, long-press or right-click on the labels in the second section to see how ViewBoundContextMenu works.")
      } header: {
        Text("About This App")
      }
      .font(.subheadline)
      
      Section {
        HStack {
          Text("Left Label")
            .bold()
            .contextMenu {
              Button(action: { selectedAction = "SwiftUI, Left Label" }) {
                Label("Left Label", systemImage: "arrow.left")
              }
              
              Menu("Left Submenu") {
                Button(action: { }) {
                  Label("Left Submenu Item", systemImage: "arrow.left")
                }
              }
            }
          
          Spacer()
          
          Text("Right Label")
            .bold()
            .contextMenu {
              Button(action: { selectedAction = "SwiftUI, Right Label" }) {
                Label("Right Label", systemImage: "arrow.right")
              }
              
              Menu("Right Submenu") {
                Button(action: { }) {
                  Label("Right Submenu Item", systemImage: "arrow.right")
                }
              }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      } header: {
        Text("SwiftUI Context Menu")
      } footer: {
        Text("Context menus attached to any view that is included in a list are applied to the entire row, instead of the view that has the \"contextMenu\" attribute.")
      }
      
      Section {
        HStack {
          Text("Left Label")
            .bold()
            .viewBoundContextMenu {
              [
                .init(
                  identifier: "actionForLeftLabel",
                  title: "Left Label",
                  image: .init(systemName: "arrow.left"),
                  action: { selectedAction = "ViewBoundContextMenu, Left Label" }
                ),
                .init(
                  identifier: "submenuForLeftLabel",
                  title: "Left Submenu",
                  children: [
                    .init(
                      identifier: "submenuItemForLeftLabel",
                      title: "Left Submenu Item",
                      image: .init(systemName: "arrow.left"),
                      action: { selectedAction = "ViewBoundContextMenu, Left Submenu Item" }
                    )
                  ],
                  action: { }
                )
              ]
            }
          
          Spacer()
          
          Text("Right Label")
            .bold()
            .viewBoundContextMenu {
              [
                .init(
                  identifier: "actionForRightLabel",
                  title: "Right Label",
                  image: .init(systemName: "arrow.right"),
                  action: { selectedAction = "ViewBoundContextMenu, Right Label" }
                ),
                .init(
                  identifier: "submenuForRightLabel",
                  title: "Right Submenu",
                  children: [
                    .init(
                      identifier: "submenuItemForRightLabel",
                      title: "Right Submenu Item",
                      image: .init(systemName: "arrow.right"),
                      action: { selectedAction = "ViewBoundContextMenu, Right Submenu Item" }
                    )
                  ],
                  action: { }
                )
              ]
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      } header: {
        Text("ViewBoundContextMenu")
      } footer: {
        Text("ViewBoundContextMenu works on any view in any container, including List rows. Each view can define its own viewBoundContextMenu and it will get the correct highlighting, as well as the correct actions.")
      }
      
      Section {
        Text("\(selectedAction)")
      } header: {
        Text("Selected Action")
      } footer: {
        Text("Choose one of the menu actions to see the result here.")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

#if canImport(AppKit)
private extension NSImage {
  convenience init?(systemName: String) {
    self.init(systemSymbolName: systemName, accessibilityDescription: nil)
  }
}
#endif
