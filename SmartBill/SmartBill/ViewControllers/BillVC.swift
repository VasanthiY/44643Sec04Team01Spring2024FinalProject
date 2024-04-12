//
//  BillVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/11/24.
//

import UIKit
import Lottie

class BillVC: UIViewController {

    @IBOutlet weak var launchLAV: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimationView()
    }
    
    private func setupAnimationView() {
        let animationView = LottieAnimationView(name: "smart_bill.json")
        animationView.frame = self.launchLAV.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        
        self.launchLAV.addSubview(animationView)
        animationView.play()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            animationView.stop()
            self.launchLAV.removeFromSuperview()
            self.performSegue(withIdentifier: "animeToLogin", sender: self)
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
