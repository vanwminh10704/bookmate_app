import '../../models/book_model.dart';
import 'package:flutter/material.dart';
import '../../components/book_item.dart';
import '../../components/app_dialog.dart';
import '../../controller/book_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookController _bookController = BookController();
  List<BookModel> _books = [];
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    await _bookController.loadBookList();
    await _bookController.loadFavoriteBooks();
    setState(() {
      _books = _bookController.getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5EF),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20.0,
          bottom: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'BookMate',
              style: TextStyle(
                color: Color(0xFFBDC65B),
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, idx) {
                  BookModel book = _books[idx];
                  return BookItem(
                    book: book,
                    onAdd: () async {
                      await _bookController.toggleFavorite(book);
                      setState(() {});
                    },
                    onDelete: () async {
                      await AppDialog.dialog(
                        title: const Text(
                          "🗑️ Xác nhận xoá sách",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                        context,
                        content: "Bạn có chắc chắn muốn xoá sách này không?",
                        confirmText: "Xoá",
                        action: () async {
                          await _bookController.removeBook(book);
                          await _loadBooks();
                        },
                      );
                    },
                    isFavorite: _bookController.isFavorite(book),
                  );
                },
                separatorBuilder: (context, idx) =>
                    const SizedBox(height: 20.0),
                itemCount: _books.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
