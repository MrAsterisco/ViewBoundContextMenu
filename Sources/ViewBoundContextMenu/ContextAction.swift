//
//  File.swift
//  
//
//  Created by Alessio Moiso on 21.09.22.
//

#if canImport(UIKit)
import UIKit
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PlatformImage = NSImage
#endif

public struct ContextAction {
  let identifier: String
  let title: String
  let image: PlatformImage?
  let action: () -> ()
  
  public init(identifier: String, title: String, image: PlatformImage? = nil, action: @escaping () -> ()) {
    self.identifier = identifier
    self.title = title
    self.image = image
    self.action = action
  }
}
