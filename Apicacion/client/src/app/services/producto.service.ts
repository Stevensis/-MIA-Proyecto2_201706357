import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Categoria } from '../models/categoria';
import { Producto } from '../models/producto';
@Injectable({
  providedIn: 'root'
})
export class ProductoService {

  constructor(private http: HttpClient) { }

  url:string = "http://192.168.0.5:3009/";

  addCategoria(categoria:Categoria){
    return this.http.post(`${this.url}producto/categoria`,categoria);
  }

  getCategoria(id:number){
    return this.http.get(`${this.url}producto/categoria/${id}`)
  }

  getCategorias(){
    return this.http.get(`${this.url}producto/categorias`);
  }

  updateCategoria(categoria:Categoria){
    return this.http.post(`${this.url}producto/categorias/update`,categoria);
  }

  addProducto(producto:Producto){
    return this.http.post(`${this.url}producto/`,producto);
  }

  getProducto(id:string){
    return this.http.get(`${this.url}producto/Inicio/${id}`);  
  }

  getMyProducto(id:string){
    return this.http.get(`${this.url}producto/MisProductos/${id}`);  
  }

  getFiltro(sql:any){
    return this.http.post(`${this.url}producto/Ordenar/`,sql);
  }

  getDetalleProducto(id:string){
    return this.http.get(`${this.url}producto/DetalleProducto/${id}`);  
  }

  addLike(objeto:any){
    return this.http.post(`${this.url}producto/Like`,objeto);
  }

  getAllLikes(id:string){
    return this.http.get(`${this.url}producto/CantLikes/${id}`);
  }

  addComentario(objeto:any){
    return this.http.post(`${this.url}producto/comentario`,objeto);
  }

  getComentarios(id:string){
    return this.http.get(`${this.url}producto/comentarios/${id}`);
  }

  addDenuncia(objeto:any){
    return this.http.post(`${this.url}producto/Denuncias`,objeto);
  }

  getDenuncia(){
    return this.http.get(`${this.url}producto/Denuncias`);
  }

  updateDenuncia(objeto:any){
    return this.http.post( `${this.url}producto/EstadoDenuncia`,objeto);
  }

  sendEmail(objeto:any){
    return this.http.post( `${this.url}producto/SendMail`,objeto);
  }

  addCarrito(objeto:any){
    return this.http.post(`${this.url}producto/Carrito/add`,objeto)
  }
  
  getCarrito(id:string){
    return this.http.get(`${this.url}producto/Carrito/all/${id}`);
  }

  deleteOneProduct(id:string){
    return this.http.get(`${this.url}producto/Carrito/Delete/${id}`);
  }

  deleteAllCarrito(id:string){
    return this.http.get(`${this.url}producto/Carrito/DeleteAll/${id}`);
  }

  addCompra(objeto:any){
    return this.http.post(`${this.url}producto/Compra/add`,objeto);
  }

  sendEmailCOmpra(objeto:any){
    return this.http.post(`${this.url}producto/Compra/correo`,objeto);
  }

}
