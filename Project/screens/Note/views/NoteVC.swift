//
//  NoteVC.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import UIKit

class NoteVC: UIViewController {
    
    let viewModel = NoteViewModel()
    @IBOutlet weak var tblView: UITableView!
    
    var customData: [CustomNoteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblView.separatorStyle = .none
        tblView.register(UINib(nibName: "\(InterestedTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(InterestedTableViewCell.self)")
        tblView.register(UINib(nibName: "\(LikedPeopleTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(LikedPeopleTableViewCell.self)")
        getNotes()
        
    }
    
    private func getNotes() {
        Task {
            do {
                self.view.isUserInteractionEnabled = false
                let data = try await viewModel.getNotes(repository: RepositoryIMPL())
                self.view.isUserInteractionEnabled = true
                dump(data)
                for i in data.invites?.profiles ?? [] {
                    let images = i?.photos?.compactMap({ photos in
                        photos?.photo
                    })
                    customData.append(CustomNoteModel(type: .Invited, profile: [Profile(name: i?.general_information?.first_name ?? "N/A", age: i?.general_information?.age ?? 0, image: images ?? [])]))
                }
                var profiles: [Profile] = []
                for i in data.likes?.profiles ?? [] {
                    profiles.append(Profile(name: i?.first_name ?? "", age: 0, image: [i?.avatar ?? ""], premium: data.likes?.can_see_profile ?? false))
                }
                customData.append(CustomNoteModel(type: .Liked, profile: profiles))
                tblView.reloadData()
            }catch {
                self.view.isUserInteractionEnabled = true
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc : PhoneVC? = storyboard.instantiateViewController(withIdentifier: "PhoneVC") as? PhoneVC
                if let vc = vc {
                    self.navigationController?.setViewControllers([vc], animated: true)
                }else {
                    let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if customData[indexPath.row].type == .Invited {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InterestedTableViewCell", for: indexPath) as! InterestedTableViewCell
            cell.setupCell(row: indexPath.row, note: customData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikedPeopleTableViewCell", for: indexPath) as! LikedPeopleTableViewCell
            cell.selectionStyle = .none
            cell.setupCell(data: customData[indexPath.row].profile)
            return cell
        }
    }
    
    
}

struct CustomNoteModel {
    let type: ProfileType
    let profile: [Profile]
}

enum ProfileType {
    case Invited
    case Liked
}

struct Profile {
    let name: String
    let age: Int
    let image: [String]
    var premium: Bool = false
}
