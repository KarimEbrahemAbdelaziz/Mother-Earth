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
                // Traditional way of doing things.. We will use Schedulers later
                DispatchQueue.main.async {
                    self?.categoriesTableView?.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        categories
            .asObservable()
            .bind(to: categoriesTableView.rx.items(cellIdentifier: "categoryCell")) { index, model, cell in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = model.description
            }
            .disposed(by: disposeBag)
        
        startDownload()
    }

    func startDownload() {
        let localCategories = EONETRequestRouter.categories
        localCategories
            .bind(to: categories)
            .disposed(by : disposeBag)
    }
    
}
