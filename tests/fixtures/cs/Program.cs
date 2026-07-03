var greeting = Greet("world");
Console.WriteLine(greeting);

static string Greet(string name) => $"hello {name}";
