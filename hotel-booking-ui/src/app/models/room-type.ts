export class RoomType {
  id: number;
  name: string = '';  
  available: boolean;
  rate: string;

  constructor(values: Object = {}) {
    Object.assign(this, values);
  }
}
