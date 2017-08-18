
//  swift_earlgrey_bootcampTests.swift
//  swift-earlgrey-bootcampTests
//
//  Created by Pivotal on 2017-05-08.
//
//

import XCTest
import EarlGrey
import OHHTTPStubs

@testable import swift_earlgrey_bootcamp

class swift_earlgrey_bootcampTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        stub(condition: isHost("api.openweathermap.org")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("data.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testHomeUIPresence()
    {
        // check for visibility of the home button
        EarlGrey.select(elementWithMatcher: grey_accessibilityTrait(UIAccessibilityTraitHeader))
            .assert(with: grey_sufficientlyVisible())
        
        // check for visibility of Step 1
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 1"))
            .assert(with: grey_sufficientlyVisible())
        
        // check for visibility of Step 2
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 2"))
            .assert(with: grey_sufficientlyVisible())
        
        // check for visibility of Step 3
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 3"))
            .assert(with: grey_sufficientlyVisible())
        
        // scroll to the bottom of the screen
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 3"))
            .perform(grey_swipeFastInDirection(GREYDirection.up))
        
        // check for visibility of Step 4
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 4"))
            .assert(with: grey_sufficientlyVisible())
        
        // scroll back to the top of the screen
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 3"))
            .perform(grey_swipeFastInDirection(GREYDirection.down))

    }
    
    func testStep_a_One()
    {
        // click on step 1
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 1"))
            .perform(grey_tap())
        
        // check for visibility of label
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("This is a label"))
            .assert(with: grey_sufficientlyVisible())
        
        // check for visibility of text field
        EarlGrey.select(elementWithMatcher: grey_accessibilityValue("This is a text field"))
            .assert(with: grey_sufficientlyVisible())
        
        // enter text in the text field
        EarlGrey.select(elementWithMatcher: grey_accessibilityValue("This is a text field"))
            .perform(grey_replaceText("Hello World"))
        
        // check for visibility of the button
        EarlGrey.select(elementWithMatcher: grey_buttonTitle("This is a button"))
            .assert(with: grey_sufficientlyVisible())
        
        // click on the button
        EarlGrey.select(elementWithMatcher: grey_buttonTitle("This is a button"))
            .perform(grey_tap())
        
        // check for the new label text
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Button pressed"))
            .assert(with: grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityTrait(UIAccessibilityTraitButton),
                                                        grey_accessibilityLabel("Home"), grey_sufficientlyVisible()]))
            .perform(grey_tap())
    }
    
    func testStep_b_Two()
    {
        // click on step 2
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 2"))
            .perform(grey_tap())
        
        
    
        
        // check for visibility of 100
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("100"))
            .using(searchAction: grey_swipeFastInDirection(GREYDirection.up),
            onElementWithMatcher: grey_kindOfClass(UITableView.self))
                .perform(grey_tap())
        
        // click on home button
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityTrait(UIAccessibilityTraitButton),
                                                        grey_accessibilityLabel("Home"), grey_sufficientlyVisible()]))
            .perform(grey_tap())
  

    }
    
    func testStep_c_Three()
    {
        // click on step 3
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 3"))
            .perform(grey_tap())
        
        // click on home button



        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITableView.self))
            .perform(grey_tap())

        EarlGrey.select(elementWithMatcher: grey_descendant(grey_kindOfClass(UITableView.self))).atIndex(0)
            .perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: grey_text("Temperature: 697.77 K"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text("Pressure: 505.0 hPa"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text("Humidity: 40.0 %"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityTrait(UIAccessibilityTraitButton),
                                                        grey_accessibilityLabel("Home"), grey_sufficientlyVisible()]))
            .perform(grey_tap())
    }
    
    func testStep_d_Four()
    {
        // scroll to the bottom of the screen
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 3"))
            .perform(grey_swipeFastInDirection(GREYDirection.up))
        
        // click on step 4
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Step 4"))
            .perform(grey_tap())
        
        var error: NSError?
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Select Button")).assert(grey_notNil(), error: &error)
        
       repeat {
            EarlGrey.select(elementWithMatcher: grey_buttonTitle("Button")).perform(grey_tap())
            EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Select Button")).assert(grey_notNil(), error: &error)
        } while(error == nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, YYYY, kk:mm"
        
        EarlGrey.select(elementWithMatcher: grey_text(dateFormatter.string(from: Date()))).assert(with: grey_sufficientlyVisible())

        // click on home button
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityTrait(UIAccessibilityTraitButton),
                                                        grey_accessibilityLabel("Home"), grey_sufficientlyVisible()]))
            .perform(grey_tap())
    }
    
    
}
