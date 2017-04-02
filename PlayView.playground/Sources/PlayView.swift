/**
 *  PlayView
 *  Copyright (c) Agisilaos Tsaraboulidis 2017
 *  Licensed under the MIT license. See LICENSE file.
 */
import UIKit
import PlaygroundSupport

public enum NavBarVisibility {
  case viewControllerOnly
  case withNavigationViewController(isUnderTopBar: Bool)
}

public enum ScreenType : String {
  case phone3_5 = "iPhone 3.5 inch screen"
  case phone4 = "iPhone 4 inch screen"
  case phone4_7 = "iPhone 4.7 inch screen"
  case phone5_5 = "iPhone 5.5 inch screen"
  case ipad = "iPad screen"
  case ipad_12_9 = "iPad Pro screen"
  case tv = "TV screen"
  
  public func size(isPortrait: Bool = true) -> CGSize {
    var scsize: CGSize
    switch self {
    case .phone3_5:
      scsize = CGSize(width: 320, height: 480)
    case .phone4:
      scsize = CGSize(width: 320, height: 568)
    case .phone4_7:
      scsize = CGSize(width: 375, height: 667)
    case .phone5_5:
      scsize = CGSize(width: 414, height: 736)
    case .ipad:
      scsize = CGSize(width: 768, height: 1024)
    case .ipad_12_9:
      scsize = CGSize(width: 1024, height: 1366)
    case .tv:
      scsize = CGSize(width: 1980, height: 1020)
    }
    if !isPortrait, self != .tv {
      return CGSize(width: scsize.height, height: scsize.width)
    }
    return scsize
  }
  
  public func rect(isPortrait: Bool = true) -> CGRect {
    return CGRect(origin: .zero, size: self.size(isPortrait: isPortrait))
  }
}

extension UIViewController {
  
  public convenience init(screenType: ScreenType, isPortrait: Bool = true, NavbarVisibility: NavBarVisibility = .viewControllerOnly) {
    self.init(nibName: nil, bundle: nil)
    
    let size = screenType.size(isPortrait: isPortrait)
    let rect = screenType.rect(isPortrait: isPortrait)
    self.view.frame = rect
    view.backgroundColor = .white
    let w = UIWindow(frame: rect)
    switch NavbarVisibility {
    case .viewControllerOnly:
      w.rootViewController = self
      preferredContentSize = size
      PlaygroundPage.current.liveView = self.view
    case .withNavigationViewController(let isUnderTopBar):
      let nc = UINavigationController(rootViewController: self)
      nc.view.frame = rect
      w.rootViewController = nc
      if !isUnderTopBar { edgesForExtendedLayout = [] }
      PlaygroundPage.current.liveView = nc.view
    }
  }
}

