import { Component, Inject, OnInit, ViewEncapsulation } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from "@angular/material";

// import { Router, ActivatedRoute } from "@angular/router";
import { HotelDataService } from '../../../services/hotel/hotel-data.service';
import { Hotel } from '../../../models/hotel';

import { FormBuilder, FormGroup, FormControl } from "@angular/forms";
import * as moment from 'moment';

@Component({
  selector: 'app-hotel-availability',
  templateUrl: './hotel-availability.component.html',
  styleUrls: ['./hotel-availability.component.css'],

  providers: [ HotelDataService ]
})
export class HotelAvailabilityComponent implements OnInit {

  id:number;
  name:string;
  hotelSlug:string;
  minimumStay:number;

  private hotelForm: FormGroup;
  private hotel: Hotel;
  private selectedRoom: any;
  private minCheckInDate: Date;
  private minCheckOutDate: Date;
  
  constructor(
    private hotelDataService: HotelDataService,
    private formBuilder: FormBuilder,
    private dialogRef: MatDialogRef<HotelAvailabilityComponent>,
    @Inject(MAT_DIALOG_DATA) { id, name, slug, minimum_stay }:Hotel
    // private route: ActivatedRoute
  ) {     

    // this.id = id;
    this.name = name;
    this.hotelSlug = slug;
    this.minimumStay = minimum_stay;
  }

  ngOnInit() {
    // Access route param ID
    this.getAvailability("init");

    this.minCheckInDate = new Date();
  }

  getAvailability(source) {
    let hotelSlug, selectedRoomId, checkInDate, checkOutDate;

    if (source == "change") {
      hotelSlug = this.hotel.slug;      
      checkInDate = moment(this.hotel.availability.check_in_date).format('MM-DD-YYYY');
      checkOutDate = moment(this.hotel.availability.check_out_date).format('MM-DD-YYYY');
      
      if (this.selectedRoom) {
        selectedRoomId = this.selectedRoom.id;
      } 
      
    } else {
      hotelSlug = this.hotelSlug;
    }

    // Get hotel availability details
    this.hotelDataService
      .checkAvailability(hotelSlug, selectedRoomId, checkInDate, checkOutDate)
      .subscribe(
        hotel => {
          this.hotel = hotel;

          this.hotel.availability.check_in_date = moment(this.hotel.availability.check_in_date);
          this.hotel.availability.check_out_date = moment(this.hotel.availability.check_out_date);

          this.selectedRoom = this.hotel.room_types[0];

          this.initForm();          
        });            
  }

  // Initialize hotel availability form
  initForm() {
    this.hotelForm = new FormGroup({
        'name': new FormControl(this.hotel.name),
        'checkInDate': new FormControl(moment(this.hotel.availability.check_in_date)),
        'checkOutDate': new FormControl(moment(this.hotel.availability.check_out_date)),
        'selectedRoomType': new FormControl()
    })
  }

  changeRoomType(event: MdOptionSelectionChange, roomType: any) {
    if (event.source.selected) {
      console.log('You selected: ' , roomType);
      this.selectedRoom = roomType;
    }
  }

  changeDuration(event: MatDatepickerInputEvent<Date>, source: string) {

    console.log('You selected date: ' , new Date(event.value));

    if (source == 'checkIn') {
      this.hotel.availability.check_in_date = new Date(event.value);
      // Update checkOut date - checkInDate + minimumStay
      this.hotel.availability.check_out_date = new Date(event.value.add(this.minimumStay, 'days'));

      console.log('CHANGE - availability.check_out_date: ' , this.hotel.availability.check_out_date);
    } 
    // Update availability
    this.getAvailability("change");
  }

  save() {
    this.dialogRef.close(this.hotelForm.value);
  }

  close() {
    this.dialogRef.close();
  }

}
