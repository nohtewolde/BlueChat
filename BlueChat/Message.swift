//
//  Message.swift

//


//

import Foundation

struct Message {
    
    var text : String
    var isSent : Bool
    
    init(text: String, isSent: Bool) {
        
        self.text = text
        self.isSent = isSent
    }
}
