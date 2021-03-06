//
//  ChatCell.swift

//


//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var receivedMessage: PaddingLabel!
    
    @IBOutlet weak var sentMessage: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
        self.receivedMessage.layer.backgroundColor = UIColor.white.cgColor
        self.receivedMessage.layer.cornerRadius = 10 
        self.sentMessage.layer.backgroundColor = UIColor(red: 213/255, green: 246/255, blue: 226/255, alpha: 1.0).cgColor
        self.sentMessage.layer.cornerRadius = 10
        
    }
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupViews(isSent: Bool){
        addSubview(profileImage)
        if isSent {
            addConstraintsWithFormat(format: "H:[v0(40)]|", views: profileImage)
            addConstraintsWithFormat(format: "V:[v0(40)]|", views: profileImage)
            profileImage.image = UIImage(named: "avatar5")
        }
        else{
            addConstraintsWithFormat(format: "H:|[v0(50)]", views: profileImage)
            addConstraintsWithFormat(format: "V:[v0(50)]|", views: profileImage)
            profileImage.image = UIImage(named: "avatar4")
        }
        
    }
}
