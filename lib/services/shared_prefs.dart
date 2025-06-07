import 'dart:convert';
import 'package:book_flutter/models/book_model.dart';
import 'package:book_flutter/models/app_use_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const accessKey = 'accessKey';
  static const loginKey = 'loginKey';
  static const userKey = 'userKey';
  static const favouriteBooksKey = 'favourite_books';
  static const booksKey = 'booksKey';
  Future<bool> isAccess() async {
    SharedPreferences prefs = await _prefs;
    bool? data = prefs.getBool(accessKey);
    if (data == null) return false;
    return data;
  }

  Future<void> setAccess(bool value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(accessKey, value);
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await _prefs;
    bool? data = prefs.getBool(loginKey);
    if (data == null) return false;
    return data;
  }

  Future<void> setLogin(bool value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(loginKey, value);
  }

  Future<AppUserModel?> getUser() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString(userKey);
    if (data == null) return null;
    Map<String, dynamic> json = jsonDecode(data) as Map<String, dynamic>;
    AppUserModel user = AppUserModel.fromJson(json);
    return user;
  }

  Future<void> saveUser(AppUserModel user) async {
    SharedPreferences prefs = await _prefs;
    String st = jsonEncode(user.toJson());
    prefs.setString(userKey, st);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove(loginKey);
  }

  Future<List<BookModel>> getBookList() async {
    final prefs = await _prefs;
    String? data = prefs.getString(booksKey);
    if (data == null) return [];
    List<dynamic> decode = jsonDecode(data);
    return decode.map((e)=>BookModel.fromJson(e)).toList();
  }

  Future<void> saveBookList(List<BookModel> books) async{
    final prefs = await _prefs;
    String st = jsonEncode(books.map((e)=>e.toJson()).toList());
    await prefs.setString(booksKey, st);
  }

  Future<List<BookModel>> getFavoriteBooks() async{
    final prefs = await _prefs;
    String? data = prefs.getString(favouriteBooksKey);
    if (data == null) return [];
    List <dynamic> decode = jsonDecode(data);
    return decode.map((e)=>BookModel.fromJson(e)).toList();
  }

  Future<void> saveFavoriteBooks(List<BookModel> books) async{
    final prefs = await _prefs;
    String st = jsonEncode(books.map((e) => e.toJson()).toList());
    await prefs.setString(favouriteBooksKey, st);
  }
}