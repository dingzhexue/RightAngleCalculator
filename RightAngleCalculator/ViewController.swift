//
//  ViewController.swift
//  RightAngleCalculator
//
//  Created by admin on 10/27/17.
//

import UIKit

var mainTriangle : Triangle!
var previousTriangles:[Triangle] = []

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var legAFeet: UITextField!
    @IBOutlet weak var legAInches: UITextField!
    @IBOutlet weak var legASixteenths: UITextField!
    
    @IBOutlet weak var legBFeet: UITextField!
    @IBOutlet weak var legBInches: UITextField!
    @IBOutlet weak var legBSixteenths: UITextField!
    
    @IBOutlet weak var hypotenuseFeet: UITextField!
    @IBOutlet weak var hypotenuseInches: UITextField!
    @IBOutlet weak var hypotenuseSixteenths: UITextField!
    
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var previousTrianglesView: UIView!
    @IBOutlet weak var previousTableView: UITableView!
    
    var triangleView : TriangleView!
    var triangleLengthsView : TriangleLengthsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainTriangle = Triangle()
        
        self.loadPreviousTriangles()
        self.hideTriangle()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func savePreviousTriangles(){
        let saveArray = NSMutableArray()
        
        for  temp in previousTriangles {
            let buf = Triangle.init()
            saveArray.add(buf.stringFromTriangle(triangle: temp))
        }
        
        saveArray.write(to: URL(string:self.completePathForFileName(str: "PreviousTriangles"))!, atomically: false)
    }

    func loadPreviousTriangles() {
        previousTriangles = []
        let triangle = Triangle.init()
        
        let path = completePathForFileName(str:"previousTriangles")
        
        let loadedArray : NSArray? = NSArray(contentsOfFile: path)
        
        loadedArray?.forEach{ str in
            previousTriangles.append(triangle.triangleFromString(string: str as! String))
        }
    }

    func completePathForFileName(str:String) -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        return String(describing: documentsDirectory?.appendingPathComponent(str))
    }

    //MARK: private methods
    func previousTriangleChosen(index:Int){

        if (index >= previousTriangles.count) {return}

        self.dismissKeyboard()
        self.hidePreviousTriangles()

        // load selected triangle
        mainTriangle = previousTriangles[index]
        self.fillFields()
        self.drawTriangle()
    }

    func clearFields(){
        mainTriangle = Triangle()

        legAFeet.text = ""
        legAInches.text = ""
        legASixteenths.text = ""

        legBFeet.text = ""
        legBInches.text = ""
        legBSixteenths.text = ""

        hypotenuseFeet.text = ""
        hypotenuseInches.text = ""
        hypotenuseSixteenths.text = ""
    }
    func hidePreviousTriangles() {
        previousTrianglesView.isHidden = true
    }

    // Updates mainTriangle with values from the textFields
    func updateTriangleValues(){
        mainTriangle.legA = (legAFeet.text! as NSString).doubleValue + (legAInches.text! as NSString).doubleValue/12.0 + (legASixteenths.text! as NSString).doubleValue/(12.0*16.0)

        mainTriangle.legB = (legBFeet.text! as NSString).doubleValue + (legBInches.text! as NSString).doubleValue/12.0 + (legBSixteenths.text! as NSString).doubleValue/(12.0*16.0)

        mainTriangle.hypotenuse = (hypotenuseFeet.text! as NSString).doubleValue + (hypotenuseInches.text! as NSString).doubleValue/12.0 + (hypotenuseSixteenths.text! as NSString).doubleValue/(12.0*16.0)
    }

    func dismissKeyboard(){
        legAFeet.resignFirstResponder()
        legAInches.resignFirstResponder()
        legASixteenths.resignFirstResponder()

        legBFeet.resignFirstResponder()
        legBInches.resignFirstResponder()
        legBSixteenths.resignFirstResponder()

        hypotenuseFeet.resignFirstResponder()
        hypotenuseInches.resignFirstResponder()
        hypotenuseSixteenths.resignFirstResponder()
    }

    func hideTriangle() {
        if(triangleView != nil){
            triangleView.isHidden = true
            triangleLengthsView.isHidden = true
        }

        aLabel.isHidden = true
        bLabel.isHidden = true
        cLabel.isHidden = true
    }

    func showTriangle(){
        if(triangleView != nil){
            triangleView.isHidden = false
            triangleLengthsView.isHidden = false
        }
        aLabel.isHidden = false
        bLabel.isHidden = false
        cLabel.isHidden = false
    }

    // Draws triangle currently in mainTriangle
    func drawTriangle(){
        self.showTriangle()

        let triangleSize:Float = 200

        // scale triangle so largest leg has appropriate length
        let largestLegLength:Double = max(mainTriangle.legA,mainTriangle.legB)
        let scale:Double = Double(triangleSize)/largestLegLength

        let calcButtonBottom:Float = Float(calculateButton.frame.origin.y + calculateButton.frame.size.height)

        // Determine origin for triangle
        let vSpace:Float = Float(self.view.frame.size.height) - 30 - calcButtonBottom
        let hSpace:Float = 375
        let origin:CGPoint = CGPoint(x:Double(hSpace)/2.0 - mainTriangle.legB*scale/2.0,
                                     y:Double(calcButtonBottom) + Double(vSpace)/2.0 + mainTriangle.legA*scale/2.0)

        //////////////
        //Set up labels for triangle diagram

        aLabel.isHidden = false
        bLabel.isHidden = false
        cLabel.isHidden = false

        aLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        bLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        cLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)

        aLabel.frame = CGRect(x: 0, y: 0, width: origin.x - 6 - 2*4, height: 100)

        let length = Length.init()
        aLabel.text = String(format:"A\n%@", length.formattedStringForFeet(feet: mainTriangle.legA))
        bLabel.text = String(format:"B\n%@", length.formattedStringForFeet(feet: mainTriangle.legB))
        cLabel.text = String(format:"C\n%@", length.formattedStringForFeet(feet: mainTriangle.hypotenuse))

        aLabel.sizeToFit()
        bLabel.sizeToFit()
        cLabel.sizeToFit()

        ///////////////////////////
        if(triangleView != nil){
            triangleView.isHidden = false
            triangleLengthsView.isHidden = false
            
            triangleView.removeFromSuperview()
            triangleLengthsView.removeFromSuperview()

        }

        
        
        triangleView = TriangleView(frame: CGRect(x: origin.x,
                                                  y: origin.y - CGFloat(mainTriangle.legA*scale),
                                                  width: CGFloat(mainTriangle.legB*scale),
                                                  height: CGFloat(mainTriangle.legA*scale)))
        self.view.addSubview(triangleView)
        triangleLengthsView = TriangleLengthsView.init()
        triangleLengthsView.size = 6
        triangleLengthsView.padding = 4
        triangleLengthsView.frame = CGRect(x: Double(Float(origin.x) - triangleLengthsView.size - triangleLengthsView.padding),
                                           y: Double(Float(origin.y) - Float(mainTriangle.legA*scale) - triangleLengthsView.size - triangleLengthsView.padding),
                                           width:  Double(Float(mainTriangle.legB*scale) + 2*triangleLengthsView.size + 2*triangleLengthsView.padding),
                                           height: Double(Float(mainTriangle.legA*scale) + 2*triangleLengthsView.size + 2*triangleLengthsView.padding))

        self.view.addSubview(triangleLengthsView)

        /////////////
        // Position Labels

        aLabel.center = CGPoint(x: Double(Float(origin.x) - Float(aLabel.frame.size.width)/2.0 - triangleLengthsView.size - 2*triangleLengthsView.padding),
                                y: Double(Float(origin.y) - Float(mainTriangle.legA/2.0*scale)))
        bLabel.center = CGPoint(x: Double(origin.x) + mainTriangle.legB/2.0*scale,
                                y: Double(origin.y) + Double(bLabel.frame.size.height)/2.0 + Double(triangleLengthsView.size) + 2*Double(triangleLengthsView.padding))

        let angle:Float = atan2f(Float(triangleView.frame.size.width), Float(triangleView.frame.size.height));
        cLabel.center = CGPoint(x: Double(Float(origin.x) + Float(mainTriangle.legB/2.0*scale) + (Float(cLabel.frame.size.width)/2.0 + triangleLengthsView.size + 3*triangleLengthsView.padding)*cos(angle)),
                                y: Double(Float(origin.y) - Float(mainTriangle.legA/2.0*scale) - (Float(cLabel.frame.size.height)/2.0 + triangleLengthsView.size + 3*triangleLengthsView.padding)*sin(angle)))
        ////////////
        // Necessary for centers to update properly
        aLabel.removeFromSuperview()
        bLabel.removeFromSuperview()
        cLabel.removeFromSuperview()

        self.view.addSubview(aLabel)
        self.view.addSubview(bLabel)
        self.view.addSubview(cLabel)

        self.fillFields()
    }

    ////////////
    // Computes the length of the missing side and saves the triangle's information
    func completeMainTriangle(){

        self.dismissKeyboard()

        if(mainTriangle.legA == 0){
            if (mainTriangle.legB > mainTriangle.hypotenuse) {
                self.clearFields()
                let alert = UIAlertController(title: "Impossible Triangle!", message: "The triangle you specified is not possible because the hypotenuse is shorter than one of the legs!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertActionStyle.default, handler: nil))
                alert.present(alert, animated: true, completion: nil)
                return
            }

            mainTriangle.legA = sqrt(pow(mainTriangle.hypotenuse,2) - pow(mainTriangle.legB, 2))
        }

        if(mainTriangle.legB == 0){
            if (mainTriangle.legA > mainTriangle.hypotenuse) {
                self.clearFields()
                let alert = UIAlertController(title: "Impossible Triangle!", message: "The triangle you specified is not possible because the hypotenuse is shorter than one of the legs!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertActionStyle.default, handler: nil))
                alert.present(alert, animated: true, completion: nil)
                return
            }

            mainTriangle.legB = sqrt(pow(mainTriangle.hypotenuse,2) - pow(mainTriangle.legA, 2))
        }

        if(mainTriangle.hypotenuse == 0){
            mainTriangle.hypotenuse = sqrt(pow(mainTriangle.legA,2) + pow(mainTriangle.legB, 2))
        }

        self.fillFields()
        self.drawTriangle()
        self.saveMainTriangle()
    }

    func saveMainTriangle(){
        if(previousTriangles.count >= 7) {
            previousTriangles.removeLast()
        }
        previousTriangles.insert(mainTriangle, at: 0)
        self.savePreviousTriangles()
        previousTableView.reloadData()
    }

    ////////////////
    // Fills textfields with values from mainTriangle
    func fillFields(){
        var length = Length.init()

        length = length.lengthWithFeet(feet: mainTriangle.legA)
        legAFeet.text = String(format:"%d",length.feet)
        legAInches.text = String(format:"%d",length.inches)
        legASixteenths.text = String(format:"%d",length.sixteenths)

        length = length.lengthWithFeet(feet: mainTriangle.legB)
        legBFeet.text = String(format:"%d",length.feet)
        legBInches.text = String(format:"%d",length.inches)
        legBSixteenths.text = String(format:"%d",length.sixteenths)

        length = length.lengthWithFeet(feet: mainTriangle.hypotenuse)
        hypotenuseFeet.text = String(format:"%d",length.feet)
        hypotenuseInches.text = String(format:"%d",length.inches)
        hypotenuseSixteenths.text = String(format:"%d",length.sixteenths)
    }
    
    
    //MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousTriangles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TriangleCell(style: .default, reuseIdentifier: "")
        let t = previousTriangles[indexPath.row]
        let length = Length()
        cell.aLabel.text = String(format:"A: %@",length.formattedStringForFeet(feet: t.legA))
        cell.bLabel.text = String(format:"B: %@",length.formattedStringForFeet(feet: t.legB))
        cell.cLabel.text = String(format:"C: %@",length.formattedStringForFeet(feet: t.hypotenuse))
        
        return cell
    }
    
    //MARK: UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.previousTriangleChosen(index: indexPath.row)
    }
    
    
    //MARK: Actions of buttons
    @IBAction func showPreviousTriangles(_ sender: Any) {
        self.dismissKeyboard()
        
        if(previousTrianglesView.isHidden){
            previousTrianglesView.isHidden = false
            self.hideTriangle()
        }
        else{
            self.hidePreviousTriangles()
        }
    }
    
    @IBAction func calulateButtonPushed(_ sender: Any) {
        self.dismissKeyboard()
        self.hidePreviousTriangles()
        
        // Determine if triangle should be calculated; Only do calculation if EXACTLY 2 sides have values
        self.updateTriangleValues()
        
        if(mainTriangle.legA != 0 && mainTriangle.legB != 0 && mainTriangle.hypotenuse != 0){
            // There is already a complete triangle entered
            self.drawTriangle()
            return
        }
        if (mainTriangle.legA == 0 && mainTriangle.legB == 0) {return}
        if (mainTriangle.legA == 0 && mainTriangle.hypotenuse == 0) {return}
        if (mainTriangle.legB == 0 && mainTriangle.hypotenuse == 0) {return}
        
        self.completeMainTriangle()
    }
    
    @IBAction func clearButtonPushed(_ sender: Any) {
        self.hideTriangle()
        self.hidePreviousTriangles()
        self.clearFields()
    }
    
    //MARK: UITextFieldDelegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if((textField.text)!.characters.count > 6) {return false}
        
        self.updateTriangleValues()
        
        switch (textField.tag) {
            case 1:
                if(mainTriangle.legB != 0 && mainTriangle.hypotenuse != 0) {return false}
                break
            case 2:
                if(mainTriangle.legA != 0 && mainTriangle.hypotenuse != 0) {return false}
                break
            case 3:
                if(mainTriangle.legB != 0 && mainTriangle.legA != 0) {return false}
                break
            default:
                break
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            if(mainTriangle.legB != 0 && mainTriangle.hypotenuse != 0) {return false}
            break
        case 2:
            if(mainTriangle.legA != 0 && mainTriangle.hypotenuse != 0) {return false}
            break
        case 3:
            if(mainTriangle.legB != 0 && mainTriangle.legA != 0) {return false}
            break
        default:
            break
        }
        return true
    }
}

