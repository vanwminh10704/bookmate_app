import 'package:book_flutter/models/book_model.dart';
import 'package:book_flutter/services/shared_prefs.dart';

class BookController {
  static final BookController _instance = BookController._internal();
  factory BookController() => _instance;
  BookController._internal();
  List<BookModel> _books = books;
  List<BookModel> _favoriteBooks = [];
  List<BookModel> getBooks() => _books;
  List<BookModel> getFavoriteBooks() => _favoriteBooks;
  final SharedPrefs _sharedPrefs = SharedPrefs();
  Future<void> loadBookList() async {
    _books = await _sharedPrefs.getBookList();
    if (_books.isEmpty) {
      _books = books; // nếu prefs rỗng, load từ list mặc định ban đầu
      await _sharedPrefs.saveBookList(_books);
    }
  }

  Future<void> loadFavoriteBooks() async {
    _favoriteBooks = await _sharedPrefs.getFavoriteBooks();
  }

  Future<void> toggleFavorite(BookModel book) async {
    if (_favoriteBooks.any((b) => b.id == book.id)) {
      _favoriteBooks.removeWhere((b) => b.id == book.id);
    } else {
      _favoriteBooks.add(book);
    }
    await _sharedPrefs.saveFavoriteBooks(_favoriteBooks);
  }

  bool isFavorite(BookModel book) {
    return _favoriteBooks.any((b) => b.id == book.id);
  }

  Future<void> removeBook(BookModel book) async {
    _books.removeWhere((b) => b.id == book.id);
    _favoriteBooks.removeWhere((b) => b.id == book.id);
    await _sharedPrefs.saveBookList(_books);
    await _sharedPrefs.saveFavoriteBooks(_favoriteBooks);
  }

  List<BookModel> searchBooksByName(String query) {
    final q = query.toLowerCase();
    return _books.where((book) {
      final name = book.nameBook?.toLowerCase() ?? '';
      return name.contains(q);
    }).toList();
  }
}
