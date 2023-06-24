

import UIKit

class ViewController1: BaseViewController {

    @IBOutlet weak var sidebarButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftDrawer(self)
        self.sidebarButton.addTarget(self, action: #selector(openSidebar(_:)), for: .touchUpInside)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    
    @objc func openSidebar(_ sender : UIButton){
        self.presentSideMenu()
    }
    

    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.presentSideMenu()
        }
    }
        
    

}
