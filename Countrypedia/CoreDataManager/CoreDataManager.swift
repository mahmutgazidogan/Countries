//
//  CoreDataManager.swift
//  Countrypedia
//
//  Created by Mahmut Doğan on 15.11.2024.
//


import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Adding to favorites
    func addToFavorites(name: String, flag: String) {
        let favorite = FavoriteCountry(context: context)
        favorite.name = name
        favorite.flag = flag
        
        save()
        let count = getFavoriteCount()
        print("\(name) saved to favorites. Favorites count: \(count)")
    }
    
    // Removing from favorites
    func removeFromFavorites(name: String) {
        let fetchRequest: NSFetchRequest<FavoriteCountry> = FavoriteCountry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriteToRemove = results.first {
                context.delete(favoriteToRemove)
                save()
                let count = getFavoriteCount()
                print("\(name) removed from favorites. Favorites count: \(count)")
            }
        } catch {
            print("Removing favorite failed: \(error)")
        }
    }
    
    // Favorite status checking
    func checkFavoriteStatus(for countries: [Country]) -> [Country] {
        // Get favorite countries from Core Data
        let favoriteCountries = getAllFavorites()
        
        // Update all countries coming from API
        return countries.map { country in
            var updatedCountry = country
            
            // Eğer ülke Core Data'da varsa favorili olarak işaretle
            // If Core Data contains the country, mark that country as favorite
            
            updatedCountry.isFavorited = favoriteCountries.contains(where: {
                $0.name == country.name?.common
            })
            return updatedCountry
        }
    }
    
    // Get All Favorite Items
    func getAllFavorites() -> [FavoriteCountry] {
        let fetchRequest: NSFetchRequest<FavoriteCountry> = FavoriteCountry.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    //TODO: Favori sayısını badge olarak tabbarda favori kısmında göster
    func getFavoriteCount() -> Int {
        let fetchRequest: NSFetchRequest<FavoriteCountry> = FavoriteCountry.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print("Core Data count error: \(error)")
            return 0
        }
    }
    
    // Clear Core Data
    func clearEntityData() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "FavoriteCountry"))
        
        do {
            try context.execute(deleteRequest)
            save()
        } catch {
            print("Core Data clearing error: \(error)")
        }
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Saving error: \(error)")
            }
        }
    }
}
