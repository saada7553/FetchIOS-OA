//
//  ListViewModel.swift
//  FetchApp (iOS)
//
//  Created by Saad Ata on 2/19/23.
//

import Foundation


class ListViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    @Published var nullStringRemoved: [ItemModel] =  []
    var allItems: [ItemModel] = []
    
    
    // MARK: FUNCTIONS
    init(){
        downloadData() // Get data from API
    }
    
    /// Goes to the API URL and downloads the data safely, creates the ItemModel objects and stores them in the allItems list
    func downloadData(){
        
        guard let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json") else { return } // Make sure URL is valid
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data, // Make sure we got data
                error == nil, // Confirm there was no error
                let response = response as? HTTPURLResponse, // Check if the response was positive
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error Downloading Data")
                return
            }
            guard let items = try? JSONDecoder().decode([ItemModel].self, from: data) else { return } // Decode JSON data into a list of objects
            DispatchQueue.main.async {[weak self] in
                self?.allItems = items // Update list
            }
        }.resume()
        
    }
    
    
    /// Appends all ItemModels  to a new list which have a name. This is since we want to excluse items with no name or a nil string entry.
    func removeNullNames(){
        nullStringRemoved = [] // This is needed if the user presses the fetch button multiple times to make sure there are no repeated entries
        
        for item in allItems{
            if item.name != "" && item.name != nil { // If the item has a name
                self.nullStringRemoved.append(item) // Add item to the list where all items have a name
            }
        }
    }
    
    
    /// Sorts the nullStringRemoved list by first comparing the listIds and then comparing the names
    func sort() {
        nullStringRemoved.sort{
            
            /*
             The following 4 let statements are to make the name comparable. While we can directly compare the names, it is not
             practical since comparing strings results in alphabetical sorting. The instructions called for the items to be sorted by
             their names. However, if we just used string comparasitions, the name "Item 110" would appear before "Item 12" because
             each charachter is evaluated one at a time unline integer comparasions. Therefore, we need to convert the numerical
             portion of the name into an integer for correct sorting.
             
             Additionally, note that because the name attribute is optional in the original struct, we need to add ?? ["", "0"] to
             the new lists since the complies assumes that there may be an item without a name. We know that all items in this
             nullStringsRemoves have a name because we ran a function which removes items with null names, but the compiles does not
             know this.
             */
            let nameLst: [String] = $0.name?.components(separatedBy: " ") ?? ["","0"] // Split first item name into a list
            let numericalName: Int = Int(nameLst[1]) ?? 0 // Access the numerical part of the name and store it in an integer
            
            let nameLst2: [String] = $1.name?.components(separatedBy: " ") ?? ["","0"] // Split the second item into a list
            let numericalName2: Int = Int(nameLst2[1]) ?? 0 // Access the numerical part of the name and store it in an integer
            
            return ($0.listId, numericalName) < ($1.listId, numericalName2) // Compare the listId first, followed by the numerical part of the name, return a Bool
        }
    }
}
