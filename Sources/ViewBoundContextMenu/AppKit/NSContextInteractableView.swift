#if os(macOS)
import AppKit
import SwiftUI
import SwiftUIX

public class ContextInteractableView: NSView {
  var actions = [ContextAction]()
  
  var content: (() -> any View)? {
    didSet {
      configureHostingView()
    }
  }
  
  private var hostingView: NSHostingView<AnyView>?
  
  public override var intrinsicContentSize: NSSize {
    hostingView?.intrinsicContentSize ?? .zero
  }
  
  public override func rightMouseDown(with event: NSEvent) {
    let menu = NSMenu(title: "")
    
    actions
      .map {
        let item = NSMenuItem(title: $0.title, action: #selector(handle(sender:)), keyEquivalent: "")
        item.target = self
        item.identifier = .init($0.identifier)
        item.image = $0.image
        return item
      }
      .forEach(menu.addItem)
    
    NSMenu.popUpContextMenu(menu, with: event, for: self)
  }
  
  @objc func handle(sender: NSMenuItem) {
    actions.first { $0.identifier == sender.identifier?.rawValue }?.action()
  }
}

private extension ContextInteractableView {
  func configureHostingView() {
    if let content = content?() {
      if hostingView == nil {
        hostingView = NSHostingView(rootView: AnyView(content))
        
        addSubview(hostingView!)
        
        hostingView!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          hostingView!.leadingAnchor.constraint(equalTo: leadingAnchor),
          hostingView!.trailingAnchor.constraint(equalTo: trailingAnchor),
          hostingView!.topAnchor.constraint(equalTo: topAnchor),
          hostingView!.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
      } else {
        hostingView?.rootView = AnyView(content)
      }
    } else {
      hostingView?.removeFromSuperview()
      hostingView = nil
    }
  }
}
#endif
