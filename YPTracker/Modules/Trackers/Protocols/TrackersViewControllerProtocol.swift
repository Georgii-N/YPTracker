import Foundation

protocol TrackersViewControllerProtocol: AnyObject {
    
    var presenter: TrackersPresenterProtocol? { get set }
    
    func showActualTrackers()
    func showTrackerIsCompled(_ cell: TrackersCollectionViewCell)
    func showStub(after filter: TypeOfStub)
    
    func hideStub()
}

