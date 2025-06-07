import 'package:flutter/material.dart';
import 'package:book_flutter/models/book_model.dart';
import 'package:book_flutter/components/book_item.dart';
import 'package:book_flutter/components/app_dialog.dart';
import 'package:book_flutter/controller/book_controller.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final BookController _bookController = BookController();
  List<BookModel> _favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteBooks();
  }

  Future<void> _loadFavoriteBooks() async {
    await _bookController.loadFavoriteBooks();
    setState(() {
      _favoriteBooks = _bookController.getFavoriteBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5EF),

      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20.0,
          bottom: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Danh Sách Yêu Thích ',
              style: TextStyle(
                color: Color(0xFFBDC65B),
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child:
                  _favoriteBooks.isEmpty
                      ? const Center(child: Text("Chưa có sách yêu thích"))
                      : ListView.builder(
                        itemCount: _favoriteBooks.length,
                        itemBuilder: (context, index) {
                          final book = _favoriteBooks[index];
                          return BookItem( 
                            book: book,
                            isFavorite: true,
                            onAdd: () async {
                              await _bookController.toggleFavorite(book);
                              await _loadFavoriteBooks();
                              setState(() {});
                            },
                            onDelete: () async {
                              await AppDialog.dialog(
                                title: const Text("🗑️ Xác nhận xoá sách", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
                                context,
                                content: "Bạn có chắc chắn muốn xoá sách này không?",
                                confirmText: "Xoá",
                                action: () async {
                                  await _bookController.removeBook(book);
                                  await _loadFavoriteBooks();
                                },
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
