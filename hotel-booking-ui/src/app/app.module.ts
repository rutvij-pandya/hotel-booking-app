import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
// import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { MaterializeModule } from 'angular2-materialize';
import { 
  MatInputModule,
  MatDatepickerModule, 
  MatListModule, 
  MatSelectModule,   
  MatDialogModule,
  MatSidenavModule,
  MatToolbarModule
} from "@angular/material";
import { MatButtonModule } from '@angular/material/button'
import { MatIconModule } from '@angular/material/icon';
import { MatCardModule } from '@angular/material/card';
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { MatMomentDateModule } from "@angular/material-moment-adapter";

import { AppComponent } from './app.component';
import { HotelsComponent } from './components/hotel/hotels/hotels.component';
import { HotelListHeaderComponent } from './components/hotel/hotel-list-header/hotel-list-header.component';
import { HotelListItemComponent } from './components/hotel/hotel-list-item/hotel-list-item.component';
import { HotelAvailabilityComponent } from './components/hotel/hotel-availability/hotel-availability.component';

import { BaseService } from "./services/base.service";
import { HotelApiService } from './services/hotel/hotel-api.service';
import { HotelDataService } from './services/hotel/hotel-data.service';
import { AppRoutingModule } from './app-routing.module';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';


@NgModule({
  declarations: [
    AppComponent,
    HotelListHeaderComponent,
    HotelListItemComponent,
    HotelAvailabilityComponent,
    HotelsComponent,
    PageNotFoundComponent
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,    
    HttpModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    MaterializeModule,
    MatInputModule,
    MatDatepickerModule, 
    MatMomentDateModule,
    MatListModule, 
    MatSelectModule,
    MatDialogModule,
    MatSidenavModule,
    MatToolbarModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule
  ],
  providers: [
    BaseService,
    HotelDataService, 
    HotelApiService
  ],
  bootstrap: [AppComponent],
  entryComponents: [HotelAvailabilityComponent]
})
export class AppModule { }
