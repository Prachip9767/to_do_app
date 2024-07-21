class ToDoModel{
  final int userId;
  final int id;
  final String title;
  final bool isCompleted;

  ToDoModel({required this.userId,required this.id,required this.title,required this.isCompleted});

  factory ToDoModel.fromJson(Map<String,dynamic> json){
    return ToDoModel(
        userId:json['userId'],
        id:json['id'],
        title:json['title'],
      isCompleted: json['completed']
    );
  }
  Map<String,dynamic> toJson()=>{
     'userId':userId,
    'id':id,
    'title':title,
    'completed':isCompleted
  };
}