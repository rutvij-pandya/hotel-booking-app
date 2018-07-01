import { Component, OnInit, Input } from '@angular/core';
import { Hotel } from '../../../models/hotel';

@Component({
  selector: 'app-hotel-list-item',
  templateUrl: './hotel-list-item.component.html',
  styleUrls: ['./hotel-list-item.component.css']
})
export class HotelListItemComponent implements OnInit {

  @Input() 
  hotel: Hotel;

  constructor() { }

  ngOnInit() {
  }

}
