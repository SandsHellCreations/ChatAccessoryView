//
//  ChatTable.swift
//  DynamicAccessoryViewChat
//
//  Created by MAC_MINI_6 on 06/06/18.
//  Copyright © 2018 MAC_MINI_6. All rights reserved.
//

import UIKit

class ChatTable: UITableView {
  
  lazy var inputAccessory: ChatAccessory = {
    let rect = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: 144)
    let inputAccessory = ChatAccessory(frame: rect)
    return inputAccessory
  }()

  override var inputAccessoryView: UIView? {
    return inputAccessory
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override func awakeFromNib() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector:  #selector(keyboardWillShow(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      self.contentInset.bottom = keyboardHeight
      if keyboardHeight > 100 {
        scrollToBottom()
      }
    }
  }
  
  @objc func keyboardWillHide(_ notification: NSNotification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      self.contentInset.bottom = keyboardHeight
    }
  }
}
//MARK:- Scroll to bottom function
extension UITableView {
  func scrollToBottom(animated: Bool = true, scrollPostion: UITableViewScrollPosition = .bottom) {
    let no = self.numberOfRows(inSection: 0)
    if no > 0 {
      let index = IndexPath(row: no - 1, section: 0)
      scrollToRow(at: index, at: scrollPostion, animated: animated)
    }
  }
}
