//
//  PinBoardViewController.swift
//  MEValleyPins
//
//  Created by Mohamed Mostafa on 7/16/19.
//  Copyright © 2019 Elwan. All rights reserved.
//

import UIKit

class PinBoardViewController: UIViewController {
    
    // MARK:- Constants
    struct Constants {
        static let pinCellName = "PinCollectionViewCell"
    }
    
    // MARK:- Properties
    var pinsService: PinsFetcher!
    var pinsDataLoadState = PaginatedDataLoadState<Pin>.notLoaded {
        didSet {
            Dispatch.onMainThread {
                self.pinsCollectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PinBoardViewController.loadPins), for: .valueChanged)
        return refreshControl
    } ()
    
    // MARK: Outlets
    @IBOutlet var pinsCollectionView: UICollectionView!
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        pinsService = PinService()
        registerCollectionViewCells()
        addRefreshControlToCollectionView()
        loadPins()
    }
    
    // MARK:- Methods
    // MARK: Public Methods
    // MARK: Private Methods
    fileprivate func registerCollectionViewCells() {
        let pinCellNib = UINib(nibName: Constants.pinCellName, bundle: Bundle.main)
        self.pinsCollectionView.register(pinCellNib, forCellWithReuseIdentifier: Constants.pinCellName)
    }
    
    @objc fileprivate func loadPins() {
        pinsDataLoadState = .loading
        loadPinsNextPage()
    }
    
    fileprivate func addRefreshControlToCollectionView() {
        pinsCollectionView.addSubview(refreshControl)
    }
    
    fileprivate func loadPinsNextPage() {
        let nextPage = pinsDataLoadState.nextPage
        pinsService.getPins(page: nextPage) {[weak self] (pins, error) in
            guard error == nil else { return }
            guard let `self` = self else { return }
            let newPins = pins ?? []
            let newToBeAddedPins = newPins.filter{ !Set(self.pinsDataLoadState.data.compactMap{$0.id}).contains($0.id) }
            self.pinsDataLoadState = .paging(newToBeAddedPins + self.pinsDataLoadState.data, nextPage: nextPage+1)
        }
    }
    
    // MARK: Actions
    
}

// MARK:- UIViewController
extension PinBoardViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinsDataLoadState.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.pinCellName, for: indexPath) as! PinCollectionViewCell
        cell.configure(pin: pinsDataLoadState.data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
        }
        return CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
    
}
