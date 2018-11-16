//
//  EventsViewController.swift
//  Mother Earth
//
//  Created by Karim Ebrahem on 11/16/18.
//  Copyright © 2018 KarimEbrahem. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var eventsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell")!
        return cell
    }

}
