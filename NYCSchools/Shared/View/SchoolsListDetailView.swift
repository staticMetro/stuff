//
//  SchoolsListDetailView.swift
//  NYCSchools
//
//  Created by Aimeric Tshibuaya on 6/10/22.
//

import SwiftUI

struct SchoolsListDetailView: View {
    @StateObject var schoolListViewModel1 = SchoolListViewModel()


    var body: some View {
        List(schoolListViewModel1.satResults, id: \.dbn) { item in
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "number.circle")
                        .foregroundColor(.red)
                        .imageScale(.large)
                    Text("# Test Takers: ")
                    Text(item.num_of_sat_test_takers!)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(3)
                HStack {
                    Image(systemName: "book.circle")
                        .foregroundColor(.green)
                        .imageScale(.large)
                    Text("Reading Avg Score: ")
                    Text(item.sat_critical_reading_avg_score!)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(3)
                HStack {
                    Image(systemName: "plusminus.circle")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                    Text("Math Avg Score: ")
                    Text(item.sat_math_avg_score!)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(3)
                HStack {
                    Image(systemName: "pencil.circle")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                    Text("Writing Avg Score: ")
                    Text(item.sat_writing_avg_score!)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(3)
            }
        }.onAppear{
            schoolListViewModel1.fetchSATScores()
        }
    }
}

struct SchoolsListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolsListDetailView()
    }
}
