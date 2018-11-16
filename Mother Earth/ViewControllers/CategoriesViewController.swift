//
//  CategoriesViewController.swift
//  Mother Earth
//
//  Created by Karim Ebrahem on 11/16/18.
//  Copyright © 2018 KarimEbrahem. All rights reserved.
//

import UIKit
import RxSwift

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    let categories = Variable<[Category]>([])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.categoriesTableView?.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        categories
            .asObservable()
            .bind(to: categoriesTableView.rx.items(cellIdentifier: "categoryCell")) { index, model, cell in
                cell.textLabel?.text = "\(model.name) (\(model.events.count))"
                cell.accessoryType = (model.events.count > 0) ? .disclosureIndicator
                    : .none
            }
            .disposed(by: disposeBag)
        
        startDownload()
    }

    func startDownload() {
        let localCategories = EONETRequestRouter.categories
        let downloadedEvents = EONETRequestRouter.events(forLast: 360)
        let updatedCategories =
            Observable
                .combineLatest(localCategories, downloadedEvents) { (categories, events) -> [Category] in
                    return categories.map { category in
                        var cat = category
                        cat.events = events.filter {
                            $0.categories.contains(category.id)
                        }
                        return cat
                    }
        }
        localCategories
            .concat(updatedCategories)
            .bind(to: categories)
            .disposed(by: disposeBag)
    }
    
}
