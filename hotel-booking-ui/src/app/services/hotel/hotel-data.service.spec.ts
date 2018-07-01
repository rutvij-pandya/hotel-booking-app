import { TestBed, inject } from '@angular/core/testing';
import { Hotel } from './hotel';
import { HotelDataService } from './hotel-data.service';

describe('HotelDataService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [HotelDataService]
    });
  });

  it('should be created', inject([HotelDataService], (service: HotelDataService) => {
    expect(service).toBeTruthy();
  }));
});
