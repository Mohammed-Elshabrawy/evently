String getImageByMode({
  required String light,
  required String dark,
  required bool isLight,
}) {
  return isLight ? light : dark;
}
