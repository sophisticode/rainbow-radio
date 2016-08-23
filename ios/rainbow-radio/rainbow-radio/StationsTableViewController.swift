//
//  StationsTableViewController.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 11.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class StationsTableViewController: UITableViewController {

    var viewModel: StationsTableViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        viewModel = StationsTableViewModel()
        self.title = viewModel!.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target:viewModel, action: #selector(StationsTableViewModel.didSelectRightBarButton))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "RadioStationCell", bundle:nil), forCellReuseIdentifier: "RadioStationCell")
        viewModel?.reload()
        viewModel?.needsReload.asObservable().subscribe { (element) in
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.numberOfSections())!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.numbersOfRowsInSection(section: section))!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioStationCell", for: indexPath) as! RadioStationCell

        // Configure the cell...
        let item = viewModel?.itemForIndexPath(indexPath: indexPath)
        if item != nil {
            cell.titleLabel?.text = item?.title
            if item?.imageUrl != nil {

                Alamofire.request(item!.imageUrl, withMethod:.get)
                    .validate()
                    .responseData { response in
                        if let data = response.data {
                            cell.symbolImageView?.image = UIImage(data:data)
                        }
                }
            }
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectIndexPath(indexPath: indexPath)
    }
}
