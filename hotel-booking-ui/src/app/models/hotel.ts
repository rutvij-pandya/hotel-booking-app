import { RoomType } from './room-type';
import { Availability } from './availability';

export class Hotel {
  id: number;
  name: string = '';
  slug: string = '';
  minimum_stay: number;
  cover_picture: string = ''; 
  room_types: RoomType[] = [];
  availability: Availability = new Availability;

  constructor(values: Object = {}) {
    Object.assign(this, values);
  }
}
