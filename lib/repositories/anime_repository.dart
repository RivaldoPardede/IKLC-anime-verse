import 'package:anime_verse/models/anime.dart';
import 'package:jikan_api/jikan_api.dart' as jikan;

class AnimeRepository {
  final jikan.Jikan _jikan = jikan.Jikan();

  Future<List<Anime>> getTopAnime({int page = 1}) async {
    try {
      final response = await _jikan.getTopAnime(page: page);

      await Future.delayed(const Duration(milliseconds: 400));

      final animeList = response.map((jikanAnime) {
        return Anime(
          malId: jikanAnime.malId,
          title: jikanAnime.title,
          imageUrl: jikanAnime.imageUrl,
          largeImageUrl: jikanAnime.imageUrl,
          genres: jikanAnime.genres.map((g) => g.name).toList(),
          score: jikanAnime.score,
          episodes: jikanAnime.episodes,
          synopsis: jikanAnime.synopsis,
          type: jikanAnime.type,
          year: jikanAnime.year,
          ageRating: jikanAnime.rating,
        );
      }).toList();

      return animeList.where((anime) => anime.isAppropriateContent).toList();
    } catch (e) {
      throw Exception('Failed to fetch top anime: $e');
    }
  }

  Future<List<Anime>> searchAnime(String query, {int limit = 20}) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }

      final response = await _jikan.searchAnime(query: query);

      await Future.delayed(const Duration(milliseconds: 400));

      final animeList = response.map((jikanAnime) {
        return Anime(
          malId: jikanAnime.malId,
          title: jikanAnime.title,
          imageUrl: jikanAnime.imageUrl,
          largeImageUrl: jikanAnime.imageUrl,
          genres: jikanAnime.genres.map((g) => g.name).toList(),
          score: jikanAnime.score,
          episodes: jikanAnime.episodes,
          synopsis: jikanAnime.synopsis,
          type: jikanAnime.type,
          year: jikanAnime.year,
          ageRating: jikanAnime.rating,
        );
      }).toList();

      return animeList.where((anime) => anime.isAppropriateContent).toList();
    } catch (e) {
      throw Exception('Failed to search anime: $e');
    }
  }

  Future<Anime> getAnimeById(int malId) async {
    try {
      final response = await _jikan.getAnime(malId);

      await Future.delayed(const Duration(milliseconds: 400));

      return Anime(
        malId: response.malId,
        title: response.title,
        imageUrl: response.imageUrl,
        largeImageUrl: response.imageUrl,
        genres: response.genres.map((g) => g.name).toList(),
        score: response.score,
        episodes: response.episodes,
        synopsis: response.synopsis,
        type: response.type,
        year: response.year,
        status: response.status,
        ageRating: response.rating,
      );
    } catch (e) {
      throw Exception('Failed to fetch anime details: $e');
    }
  }
}