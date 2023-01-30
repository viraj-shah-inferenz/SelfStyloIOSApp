//
//  PatronDao.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 13/01/23.
//

import Foundation
import SQLite3
  
class PatronDao
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
            let createTableString = "CREATE TABLE IF NOT EXISTS patron(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,contact_number NUMERIC,name TEXT,gender TEXT,profile_photo TEXT,uuid TEXT);"
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
    
    
      
      
    func insert(userList: Patron)
    {
        let insertStatementString = "INSERT INTO patron (id,email,contact_number,name,gender,profile_photo,uuid) VALUES (?,?,?,?,?,?,?);"
        var insertStatement: OpaquePointer? = nil
        var isEmpty = false
                if getAll().isEmpty {
                    isEmpty = true
                }
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            if isEmpty{
                sqlite3_bind_int(insertStatement, 1, Int32(userList.id))
            }
            sqlite3_bind_text(insertStatement, 2, (userList.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (userList.phoneNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (userList.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (userList.gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (userList.profileImage as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (userList.uuid as NSString).utf8String, -1, nil)
              
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
      
    func getAll() -> [Patron] {
           let queryStatementString = "SELECT * FROM patron;"
           var queryStatement: OpaquePointer? = nil
           var patron : [Patron] = []
           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = sqlite3_column_int(queryStatement, 0)
                   let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let phoneNumber = String(describing: String(cString: sqlite3_column_text(queryStatement!, 2)))
                   let name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 3)))
                   let gender = String(describing: String(cString: sqlite3_column_text(queryStatement!, 4)))
                   let profileImage = String(describing: String(cString: sqlite3_column_text(queryStatement!, 5)))
                   let uuid = String(describing: String(cString: sqlite3_column_text(queryStatement!, 6)))
                   patron.append(Patron(id: Int(id), email: email, phoneNumber: phoneNumber, name: name, gender: gender, profileImage: profileImage, uuid: uuid))
                   
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return patron
       }
    
    func getAll(id:Int) -> [Patron] {
           let queryStatementString = "SELECT * FROM patron WHERE id=\(id);"
           var queryStatement: OpaquePointer? = nil
           var patron : [Patron] = []
           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = sqlite3_column_int(queryStatement, 0)
                   let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let phoneNumber = String(describing: String(cString: sqlite3_column_text(queryStatement!, 2)))
                   let name = String(describing: String(cString: sqlite3_column_text(queryStatement!, 3)))
                   let gender = String(describing: String(cString: sqlite3_column_text(queryStatement!, 4)))
                   let profileImage = String(describing: String(cString: sqlite3_column_text(queryStatement!, 5)))
                   let uuid = String(describing: String(cString: sqlite3_column_text(queryStatement!, 6)))
                   patron.append(Patron(id: Int(id), email: email, phoneNumber: phoneNumber, name: name, gender: gender, profileImage: profileImage, uuid: uuid))
                   
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return patron
       }
    
    func update(patron:Patron) -> Bool
    {
        let updateStatementString = "UPDATE patron SET gender = '\(patron.gender)',email='\(patron.email)', contact_number=\(patron.phoneNumber),name='\(patron.name)' WHERE id=\(patron.id)"
         var updateStatement: OpaquePointer? = nil
         if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                       print("Successfully updated row.")
                } else {
                       print("Could not update row.")
                }
              } else {
                    print("UPDATE statement could not be prepared")
              }
              sqlite3_finalize(updateStatement)
        return true
    }
    
   
      
    func deleteAll() {
        let deleteStatementStirng = "DELETE FROM patron;"
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

