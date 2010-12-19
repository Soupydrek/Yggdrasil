SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `ProJuegos` DEFAULT CHARACTER SET utf8 ;
USE `ProJuegos` ;

-- -----------------------------------------------------
-- Table `ProJuegos`.`Region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Region` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Region` (
  `idRegion` INT NOT NULL AUTO_INCREMENT ,
  `nombre_region` VARCHAR(45) NULL ,
  PRIMARY KEY (`idRegion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Comuna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Comuna` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Comuna` (
  `idComuna` INT NOT NULL AUTO_INCREMENT ,
  `nombre_comuna` VARCHAR(45) NOT NULL ,
  `Region_idRegion` INT NOT NULL ,
  PRIMARY KEY (`idComuna`) ,
  CONSTRAINT `fk_Comuna_Region`
    FOREIGN KEY (`Region_idRegion` )
    REFERENCES `ProJuegos`.`Region` (`idRegion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comuna_Region` ON `ProJuegos`.`Comuna` (`Region_idRegion` ASC) ;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Cliente` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Cliente` (
  `rutCliente` VARCHAR(10) NOT NULL ,
  `nombres_cliente` VARCHAR(45) NOT NULL ,
  `apellido_paterno_cliente` VARCHAR(45) NOT NULL ,
  `apellido_materno_cliente` VARCHAR(45) NOT NULL ,
  `email_cliente` VARCHAR(45) NOT NULL ,
  `password_cliente` VARCHAR(45) NOT NULL ,
  `sexo_cliente` VARCHAR(45) NOT NULL ,
  `telefono_cliente` INT NOT NULL ,
  `direccion_cliente` VARCHAR(45) NOT NULL ,
  `Comuna_idComuna` INT NOT NULL ,
  PRIMARY KEY (`rutCliente`) ,
  CONSTRAINT `fk_Cliente_Comuna1`
    FOREIGN KEY (`Comuna_idComuna` )
    REFERENCES `ProJuegos`.`Comuna` (`idComuna` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cliente_Comuna1` ON `ProJuegos`.`Cliente` (`Comuna_idComuna` ASC) ;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Pedido` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT ,
  `fecha_pedido` DATETIME NOT NULL ,
  `valor_final` INT NULL ,
  `Cliente_rutCliente` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`idPedido`) ,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_rutCliente` )
    REFERENCES `ProJuegos`.`Cliente` (`rutCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pedido_Cliente1` ON `ProJuegos`.`Pedido` (`Cliente_rutCliente` ASC) ;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Producto` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT ,
  `tipo_producto` VARCHAR(45) NOT NULL ,
  `nombre_producto` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idProducto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Sistema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Sistema` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Sistema` (
  `idSistema` INT NOT NULL AUTO_INCREMENT ,
  `nombre_sistema` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idSistema`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProJuegos`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`Estado` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`Estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT ,
  `nombre_estado` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idEstado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProJuegos`.`StockProducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`StockProducto` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`StockProducto` (
  `idStockProducto` INT NOT NULL AUTO_INCREMENT ,
  `cant_stock` INT NOT NULL ,
  `valor_unitario` INT NOT NULL ,
  `Producto_idProducto` INT NOT NULL ,
  `Sistema_idSistema` INT NOT NULL ,
  `Estado_idEstado` INT NOT NULL ,
  PRIMARY KEY (`idStockProducto`) ,
  CONSTRAINT `fk_StockProducto_Producto1`
    FOREIGN KEY (`Producto_idProducto` )
    REFERENCES `ProJuegos`.`Producto` (`idProducto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StockProducto_Sistema1`
    FOREIGN KEY (`Sistema_idSistema` )
    REFERENCES `ProJuegos`.`Sistema` (`idSistema` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StockProducto_Estado1`
    FOREIGN KEY (`Estado_idEstado` )
    REFERENCES `ProJuegos`.`Estado` (`idEstado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_StockProducto_Producto1` ON `ProJuegos`.`StockProducto` (`Producto_idProducto` ASC) ;

CREATE INDEX `fk_StockProducto_Sistema1` ON `ProJuegos`.`StockProducto` (`Sistema_idSistema` ASC) ;

CREATE INDEX `fk_StockProducto_Estado1` ON `ProJuegos`.`StockProducto` (`Estado_idEstado` ASC) ;


-- -----------------------------------------------------
-- Table `ProJuegos`.`DetallePedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProJuegos`.`DetallePedido` ;

CREATE  TABLE IF NOT EXISTS `ProJuegos`.`DetallePedido` (
  `Pedido_idPedido` INT NOT NULL ,
  `StockProducto_idStockProducto` INT NOT NULL ,
  `cant_pedido` INT NOT NULL ,
  PRIMARY KEY (`Pedido_idPedido`, `StockProducto_idStockProducto`) ,
  CONSTRAINT `fk_DetallePedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` )
    REFERENCES `ProJuegos`.`Pedido` (`idPedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetallePedido_StockProducto1`
    FOREIGN KEY (`StockProducto_idStockProducto` )
    REFERENCES `ProJuegos`.`StockProducto` (`idStockProducto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DetallePedido_StockProducto1` ON `ProJuegos`.`DetallePedido` (`StockProducto_idStockProducto` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ProJuegos`.`Sistema`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `ProJuegos`;
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'Playstation 2');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'Playstation 3');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'PSP');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'Nintendo DS');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'Nintendo Wii');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'Xbox 360');
INSERT INTO `ProJuegos`.`Sistema` (`idSistema`, `nombre_sistema`) VALUES (NULL, 'PC');

COMMIT;

-- -----------------------------------------------------
-- Data for table `ProJuegos`.`Estado`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;
USE `ProJuegos`;
INSERT INTO `ProJuegos`.`Estado` (`idEstado`, `nombre_estado`) VALUES (NULL, 'nuevo');
INSERT INTO `ProJuegos`.`Estado` (`idEstado`, `nombre_estado`) VALUES (NULL, 'usado');
INSERT INTO `ProJuegos`.`Estado` (`idEstado`, `nombre_estado`) VALUES (NULL, 'proximamente');

COMMIT;
