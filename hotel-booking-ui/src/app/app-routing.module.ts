import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent } from './app.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';

import { HotelsComponent } from './components/hotel/hotels/hotels.component';
import { HotelAvailabilityComponent } from './components/hotel/hotel-availability/hotel-availability.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'hotels',
    pathMatch: 'full'
  },
  {
    path: 'hotels',
    component: HotelsComponent    
  },
  {
    path: 'hotels/:id/booking',
    component: HotelAvailabilityComponent
  },
  // NOTE - '**' - PageNotFoundComponent - MUST BE the last item in 'Routes[]'
  {
    path: '**',
    component: PageNotFoundComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: []
})
export class AppRoutingModule {
}

