//
//  HelloWorld_Tests.swift
//  HelloWorld_Tests
//
//  Created by Bhavana Kumar on 16.03.23.
//

import XCTest
@testable import HelloWorld

final class IGViewModel_Tests: XCTestCase {
    var imageGenerationViewModelInstance: ImageGenerationViewModel!
    @MainActor override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        imageGenerationViewModelInstance = ImageGenerationViewModel(imageGenerationServiceInstance: MockImageGenerationService());
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageGenerationViewModelInstance = nil
    }

    @MainActor func sendRequest_HappyPath() async throws  {
        let promptText: String = "some text"
        await imageGenerationViewModelInstance.sendRequest(prompText: promptText);
        XCTAssertFalse(imageGenerationViewModelInstance.isWorking)
    }
    
    @MainActor func sendRequest_ThrowsError() async throws  {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let promptText: String = "badURL"
        await imageGenerationViewModelInstance.sendRequest(prompText: promptText)
        XCTAssertEqual(imageGenerationViewModelInstance.alertMessage, "BAD URL")
        XCTAssertTrue(imageGenerationViewModelInstance.showAlert)
    }

    
}
