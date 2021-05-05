//
//  ViewController.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/05/06.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let csvFile = "시트 1-표 2"
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
        let contents = parseCSV(fileName: csvFile, fileType: "csv")
        
        for content in contents {
            print(content)
        }
                
    }

    func openCSV(fileName:String, fileType: String)-> String!{
       guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
           else {
               return nil
       }
       do {
           let contents = try String(contentsOfFile: filepath, encoding: .utf8)

           return contents
       } catch {
           print("File Read Error for file \(filepath)")
           return nil
       }
   }
    
    func parseCSV(fileName: String, fileType: String) -> [(String, String, String, String, String, String)]{

        let dataString: String! = openCSV(fileName: fileName, fileType: fileType)
        var items: [(String, String, String, String, String, String)] = []
        let lines: [String] = dataString.components(separatedBy: NSCharacterSet.newlines) as [String]

        for line in lines {
           var values: [String] = []
           if line != "" {
               if line.range(of: "\"") != nil {
                   var textToScan:String = line
                   var value:String?
                   var textScanner:Scanner = Scanner(string: textToScan)
                while !textScanner.isAtEnd {
                       if (textScanner.string as NSString).substring(to: 1) == "\"" {


                           textScanner.currentIndex = textScanner.string.index(after: textScanner.currentIndex)

                           value = textScanner.scanUpToString("\"")
                           textScanner.currentIndex = textScanner.string.index(after: textScanner.currentIndex)
                       } else {
                           value = textScanner.scanUpToString(",")
                       }

                        values.append(value! as String)

                    if !textScanner.isAtEnd{
                            let indexPlusOne = textScanner.string.index(after: textScanner.currentIndex)

                        textToScan = String(textScanner.string[indexPlusOne...])
                        } else {
                            textToScan = ""
                        }
                        textScanner = Scanner(string: textToScan)
                   }

                   // For a line without double quotes, we can simply separate the string
                   // by using the delimiter (e.g. comma)
               } else  {
                   values = line.components(separatedBy: ",")
               }

               // Put the values into the tuple and add it to the items array
               let item = (values[0], values[1], values[2], values[3], values[4], values[5])
               items.append(item)

            }
        }
        return items
    }
}

