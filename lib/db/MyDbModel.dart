import './SqfEntityBase.dart';

// STEP 1: define your tables as shown in the example Classes below.
// Define the "TableCategory" sample table as extended from "SqfEntityTable".

class TableCarouselImages extends SqfEntityTable {
  static SqfEntityTable __instance;
  static SqfEntityTable get getInstance {
    if (__instance == null) __instance = TableCarouselImages();
    return __instance;
  }

  TableCarouselImages() {
    // declare properties of EntityTable
    tableName = "carouselimages";
    modelName =
    null; // when the modelName (class name) is null then EntityBase uses TableName instead of modelName
    primaryKeyName = "id";
    useSoftDeleting =
    false; // when useSoftDeleting is true, creates a field named "isDeleted" on the table, and set to "1" this field when item deleted (does not hard delete)
    primaryKeyisIdentity = false;
    defaultJsonUrl =
    "https://jsonblob.com/api/jsonBlob/ff3a6236-60c9-11e9-b19d-af6ec6b68ba5"; // optional: to synchronize your table with json data from webUrl

    // declare fields
    fields = [
      SqfEntityField("url", DbType.text)
    ];

    super.init();
  }
}

class TableLiveRadios extends SqfEntityTable {
  static SqfEntityTable __instance;
  static SqfEntityTable get getInstance {
    if (__instance == null) __instance = TableLiveRadios();
    return __instance;
  }

  TableLiveRadios() {
    // declare properties of EntityTable
    tableName = "liveradios";
    modelName = null; // when the modelName (class name) is null then EntityBase uses TableName instead of modelName
    primaryKeyName = "id";
    useSoftDeleting =
    false; // when useSoftDeleting is true, creates a field named "isDeleted" on the table, and set to "1" this field when item deleted (does not hard delete)
    primaryKeyisIdentity = false;
    defaultJsonUrl =
    "https://jsonblob.com/api/jsonBlob/e65eabd3-8817-11e9-b9f8-c3b7c2b4fb11"; // optional: to synchronize your table with json data from webUrl

    // declare fields
    fields = [
      SqfEntityField("url", DbType.text),
      SqfEntityField("title", DbType.text),
      SqfEntityField("image", DbType.text)
    ];

    super.init();
  }
}


class TableYoutubeVideos extends SqfEntityTable {
  static SqfEntityTable __instance;
  static SqfEntityTable get getInstance {
    if (__instance == null) __instance = TableYoutubeVideos();
    return __instance;
  }

  TableYoutubeVideos() {
    // declare properties of EntityTable
    tableName = "youtubevideos";
    modelName = null; // when the modelName (class name) is null then EntityBase uses TableName instead of modelName
    primaryKeyName = "id";
    useSoftDeleting =
    false; // when useSoftDeleting is true, creates a field named "isDeleted" on the table, and set to "1" this field when item deleted (does not hard delete)
    primaryKeyisIdentity = false;
    defaultJsonUrl =
    "https://jsonblob.com/api/jsonBlob/e65eabd3-8817-11e9-b9f8-c3b7c2b4fb11"; // optional: to synchronize your table with json data from webUrl

    // declare fields
    fields = [
      SqfEntityField("url", DbType.text),
      SqfEntityField("video_url", DbType.text)
    ];

    super.init();
  }
}

// STEP 2: Create your Database Model to be extended from SqfEntityModel
// Note: SqfEntity provides support for the use of multiple databases. So you can create many Database Models and use them in the application.
class MyDbModel extends SqfEntityModel {
  MyDbModel() {
    databaseName = "mexDbORM.db";
    databaseTables = [
      TableLiveRadios.getInstance,
      TableCarouselImages.getInstance,
      TableYoutubeVideos.getInstance
    ]; // put defined tables into the list. ex: [TableProduct.getInstance, TableCategory.getInstance]
    bundledDatabasePath = null; // "assets/sample.db"; // This value is optional. When bundledDatabasePath is empty then EntityBase creats a new database when initializing the database
  }
}
