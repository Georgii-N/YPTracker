import XCTest
import SnapshotTesting
@testable import YPTracker

final class YPTrackerTests: XCTestCase {

    func testMainVCLight() {
        let vc = TrackersViewController()
        assertSnapshots(matching: vc, as: [.image(traits: .init(userInterfaceStyle: .light))], record: false)
    }
    
    func testMainVCDark() {
        let vc = TrackersViewController()
        assertSnapshots(matching: vc, as: [.image(traits: .init(userInterfaceStyle: .dark))], record: false)
    }
}
