extension NullableElementIterable<E> on Iterable<E?> {
  Iterable<E> whereNonNull() {
    return where((element) => element != null).map((e) => e!);
  }
}
