class PokemonNumbers {
  static String setThreeNumbers(int number) {
    return (number < 10)
        ? '00$number'
        : (number < 100)
            ? '0$number'
            : '$number';
  }
}
