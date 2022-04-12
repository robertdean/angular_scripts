import { NgModule } from '@angular/core';
import { SharedComponent } from './shared.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { AccessDeniedComponent } from './components/access-denied/access-denied.component';
import { NavComponent } from './components/nav/nav.component';
import { MaterialModule } from './material.module';
import { CommonModule } from '@angular/common';



@NgModule({
  declarations: [
    SharedComponent,
    PageNotFoundComponent,
    AccessDeniedComponent,
    NavComponent
  ],
  imports: [
    CommonModule,
    MaterialModule
  ],
  exports: [
    CommonModule,
    MaterialModule,    
    PageNotFoundComponent,
    AccessDeniedComponent,
    NavComponent
  ]
})
export class SharedModule { }
