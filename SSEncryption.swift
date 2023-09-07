//
//  SSEncryption.swift
//  SendNoteApp
//
//  Created by Kamal Punia on 24/11/22.
//

import Foundation
import CryptoSwift

final class SSEncryption: NSObject {
    
    // MARK: - Variables
    static let shared = SSEncryption()
    
    // MARK: - Initializer
    private override init() {
        super.init()
    }
    
    // MARK: - Internal functions
    func deviceEncrypt(string: String) -> String? {
        if let generatedKey = DeviceKey().retrieveKey(),
           let keyData = Data(base64Encoded: generatedKey) {
            if let encryptedString = encrypt(inputString: string, key: keyData) {
                return encryptedString
            }
        }
        return nil
    }
    
    func deviceDecrypt(string: String) -> String? {
        
        if let generatedKey = DeviceKey().retrieveKey(),
           let keyData = Data(base64Encoded: generatedKey),
           let deCryptedString = decrypt(base64EncodedString: string, key: keyData) {
            return deCryptedString
        }
        
        return nil
    }
    
    private func encrypt(inputString :String , key : Data)->String?{
        let dataBytes = Data(inputString.utf8)
        let iv = AES.randomIV(AES.blockSize)
        let gcm = GCM(iv: iv, mode: .combined)
        if let aes = try? AES(key: key.bytes, blockMode: gcm, padding: .pkcs7){
            /* Encrypt Data */
            if let encryptedBytes = try? aes.encrypt(dataBytes.bytes){
                let encryptedData = Data(encryptedBytes)
                return (iv + encryptedData).toBase64()
            }
        }
        return nil
    }
    
    private func decrypt(base64EncodedString: String , key: Data)->String?{
        if base64EncodedString.isEmptyWithTrimmedSpace {
            return nil
        }
        let data =  Array(base64: base64EncodedString)
        let iv =   Array(data.prefix(16))
        let cyphertext = Array(data.suffix(from: 16))
        
        let gcm = GCM(iv: iv, mode: .combined)
        if let aes = try? AES(key: key.bytes, blockMode: gcm, padding: .pkcs7){
            if let decryptedBytes = try? aes.decrypt(cyphertext){
                let decryptedData = Data(decryptedBytes)
                return String(data: decryptedData, encoding: .utf8)
            }
        }
        return nil
    }
}
