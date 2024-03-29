//
//  ViewController.swift
//  Quit Smoking
//
//  Created by Warren Dixon on 10/14/17.
//  Copyright © 2017 Warren Dixon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsBtn: UIButton!
    
    let myPlayer = Player()
    var count:Int = 0
    override func viewDidLoad() {
        let width = self.view.frame.size.width
        print("width is \(width) ")
        if (width > 700) {
            
            let myImage: UIImage?
            if (width > 1000) {
                myImage = UIImage(named: "cog-64.png")
            }
            else {
                myImage = UIImage(named: "cog-32.png")
            }
            if let img = myImage {
              settingsBtn.setImage(img, for: .normal)
            }
        }
        else if (width < 350) {
            titleLabel.text = "QUIT SMOKING"
        }
        super.viewDidLoad()
        myPlayer.initHypnosis()
        myPlayer.myViewController = self
        
        pauseButton.isEnabled = false
        playButton.isEnabled  = true
        let defaults = UserDefaults.standard
        count = defaults.integer(forKey: "count")
        //print("count is \(count) ")
        count = count + 1
        defaults.set(count, forKey:"count")
        if (count <= 3) {
            let remaining = 3 - count;
            let warning = "Please do not listen to hypnosis while driving or doing anything for which your safety would be jeapordized by being in a hypnotic trance. This message will display \(remaining) more times."
            let ac = UIAlertController(title: "Warning!", message: warning, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playPressed(_ sender: Any) {
        myPlayer.playMP3()
        playButton.isEnabled = false
        pauseButton.isEnabled = true
    }
    
    @IBAction func rewindPressed(_ sender: Any) {
        myPlayer.rewindMP3()
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        myPlayer.setVolume(vol: volumeSlider.value)
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        myPlayer.pauseMP3()
        pauseButton.isEnabled = false
        playButton.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
     
       // Hide the navigation bar on the this view controller
       self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }
     
     override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
     
       // Show the navigation bar on other view controllers
       self.navigationController?.setNavigationBarHidden(false, animated: animated)
     }
    
    func myTest() {
        //print ("the test worked!!")
        self.pauseButton.isEnabled = false
        self.playButton.isEnabled  = true
    }
}

