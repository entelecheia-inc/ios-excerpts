import UIKit

struct Constants {
    static let kKeyIdentifier : String = "DeviceKey"
}


class DeviceKey {

    func createKeyIfNotExist() {
        if retrieveKey() == nil {
            if let newKeyString = generateRandomBytes(length: 32) {
                let status = KeychainHelper.save(key: Constants.kKeyIdentifier, data: Data(newKeyString.utf8))
                if status == 0 {
                    print("Save Succeessful")
                }
            }
        }
    }
    
    func retrieveKey() -> String? {
        if let receivedData = KeychainHelper.load(key: Constants.kKeyIdentifier) {
            let result = String(data: receivedData, encoding: .utf8)
            return result
        }
        return nil
    }
    
    func generateRandomBytes(length: Int) -> String? {
        var keyData = Data(count: length)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, length, $0.baseAddress!)
        }
        if result == errSecSuccess {
            print("generated String", keyData.base64EncodedString())
            return keyData.base64EncodedString()
        } else {
            print("Problem generating random bytes")
            return nil
        }
    }

    func deleteKey(){
        let status = KeychainHelper.deleteKey(key: Constants.kKeyIdentifier)
        if status == 0{
            print("Deelete Succeessful")
        }
    }
}

