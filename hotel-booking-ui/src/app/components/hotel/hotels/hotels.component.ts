import { Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogConfig } from "@angular/material";
import { Hotel } from '../../../models/hotel';
import { HotelAvailabilityComponent } from '../hotel-availability/hotel-availability.component';
import { HotelDataService } from '../../../services/hotel/hotel-data.service';

@Component({
  selector: 'app-hotels',
  templateUrl: './hotels.component.html',
  styleUrls: ['./hotels.component.css'],

  providers: [HotelDataService]
})
export class HotelsComponent implements OnInit {

  hotels: Hotel[] = [];

  availabilityDialogRef: MatDialogRef<HotelAvailabilityComponent>;

  constructor(
    private dialog: MatDialog,
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

  checkAvailability({id, name, slug, minimum_stay}:Hotel) {
    const dialogConfig = new MatDialogConfig();

    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;

    dialogConfig.data = {
      id, name, slug, minimum_stay
    };

    // const dialogRef = this.dialog.open(HotelAvailabilityComponent, dialogConfig);
    this.availabilityDialogRef = this.dialog.open(HotelAvailabilityComponent, dialogConfig);


    this.availabilityDialogRef.afterClosed().subscribe(
      data => {        
        console.log("Dialog output:", data)
        let checkInDate, checkOutDate;

        checkInDate = data.checkInDate.format('DD-MM-YYYY');
        checkOutDate = data.checkOutDate.format('DD-MM-YYYY');

        this.hotelDataService
          .createBooking(data.selectedRoomType, checkInDate, checkOutDate)
          .subscribe(
            booking => {
              console.log("Booking confirmation:", booking)
            }
          );
      }
    );
  }

}
