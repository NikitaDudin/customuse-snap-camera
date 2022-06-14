//
//  SnapCameraManager.swift
//  customuse
//
//  Created by Dmitry Bezrukov on 29.05.2022.
//

import Foundation
import SwiftUI

import SCSDKCameraKit
import SCSDKCameraKitReferenceUI

@objc(SnapCameraManager)
class SnapCameraManager: RCTViewManager {

  // Customuse lenses group ID
  var groupId = "f55a9941-7a60-4bae-a1b8-459b0c877d47"
  var vc: UIHostingController<CameraView>
  var cameraController: CameraController

  public override init() {
    cameraController = CameraController()
    cameraController.groupIDs = [groupId]

    vc = UIHostingController(rootView: CameraView(cameraController: cameraController));
  }

  override func view() -> UIView! {
    return vc.view;
  }

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func applyLens(_ lensId: String,
                 withBase64 base64: String,
                 withHeight height: NSNumber,
                 withWidth width: NSNumber,

                 withWatermarkVisible watermarkVisible: Bool,
                 withWatermarkAlpha watermarkAlpha: NSNumber,

                 withWatermarkBase64 watermarkBase64: String,
                 withWatermarkHeight watermarkHeight: NSNumber,
                 withWatermarkWidth watermarkWidth: NSNumber,

                 withWatermarkTop watermarkTop: NSNumber,
                 withWatermarkRight watermarkRight: NSNumber,
                 withWatermarkBottom watermarkBottom: NSNumber,
                 withWatermarkLeft watermarkLeft: NSNumber) {
    DispatchQueue.main.async {
      let lens = self.cameraController.cameraKit.lenses.repository.lens(
        id: lensId,
        groupID: self.groupId);

      if lens != nil {
        let launchDataBuilder = LensLaunchDataBuilder()
        launchDataBuilder.add(string: base64, key: "texture_string")
        launchDataBuilder.add(number: height, key: "texture_height")
        launchDataBuilder.add(number: width, key: "texture_width")

        if watermarkVisible {
          launchDataBuilder.add(string: watermarkBase64, key: "watermark_string")
          launchDataBuilder.add(number: watermarkHeight, key: "watermark_height")
          launchDataBuilder.add(number: watermarkWidth, key: "watermark_width")

          launchDataBuilder.add(number: watermarkTop, key: "watermark_top")
          launchDataBuilder.add(number: watermarkRight, key: "watermark_right")
          launchDataBuilder.add(number: watermarkBottom, key: "watermark_bottom")
          launchDataBuilder.add(number: watermarkLeft, key: "watermark_left")

          launchDataBuilder.add(number: watermarkAlpha, key: "watermark_alpha")
        }

        self.cameraController.cameraKit.lenses.processor?.apply(
          lens: lens!,
          launchData: launchDataBuilder.launchData);
      }
    }
  }

  @objc
  func startRecording() {
    DispatchQueue.main.async {
      self.cameraController.startRecording();
    }
  }

  @objc
  func finishRecording(_ completion: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      self.cameraController.finishRecording(completion: { url, _ in
        completion([url!.path])
      })
    }
  }

  @objc
  func takePhoto(_ completion: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      self.cameraController.takePhoto(completion: { image, _ in
        let url = URL(fileURLWithPath: "\(NSTemporaryDirectory())\(UUID().uuidString).png")
        if let data = image!.pngData() {
          try? data.write(to: url)
          completion([url.path])
        } else {
          completion([])
        }
      })
    }
  }

  @objc
  func getLenses(_ completion: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      let groupLenses = self.cameraController.cameraKit.lenses.repository.lenses(groupID: self.groupId);
      let lenses = groupLenses.map {
        ["lensId": $0.id,
         "lensUUID": $0.vendorData["lensUUID"],
         "templateCode": $0.vendorData["templateCode"]]
      }
      completion([lenses])
    }
  }
}
