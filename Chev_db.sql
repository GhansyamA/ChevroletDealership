
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: Chev_db
--
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `role` varchar(10) DEFAULT 'customer',
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

INSERT INTO `user` (`iduser`, `name`, `phone`, `mail`, `password`, `gender`, `role`) VALUES
(1, 'Ghansyam', '9447857539', 'ghansyam@chevrolet.com', '637996472d68a53a7371eea5ee3a8e4323464307','Male', 'admin'),
(2, 'Manav', '9961341949', 'manav@chevrolet.com', '566852fa0e6eddfb918980d19a59895656835f6f','Male', 'admin'),
(3, 'Alan', '9207592668', 'alan@mail.com', '7992df13f2579b9f3e56698bdea9efd28567a6b7','Male', 'customer'),
(4, 'Karthik', '9846795780', 'karthik@mail.com', 'a53f7087fd5427cdc00343c95305f833044c7eae','Male', 'customer');
-- --------------------------------------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE IF NOT EXISTS `model` (
  `idmodel` int(11) NOT NULL AUTO_INCREMENT,
  `namemodel` varchar(25) NOT NULL,
  `features` varchar(200) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `price` float(11) NOT NULL,
  PRIMARY KEY (`idmodel`),
  UNIQUE KEY `namemodel` (`namemodel`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

INSERT INTO `model` (`idmodel`, `namemodel`, `features`, `photo`, `price`) VALUES
(1,'Camaro','Camaro.json','camaro1.jpg',32490),
(2,'Corvette','Corvette.json','corvette1.jpg',80050),
(3,'Tahoe','Tahoe.json','tahoe1.jpg',68730),
(4,'Silverado','Silverado.json','silverado1.jpg',36800),
(5,'Colorado','Colorado.json','colorado1.jpg',31090),
(6,'Suburban','Suburban.json','suburban1.jpg',59200),
(7,'Cruze','Cruze.json','cruze1.jpg',17990),
(8,'Malibu','Malibu.json','malibu1.jpg',25840),
(9,'Trailblazer','Trailblazer.json','trailblazer1.jpg',28395);
-- --------------------------------------------------------
DROP TABLE IF EXISTS `part`;
CREATE TABLE IF NOT EXISTS `part` (
  `idpart` int(11) NOT NULL AUTO_INCREMENT,
  `partname` varchar(100) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `price` float(11) NOT NULL,
  PRIMARY KEY (`idpart`),
  UNIQUE KEY `partname` (`partname`)
);

INSERT INTO `part` VALUES
(1,'20x9-Inch Aluminum Multi-Spoke Wheel in Black','wheel1.jpeg',750),
(2,'22x9-Inch Aluminum Multi-Spoke Wheel in Chrome','wheel2.jpeg',950),
(3,'18x8.5-Inch Aluminum Multi-Spoke Wheel in Satin Graphite','wheel3.jpeg',500),
(4,'19x7.5-Inch Aluminum 5-Spoke Wheel in Dark Argent','wheel4.jpeg',445),
(5,'Rear Brake Upgrade System','performance1.jpeg',895),
(6,'Front 6-Piston Brembo® Brake Upgrade','performance2.jpeg',2895),
(7,'6.2L Cat-Back Dual-Exit Exhaust Upgrade System','performance3.jpeg',3495),
(8,'1.4L Cat-Back Single Exit Exhaust Upgrade System','performance4.jpeg',995),
(9,'1.4L Cold Air Intake System','performance5.jpeg',625),
(10,'5.3L Cold Air Intake System','performance6.jpeg',625),
(11,'Automatic Transmission Shift Knob and Boot in Jet Black Suede','performance7.jpeg',180),
(12,'1LE Spec 2.0L Turbo and 3.6L Suede Shift Knob and Boot','performance8.jpeg',195);
-- --------------------------------------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `idstock` int(11) NOT NULL AUTO_INCREMENT,
  `idmodel` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  PRIMARY KEY (`idstock`),
  KEY `iduser` (`iduser`),
  KEY `idmodel` (`idmodel`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

INSERT INTO `stock` (`idstock`, `idmodel`, `status`, `iduser`) VALUES
(1, 1, 'available', NULL),
(2, 1, 'available', NULL),
(3, 2, 'available', NULL),
(4, 2, 'available', NULL),
(5, 3, 'available', NULL),
(6, 3, 'available', NULL),
(7, 4, 'available', NULL),
(8, 4, 'available', NULL),
(9, 5, 'available', NULL),
(10, 5, 'available', NULL),
(11, 6, 'available', NULL),
(12, 6, 'available', NULL),
(13, 6, 'available', NULL),
(14, 7, 'available', NULL),
(15, 7, 'available', NULL),
(16, 7, 'available', NULL),
(17, 8, 'available', NULL),
(18, 8, 'available', NULL),
(19, 8, 'available', NULL),
(20, 9, 'available', NULL),
(21, 9, 'available', NULL),
(22, 9, 'available', NULL);
-- --------------------------------------------------------
DROP TABLE IF EXISTS `variants`;
CREATE TABLE IF NOT EXISTS `variants` (
  `id` int(11) NOT NULL,
  `varname` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`varname`)
);

INSERT INTO `variants` VALUES
(1,'1LS'),
(1,'1LT'),
(1,'2LT'),
(1,'3LT'),
(1,'LT1'),
(1,'1SS'),
(1,'2SS'),
(1,'ZL1'),
(2,'Stingray'),
(2,'ZO6'),
(2,'E-Ray'),
(3,'LS'),
(3,'LT'),
(3,'Z71'),
(3,'RST'),
(3,'Premier'),
(3,'High Country'),
(4,'Estate'),
(4,'LT'),
(4,'High Country'),
(4,'ZR2'),
(4,'Custom Trail Boss'),
(5,'WT'),
(5,'LT'),
(5,'Trail Boss'),
(5,'Z71'),
(5,'ZR2'),
(6,'LS'),
(6,'LT'),
(6,'Z71'),
(6,'RST'),
(6,'Premier'),
(6,'High Country'),
(7,'LT'),
(7,'LTZ'),
(7,'LTZ AT'),
(8,'LS'),
(8,'RS'),
(8,'1LT'),
(8,'2LT'),
(9,'ACTIV'),
(9,'RS'),
(9,'LS'),
(9,'LT');
-- --------------------------------------------------------
DROP TABLE IF EXISTS `colors`;
CREATE TABLE IF NOT EXISTS `colors` (
  `id` int(11) NOT NULL,
  `color` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`color`)
);

INSERT INTO `colors` VALUES
(1,'Red Hot'),
(1,'Summit White'),
(1,'Black'),
(1,'Vivid Orange Metallic'),
(1,'Nitro Yellow'),
(1,'Riptide Blue Metallic'),
(1,'Sharkskin Metallic'),
(1,'Panther Black Metallic'),
(2,'Arctic White'),
(2,'Black'),
(2,'Cacti Green'),
(2,'Rapid Blue'),
(2,'Torch Red'),
(2,'Hypersonic Gray Metallic'),
(2,'Amplify Orange Tintcoat'),
(2,'Accelerate Yellow Metallic'),
(2,'Carbon Flash Metallic'),
(2,'Riptide Blue Metallic'),
(3,'Auburn Metallic'),
(3,'Black'),
(3,'Cherry Red Tintcoat'),
(3,'Dark Ash Metallic'),
(3,'Empire Beige Metallic'),
(3,'Iridescent Pearl Tricoat'),
(3,'Midnight Blue Metallic'),
(3,'Satin Steel Metallic'),
(3,'Summit White'),
(4,'Summit White'),
(4,'Black'),
(4,'Glacier Blue Metallic'),
(4,'Dark Ash Metallic'),
(4,'Red Hot'),
(4,'Sand Dune Metallic'),
(4,'Northsky Blue Metallic'),
(4,'Harvest Bronze Metallic'),
(5,'Satin Steel Metallic'),
(5,'Summit White'),
(5,'Black'),
(5,'Crush'),
(5,'Cherry Red Tintcoat'),
(5,'Bright Blue Metallic'),
(5,'Sand Dune Metallic'),
(6,'Summit White'),
(6,'Black'),
(6,'Auburn Metallic'),
(6,'Midnight Blue Metallic'),
(6,'Iridescent Pearl Tricoat'),
(6,'Radiant Red Tintcoat'),
(6,'Silver Sage Metallic'),
(6,'Sterling Gray Metallic'),
(6,'Empire Beige Metallic'),
(7,'Summit White'),
(7,'Autumn Bronze Metallic'),
(7,'Blue Ray Metallic'),
(7,'Rainforest Green Metallic'),
(7,'Red Hot'),
(7,'Silver Ice Metallic'),
(7,'Siren Red Tintcoat'),
(7,'Tungsten Metallic'),
(8,'Summit White'),
(8,'Mineral Gray Metallic'),
(8,'Mosaic Black Metallic'),
(8,'Lakeshore Blue Metallic'),
(8,'Sterling Gray Metallic'),
(8,'Radiant Red Tintcoat'),
(9,'Cacti Green x Summit White'),
(9,'Copper Harbor x Summit White'),
(9,'Fountain Blue x Summit White'),
(9,'Iridescent Pearl x Iridescent Pearl'),
(9,'Mosaic Black x Summit White'),
(9,'Nitro Yellow x Summit White'),
(9,'Sterling Gray x Summit White'),
(9,'Summit White x Summit White');
-- --------------------------------------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `idinvoice` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idvehicle` int(11) NOT NULL,
  `variant` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `bookdate` date NOT NULL,
  `method` varchar(10) DEFAULT NULL,
  `paystatus` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idinvoice`,`iduser`,`idvehicle`,`variant`),
  KEY `iduser` (`iduser`),
  KEY `idvehicle` (`idvehicle`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
-- --------------------------------------------------------
DROP TABLE IF EXISTS `serviceinvoice`;
CREATE TABLE IF NOT EXISTS `serviceinvoice` (
  `idinvoice` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idmodel` int(11) NOT NULL,
  `regnum` varchar(20) NOT NULL,
  `servtype` varchar(20) NOT NULL,
  `servdate` date NOT NULL,
  `servtime` varchar(10) NOT NULL,
  PRIMARY KEY (`idinvoice`,`iduser`,`idmodel`,`regnum`),
  KEY `iduser` (`iduser`)
);
-- --------------------------------------------------------
DROP TABLE IF EXISTS `partinvoice`;
CREATE TABLE IF NOT EXISTS `partinvoice` (
  `idinvoice` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idpart` int(11) NOT NULL,
  `partname` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL,
  `bookdate` date NOT NULL,
  `method` varchar(10) DEFAULT NULL,
  `paystatus` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idinvoice`,`iduser`,`idpart`,`partname`),
  KEY `iduser` (`iduser`),
  KEY `idpart` (`idpart`)
);
-- --------------------------------------------------------
--STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE AddInvoice (
    IN p_iduser INT,
    IN p_idvehicle INT,
    IN p_variant VARCHAR(50),
    IN p_color VARCHAR(50),
    IN p_amount INT
)
BEGIN
    DECLARE v_status VARCHAR(50);
    SELECT status INTO v_status FROM stock WHERE idmodel = p_idvehicle AND status = 'available' LIMIT 1;
    IF v_status = 'available' THEN
        INSERT INTO invoice (iduser, idvehicle, variant, color, amount)
        VALUES (p_iduser, p_idvehicle, p_variant, p_color, p_amount);
        UPDATE stock
        SET status = 'Booked', iduser = p_iduser
        WHERE idmodel = p_idvehicle AND status = 'available';
        SELECT 'Invoice added successfully' AS message;
    ELSE
        SELECT 'Vehicle not available in stock' AS message;
    END IF;
END;
//
DELIMITER ;

--TRIGGER
DELIMITER //
CREATE TRIGGER after_invoice_insert
AFTER INSERT ON invoice
FOR EACH ROW
BEGIN
    UPDATE stock
    SET status = 'Booked',
        iduser = NEW.iduser
    WHERE idmodel = NEW.idvehicle AND status = 'available';
END;
//
DELIMITER ;

COMMIT;