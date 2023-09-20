//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Arystan on 11.09.2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {
    
    private var sut: CalculatorVM!
    private var cancellable: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        logoViewTapSubject = .init()
        audioPlayerService = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        cancellable = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellable = nil
        audioPlayerService = nil
        logoViewTapSubject = nil
    }
    
    func testResultWithoutTipFor1Person() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    func testResultWithoutTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }

    func testResultWithCustomTipFor2Person() {
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 20)
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 60)
            XCTAssertEqual(result.totalBill, 120)
            XCTAssertEqual(result.totalTip, 20)
        }.store(in: &cancellable)
    }
    
    func testResultWith10PercentTipFor1Person() {
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(bill: bill, tip: tip, split: split)
        let output = sut.transform(input: input)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellable)
    }

    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
        // given
        let input = buildInput(bill: 90, tip: .fifteenPercent, split: 1)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        // then
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellable)
        // when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
}

class MockAudioPlayerService: AudioPlayerService {
    var expectation = XCTestExpectation(description: "audioplayer is played")

    func playSound() {
        expectation.fulfill()
    }
}
