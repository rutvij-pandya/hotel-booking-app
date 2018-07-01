import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { Http, Response, Headers, RequestOptions } from '@angular/http';

import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/throw';

import { Hotel } from '../../models/hotel';
import { Availability } from '../../models/availability';
import { RoomType } from '../../models/room-type';


const API_URL = environment.apiUrl;

@Injectable({
  providedIn: 'root'
})

export class HotelApiService {

  constructor(private http: Http) { }

  // API: GET /hotels
  public getAllHotels(): Observable<Hotel[]> {
    return this.http
      .get(API_URL + '/hotels.json')
      .map(response => {
        const hotels = response.json();
        return hotels.map((hotel) => new Hotel(hotel));
      })
      .catch(this.handleError);
  }

  // API: GET /hotels/comfort-inn-pomona/1133213962/availability.json?check_in_date=2018-07-10&check_out_date=2018-08-09
  public checkAvailability(hotelSlug: string, roomTyprId: number) Observable<Response> {
    return this.http
      .get(API_URL + '/hotels/' + hotelSlug + '/' + roomTyprId.toString() + '/availability.json')
      .map(response: Response => {
        const resp = response.json();
        const result = {'hotel': new Hotel, 'availability': new Availability, 'room_types': []};
        result.hotel = resp.hotel;
        result.availability = resp.availability;
        result.room_types = resp.room_types.map((room_type) => new RoomType(room_type));

        return result;
      })
      .catch(this.handleError);
      // .catch(this.baseService.handleError);
  }


  private handleError (error: Response | any) {
    // console.error('ApiService::handleError', error);
    return Observable.throw(error);
  }
}
