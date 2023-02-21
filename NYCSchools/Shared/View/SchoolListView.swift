//
//  ContentView.swift
//  Shared
//
//  Created by Aimeric Tshibuaya on 6/9/22.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject var schoolListViewModel = SchoolListViewModel()

    var body: some View {
        NavigationView {
            List (schoolListViewModel.schools, id: \.dbn){ School in
                NavigationLink(destination: SchoolsListDetailView(),label: {
                    VStack (alignment: .leading) {
                        Text(School.school_name!)
                            .font(.system(size: 14))
                    }
                })
            }
            .navigationTitle("NYC Schools")
            .onAppear{
                schoolListViewModel.fetchSchools()
                //schoolListViewModel.fetchSATScores()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}


