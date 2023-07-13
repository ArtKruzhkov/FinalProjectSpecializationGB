# 7. В подключенном MySQL репозитории создать базу данных "Друзья человека"

DROP DATABASE IF EXISTS `human_friends`;

CREATE DATABASE IF NOT EXISTS `human_friends`;

USE `human_friends`;


# 8. Создать таблицы с иерархией из диаграммы в БД

# Создаем таблицу animals
CREATE TABLE `animals` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
  Animal_Class VARCHAR(20)
);

# Создаем таблицу Домашние животные
CREATE TABLE `HomePets` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
  `KindOfAnimal` VARCHAR(20) NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
   FOREIGN KEY (`Animal_Class_Id`) REFERENCES `animals` (`id`) ON DELETE CASCADE
);

# Создаем таблицу Вьючные животные
CREATE TABLE `PackAnimals` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
  `KindOfAnimal` VARCHAR(20) NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
   FOREIGN KEY (`Animal_Class_Id`) REFERENCES `animals` (`id`) ON DELETE CASCADE
);


# Создаем таблицу dogs, cats, hamsters с внешним ключом на таблицу HomePets
CREATE TABLE `dogs` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `HomePets` (`Animal_Class_Id`) ON DELETE CASCADE
);


CREATE TABLE `cats` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `HomePets` (`Animal_Class_Id`) ON DELETE CASCADE
);


CREATE TABLE `hamsters` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `HomePets` (`Animal_Class_Id`) ON DELETE CASCADE
);


# Создаем таблицу horses, camels, donkeys с внешним ключом на таблицу PackAnimals
CREATE TABLE `horses` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `PackAnimals` (`Animal_Class_Id`) ON DELETE CASCADE
);


CREATE TABLE `camels` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `PackAnimals` (`Animal_Class_Id`) ON DELETE CASCADE
);


CREATE TABLE `donkeys` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`Animal_Class_Id`) REFERENCES `PackAnimals` (`Animal_Class_Id`) ON DELETE CASCADE
);


# 9. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения

# Заполняем таблицу animals
INSERT INTO `human_friends`.`animals` (`id`, `Animal_Class`) VALUES ('1', 'HomePet'),('2', 'PackAnimal');

# Заполняем таблицы HomePets, PackAnimals
INSERT INTO `human_friends`.`homepets` (`id`, `KindOfAnimal`, `Animal_Class_Id`) VALUES 
('1', 'dog', '1'),
('2', 'dog', '1'),
('3', 'dog', '1'),
('4', 'cat', '1'),
('5', 'cat', '1'),
('6', 'hamster', '1'),
('7', 'hamster', '1');

INSERT INTO `human_friends`.`packanimals` (`id`, `KindOfAnimal`, `Animal_Class_Id`) VALUES 
('1', 'horse', '2'),
('2', 'horse', '2'),
('3', 'camel', '2'),
('4', 'camel', '2'),
('5', 'camel', '2'),
('6', 'donkey', '2'),
('7', 'donkey', '2');


# Заполняем таблицы dogs, cats, hamsters
INSERT INTO `human_friends`.`dogs` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Jack', 'Sit, LayDown', '2020-12-31', 1),
  ('Bono', 'Stay, Bite', '2021-04-23', 1),
  ('Richi', 'Run, Sit, Voice', '2022-08-14', 1);


INSERT INTO `human_friends`.`cats` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Chaki', 'Climb', '2019-08-12', 1),
  ('Mars', 'Come, Hide', '2022-02-09', 1);


INSERT INTO `human_friends`.`hamsters` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Brix', 'Eat', '2022-07-04', 1),
  ('Vegie', 'Eat, Roll', '2022-10-11', 1);

# Заполняем таблицу horses, camels, donkeys
INSERT INTO `human_friends`.`horses` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Mustang', 'Walk, Fast, Jump', '2019-04-11', 2),
  ('Marvin', 'Walk, SpeedWalk, Jump, ', '2021-03-29', 2);


INSERT INTO `human_friends`.`camels` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Sahara', 'Walk, Drink', '2018-10-23', 2),
  ('Namib', 'Walk, LayDown, Relax', '2020-07-15', 2),
  ('Carru', 'Walk', '2021-11-08', 2);


