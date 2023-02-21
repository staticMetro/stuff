//
//  SchoolsViewController.swift
//  NYCSchools
//
//  Created by Aimeric Tshibuaya on 6/9/22.
//

import Foundation
import UIKit

class SchoolListViewController: UIViewController {
    //Function to throw alert.
    func displayAlert(_ error: Error) {

        DispatchQueue.main.async{
            self.dismiss(animated: false) {
                OperationQueue.main.addOperation {
                    print("Error while fetching Schools.")
                    print(error.localizedDescription)

                    let alert = UIAlertController(title: "Error while fetching details.", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        print("Error while fetching details.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
 

}
extension SchoolListViewController: SchoolListViewControllerDelegate {

    func fetchSchoolListSuccess(_ failedError: Error?){

        if let error = failedError {
            self.displayAlert(error)
        }
    }

    func fetchSATSuccess(_ failedError: Error?){
        if let error = failedError {
            self.displayAlert(error)
        }
    }
}
