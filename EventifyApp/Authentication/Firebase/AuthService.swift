//
//  AuthService.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 25.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()

    public func registerUser(with userRequest: UserModel, completion: @escaping (Bool, Error?) -> Void) {
        let email = userRequest.email
        let password = userRequest.password

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
            }

            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                    }

                    completion(true, nil)
                }
        }
    }

    public func loginUser(with userModel: UserModel, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userModel.email, password: userModel.password) { _, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    // swiftlint:disable all
    public func logOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    // swiftlint:enable all
}
