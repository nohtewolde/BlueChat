//
//  AvatarPickerViewController.swift


import UIKit
import Gemini

class AvatarPickerViewController: UIViewController
{
    @IBOutlet weak var collectionView: GeminiCollectionView!
    let avatarCellReuseIdentifier = "AvatarPickerCell"
    let columnCount = 3
    let margin : CGFloat = 10
    let avatarCount = 8
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        assignbackground()
//        ViewHelper.setCollectionViewLayout(collectionView: collectionView, margin: margin)
//        collectionView.gemini
        collectionView.gemini
            .circleRotationAnimation()
            .radius(450) // The radius of the circle
            .rotateDirection(.clockwise) // Direction of rotation.
            .itemRotationEnabled(true) // Whether the item rotates or not
    }
    
    func assignbackground(){
        let background = UIImage(named: "background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.animateVisibleCells()
    }
    
}


// MARK: - UICollectionViewDataSource protocol
extension AvatarPickerViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarCellReuseIdentifier, for: indexPath as IndexPath) as! AvatarPickerCell
        
        cell.avatarImageView.image = UIImage(named: String(format: "%@%d", Constants.kAvatarImagePrefix, indexPath.item + 1))
        
        self.collectionView.animateCell(cell)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate protocol
extension AvatarPickerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var userData =  UserData()
        userData.avatarId = indexPath.item + 1
        userData.save()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        if let cell = cell as? AvatarPickerCell{
            self.collectionView.animateCell(cell)
        }
    }
}

extension AvatarPickerViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(columnCount - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(columnCount)).rounded(.down)
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
    
}
