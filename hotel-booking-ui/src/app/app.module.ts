import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { MaterializeModule } from 'angular2-materialize';

import { AppComponent } from './app.component';
import { HotelsComponent } from './components/hotel/hotels/hotels.component';
import { HotelListHeaderComponent } from './components/hotel/hotel-list-header/hotel-list-header.component';
import { HotelListItemComponent } from './components/hotel/hotel-list-item/hotel-list-item.component';
import { HotelAvailabilityComponent } from './components/hotel/hotel-availability/hotel-availability.component';

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
    FormsModule,
    HttpModule,
    MaterializeModule
  ],
  providers: [
    HotelDataService, 
    HotelApiService
  ],
  bootstrap: [AppComponent]  
})
export class AppModule { }
