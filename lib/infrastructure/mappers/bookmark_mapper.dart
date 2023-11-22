import '/domain/entities/bookmark_entity.dart';
import '/infrastructure/models/bookmark_model.dart';

class BookmarkMapper{
  
    static List<BookmarkEntity> toListBookmarkEntity(List<BookmarkModel> list) {
    return list.map((e) => BookmarkMapper.toBookmarkEntity(e)).toList();
  }

  static BookmarkEntity toBookmarkEntity( BookmarkModel courseModel) => BookmarkEntity(
    segunds: courseModel.segunds,
    title: courseModel.title,
    videoUrl: courseModel.videoUrl
  );
}