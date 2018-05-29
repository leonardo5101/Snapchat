//
//  ImageViewController.swift
//  Snapchat
//
//  Created by Jhordan Mayhua on 21/05/18.
//  Copyright © 2018 MCJ_Developers. All rights reserved.
//

import UIKit
import Firebase

class ImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var btnChooseContact: UIButton!
    @IBOutlet weak var txtdescripcion: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    func mostrarAlerta(title:String, message:String, action:String){
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelock = UIAlertAction(title: title, style: .default, handler: nil)
        alertaGuia.addAction(cancelock)
        present(alertaGuia, animated: true, completion: nil)
    }
    @IBAction func btnChooseContactTapped(_ sender: Any) {
        btnChooseContact.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData, metadata: nil, completion: {(metadata,error) in
            if error != nil {
                self.mostrarAlerta(title:"Error", message:"Se produjo un error al subir la imagen", action:"Cancelar")
                self.btnChooseContact.isEnabled = true
                print("Ocurrio un error al subir la imagen")
            }else{
                self.performSegue(withIdentifier: "ChooseContactSegue", sender: nil)
            }
        })
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

}
