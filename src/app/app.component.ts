import { Component, AfterViewInit, OnInit } from "@angular/core";
import { fromEvent, of, interval, merge, Subject } from "rxjs";
import {
  scan,
  mapTo,
  startWith,
  pluck,
  shareReplay,
  distinctUntilChanged
} from "rxjs/operators";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"]
})
export class AppComponent implements OnInit {
  up;
  down;
  up$;
  down$;
  initialState = { direction: "up" };
  programmaticCommands;
  commands$;
  state$;
  direction$;
  direction2$;
  query;

  ngOnInit() {
    //Utility Operators
    //We want to pluck properties from an object and only emit if distinct
    function query(name) {
      function queryprop(ob) {
        return ob.pipe(pluck(name), distinctUntilChanged());
      }
      return queryprop;
    }
    this.query = query;

    //Getting items from the DOM
    this.up = document.querySelector("#up");
    this.down = document.querySelector("#down");

    //Setting the initial state, it's properties will become command observables
    this.initialState = { direction: "up" };

    //Command observables: i.e. Mapping DOM events to properties of state
    this.up$ = fromEvent(this.up, "click").pipe(mapTo({ direction: "up" }));
    this.down$ = fromEvent(this.down, "click").pipe(
      mapTo({ direction: "down" })
    );
    //Special command observable that allows us to use javascript to push commands
    this.programmaticCommands = new Subject();

    //All state is derived from the previous state and this observable
    this.commands$ = merge(
      this.up$,
      this.down$,
      this.programmaticCommands.asObservable()
    );

    //We use StartWith so values will initialize properly
    //We use ShareReplay (see also share and replay) so all subscriptions use one
    //observable and shareReplay(1) so derived property observables get latest value
    this.state$ = this.commands$.pipe(
      //Need startWith in addition to the default value in scan so the view initializes properly with non-null values
      startWith(this.initialState),
      scan((state, command) => ({ ...state, ...command }), this.initialState),
      shareReplay(1)
    );

    //Derived property observables
    this.direction$ = this.state$.pipe(pluck("direction"));
    this.direction2$ = this.state$.pipe(this.query("direction"));
  }
}
