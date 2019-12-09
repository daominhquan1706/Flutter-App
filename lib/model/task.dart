class Task {
  String title;
  String content;
  String date;
  int subTaskAmount;
  int documentAmount;

  Task(
      {this.title,
      this.content,
      this.date,
      this.subTaskAmount,
      this.documentAmount});

  static List<Task> getLists(int i) {
    List<Task> list = new List<Task>();
    list.add(
      Task(
        title: "ABC XYZ",
        content: "lorem sumasdfioapn pskdfpoa sdfpoa jpsdf p",
        date: "12/5/2019",
        documentAmount: 4,
        subTaskAmount: 21,
      ),
    );
    list.add(
      Task(
        title: "ABC XYZ",
        content: "lorem sumasdfioapn pskdfpoa sdfpoa jpsdf p",
        date: "12/5/2019",
        documentAmount: 4,
        subTaskAmount: 21,
      ),
    );
    list.add(
      Task(
        title: "ABC XYZ",
        content: "lorem sumasdfioapn pskdfpoa sdfpoa jpsdf p",
        date: "12/5/2019",
        documentAmount: 4,
        subTaskAmount: 21,
      ),
    );
    list.add(
      Task(
        title: "ABC XYZ",
        content: "lorem sumasdfioapn pskdfpoa sdfpoa jpsdf p",
        date: "12/5/2019",
        documentAmount: 4,
        subTaskAmount: 21,
      ),
    );
    list.add(
      Task(
        title: "ABC XYZ",
        content: "lorem sumasdfioapn pskdfpoa sdfpoa jpsdf p",
        date: "12/5/2019",
        documentAmount: 4,
        subTaskAmount: 21,
      ),
    );
    return list;
  }
}
