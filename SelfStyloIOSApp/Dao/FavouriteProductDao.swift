//
//  FavouriteProductDao.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 12/01/23.
//

import Foundation
import SQLite3
  
class FavouriteProductDao
{
    init()
    {
        db = openDatabase()
        createTable()
    }
  
  
    let dbPath: String = "selfstylo_app.sqlite"
    var db:OpaquePointer?
  
  
    func openDatabase() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            debugPrint("can't open database")
            return nil
        }
        else
        {
            print("Successfully created connection to database at \(dbPath)")
            return db
        }
    }
      
    func createTable() {
            let createTableString = "CREATE TABLE IF NOT EXISTS favourite_products(product_id INTEGER NOT NULL,sub_category_name TEXT,category_name TEXT,color_name TEXT,color_code TEXT,brand_name TEXT,brand_logo TEXT,PRIMARY KEY(product_id));"
            var createTableStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
            {
                if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("login table created.")
                } else {
                    print("login table could not be created.")
                }
            } else {
                print("CREATE TABLE statement could not be prepared.")
            }
            sqlite3_finalize(createTableStatement)
        }
    
    
      
      
    func insert(userList: FavouriteProducts)
    {
        let insertStatementString = "INSERT INTO favourite_products (product_id,sub_category_name,category_name,color_name,color_code,brand_name,brand_logo) VALUES (?,?,?,?,?,?,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(userList.product_id))
            sqlite3_bind_text(insertStatement, 2, (userList.subCategoryName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (userList.categoryName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (userList.colorName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (userList.colorCode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (userList.brandName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (userList.brandLogoUrl as NSString).utf8String, -1, nil)
              
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
      
    func getAll() -> [FavouriteProducts] {
           let queryStatementString = "SELECT * FROM favourite_products;"
           var queryStatement: OpaquePointer? = nil
           var favourite_product : [FavouriteProducts] = []
           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = sqlite3_column_int(queryStatement, 0)
                   let sub_category_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let category_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 2)))
                   let color_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 3)))
                   let color_code = String(describing: String(cString: sqlite3_column_text(queryStatement!, 4)))
                   let brand_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 5)))
                   let brand_logo = String(describing: String(cString: sqlite3_column_text(queryStatement!, 6)))
                   favourite_product.append(FavouriteProducts(product_id: Int(id), subCategoryName: sub_category_name, categoryName: category_name, colorName: color_name, colorCode: color_code, brandName: brand_name, brandLogoUrl: brand_logo))
                   
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return favourite_product
       }
    
    func getAll(limit:Int) -> [FavouriteProducts] {
           let queryStatementString = "SELECT * FROM favourite_products LIMIT \(limit);"
           var queryStatement: OpaquePointer? = nil
           var favourite_product : [FavouriteProducts] = []
           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = sqlite3_column_int(queryStatement, 0)
                   let sub_category_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let category_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 2)))
                   let color_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 3)))
                   let color_code = String(describing: String(cString: sqlite3_column_text(queryStatement!, 4)))
                   let brand_name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 5)))
                   let brand_logo = String(describing: String(cString: sqlite3_column_text(queryStatement!, 6)))
                   favourite_product.append(FavouriteProducts(product_id: Int(id), subCategoryName: sub_category_name, categoryName: category_name, colorName: color_name, colorCode: color_code, brandName: brand_name, brandLogoUrl: brand_logo))
                   
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return favourite_product
       }
    
      
    func deleteAll() {
        let deleteStatementStirng = "DELETE FROM favourite_products;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
      
}
