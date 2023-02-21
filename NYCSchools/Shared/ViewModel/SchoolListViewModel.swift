//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by Aimeric Tshibuaya on 6/9/22.
//

import Foundation

protocol SchoolListViewControllerDelegate: AnyObject {
    func fetchSchoolListSuccess(_ failedError: Error?)
    func fetchSATSuccess(_ failedError: Error?)
}

class SchoolListViewModel: ObservableObject {
    @Published var schools: [School] = []
    @Published var satResults: [SATScore] = []

    let schoolsDataManager = SchoolsDataManager()
    weak var schoolsListViewControllerDelegate: SchoolListViewControllerDelegate?

    
    func fetchSchools(){
        schoolsDataManager.fetchData(urlString: APIURLS.fetchSchoolsLink) { (resultData, fetchError) in
            if let error = fetchError{
                self.schoolsListViewControllerDelegate?.fetchSchoolListSuccess(error)
            }else {
                do{
                    let schoolsList = try JSONDecoder().decode([School].self, from: resultData as! Data)
                    DispatchQueue.main.async{
                        self.schools = schoolsList

                        self.fetchSATScores()
                    }
                    //self.mapSATScores(self.satResults)
                }catch{
                    self.schoolsListViewControllerDelegate?.fetchSchoolListSuccess(error)
                    }
            }

        }
    }

   func fetchSATScores(){
       schoolsDataManager.fetchData(urlString: APIURLS.fetchSATScoresLink) { (resultData, fetchError) in
           if let error = fetchError{
               self.schoolsListViewControllerDelegate?.fetchSATSuccess(error)
           }else {
               do{
                   let satScores = try JSONDecoder().decode([SATScore].self, from: resultData as! Data)
                   DispatchQueue.main.async{
                       self.satResults = satScores
                   }
                   //self.mapSATScores(satScores)
                   self.schoolsListViewControllerDelegate?.fetchSATSuccess(fetchError)
               }catch{
                   self.schoolsListViewControllerDelegate?.fetchSATSuccess(error)
                   }
           }
       }
   }

    func mapSATScores(_ satScoresList: [SATScore]){
        let previous = self.schools
        self.schools.removeAll()

        for satScore in satScoresList {
            if let dbn = satScore.dbn{
                let matchSchool = previous.first(where: { (School) -> Bool in
                    return School.dbn == dbn
                })
                guard matchSchool != nil else{
                    continue
                }
            }
        }
    }

}
