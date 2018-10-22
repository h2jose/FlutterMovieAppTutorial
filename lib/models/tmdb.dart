class Tmdb{
  static const apiKey = "03400e684b0d8c24d655190914d4aab8";

  static const baseUrl = "https://api.themoviedb.org/3/movie/";
  static const baseImageUrl = "https://image.tmdb.org/t/p/";

  static const nowPlayingUrl = "${baseUrl}now_playing?api_key=$apiKey&language=es";
  static const upcomingUrl = "${baseUrl}upcoming?api_key=$apiKey&language=es";
  static const popularUrl = "${baseUrl}popular?api_key=$apiKey&language=es";
  static const topRatedUrl = "${baseUrl}top_rated?api_key=$apiKey&language=es";

}