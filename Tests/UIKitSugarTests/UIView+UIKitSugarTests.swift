import XCTest

class UIView_UIKitSugarTests: XCTestCase {
  func testFirstSuperviewOfKindWhere() {
    let view = UIView()
    let label2 = UILabel()
    label2.text = "label2"
    let button = UIButton()
    button.backgroundColor = .green
    let scrollview = UIScrollView()
    scrollview.backgroundColor = .green
    let label1 = UILabel()
    label1.text = "label1"
    let leafView = UIView()
    
    view.addSubview(label2)
    label2.addSubview(button)
    button.addSubview(scrollview)
    scrollview.addSubview(label1)
    label1.addSubview(leafView)
    
    let firstLabel = leafView.firstSuperview(ofKind: UILabel.self)
    XCTAssertEqual(firstLabel, label1)
    
    let secondLabel = leafView.firstSuperview(ofKind: UILabel.self) { label -> Bool in
      return label.text == "label2"
    }
    XCTAssertEqual(secondLabel, label2)
    
    let rootView = leafView.firstSuperview(ofKind: UIView.self) { view -> Bool in
      return view.isMember(of: UIView.self)
    }
    XCTAssertEqual(rootView, view)
    
    let greenView = leafView.firstSuperview(ofKind: UIView.self) { view -> Bool in
      return view.backgroundColor == .green
    }
    XCTAssertEqual(greenView, scrollview)
    
    let greenButton = leafView.firstSuperview(ofKind: UIButton.self) { button -> Bool in
      return button.backgroundColor == .green
    }
    XCTAssertEqual(greenButton, button)
    
    let nilResult1 = leafView.firstSuperview(ofKind: UISwitch.self)
    XCTAssertNil(nilResult1)
    
    let nilResult2 = leafView.firstSuperview(ofKind: UILabel.self) { label -> Bool in
      return label.text == "no matching text"
    }
    XCTAssertNil(nilResult2)
  }
}
