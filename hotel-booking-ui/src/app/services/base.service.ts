import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { Observable } from 'rxjs/Observable';

@Injectable()
export class BaseService {

  constructor() { 
  }

  // Set URL Headers
  public headers = new Headers({ 
    'Content-Type': 'application/json'
  });
  public options = new RequestOptions({ headers: this.headers });

  // API Error handling
  public handleError (error: Response | any) {
    console.error('ApiService::handleError', error);
    alert(error.status + ' : ' + error._body);
    return Observable.throw(error);
  }

}