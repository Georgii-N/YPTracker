import Foundation

protocol TrackersViewControllerProtocol: AnyObject {
    
    var presenter: TrackersPresenterProtocol? { get set }
    
    func updateCollectionView()
    func trackerIsCompleted(_ cell: TrackersCollectionViewCell)
    func checkAndSetupStub()
    func checkAndSetupStubAfterSearch()
}

