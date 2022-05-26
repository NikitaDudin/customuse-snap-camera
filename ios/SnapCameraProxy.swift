import SwiftUI

@objcMembers class SnapCameraProxy: NSObject {
  private var vc = UIHostingController(rootView: SnapCamera())

  static let storage = NSMutableDictionary()

  var groupId: String {
    set { vc.rootView.props.groupId = newValue }
    get { return vc.rootView.props.groupId }
  }

  var lensId: String {
    set { vc.rootView.props.lensId = newValue }
    get { return vc.rootView.props.lensId }
  }

  var textureString: String {
    set { vc.rootView.props.textureString = newValue }
    get { return vc.rootView.props.textureString }
  }

  var textureHeight: Int {
    set { vc.rootView.props.textureHeight = newValue }
    get { return vc.rootView.props.textureHeight }
  }

  var textureWidth: Int {
    set { vc.rootView.props.textureWidth = newValue }
    get { return vc.rootView.props.textureWidth }
  }

  var count: Int {
    set { vc.rootView.props.count = newValue }
    get { return vc.rootView.props.count }
  }

  var onCountChange: RCTBubblingEventBlock {
    set { vc.rootView.props.onCountChange = newValue }
    get { return vc.rootView.props.onCountChange }
  }

  var view: UIView {
    return vc.view
  }
}
