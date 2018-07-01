import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HotelListHeaderComponent } from './hotel-list-header.component';

describe('HotelListHeaderComponent', () => {
  let component: HotelListHeaderComponent;
  let fixture: ComponentFixture<HotelListHeaderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HotelListHeaderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HotelListHeaderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
