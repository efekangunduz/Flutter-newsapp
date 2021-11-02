class News {
  String newTitle;
  String author;
  String authorImage;
  String description;
  String imageUrl;
  String publishedAt;
  String source;
  String details;
  String comments;

  News(
      this.newTitle,
      this.author,
      this.authorImage,
      this.description,
      this.imageUrl,
      this.publishedAt,
      this.source,
      this.details,
      this.comments);

  static List<News> samples = [
    News(
      'Okullar yüz yüze eğitime geçti.',
      'Efekan Gündüz',
      'assets/1.jpg',
      'Okullar bu günden itibaren yüz yüze eğitim vermeye devam edecek.',
      'assets/1.jpg',
      '25-02-2018',
      'www.meb.gov.tr',
      'Detaylarr',
      'Yorumlar',
    ),
    News(
      'Beşiktaş Fenerbahçe maçını 3-1 üstünlükle Beşiktaş kazandı',
      'Efekan Gündüz',
      'assets/2.jpg',
      'Beşiktaş kendi evinde 19. kez Fenerbahçeyi ezci bir üstünlükle yendi',
      'assets/2.jpg',
      '25-02-2018',
      'bjk.com.tr',
      'Detaylarrr',
      'Yorumlar',
    ),
    News(
      'Beşiktaş Fenerbahçe maçını 3-1 üstünlükle Beşiktaş kazandı',
      'Efekan Gündüz',
      'assets/2.jpg',
      'Beşiktaş kendi evinde 19. kez Fenerbahçeyi ezci bir üstünlükle yendi',
      'assets/2.jpg',
      '25-02-2018',
      'bjk.com.tr',
      'Detaylarrr',
      'Yorumlar',
    ),
  ];
}
