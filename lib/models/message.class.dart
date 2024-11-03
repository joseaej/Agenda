class Message {
  final int id;
  final String from;
  final String to;
  final String subject;
  final String body;
  const Message(
      {this.id = 0,
      this.from = "",
      this.to = "",
      this.subject = "",
      this.body = ""});
}
