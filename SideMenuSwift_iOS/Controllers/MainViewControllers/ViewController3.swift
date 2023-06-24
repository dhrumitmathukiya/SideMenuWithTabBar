

import UIKit

class ViewController3: BaseViewController {

    @IBOutlet weak var sidebarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftDrawer(self)
        self.sidebarButton.addTarget(self, action: #selector(openSidebar(_:)), for: .touchUpInside)
    }
    

    @objc func openSidebar(_ sender : UIButton){
        self.presentSideMenu()
    }

}
