import SwiftUI

struct ContextualListItemViewModifier: ViewModifier {
  let actions: [ContextAction]
  
  func body(content: Content) -> some View {
    ViewBoundContextMenu(
      actions: actions,
      content: { AnyView(content) }
    )
    .fixedSize()
  }
}

public extension View {
  func viewBoundContextMenu(actions: () -> [ContextAction]) -> some View {
    self.modifier(ContextualListItemViewModifier(actions: actions()))
  }
}
