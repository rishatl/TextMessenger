//
//  MessagesDisplayData.swift
//  TextMessenger
//
//  Created by Rishat on 09.10.2021.
//

import UIKit

//MARK: - ViewModel

struct ChatViewModel {

    let chats: [Chat]

    struct Chat {

        let image: UIImage?
        let firstName: String
        let lastName: String
        let description: String
        let date: String
        
    }

}
