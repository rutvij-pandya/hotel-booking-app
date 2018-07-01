import { Hotel } from './hotel';

describe('Hotel', () => {
  it('should create an instance', () => {
    expect(new Hotel()).toBeTruthy();
  });

  it('should accept values in the constructor', () => {
    let hotel = new Hotel({
      name: 'Comfort Inn Pomona',
      slug: 'comfort-inn-pomona',
      available: true
    });
    expect(hotel.name).toEqual('Comfort Inn Pomona');
    expect(hotel.slug).toEqual('comfort-inn-pomona');
    expect(hotel.available).toEqual(true);
  });

});
