#if canImport(UIKit)
import UIKit
import SwiftUI
import SwiftUIX

public class ContextInteractableView: UIView {
  var actions = [ContextAction]()
  
  var content: (() -> any View)? {
    didSet {
      configureHostingView()
    }
  }
  
  private var hostingView: UIHostingView<AnyView>?
  
  init() {
    super.init(frame: .zero)
    addInteraction(UIContextMenuInteraction(delegate: self))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override var intrinsicContentSize: CGSize {
    hostingView?.intrinsicContentSize ?? .zero
  }
  
  public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
    hostingView?.sizeThatFits(targetSize) ?? .zero
  }
  
  public override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    hostingView?.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority) ?? .zero
  }
  
  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    hostingView?.sizeThatFits(size) ?? .zero
  }
}

private extension ContextInteractableView {
  func configureHostingView() {
    if let content = content?() {
      if hostingView == nil {
        hostingView = UIHostingView(rootView: AnyView(content))
        
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

extension ContextInteractableView: UIContextMenuInteractionDelegate {
  public func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
    .init(
      identifier: nil,
      previewProvider: nil
    ) { [weak self] _ in
      guard let self = self else { return nil }
      return UIMenu(
        title: "",
        children: self.actions.map(\.asMenuElement)
      )
    }
  }
}

private extension ContextAction {
  var asMenuElement: UIMenuElement {
    if children.isEmpty {
      return UIAction(
        title: title,
        image: image,
        identifier: .init(identifier)
      ) { _ in
        action?()
      }
    } else {
      return UIMenu(
        title: title,
        image: image,
        identifier: .init(identifier),
        children: children.map(\.asMenuElement)
      )
    }
  }
}
#endif
