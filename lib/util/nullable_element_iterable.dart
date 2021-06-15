extension NullableElementIterable<E> on Iterable<E?> {
  Iterable<E> whereNonNull() {
    return this.where((element) => element != null).map((e) => e!);
  }
}
