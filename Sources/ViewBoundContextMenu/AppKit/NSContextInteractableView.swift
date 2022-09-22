#if os(macOS)
import AppKit
import SwiftUI
import SwiftUIX

public class ContextInteractableView: NSView {
  var actions = [ContextAction]() {
    didSet {
      flattedActions = actions
        .reduce([ContextAction](), { $0 + [$1] + $1.children })
    }
  }
  private var flattedActions = [ContextAction]()
  
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
        $0.asMenuItem(self, #selector(handle(sender:)))
      }
      .forEach(menu.addItem)
    
    NSMenu.popUpContextMenu(menu, with: event, for: self)
  }
  
  @objc func handle(sender: NSMenuItem) {
    flattedActions.first { $0.identifier == sender.identifier?.rawValue }?.action?()
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

private extension ContextAction {
  func asMenuItem(_ target: AnyObject, _ selector: Selector) -> NSMenuItem {
    if children.isEmpty {
      let item = NSMenuItem(title: title, action: selector, keyEquivalent: "")
      item.target = target
      item.identifier = .init(identifier)
      item.image = image
      return item
    } else {
      let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
      let submenu = NSMenu(title: title)
      children
        .map { $0.asMenuItem(target, selector) }
        .forEach(submenu.addItem)
      item.submenu = submenu
      return item
    }
  }
}
#endif
