export class Hotel {
  id: number;
  name: string = '';
  slug: string = '';
  minimum_stay: number;
  cover_picture: string = ''; 

  constructor(values: Object = {}) {
    Object.assign(this, values);
  }
}
