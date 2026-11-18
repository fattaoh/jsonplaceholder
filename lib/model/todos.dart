// To parse this JSON data, do
//
//     final todos = todosFromJson(jsonString);

import 'dart:convert';

Todos todosFromJson(String str) => Todos.fromJson(json.decode(str));

String todosToJson(Todos data) => json.encode(data.toJson());

class Todos {
    final String greeting;
    final List<String> instructions;

    Todos({
        required this.greeting,
        required this.instructions,
    });

    factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        greeting: json["greeting"],
        instructions: List<String>.from(json["instructions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "greeting": greeting,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
    };
}
