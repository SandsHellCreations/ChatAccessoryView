//
//  ChatAccessory.swift
//  DynamicAccessoryViewChat
//
//  Created by MAC_MINI_6 on 06/06/18.
//  Copyright © 2018 MAC_MINI_6. All rights reserved.
//

import UIKit
import GrowingTextView
class ChatAccessory: UIView {
  
  @IBOutlet weak var textView: GrowingTextView!  {
    didSet {
      textView.delegate = self
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  //MARK:- for iPhoneX Spacing bottom
  override func didMoveToWindow() {
    super.didMoveToWindow()
    if #available(iOS 11.0, *) {
      if let window = self.window {
        self.bottomAnchor.constraintLessThanOrEqualToSystemSpacingBelow(window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0).isActive = true
      }
    }
  }
  
  @IBAction func btnSendAction(_ sender: Any) {
    
  }
}
//MARK:- GrowingTextView Delegate for dynamic height increase according to text
extension ChatAccessory: GrowingTextViewDelegate {
  func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
    // invalidateIntrinsicContentSize()
    // https://developer.apple.com/documentation/uikit/uiview/1622457-invalidateintrinsiccontentsize
    // to reflect height changes
    textView.invalidateIntrinsicContentSize()
  }
}
//MARK:- ChatAccessory Functions
extension ChatAccessory {
  // Performs the initial setup.
  private func setupView() {
    let view = viewFromNibForClass()
    view.frame = bounds
    view.autoresizingMask = [
      UIViewAutoresizing.flexibleWidth,
      UIViewAutoresizing.flexibleHeight
    ]
    addSubview(view)
    // to dynamically increase height of text view
    // http://ticketmastermobilestudio.com/blog/translating-autoresizing-masks-into-constraints
    //if textView.translatesAutoresizingMaskIntoConstraints = true then height will not increase automatically
    // translatesAutoresizingMaskIntoConstraints default = true
    textView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // Loads a XIB file into a view and returns this view.
  private func viewFromNibForClass() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    return view
  }
}
