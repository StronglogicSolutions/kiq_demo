#include <iostream>
#include <string>
#include <vector>

unsigned int g_counter = 0;

using Str = std::string;

enum Type {
  x = 1,
  y = 2,
  z = 3,
};

class Argument {
  Str name;
  Type type;
  int id;

 public:
  Argument(Str _name, Type _type) : name(_name), type(_type) {
    id = g_counter++;
  }
  Type getType() { return type; }
  void identify() { std::cout << id << std::endl; }
};

using Arguments = std::vector<Argument>;

class Task {
 public:
  Task(Arguments _args) : args(_args) {}

  Arguments args;
};

using Tasks = std::vector<Task>;

void processTask(Task task) { auto ptr = &task; }

void processArgument(Argument argument) {
  argument.identify();
  if (argument.getType() == Type::x) {
    std::cout << "Text" << std::endl;
  } else if (argument.getType() == Type::y) {
    // File
    std::cout << "File" << std::endl;
  } else if (argument.getType() == Type::z) {
    // Container
    std::cout << "Container" << std::endl;
  }
}

void incrementTasks(Tasks& tasks) {}

Tasks tasks{Task{
    Arguments{Argument{"First Name", Type::x}, Argument{"Second Name", Type::x},
              Argument{"File", Type::y}, Argument{"Socks", Type::z}}}};

int main(int argc, char** argv) {
  for (const auto& task : tasks) {
    for (const auto& argument : task.args) {
      processArgument(argument);
    }
  }
  return 0;
}
