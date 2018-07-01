import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from "@angular/router";

import { HotelDataService } from '../../../services/hotel/hotel-data.service';

import { Hotel } from '../../../models/hotel';
import { Availability } from '../../../models/availability';
import { RoomType } from '../../../models/room-type';

@Component({
  selector: 'app-hotel-availability',
  templateUrl: './hotel-availability.component.html',
  styleUrls: ['./hotel-availability.component.css'],

  providers: [HotelDataService]
})
export class HotelAvailabilityComponent implements OnInit {

  hotel: Hotel = new Hotel;
  availability: Availability = new Availability;
  hotelSlug: string;

  constructor(
    private hotelDataService: HotelDataService,
    private route: ActivatedRoute
  ) { }

  public ngOnInit() {
    // Access route param ID
    this.hotelSlug = this.route.snapshot.params['id']

    this.hotelDataService
      .checkAvailability(this.hotelSlug, 496996176)
      .subscribe(
        (response) => {
          this.hotel = response.hotel;
        }
      );
  }

}
