

import UIKit

class BaseViewController: UIViewController {


    var leftDrawerTransition:DrawerTransition?
    var left = LeftMenuViewController()
    typealias completionBlock = (_ isCartButton:Bool)->()
    typealias completionMenuBlock = ()->()
    var btnClickBlock : completionBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    

    public func removeTitle(tag: Int){
        if let tab = self.tabBarController?.tabBar.items {
            _ = self.tabBarController!.tabBar
            tab.forEach {
                if $0.tag == tag {
                    if tag == 0 {
                        $0.title = "ViewController1"
                    } else if tag == 1 {
                        $0.title = "ViewController2"
                    } else if tag == 2 {
                        $0.title = "ViewController3"
                    } else {
                        $0.title = ""
                    }
                }
            }
        }
    }
    
    
    // MARK :-  Setup for side menu
    func pressButtonOnNavigaion(completion : @escaping completionBlock) {
        btnClickBlock = completion
    }
    
    func presentSideMenu() {
        self.leftDrawerTransition?.presentDrawerViewController(animated: true)
    }
    
    func closeSideMenu() {
        self.leftDrawerTransition?.dismissDrawerViewController()
    }
    
    func setupLeftDrawer(_ controller: UIViewController) {
        self.leftDrawerTransition = DrawerTransition(target: controller, drawer: left)
        self.leftDrawerTransition?.setPresentCompletion { print() }
        self.leftDrawerTransition?.setDismissCompletion { print() }
        self.leftDrawerTransition?.edgeType = .left
        self.leftDrawerTransition?.dismissDrawerViewController()
        left.clickCellEvent { (title) in
            guard let menuTitle = title else { return }
            switch menuTitle{
            case .SideController1:
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SideController1") as! SideController1
                self.navigationController?.pushViewController(vc, animated: true)
                self.leftDrawerTransition?.dismissDrawerViewController()
            case .SideController2 :
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SideController2") as! SideController2
                self.navigationController?.pushViewController(vc, animated: true)
                self.leftDrawerTransition?.dismissDrawerViewController()
            case .SideController3 :
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SideController3") as! SideController3
                self.navigationController?.pushViewController(vc, animated: true)
                self.leftDrawerTransition?.dismissDrawerViewController()
            case .back:
                self.leftDrawerTransition?.dismissDrawerViewController()
            }
        }
    }
    
    

}
