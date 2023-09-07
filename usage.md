```
crosspass-ios $ git grep "decryptString"
SendNoteApp/NotificationServiceExtension/NotificationService.swift:        let baseContext = self.decryptString(encryptedBaseContext)else {
SendNoteApp/NotificationServiceExtension/NotificationService.swift:              let baseContext = self.decryptString(encryptedBaseContext),
SendNoteApp/NotificationServiceExtension/NotificationService.swift:    private func decryptString(_ string: String) -> String? {
crosspass-ios $ git grep "deviceDecrypt"
SendNoteApp/NotificationServiceExtension/NotificationService.swift:        return SSEncryption.shared.deviceDecrypt(string: string)
SendNoteApp/SendNoteApp/HelperClasses/CustomEncryption/SSEncryption.swift:    func deviceDecrypt(string: String) -> String? {
SendNoteApp/SendNoteApp/Model/RetrieveNoteDataModel.swift:            return SSEncryption.shared.deviceDecrypt(string: encryptedPin)
SendNoteApp/SendNoteApp/Model/RetrieveNoteDataModel.swift:        return SSEncryption.shared.deviceDecrypt(string: self.note)
```
