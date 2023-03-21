//
//  ImageGenerationViewModel_Test.swift
//  HelloWorld_Tests
//
//  Created by Bhavana Kumar on 17.03.23.
//

import XCTest
@testable import HelloWorld

class ImageGenerationViewModel_Tests: XCTestCase {
    
    var imageGenerationViewModelInstance: ImageGenerationViewModel!
    
    @MainActor override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        imageGenerationViewModelInstance = ImageGenerationViewModel(imageGenerationServiceInstance: MockImageGenerationService());
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        imageGenerationViewModelInstance = nil
    }
    
    @MainActor func generateImage_HappyScenario() async {
        print("i gve up")
        let promptText: String = "some text"
        await imageGenerationViewModelInstance.sendRequest(prompText: promptText);
        XCTAssertFalse(imageGenerationViewModelInstance.isWorking, "BAD URL")
    }
}
