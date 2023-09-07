# iOS Excertps

## Device encryption

All user data is stored on the device in encrypted form. The encryption key never leaves the device, and it is stored in Secure Enclave.
The relevant code is in `DeviceKey.swift`, `SSEncryption.swift`, and `KeychainHelper.swift`. See `usage.md` for the way they are called.
