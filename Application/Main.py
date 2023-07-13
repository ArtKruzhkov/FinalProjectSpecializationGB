import json
class AnimalCounter:
    def __init__(self):
        self.count = 0

    def add(self):
        self.count += 1

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type is None:
            if self.count == 0:
                raise ValueError("Resource not used in resourceful try")
        else:
            raise exc_val


class AnimalRegistry:
    def __init__(self, filename):
        self.filename = filename
        self.command_list = {
            'dog': ['sit'],
            'cat': ['meow'],
            'hamster': [''],
            'horse': [''],
            'donkey': ['']
        }
        self.counter = AnimalCounter()

        try:
            with open(self.filename, 'r') as file:
                self.animals = json.load(file)
        except FileNotFoundError:
            self.animals = []

    def save_data(self):
        with open(self.filename, 'w') as file:
            json.dump(self.animals, file)

    def load_data(self):
        try:
            with open(self.filename, 'r') as file:
                self.animals = json.load(file)
        except FileNotFoundError:
            self.animals = []


    def add_animal(self, animal_type, name):
        if animal_type not in self.command_list:
            raise ValueError("Invalid animal type")

        animal = {'type': animal_type, 'name': name, 'commands': []}
        self.animals.append(animal)
        self.counter.add()
        self.save_data()

    def teach_command(self, name, command):
        for animal in self.animals:
            if animal['name'] == name:
                animal['commands'].append(command)
                self.save_data()
                return
        raise ValueError("Animal not found")

    def show_animal_commands(self, name):
        for animal in self.animals:
            if animal['name'] == name:
                commands = animal['commands']
                if commands:
                    return commands
                else:
                    return "Animal doesn't know any commands yet."
        return "Animal not found."

    def print_all_animals(self):
        if not self.animals:
            print("No animals in the registry.")
        else:
            print("List of animals:")
            for animal in self.animals:
                print(f"Name: {animal['name']}, Type: {animal['type']}")
            print()




    def print_menu(self):
        print("Menu:")
        print("1. Add new animal")
        print("2. Teach command to an animal")
        print("3. Show commands for an animal")
        print("4. Print all animals")
        print("5. Print menu")
        print("6. Exit")

    def run(self):
        self.print_menu()
        while True:
            choice = input("Enter your choice: ")
            if choice == '1':
                animal_type = input("Enter animal type (dog, cat, hamster, horse, donkey): ")
                name = input("Enter animal name: ")
                try:
                    with self.counter:
                        self.add_animal(animal_type, name)
                        print("Animal added successfully.")
                except Exception as e:
                    print("Error: ", str(e))
            elif choice == '2':
                name = input("Enter animal name: ")
                command = input("Enter command: ")
                try:
                    self.teach_command(name, command)
                    print("Command taught successfully.")
                except Exception as e:
                    print("Error: ", str(e))
            elif choice == '3':
                name = input("Enter animal name: ")
                commands = self.show_animal_commands(name)
                print(f"Commands for {name}: {commands}")
            elif choice == '4':
                self.print_all_animals()
            elif choice == '5':
                self.print_menu()
            elif choice == '6':
                print("Exiting program...")
                break
            else:
                print("Invalid choice. Please try again.")



if __name__ == '__main__':
    animal_registry = AnimalRegistry("animals.json")
    animal_registry.run()