INSERT INTO `human_friends`.`donkeys` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`) VALUES
  ('Gibli', 'Walk', '2019-08-12', 2),
  ('Dover', 'Walk, Spin, Up', '2021-06-02', 2);
  
  
 # 10. Удалить из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. 
 # Объединить таблицы лошади, и ослы в одну таблицу.

  DROP TABLE `human_friends`.`camels`;
  
# Объединить таблицы "horses", и "donkeys" в одну таблицу
# Создаем новую таблицу horses_and_donkeys
CREATE TABLE `horses_and_donkeys` (
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  `KindOfAnimal` VARCHAR(20) NOT NULL
);

# Вставляем данные из horses в таблицу horses_and_donkeys
INSERT INTO `horses_and_donkeys` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `KindOfAnimal`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'horse' AS `KindOfAnimal`
FROM `horses`;

# Вставляем данные из donkeys в таблицу horses_and_donkeys
INSERT INTO `horses_and_donkeys` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `KindOfAnimal`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'donkey' AS `KindOfAnimal`
FROM `donkeys`;


# 11.Создать новую таблицу “молодые животные” в которую попадут все
# животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
# до месяца подсчитать возраст животных в новой таблице

# Создаем новую таблицу young_animals
CREATE TABLE `young_animals` (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Name` VARCHAR(45) NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  `KindOfAnimal` VARCHAR(20) NOT NULL,
  `Age_Months` INT NOT NULL
);

# Вставляем данные из таблиц dogs, cats, hamsters, horses, donkeys в таблицу young_animals
INSERT INTO `young_animals` (`Name`, `Animal_Class_Id`, `KindOfAnimal`, `Age_Months`)
SELECT `Name`, `Animal_Class_Id`, 'dog' AS `KindOfAnimal`, TIMESTAMPDIFF(MONTH, `Birth`, CURDATE()) AS `Age_Months`
FROM `dogs`
WHERE `Birth` <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND `Birth` >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

INSERT INTO `young_animals` (`Name`, `Animal_Class_Id`, `KindOfAnimal`, `Age_Months`)
SELECT `Name`, `Animal_Class_Id`, 'cat' AS `KindOfAnimal`, TIMESTAMPDIFF(MONTH, `Birth`, CURDATE()) AS `Age_Months`
FROM `cats`
WHERE `Birth` <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND `Birth` >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

INSERT INTO `young_animals` (`Name`, `Animal_Class_Id`, `KindOfAnimal`, `Age_Months`)
SELECT `Name`, `Animal_Class_Id`, 'hamster' AS `KindOfAnimal`, TIMESTAMPDIFF(MONTH, `Birth`, CURDATE()) AS `Age_Months`
FROM `hamsters`
WHERE `Birth` <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND `Birth` >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

INSERT INTO `young_animals` (`Name`, `Animal_Class_Id`, `KindOfAnimal`, `Age_Months`)
SELECT `Name`, `Animal_Class_Id`, 'horse' AS `KindOfAnimal`, TIMESTAMPDIFF(MONTH, `Birth`, CURDATE()) AS `Age_Months`
FROM `horses`
WHERE `Birth` <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND `Birth` >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

INSERT INTO `young_animals` (`Name`, `Animal_Class_Id`, `KindOfAnimal`, `Age_Months`)
SELECT `Name`, `Animal_Class_Id`, 'donkey' AS `KindOfAnimal`, TIMESTAMPDIFF(MONTH, `Birth`, CURDATE()) AS `Age_Months`
FROM `donkeys`
WHERE `Birth` <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND `Birth` >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);


# 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
# прошлую принадлежность к старым таблицам.

# Создаем новую таблицу all_animals
CREATE TABLE `all_animals` (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  `Name` VARCHAR(45) NOT NULL,
  `Skills` VARCHAR(110) NOT NULL,
  `Birth` DATE NOT NULL,
  `Animal_Class_Id` INT UNSIGNED NOT NULL,
  `FromTable` VARCHAR(10) NOT NULL
);

# Вставляем данные из таблиц `dogs`, `cats`, `donkeys`, `hamsters`, и `horses` в таблицу `all_animals`
INSERT INTO `all_animals` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `FromTable`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'dogs' AS `FromTable`
FROM `dogs`;

INSERT INTO `all_animals` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `FromTable`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'cats' AS `FromTable`
FROM `cats`;

INSERT INTO `all_animals` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `FromTable`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'hamsters' AS `FromTable`
FROM `hamsters`;

INSERT INTO `all_animals` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `FromTable`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'horses' AS `FromTable`
FROM `horses`;

INSERT INTO `all_animals` (`Name`, `Skills`, `Birth`, `Animal_Class_Id`, `FromTable`)
SELECT `Name`, `Skills`, `Birth`, `Animal_Class_Id`, 'donkeys' AS `FromTable`
FROM `donkeys`;
