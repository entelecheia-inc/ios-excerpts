//
//  KeychainHelper.swift
//  keychainDemo
//
//  Created by Anshumaan Singh on 24/11/22.
//

import Foundation

import Security
import UIKit

class KeychainHelper {
    private static let teamID = AppConstants.teamID
    private static let accessGroup = "\(teamID).app.crosspass.ios.keychain_access_group"
    class func save(key: String, data: Data) -> OSStatus {
    
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data,
            //kSecAttrAccessible as String : kSecAttrAccessibleAlwaysThisDeviceOnly
            kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
            kSecAttrAccessGroup as String : accessGroup
        ] as [String : Any]
            
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecAttrAccessGroup as String : accessGroup,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func deleteKey(key:String)-> OSStatus{
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccessGroup as String : accessGroup,
            kSecAttrAccount as String : key] as [String : Any]
        return SecItemDelete(query as CFDictionary)
    }    

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
