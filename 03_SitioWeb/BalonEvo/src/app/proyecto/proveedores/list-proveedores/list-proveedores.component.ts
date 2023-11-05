import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-list-proveedores',
  templateUrl: './list-proveedores.component.html',
  styleUrls: ['./list-proveedores.component.css']
})
export class ListProveedoresComponent {

  proveedores: any[] = []; // Aquí almacenaremos la lista de usuarios

  mostrarFormulario = false;
  proveedorSeleccionado: any = {}; // Declarar esta variable en tu componente


  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.obtenerProveedores();
  }

  alternarFormulario(proveedor: any) {
    this.proveedorSeleccionado = proveedor; // Asigna los valores del usuario
    this.mostrarFormulario = !this.mostrarFormulario;
  }


obtenerProveedores() {
    this.http.get('https://localhost:5247/api/Proveedor').subscribe(
      (response: any) => {
        this.proveedores = response;
      },
      (error) => {
        console.error('Error al obtener proveedores:', error);
      }
    );
  }

  eliminarProveedor(id: number) {
    this.http.delete(`https://localhost:5247/api/Proveedor/${id}`).subscribe(
      () => {
        this.obtenerProveedores();
        Swal.fire({
          icon: 'success',
          title: 'Éxito',
          text: 'Usuario inhabilitado correctamente'
        });
      },
      (error) => {
        Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'No se pudo eliminar el usuario'
        });
      }
    );
  }

}
