//
//  ColorPickerViewController.swift

//


//

import UIKit
import Gemini

class ColorPickerViewController: UIViewController
{
    
    @IBOutlet weak var collectionView: GeminiCollectionView!
    let reuseIdentifier = "ColorPickerCell"
    let columnCount = 3
    let margin : CGFloat = 10
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        assignbackground()
//        ViewHelper.setCollectionViewLayout(collectionView: collectionView, margin: margin)
        collectionView.gemini
            .rollRotationAnimation()
            .degree(90)
            .rollEffect(.rollDown)
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
extension ColorPickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.colors.count
    }
    
    // make a cell for each cell index path
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GeminiCell
        
        cell.backgroundColor = Constants.colors[indexPath.item]
    
        self.collectionView.animateCell(cell)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate protocol
extension ColorPickerViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var userData =  UserData()
        userData.colorId = indexPath.item
        userData.save()
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        if let cell = cell as? GeminiCell{
            self.collectionView.animateCell(cell)
        }
    }
}

extension ColorPickerViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(columnCount - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(columnCount)).rounded(.down)
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
}
