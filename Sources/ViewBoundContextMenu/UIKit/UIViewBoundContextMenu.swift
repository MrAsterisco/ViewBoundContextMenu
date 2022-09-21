#if canImport(UIKit)
import SwiftUI
import UIKit

public struct ViewBoundContextMenu: UIViewRepresentable {
  var actions: [ContextAction]
  var content: () -> any View
  
  init(actions: [ContextAction] = [], content: @escaping () -> any View) {
    self.actions = actions
    self.content = content
  }
  
  public func makeUIView(context: Context) -> ContextInteractableView {
    let view = ContextInteractableView()
    view.actions = actions
    view.content = content
    
    return view
  }
  
  public func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.actions = actions
    uiView.content = content
  }
}
#endif
