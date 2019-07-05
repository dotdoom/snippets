class Vehicle {
  void run() {
    print('I am a vehicle!');
  }
}

class ElectricCar {
  void run() {
    super.run();
    print('I am an electric car!');
  }
}

class Car extends Vehicle with ElectricCar {
  @override
  void run() {
    print('I am a car!');
    super.run();
  }
}

void main() {
  Vehicle x = new Car();
  x.run();
}
