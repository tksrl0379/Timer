//
//  ViewController.swift
//  Timertest
//
//  Created by a1111 on 2020/08/15.
//  Copyright © 2020 sym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer?
    var timer2: Timer?

    var count = 0
    var count2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
    }
    
    func startTimer(){
        //
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .default)

        DispatchQueue.global(qos: .background).async {
            self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.update2), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
        
        // Main Thread 의 Timer 는 5초 지연 후 시작
        sleep(5)
    }
    
    @objc func update(){
        print("Timer in Main Thread")
        
        count += 1
        print(count)
        if(count > 10){
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    @objc func update2(){
        print("Timer in Background Thread")
        
        count2 += 1
        print(count2)
        if(count2 > 10){
            self.timer2?.invalidate()
            self.timer2 = nil
        }
    }

}

