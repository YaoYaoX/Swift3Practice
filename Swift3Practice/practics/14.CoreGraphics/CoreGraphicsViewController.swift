//
//  CoreGraphicsViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/2/15.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit

class CoreGraphicsViewController: UIViewController {
    
    var imgv: UIImageView!
    var index = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        drawImage(button: nil)
    }
    
    func setupSubviews() {
        view.backgroundColor = UIColor.white
        
        let size = view.bounds.size
        
        let imgv = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
        imgv.center = CGPoint(x: size.width*0.5, y: size.height*0.5)
        imgv.backgroundColor = UIColor(red: 0.95, green:  0.95, blue:  0.95, alpha: 1)
        imgv.contentMode = .scaleAspectFit
        view.addSubview(imgv)
        self.imgv = imgv
        
        let nextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        nextBtn.setTitleColor(.blue, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        nextBtn.center = CGPoint(x: size.width*0.5, y: size.height-50)
        nextBtn.setTitle("next", for: .normal)
        nextBtn.addTarget(self, action: #selector(drawImage(button:)), for: .touchUpInside)
        view.addSubview(nextBtn)
    }
    
    func drawImage(button: UIButton?){
        switch index {
            case 0:
                drawRectangle()
            
            case 1:
                drawCircle()
                
            case 2:
                drawCheckboar()
                
            case 3:
                drawRotatedSquares()
                
            case 4:
                drawLines()
            
            case 5:
                drawOther()
            
            default:
                break
        }
        
        index += 1
        if index > 5 {
            index = 0
        }
    }
    
    func drawRectangle(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.setFillColor(UIColor.yellow.cgColor)
            context.setStrokeColor(UIColor.lightGray.cgColor)
            context.setLineWidth(10)
            
            context.addRect(CGRect(x: 0, y: 0, width: 512, height: 512))
            context.drawPath(using: .fillStroke)
        }
        
        imgv.image = image;
    }
    
    func drawCircle(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.setFillColor(UIColor.yellow.cgColor)
            context.setStrokeColor(UIColor.lightGray.cgColor)
            context.setLineWidth(10)
            
            context.addEllipse(in: CGRect(x: 5, y: 5, width: 502, height: 502))
            context.drawPath(using: .fillStroke)
        }
        
        imgv.image = image;
    }
    
    func drawCheckboar(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.setFillColor(UIColor.lightGray.cgColor)
            var img = UIImage(contentsOfFile: Bundle.main.path(forResource: "rmb", ofType: "jpg")!)
            img = nil;
            let multi = 4;
            let wh: CGFloat = CGFloat(64/multi)
            
            for row in 0 ..< 8*multi {
                for col in 0 ..< 8*multi {
                    if (row + col) % 2 == 0 {
                        if img != nil {
                            let height = wh * (img!.size.height/img!.size.width)
                            img!.draw(in: CGRect(x: wh*CGFloat(col), y: (wh*CGFloat(row)+(wh-height)*0.5), width: wh, height: height))
                        } else {
                            context.fill(CGRect(x: wh*CGFloat(col), y: wh*CGFloat(row), width: wh, height: wh))
                        }
                    }
                }
            }
        }
        
        imgv.image = image;
    }
    
    func drawRotatedSquares(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.setStrokeColor(UIColor.lightGray.cgColor)
            
            let counts = 64
            let rotation = Double.pi/Double(counts)
            
            context.translateBy(x: 256, y: 256)
            for _ in 0 ... counts {
                context.rotate(by: CGFloat(rotation))
                context.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            context.strokePath()
        }
        
        imgv.image = image;
    }
    
    func drawLines(){
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.translateBy(x: 256, y: 256)
            context.setStrokeColor(UIColor.lightGray.cgColor)
            
            var first = true
            var length:CGFloat = 200
            
            for index in 0 ... 256 {
//                let y = 50 * 0.02 * CGFloat(index)
//                context.move(to: CGPoint(x: 0, y: y))
//                context.addLine(to: CGPoint(x: length, y: y))

                context.rotate(by: CGFloat.pi/2)
                if first {
                    first = false
                    context.move(to: CGPoint(x: length, y: 50))
                } else {
                    context.addLine(to: CGPoint(x: length, y: 50-CGFloat(index)*0.6))
                }
                
//                //只画点
//                context.rotate(by: CGFloat.pi/2)
//                (String(index) as NSString).draw(at: CGPoint(x: length, y: 50-CGFloat(index)), withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 10)])
                length *= 0.99
            }
            
            context.strokePath()
        }
        
        imgv.image = image;
    }
    
    func drawOther() {
        drawOther1()
    }
    
    func drawOther1() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { [unowned self] (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            let count = 128
            context.translateBy(x: 256, y: 256)
            for _ in 0 ..< count {
                context.rotate(by: CGFloat.pi*2/CGFloat(count))
                context.addEllipse(in: CGRect(x: -256, y: -50, width: 512, height: 100))
                context.setStrokeColor(self.randomColor().cgColor)
                context.strokePath()
            }
            
            var length: CGFloat = 50
            for _ in 0 ..< 100 {
                context.addEllipse(in: CGRect(x: -length, y: -length, width: length*2, height: length*2))
                context.setStrokeColor(self.randomColor().cgColor)
                context.strokePath()
                length *= 1.01
            }
            
        }
        
        imgv.image = image;
    }
    
    func drawOther2() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { (ctx: UIGraphicsImageRendererContext) in
            
            let context = ctx.cgContext
            context.setStrokeColor(UIColor.lightGray.cgColor)
            let multi = 2;
            let wh: CGFloat = CGFloat(64/multi)
            for row in 0 ..< 8*multi {
                for col in 0 ..< 8*multi {
                    context.move(to: CGPoint(x: CGFloat(col)*wh, y: CGFloat(row+1)*wh))
                    context.addLine(to: CGPoint(x: (CGFloat(col)+0.5)*wh, y: CGFloat(row)*wh))
                    context.addLine(to: CGPoint(x: CGFloat(col+1)*wh, y: CGFloat(row+1)*wh))
                    context.addLine(to: CGPoint(x: CGFloat(col)*wh, y: CGFloat(row+1)*wh))
                }
            }
            context.strokePath()
        }
        
        imgv.image = image;
    }

    func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256))/255
        let blue = CGFloat(arc4random_uniform(256))/255
        let green = CGFloat(arc4random_uniform(256))/255
        let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        return randomColor
    }
}
