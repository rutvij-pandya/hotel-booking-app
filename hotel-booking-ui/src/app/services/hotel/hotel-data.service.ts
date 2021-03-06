import { Injectable } from '@angular/core';
import { Hotel } from '../../models/hotel';
import { HotelApiService } from './hotel-api.service';
import { Observable } from 'rxjs/Observable';

@Injectable({
  providedIn: 'root'
})
export class HotelDataService {

  // Placeholder for last id so we can simulate
  // automatic incrementing of ids
  lastId: number = 0;

  constructor(private api: HotelApiService) { }

  // centralize the business logic in a service.

  // Simulate GET /hotels
  getAllHotels(): Observable<Hotel[]> {
    return this.api.getAllHotels();
  }

  // Simulate GET /hotels/comfort-inn-pomona/availability.json?room_type_id=1133213962&check_in_date=2018-07-10&check_out_date=2018-08-09
  checkAvailability(hotelSlug: string, roomTypeId: number, checkInDate: string, checkOutDate: string): Observable<Hotel> {        
    return this.api.checkAvailability(hotelSlug, roomTypeId, checkInDate, checkOutDate);
  }

  // Simulate POST /bookings.json
  createBooking(roomTyprId: number, checkInDate: string, checkOutDate: string): Observable<any> {
    return this.api.createBooking(roomTyprId, checkInDate, checkOutDate);
  }
}
