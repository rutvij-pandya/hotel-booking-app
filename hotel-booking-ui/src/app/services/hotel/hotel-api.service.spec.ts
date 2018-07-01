import { TestBed, inject } from '@angular/core/testing';

import { HotelApiService } from './hotel-api.service';

describe('HotelApiService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [HotelApiService]
    });
  });

  it('should be created', inject([HotelApiService], (service: HotelApiService) => {
    expect(service).toBeTruthy();
  }));
});
