//
//  ViewController.swift
//  Snapchat
//
//  Created by Jhordan Mayhua on 14/05/18.
//  Copyright © 2018 MCJ_Developers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class iniciarSesionViewController: UIViewController {
    //Outlets para usuarios registrados
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    
    //Outlets para usuarios que recien se registraran
    @IBOutlet weak var txtEmailRegister: UITextField!
    @IBOutlet weak var txtPassRegister: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func mostrarAlerta(title: String, message: String, segue:String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let guiaOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.performSegue(withIdentifier: segue, sender: nil)
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: {(action) in
            
        })
        alertaGuia.addAction(guiaOk)
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
    }

    @IBAction func iniciarSessionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtemail.text!, password: txtpass.text!) { (user, error) in
            print("Intentado iniciar sesion")
            if error != nil {
                self.mostrarAlerta(title: "Oops" , message: "No te encuentras registrado, REGISTRATE!", segue: "registrarUsuarioSegue")
            }else{
                print("Inicio de Sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }

    @IBAction func registrarUsuarioTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.txtEmailRegister.text!, password: self.txtPassRegister.text!, completion: {(user,error) in print("Intentando crear usuario")
            if error != nil {
                self.mostrarAlerta(title: "Oops", message: "No se pudo crear tu usuario", segue: "registrarUsuarioSegue")
            }else {
                
            self.mostrarAlerta(title: "Felicidades", message: "Tu usuario Fue creado con exito", segue: "inicioSesionNuevo")
            Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                
                
            }
        })
        
    }
    
    
 
}

