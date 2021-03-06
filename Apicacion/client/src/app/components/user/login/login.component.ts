import { templateJitUrl } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from '../../../services/user.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
   image :string="foto.jpg";

  constructor(private userService: UserService,private router:Router) {
    this.userService.limpiarSesion();
   }

  user:User ={
    id: 0, 
    nombre: '',
    apellido: '',
    pass: '',
    email: '',
    nacimieno: new Date(),
    credito: 10000,
    idTipo_U: 2,
  }

  correoRecuperar:string='';

  ngOnInit(): void {
  }
  tempU : any;
  login(){
    delete this.user.id;
    delete this.user.nombre;
    delete this.user.apellido;
    delete this.user.nacimieno;
    delete this.user.credito;
    delete this.user.idTipo_U;
    console.log(this.user)
    this.userService.login(this.user).subscribe(
      res => {
        this.tempU=res;
       
          if(this.tempU.confirmacion==1){
            this.userService.setUser(res);
            
            if(this.tempU.rol==1){
              this.addBitacora();
              document.location.href="admin/categorias"
              //this.router.navigate(['admin/categorias']);
            }else if(this.tempU.rol==2){
              this.addBitacora();
              document.location.href="user/home"
             // this.router.navigate(['user/home']);
            }
          }else{
            alert("No ah balidado la cuenta");
          }
        
        
        console.log(res)},
      err => console.log(err) 
     );
  }

  addBitacora(){
    var BitacoraTemp={
      email:this.userService.getSesion().email,
      descripcion:'Este usuario ah iniciado sesion'
    }
    this.userService.addBitacora(BitacoraTemp).subscribe(
      res=>{console.log(res);
      },
      err=>console.log(err)
      
    );
  }

  recuperarContrasenia(){
    console.log(this.correoRecuperar);
    this.userService.getUserEmail(this.correoRecuperar).subscribe(
      res =>{
        this.tempU=res;
        this.userService.sendEmailRecuperar(this.tempU).subscribe(
          res=> {console.log(res); },
          err=> alert(err) 
          );
        alert('Mensaje enviado a su correo');
      },
      err =>{console.log(err)}
    );
  }
}
