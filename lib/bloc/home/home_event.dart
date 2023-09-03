abstract class HomeEvent {

}

class HomeGetInitializeData extends HomeEvent {

}

class HomeProductSearched extends HomeEvent {
  String query;
  HomeProductSearched(this.query);
}