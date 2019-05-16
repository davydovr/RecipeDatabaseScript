-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema recipedatabase
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `recipedatabase` ;

-- -----------------------------------------------------
-- Schema recipedatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recipedatabase` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `recipedatabase` ;

-- -----------------------------------------------------
-- Table `recipedatabase`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`category` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`category` (
  `CategoryID` INT(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE INDEX `UNQ_CategoryName` (`CategoryName` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`kashrusstatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`kashrusstatus` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`kashrusstatus` (
  `KashrusStatusID` INT(11) NOT NULL AUTO_INCREMENT,
  `KashrusStatusName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`KashrusStatusID`),
  UNIQUE INDEX `UNQ_KashrusStatus` (`KashrusStatusName` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`users` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`users` (
  `UserID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(30) NOT NULL,
  `LastName` VARCHAR(30) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UNQ_UserName` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`recipe` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`recipe` (
  `RecipeID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserID` INT(11) NULL DEFAULT NULL,
  `RecipeTitle` VARCHAR(45) NOT NULL,
  `PrepTime` INT(11) NOT NULL,
  `ServingSize` INT(11) NULL DEFAULT NULL,
  `RecipeKashrusStatus` INT(11) NOT NULL,
  `CategoryIDNum` INT(11) NOT NULL,
  PRIMARY KEY (`RecipeID`),
  INDEX `RecipeKashrusStatus` (`RecipeKashrusStatus` ASC) VISIBLE,
  INDEX `CategoryIDNum` (`CategoryIDNum` ASC) VISIBLE,
  INDEX `UserID` (`UserID` ASC) VISIBLE,
  CONSTRAINT `recipe_ibfk_1`
    FOREIGN KEY (`RecipeKashrusStatus`)
    REFERENCES `recipedatabase`.`kashrusstatus` (`KashrusStatusID`),
  CONSTRAINT `recipe_ibfk_2`
    FOREIGN KEY (`CategoryIDNum`)
    REFERENCES `recipedatabase`.`category` (`CategoryID`),
  CONSTRAINT `recipe_ibfk_3`
    FOREIGN KEY (`UserID`)
    REFERENCES `recipedatabase`.`users` (`UserID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`ingredient` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`ingredient` (
  `IngredientID` INT(11) NOT NULL AUTO_INCREMENT,
  `IngRecipeID` INT(11) NULL DEFAULT NULL,
  `IngredientName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IngredientID`),
  INDEX `IngRecipeID` (`IngRecipeID` ASC) VISIBLE,
  CONSTRAINT `ingredient_ibfk_1`
    FOREIGN KEY (`IngRecipeID`)
    REFERENCES `recipedatabase`.`recipe` (`RecipeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`instruction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`instruction` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`instruction` (
  `InstructionID` INT(11) NOT NULL AUTO_INCREMENT,
  `InstRecipeID` INT(11) NULL DEFAULT NULL,
  `InstructionNum` INT(11) NOT NULL,
  `InstructionText` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`InstructionID`),
  INDEX `InstRecipeID` (`InstRecipeID` ASC) VISIBLE,
  CONSTRAINT `instruction_ibfk_1`
    FOREIGN KEY (`InstRecipeID`)
    REFERENCES `recipedatabase`.`recipe` (`RecipeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`recipeingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`recipeingredients` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`recipeingredients` (
  `RecipeID` INT(11) NOT NULL,
  `IngredientID` INT(11) NOT NULL,
  INDEX `RecipeID` (`RecipeID` ASC) VISIBLE,
  INDEX `IngredientID` (`IngredientID` ASC) VISIBLE,
  CONSTRAINT `recipeingredients_ibfk_1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipedatabase`.`recipe` (`RecipeID`),
  CONSTRAINT `recipeingredients_ibfk_2`
    FOREIGN KEY (`IngredientID`)
    REFERENCES `recipedatabase`.`ingredient` (`IngredientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `recipedatabase`.`recipeinstructions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipedatabase`.`recipeinstructions` ;

CREATE TABLE IF NOT EXISTS `recipedatabase`.`recipeinstructions` (
  `RecipeID` INT(11) NOT NULL,
  `InstructionID` INT(11) NOT NULL,
  INDEX `RecipeID` (`RecipeID` ASC) VISIBLE,
  INDEX `InstructionID` (`InstructionID` ASC) VISIBLE,
  CONSTRAINT `recipeinstructions_ibfk_1`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipedatabase`.`recipe` (`RecipeID`),
  CONSTRAINT `recipeinstructions_ibfk_2`
    FOREIGN KEY (`InstructionID`)
    REFERENCES `recipedatabase`.`instruction` (`InstructionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into Users (firstname, lastname, email)
values ("devory", "charach", "devoryc@gmail.com"),
		("Ruth", "Davydov", "ruthdavydov@gmail.com");

insert into Category(CategoryName) values('Appetizers'), ('Beverages'),('Dessert'),('Meat'),
('Poultry'),('Salads'),('Sides'), ('Soups');

insert into Kashrusstatus(KashrusStatusName) values('Meat'), ('Dairy'), ('Pareve');

insert into recipe(userID, recipeTitle,prepTime,ServingSize,RecipeKashrusStatus,CategoryIDNum)
	values (3,'Gefilta Fish', 30, 4, 4, 2), 
    (3, 'Chicken', 10, 4, 2, 6), 
    (4, 'Caesar Salad', 20, 8, 4, 7);

insert into instruction (instrecipeid, instructionnum, instructiontext) values (10, 1, "Shred cabbage and carrots");
insert into instruction (instrecipeid, instructionnum, instructiontext) values (10, 2, "Mix salad dressing");
insert into instruction (instrecipeid, instructionnum, instructiontext) values (10, 3, "Pour onto salad");

select inst.instructionnum, inst.instructiontext
	from instruction inst 
    inner join recipe rec on inst.instrecipeid = rec.recipeid where rec.recipeid = 10;

select * from ingredient;
insert into ingredient (ingrecipeid, ingredientname) values (10, "Cabbage"), (10, "Carrots"), (10, "Salt"), (10, "Oil");

select ing.ingredientname from ingredient ing
inner join recipe rec on ing.ingrecipeid = rec.recipeid where recipeid = 10;
#query inner join to get a recipe. Practice. 
select rec.recipeid, rec.recipeTitle, rec.userID, rec.preptime, rec.servingsize, kshr.kashrusstatusname, cat.categoryname 
	from recipe rec
    inner join category cat on rec.categoryidnum = cat.categoryid
    inner join kashrusstatus kshr on rec.recipekashrusstatus = kshr.kashrusstatusid
	#inner join instruction 
    inner join users usr on rec.userID = usr.userID where usr.Email = "ruthdavydov@gmail.com";
    
select * from recipe where userid = 4;

# new from May 16
insert into ingredient (ingrecipeid, ingredientname) values (8, "Gefilta Fish Roll"), (8, "Single Carrot"), (8, "Salt"), (8, "Black Pepper");
insert into instruction (instrecipeid, instructionnum, instructiontext) values 
	(8, 1, "Boil water"),
    (8, 2, "Place gefilte fish and carrot"),
    (8, 3, "Add salt and black pepper"),
    (8, 4, "Let cook");
    ;
    
insert into ingredient (ingrecipeid, ingredientname) values 
	(9, "Chicken"), 
    (9, "Duck Sauce"), 
    (9, "Salt"), 
    (9, "Garlic Powder");    

insert into instruction (instrecipeid, instructionnum, instructiontext) values 
	(9, 1, "Clean chicken"),
    (9, 2, "Season chicken"),
    (9, 3, "Bake at 350 for 1 hour")
    ;

