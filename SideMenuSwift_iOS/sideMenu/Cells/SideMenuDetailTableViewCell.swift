

import UIKit

class SideMenuDetailTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuDetailTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SideMenuDetailTableViewCell", bundle: nil)
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
}
