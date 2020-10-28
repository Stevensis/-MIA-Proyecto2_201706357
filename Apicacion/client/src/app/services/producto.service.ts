import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Categoria } from '../models/categoria';
import { Producto } from '../models/producto';
@Injectable({
  providedIn: 'root'
})
export class ProductoService {

  constructor(private http: HttpClient) { }

  url:string = "http://localhost:3009/";

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
}