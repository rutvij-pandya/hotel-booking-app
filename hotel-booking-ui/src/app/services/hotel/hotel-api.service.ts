import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { Http, Response, Headers, RequestOptions, URLSearchParams } from '@angular/http';

import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/throw';

import { Hotel } from '../../models/hotel';
import { Availability } from '../../models/availability';
import { RoomType } from '../../models/room-type';

import { BaseService } from '../base.service';


const API_URL = environment.apiUrl;

@Injectable({
  providedIn: 'root'
})

export class HotelApiService {

  constructor(private http: Http,
              private baseService: BaseService) { }

  // API: GET /hotels
  public getAllHotels(): Observable<Hotel[]> {
    return this.http
      .get(API_URL + '/hotels.json', this.baseService.options)
      .map(response => {
        const hotels = response.json();
        return hotels.map((hotel) => new Hotel(hotel));
      })
      .catch(this.baseService.handleError);
  }

  // API: GET /hotels/comfort-inn-pomona/availability.json?room_type_id=1133213962&check_in_date=2018-07-10&check_out_date=2018-08-09
  public checkAvailability(hotelSlug: string, roomTyprId: number, checkInDate: string, checkOutDate: string): Observable<Hotel> {
    
    let apiUrl = API_URL;
    let apiParams = new URLSearchParams();
    
    // if (roomTyprId) {
    //   apiParams.append('room_type_id', roomTyprId.toString());  
    // }
    
    if (checkInDate && checkOutDate) {
      apiParams.append('check_in_date', checkInDate); 
      apiParams.append('check_out_date', checkOutDate);       
    }

    this.baseService.options.params = apiParams;    

    apiUrl += ('/hotels/' + hotelSlug + '/availability.json'); 

    return this.http
      .get(apiUrl, this.baseService.options)
      .map(response => {
        return new Hotel(response.json());
      })
      .catch(this.baseService.handleError);
  }

  // API: POST /bookings.json
  public createBooking(roomTyprId: number, checkInDate: string, checkOutDate: string): Observable<any> {
    let data = { "room_type_id": roomTyprId, "check_in_date": checkInDate, "check_out_date": checkOutDate }

    return this.http
      .post(API_URL + '/bookings.json', data)
      .map(response => {
        return response.json();
      })
      .catch(this.baseService.handleError);
  }

}
