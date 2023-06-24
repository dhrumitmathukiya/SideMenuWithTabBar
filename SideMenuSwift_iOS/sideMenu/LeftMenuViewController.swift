

import UIKit
//Structure for Menu (Side Menu)
struct menuData {
    var image: UIImage
    var title: SideMenuCategory
}

enum SideMenuCategory: String{
    case SideController1 = "SideController1"
    case SideController2 = "SideController2"
    case SideController3 = "SideController3"
    case back = "Back"
}


class LeftMenuViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            
            if #available(iOS 15.0, *) {
                tblView.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            }
        }
    }

    typealias CompletionBlock = (SideMenuCategory?) -> Void
    
    //MARK: Variables
    var menuClickBlock : CompletionBlock!
    var leftDrawerTransition:DrawerTransition!
    var tableData = [menuData]()
    
    //MARK View Controllwe methods
    override func viewDidLoad() {
        super.viewDidLoad()
        doSetupUI()
        
    }
    
    //MARK: Actions
    @IBAction func btnCloseMenuAction(_ sender: UIButton) {
        menuClickBlock(SideMenuCategory.back)
    }
    
    //MARK: Functions
    func doSetupUI() {
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        let top = self.view.frame.height - height
        topConstraint.constant = (top / 2) + 8
        
        let btnHeight = (self.view.frame.height * 25) / 896
        bottomHeightConstaint.constant = btnHeight
 //       backGroundView.layer.shadowColor = AppColor.appGrren.cgColor
        backGroundView.layer.shadowOpacity = 1
        backGroundView.layer.shadowOffset = CGSize(width: -1, height: 1)
        backGroundView.layer.shadowRadius = 3
       // gradientImage.roundCorners([.topLeft, .bottomLeft], radius: 50)
      //  lblUserName.font = Utils.setFont(name: .bold, size: .size_14)
    
        tblView.register(SideMenuDetailTableViewCell.nib(), forCellReuseIdentifier: SideMenuDetailTableViewCell.identifier)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
        tableData.removeAll()
        tableData = [
            menuData(image: UIImage(named: "SideController1") ?? UIImage(), title: .SideController1),
            menuData(image: UIImage(named: "subscribe") ?? UIImage(), title: .SideController2),
            menuData(image: UIImage(named: "Policy") ?? UIImage(), title: .SideController3),
            menuData(image: UIImage(named: "exit") ?? UIImage(), title: .back)
        ]
        tblView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        doSetupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doSetupUI()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func clickCellEvent(completion : @escaping CompletionBlock)  {
        menuClickBlock = completion
    }
 
    private func getUserInfo() {
//        let userProfile = Constant.shared.getUserProfileDataToUserDefault()
//        if userProfile != UserProfileModel() {
//            lblUserName.text = userProfile.name
//        } else {
//            self.showHUD(progressLabel: "Loading...")
//            ALMAnager.shared.getUserInfo { result in
//                switch result {
//                case .success(let json):
////                    self.dismissHUD(isAnimated: true)
//                    if json.error != nil {
////                        self.showError(msg: json.error ?? "")
//                    } else {
//                        self.lblUserName.text = json.fullName
//                     //   Constant.shared.saveEmailToUserDefalt(email: json.email ?? "")
//                    }
//
//                case .failure(let error):
//                    self.dismissHUD(isAnimated: true)
//                    self.showAlert(msg: error.localizedDescription)
//                }
//            }
//        }
    }
}

extension LeftMenuViewController:UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuDetailTableViewCell") as? SideMenuDetailTableViewCell{

            cell.lblTitle.text = data.title.rawValue
            cell.lblTitle.font = .boldSystemFont(ofSize: 15) //Utils.setFont(name: .bold, size: .size_14)
            cell.imgLogo.image = data.image
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableData[indexPath.row].title
        menuClickBlock(item)
//        self.showCustomAlert(.logout)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (self.view.frame.height * 80) / 892
        return height
    }

}

