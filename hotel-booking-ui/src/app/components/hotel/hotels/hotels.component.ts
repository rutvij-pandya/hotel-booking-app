import { Component, OnInit } from '@angular/core';
import { Hotel } from '../../../models/hotel';
import { HotelDataService } from '../../../services/hotel/hotel-data.service';

@Component({
  selector: 'app-hotels',
  templateUrl: './hotels.component.html',
  styleUrls: ['./hotels.component.css'],

  providers: [HotelDataService]
})
export class HotelsComponent implements OnInit {

  hotels: Hotel[] = [];

  constructor(
    private hotelDataService: HotelDataService
  ) { }

  public ngOnInit() {
    this.hotelDataService
      .getAllHotels()
      .subscribe(
        (hotels) => {
          this.hotels = hotels;
        }
      );
  }

}
