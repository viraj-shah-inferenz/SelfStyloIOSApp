//
//  BannerDao.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 17/01/23.
//

import Foundation
import SQLite3
  
class BannerDao
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
            let createTableString = "CREATE TABLE IF NOT EXISTS  banner(id INTEGER NOT NULL,upload_image TEXT,is_active BOOLEAN,PRIMARY KEY(id));"
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
    
    
      
      
    func insert(userList: Banner)
    {
        let insertStatementString = "INSERT INTO patron (id,upload_image,is_active) VALUES (?,?,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(userList.id))
            sqlite3_bind_text(insertStatement, 2, (userList.upload_image as NSString).utf8String, -1, nil)
            var is_active: Int    //FIXME: Vars are trouble
            if userList.is_active { is_active = 1 }
                else { is_active = 0 }
            sqlite3_bind_int(insertStatement, 3, Int32(is_active))
              
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
      
    func getAll() -> [Banner] {
           let queryStatementString = "SELECT * FROM banner;"
           var queryStatement: OpaquePointer? = nil
           var banner : [Banner] = []
           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = sqlite3_column_int(queryStatement, 0)
                   let upload_image = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let is_active = sqlite3_column_int(queryStatement, 2)
                   banner.append(Banner(id: Int(id), upload_image: upload_image, is_active: (is_active != 0)))
                   
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return banner
       }
    
   
      
    func deleteAll() {
        let deleteStatementStirng = "DELETE FROM banner;"
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

