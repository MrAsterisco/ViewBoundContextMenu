#if os(macOS)
import SwiftUI
import AppKit

public struct ViewBoundContextMenu: NSViewRepresentable {
  var actions: [ContextAction]
  var content: () -> any View
  
  init(actions: [ContextAction] = [], content: @escaping () -> any View) {
    self.actions = actions
    self.content = content
  }
  
  public func makeNSView(context: Context) -> ContextInteractableView {
    let view = ContextInteractableView()
    view.actions = actions
    view.content = content
    
    return view
  }
  
  public func updateNSView(_ nsView: NSViewType, context: Context) {
    nsView.actions = actions
    nsView.content = content
  }
}
#endif
