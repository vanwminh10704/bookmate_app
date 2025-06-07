class BookModel {
  int? id;
  String? imageStr;
  String? nameBook;
  String? nameAuthor;
  String? description;
  BookModel();
  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageStr = json['imageStr'];
    nameBook = json['nameBook'];
    nameAuthor = json['nameAuthor'];
    description = json['description'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageStr': imageStr,
      'nameBook': nameBook,
      'nameAuthor': nameAuthor,
      'description': description
    };
  }
}

List<BookModel> books = [
  BookModel()
    ..id = 1
    ..imageStr = 'assets/images/dacnhantam.jpg'
    ..nameBook = 'Đắc Nhân Tâm'
    ..nameAuthor = 'Dale Carnegie'
    ..description =
        "Đắc Nhân Tâm là cuốn sách kinh điển của Dale Carnegie, hướng dẫn cách giao tiếp, ứng xử và thuyết phục người khác một cách hiệu quả và chân thành. Qua những nguyên tắc đơn giản nhưng sâu sắc, sách giúp bạn xây dựng mối quan hệ tốt đẹp, được người khác yêu mến và thành công trong cả công việc lẫn cuộc sống.",
  BookModel()
    ..id = 2
    ..imageStr = 'assets/images/caycam.jpg'
    ..nameBook = 'Cây Cam Ngọt Của Tôi'
    ..nameAuthor = 'José Mauro de Vasconcelos'
    ..description =
        'Cây cam ngọt của tôi là tác phẩm nổi tiếng của José Mauro de Vasconcelos, kể về tuổi thơ đầy xúc động của cậu bé Zezé – một đứa trẻ nghèo nhưng giàu tình cảm và trí tưởng tượng. Câu chuyện chan chứa tình yêu, nỗi đau và khát vọng được yêu thương, chạm đến trái tim của hàng triệu độc giả.',
  BookModel()
    ..id = 3
    ..imageStr = 'assets/images/nhagiakim.jpg'
    ..nameBook = 'Nhà Giả Kim'
    ..nameAuthor = 'Paulo Coelho'
    ..description =
        'Nhà Giả Kim là một tiểu thuyết nổi tiếng của nhà văn Paulo Coelho, kể về hành trình phiêu lưu của chàng chăn cừu trẻ tên Santiago. Trên con đường đi tìm kho báu nằm dưới chân Kim Tự Tháp Ai Cập, Santiago trải qua nhiều thử thách, gặp gỡ những con người đặc biệt và dần khám phá ra ý nghĩa thật sự của giấc mơ, vận mệnh và giá trị bản thân.',
  BookModel()
    ..id = 4
    ..nameBook = 'Tuổi Trẻ Đáng Giá Bao Nhiêu'
    ..imageStr = 'assets/images/tuoi-tre.jpeg'
    ..nameAuthor = 'Rosie Nguyễn'
    ..description =
        'Tuổi trẻ đáng giá bao nhiêu là cuốn sách của Rosie Nguyễn, dành cho những người trẻ đang loay hoay tìm hướng đi cho cuộc đời. Sách chia sẻ những trải nghiệm, bài học thực tế về học tập, làm việc, du lịch, phát triển bản thân và sống có mục tiêu. Với giọng văn gần gũi và truyền cảm, cuốn sách khuyến khích người trẻ dám ước mơ, dám hành động và trân trọng thanh xuân của mình.',
  BookModel()
    ..id = 5
    ..nameBook = 'Đời Thay Đổi Khi Chúng Ta Thay Đổi'
    ..nameAuthor = 'Andrew Matthews'
    ..imageStr = 'assets/images/dtdkcttd.jpg'
    ..description =
        'Đời thay đổi khi chúng ta thay đổi là cuốn sách truyền cảm hứng của Andrew Matthews, giúp người đọc hiểu rằng thái độ sống tích cực là chìa khóa dẫn đến hạnh phúc và thành công.Cuốn sách khuyến khích mỗi người thay đổi từ bên trong, sống lạc quan, biết yêu thương bản thân, từ đó cuộc sống cũng sẽ trở nên tốt đẹp hơn.',
  BookModel()
    ..id = 6
    ..nameBook = '7 Thói Quen Để Thành Đạt'
    ..imageStr = 'assets/images/7-thoi-quen.jpg'
    ..nameAuthor = 'Stephen R. Covey'
    ..description =
        '7 Thói quen để thành đạt của Stephen R. Covey là cuốn sách phát triển bản thân nổi tiếng, trình bày 7 thói quen giúp mỗi người sống hiệu quả và thành công hơn, Cuốn sách khuyến khích xây dựng nền tảng bên trong vững chắc để đạt được thành công bền vững.',
];
