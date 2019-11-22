-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Nov 22, 2019 at 04:09 AM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_peteales`
--

-- --------------------------------------------------------

--
-- Table structure for table `cats`
--

CREATE TABLE `cats` (
  `pet_Id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `sex` char(1) NOT NULL,
  `breed` int(11) DEFAULT NULL,
  `weight` float NOT NULL,
  `color` int(11) DEFAULT NULL,
  `availability` char(1) DEFAULT NULL,
  `adoption_fee` float DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `date_adopted` date DEFAULT NULL,
  `sponsor` int(11) DEFAULT NULL,
  `chart` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cats`
--

INSERT INTO `cats` (`pet_Id`, `name`, `birthday`, `sex`, `breed`, `weight`, `color`, `availability`, `adoption_fee`, `owner`, `date_adopted`, `sponsor`, `chart`) VALUES
(1, 'Leo', '2018-07-11', 'M', 7, 13.5, 1, 'N', 150, 1, '2019-08-14', NULL, 1),
(2, 'Luna', '2019-07-16', 'F', 7, 7.5, 4, 'Y', 150, NULL, NULL, NULL, 2),
(3, 'Noodles', '2018-06-07', 'F', 8, 9.8, 6, 'Y', 150, NULL, NULL, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cat_breed`
--

CREATE TABLE `cat_breed` (
  `cat_breed_Id` int(11) NOT NULL,
  `cat_Id` int(11) DEFAULT NULL,
  `cat_breed_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cat_breed`
--

INSERT INTO `cat_breed` (`cat_breed_Id`, `cat_Id`, `cat_breed_name`) VALUES
(1, NULL, 'Persian'),
(2, NULL, 'Russian Blue'),
(3, NULL, 'Bengal'),
(4, NULL, 'British Shorthair'),
(5, NULL, 'Siamese'),
(6, NULL, 'Maine Coon'),
(7, NULL, 'Ragdoll'),
(8, NULL, 'American Shorthair'),
(9, NULL, 'Abyssian'),
(10, NULL, 'Balinese'),
(11, NULL, 'Himalayan'),
(12, NULL, 'Scottish Fold'),
(13, NULL, 'Birman'),
(14, NULL, 'Sphynx'),
(15, NULL, 'Chartreux');

-- --------------------------------------------------------

--
-- Table structure for table `cat_color`
--

CREATE TABLE `cat_color` (
  `cat_color_Id` int(11) NOT NULL,
  `pet_Id` int(11) DEFAULT NULL,
  `cat_color_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cat_color`
--

INSERT INTO `cat_color` (`cat_color_Id`, `pet_Id`, `cat_color_name`) VALUES
(1, NULL, 'White'),
(2, NULL, 'Black'),
(3, NULL, 'Ginger'),
(4, NULL, 'Blue/Grey'),
(5, NULL, 'Cream'),
(6, NULL, 'Brown'),
(7, NULL, 'Cinnamon'),
(8, NULL, 'Tabby'),
(9, NULL, 'Tortoiseshell'),
(10, NULL, 'Calico');

-- --------------------------------------------------------

--
-- Table structure for table `cat_sponsors`
--

CREATE TABLE `cat_sponsors` (
  `cat_sponsors_Id` int(11) NOT NULL,
  `cat_Id` int(11) DEFAULT NULL,
  `donor_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cat_sponsors`
--

INSERT INTO `cat_sponsors` (`cat_sponsors_Id`, `cat_Id`, `donor_Id`) VALUES
(1, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cat_to_breeds`
--

CREATE TABLE `cat_to_breeds` (
  `cat_Id` int(11) DEFAULT NULL,
  `breed_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_Id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cats_owned` int(11) DEFAULT NULL,
  `dogs_owned` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_Id`, `first_name`, `last_name`, `address`, `phone_number`, `email`, `cats_owned`, `dogs_owned`) VALUES
(1, 'Kobe', 'Bryant', '1234 Wilshire Blvd, Los Angeles, CA, 90036', '(555)555-5554', 'kobe@lakers.com', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `clients_to_cats`
--

CREATE TABLE `clients_to_cats` (
  `clients_to_cats_Id` int(11) NOT NULL,
  `client_Id` int(11) DEFAULT NULL,
  `cat_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clients_to_cats`
--

INSERT INTO `clients_to_cats` (`clients_to_cats_Id`, `client_Id`, `cat_Id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `clients_to_dogs`
--

CREATE TABLE `clients_to_dogs` (
  `clients_to_dogs_Id` int(11) NOT NULL,
  `client_Id` int(11) DEFAULT NULL,
  `dog_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clients_to_dogs`
--

INSERT INTO `clients_to_dogs` (`clients_to_dogs_Id`, `client_Id`, `dog_Id`) VALUES
(1, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `dogs`
--

CREATE TABLE `dogs` (
  `pet_Id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `sex` char(1) NOT NULL,
  `breed` int(11) NOT NULL,
  `weight` float NOT NULL,
  `color` int(11) NOT NULL,
  `availability` char(1) DEFAULT NULL,
  `adoption_fee` float DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `date_adopted` date DEFAULT NULL,
  `sponsor` int(11) DEFAULT NULL,
  `chart` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dogs`
--

INSERT INTO `dogs` (`pet_Id`, `name`, `birthday`, `sex`, `breed`, `weight`, `color`, `availability`, `adoption_fee`, `owner`, `date_adopted`, `sponsor`, `chart`) VALUES
(1, 'Rafi', '2019-04-22', 'M', 14, 40.5, 2, 'N', 250, 1, '2018-02-14', NULL, 1),
(2, 'Butler', '2018-12-18', 'M', 10, 45, 4, 'N', 250, 1, '2019-02-15', NULL, 2),
(3, 'BiBi', '2018-12-18', 'F', 8, 38, 3, 'Y', 250, NULL, NULL, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `dog_breed`
--

CREATE TABLE `dog_breed` (
  `dog_breed_Id` int(11) NOT NULL,
  `dog_Id` int(11) DEFAULT NULL,
  `dog_breed_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dog_breed`
--

INSERT INTO `dog_breed` (`dog_breed_Id`, `dog_Id`, `dog_breed_name`) VALUES
(1, NULL, 'Akita'),
(2, NULL, 'Labrador'),
(3, NULL, 'Pug'),
(4, NULL, 'Husky'),
(5, NULL, 'Beagle'),
(6, NULL, 'Pomeranian'),
(7, NULL, 'Bulldog'),
(8, NULL, 'Poodle'),
(9, NULL, 'Chihuahua'),
(10, NULL, 'Pitbull'),
(11, NULL, 'Maltese'),
(12, NULL, 'Boxer'),
(13, NULL, 'Rottweiler'),
(14, NULL, 'Dobermann'),
(15, NULL, 'Dachshund');

-- --------------------------------------------------------

--
-- Table structure for table `dog_color`
--

CREATE TABLE `dog_color` (
  `dog_color_Id` int(11) NOT NULL,
  `pet_Id` int(11) DEFAULT NULL,
  `dog_color_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dog_color`
--

INSERT INTO `dog_color` (`dog_color_Id`, `pet_Id`, `dog_color_name`) VALUES
(1, NULL, 'White'),
(2, NULL, 'Black'),
(3, NULL, 'Ginger'),
(4, NULL, 'Blue/Grey'),
(5, NULL, 'Cream'),
(6, NULL, 'Brown'),
(7, NULL, 'Cinnamon');

-- --------------------------------------------------------

--
-- Table structure for table `dog_sponsors`
--

CREATE TABLE `dog_sponsors` (
  `dog_sponsors_Id` int(11) NOT NULL,
  `dog_Id` int(11) DEFAULT NULL,
  `donor_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dog_sponsors`
--

INSERT INTO `dog_sponsors` (`dog_sponsors_Id`, `dog_Id`, `donor_Id`) VALUES
(1, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `dog_to_breeds`
--

CREATE TABLE `dog_to_breeds` (
  `dog_Id` int(11) DEFAULT NULL,
  `breed_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donors`
--

CREATE TABLE `donors` (
  `donor_Id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `last_donation` date DEFAULT NULL,
  `amount_donated` float DEFAULT NULL,
  `cats_sponsored` int(11) DEFAULT NULL,
  `dogs_sponsored` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `donors`
--

INSERT INTO `donors` (`donor_Id`, `first_name`, `last_name`, `address`, `phone_number`, `email`, `last_donation`, `amount_donated`, `cats_sponsored`, `dogs_sponsored`) VALUES
(1, 'John', 'Smith', '7462 Polk St, Eugene, OR, 97402', '(555) 555-5525', 'john@gmail.com', '2018-09-12', 100, NULL, NULL),
(2, 'Joe', 'Shmo', '4321 Chambers St, Eugene, OR, 97402', '(555) 555-8525', 'joe@gmail.com', '2018-11-15', 100, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medicalRecordsCats`
--

CREATE TABLE `medicalRecordsCats` (
  `medical_Id` int(11) NOT NULL,
  `pet_Id` int(11) NOT NULL,
  `vaccination_status` char(1) NOT NULL,
  `spayed_neutered` char(1) NOT NULL,
  `illnesses` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medicalRecordsCats`
--

INSERT INTO `medicalRecordsCats` (`medical_Id`, `pet_Id`, `vaccination_status`, `spayed_neutered`, `illnesses`, `notes`) VALUES
(1, 1, 'Y', 'Y', NULL, NULL),
(2, 2, 'N', 'Y', 'Allergic to fish', NULL),
(3, 3, 'N', 'N', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medicalRecordsDogs`
--

CREATE TABLE `medicalRecordsDogs` (
  `medical_Id` int(11) NOT NULL,
  `pet_Id` int(11) NOT NULL,
  `vaccination_status` char(1) NOT NULL,
  `spayed_neutered` char(1) NOT NULL,
  `illnesses` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medicalRecordsDogs`
--

INSERT INTO `medicalRecordsDogs` (`medical_Id`, `pet_Id`, `vaccination_status`, `spayed_neutered`, `illnesses`, `notes`) VALUES
(1, 1, 'Y', 'Y', NULL, NULL),
(2, 2, 'N', 'Y', 'Respiratory Infections', NULL),
(3, 3, 'N', 'N', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cats`
--
ALTER TABLE `cats`
  ADD PRIMARY KEY (`pet_Id`),
  ADD KEY `breed` (`breed`),
  ADD KEY `color` (`color`),
  ADD KEY `owner` (`owner`),
  ADD KEY `sponsor` (`sponsor`),
  ADD KEY `chart` (`chart`);

--
-- Indexes for table `cat_breed`
--
ALTER TABLE `cat_breed`
  ADD PRIMARY KEY (`cat_breed_Id`),
  ADD KEY `cat_Id` (`cat_Id`);

--
-- Indexes for table `cat_color`
--
ALTER TABLE `cat_color`
  ADD PRIMARY KEY (`cat_color_Id`),
  ADD KEY `pet_Id` (`pet_Id`);

--
-- Indexes for table `cat_sponsors`
--
ALTER TABLE `cat_sponsors`
  ADD PRIMARY KEY (`cat_sponsors_Id`),
  ADD KEY `cat_Id` (`cat_Id`);

--
-- Indexes for table `cat_to_breeds`
--
ALTER TABLE `cat_to_breeds`
  ADD KEY `breed_Id` (`breed_Id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_Id`),
  ADD KEY `cats_owned` (`cats_owned`),
  ADD KEY `dogs_owned` (`dogs_owned`);

--
-- Indexes for table `clients_to_cats`
--
ALTER TABLE `clients_to_cats`
  ADD PRIMARY KEY (`clients_to_cats_Id`),
  ADD KEY `cat_Id` (`cat_Id`);

--
-- Indexes for table `clients_to_dogs`
--
ALTER TABLE `clients_to_dogs`
  ADD PRIMARY KEY (`clients_to_dogs_Id`),
  ADD KEY `dog_Id` (`dog_Id`);

--
-- Indexes for table `dogs`
--
ALTER TABLE `dogs`
  ADD PRIMARY KEY (`pet_Id`),
  ADD KEY `breed` (`breed`),
  ADD KEY `color` (`color`),
  ADD KEY `owner` (`owner`),
  ADD KEY `sponsor` (`sponsor`),
  ADD KEY `chart` (`chart`);

--
-- Indexes for table `dog_breed`
--
ALTER TABLE `dog_breed`
  ADD PRIMARY KEY (`dog_breed_Id`),
  ADD KEY `dog_Id` (`dog_Id`);

--
-- Indexes for table `dog_color`
--
ALTER TABLE `dog_color`
  ADD PRIMARY KEY (`dog_color_Id`),
  ADD KEY `pet_Id` (`pet_Id`);

--
-- Indexes for table `dog_sponsors`
--
ALTER TABLE `dog_sponsors`
  ADD PRIMARY KEY (`dog_sponsors_Id`),
  ADD KEY `dog_Id` (`dog_Id`);

--
-- Indexes for table `dog_to_breeds`
--
ALTER TABLE `dog_to_breeds`
  ADD KEY `breed_Id` (`breed_Id`);

--
-- Indexes for table `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`donor_Id`),
  ADD KEY `cats_sponsored` (`cats_sponsored`),
  ADD KEY `dogs_sponsored` (`dogs_sponsored`);

--
-- Indexes for table `medicalRecordsCats`
--
ALTER TABLE `medicalRecordsCats`
  ADD PRIMARY KEY (`medical_Id`),
  ADD KEY `pet_Id` (`pet_Id`);

--
-- Indexes for table `medicalRecordsDogs`
--
ALTER TABLE `medicalRecordsDogs`
  ADD PRIMARY KEY (`medical_Id`),
  ADD KEY `pet_Id` (`pet_Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cats`
--
ALTER TABLE `cats`
  MODIFY `pet_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cat_breed`
--
ALTER TABLE `cat_breed`
  MODIFY `cat_breed_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `cat_color`
--
ALTER TABLE `cat_color`
  MODIFY `cat_color_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cat_sponsors`
--
ALTER TABLE `cat_sponsors`
  MODIFY `cat_sponsors_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clients_to_cats`
--
ALTER TABLE `clients_to_cats`
  MODIFY `clients_to_cats_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `clients_to_dogs`
--
ALTER TABLE `clients_to_dogs`
  MODIFY `clients_to_dogs_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dogs`
--
ALTER TABLE `dogs`
  MODIFY `pet_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dog_breed`
--
ALTER TABLE `dog_breed`
  MODIFY `dog_breed_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `dog_color`
--
ALTER TABLE `dog_color`
  MODIFY `dog_color_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dog_sponsors`
--
ALTER TABLE `dog_sponsors`
  MODIFY `dog_sponsors_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `donors`
--
ALTER TABLE `donors`
  MODIFY `donor_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `medicalRecordsCats`
--
ALTER TABLE `medicalRecordsCats`
  MODIFY `medical_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `medicalRecordsDogs`
--
ALTER TABLE `medicalRecordsDogs`
  MODIFY `medical_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cats`
--
ALTER TABLE `cats`
  ADD CONSTRAINT `cats_ibfk_1` FOREIGN KEY (`breed`) REFERENCES `cat_breed` (`cat_breed_Id`),
  ADD CONSTRAINT `cats_ibfk_2` FOREIGN KEY (`color`) REFERENCES `cat_color` (`cat_color_Id`),
  ADD CONSTRAINT `cats_ibfk_3` FOREIGN KEY (`owner`) REFERENCES `clients` (`client_Id`),
  ADD CONSTRAINT `cats_ibfk_4` FOREIGN KEY (`sponsor`) REFERENCES `cat_sponsors` (`cat_sponsors_Id`),
  ADD CONSTRAINT `cats_ibfk_5` FOREIGN KEY (`chart`) REFERENCES `medicalRecordsCats` (`medical_Id`);

--
-- Constraints for table `cat_breed`
--
ALTER TABLE `cat_breed`
  ADD CONSTRAINT `cat_breed_ibfk_1` FOREIGN KEY (`cat_Id`) REFERENCES `cats` (`pet_Id`);

--
-- Constraints for table `cat_color`
--
ALTER TABLE `cat_color`
  ADD CONSTRAINT `cat_color_ibfk_1` FOREIGN KEY (`pet_Id`) REFERENCES `cats` (`pet_Id`);

--
-- Constraints for table `cat_sponsors`
--
ALTER TABLE `cat_sponsors`
  ADD CONSTRAINT `cat_sponsors_ibfk_1` FOREIGN KEY (`cat_Id`) REFERENCES `cats` (`pet_Id`);

--
-- Constraints for table `cat_to_breeds`
--
ALTER TABLE `cat_to_breeds`
  ADD CONSTRAINT `cat_to_breeds_ibfk_1` FOREIGN KEY (`breed_Id`) REFERENCES `cat_breed` (`cat_breed_Id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`cats_owned`) REFERENCES `clients_to_cats` (`clients_to_cats_Id`),
  ADD CONSTRAINT `clients_ibfk_2` FOREIGN KEY (`dogs_owned`) REFERENCES `clients_to_dogs` (`clients_to_dogs_Id`);

--
-- Constraints for table `clients_to_cats`
--
ALTER TABLE `clients_to_cats`
  ADD CONSTRAINT `clients_to_cats_ibfk_1` FOREIGN KEY (`cat_Id`) REFERENCES `cats` (`pet_Id`);

--
-- Constraints for table `clients_to_dogs`
--
ALTER TABLE `clients_to_dogs`
  ADD CONSTRAINT `clients_to_dogs_ibfk_1` FOREIGN KEY (`dog_Id`) REFERENCES `dogs` (`pet_Id`);

--
-- Constraints for table `dogs`
--
ALTER TABLE `dogs`
  ADD CONSTRAINT `dogs_ibfk_1` FOREIGN KEY (`breed`) REFERENCES `dog_breed` (`dog_breed_Id`),
  ADD CONSTRAINT `dogs_ibfk_2` FOREIGN KEY (`color`) REFERENCES `dog_color` (`dog_color_Id`),
  ADD CONSTRAINT `dogs_ibfk_3` FOREIGN KEY (`owner`) REFERENCES `clients` (`client_Id`),
  ADD CONSTRAINT `dogs_ibfk_4` FOREIGN KEY (`sponsor`) REFERENCES `dog_sponsors` (`dog_sponsors_Id`),
  ADD CONSTRAINT `dogs_ibfk_5` FOREIGN KEY (`chart`) REFERENCES `medicalRecordsDogs` (`medical_Id`);

--
-- Constraints for table `dog_breed`
--
ALTER TABLE `dog_breed`
  ADD CONSTRAINT `dog_breed_ibfk_1` FOREIGN KEY (`dog_Id`) REFERENCES `dogs` (`pet_Id`);

--
-- Constraints for table `dog_color`
--
ALTER TABLE `dog_color`
  ADD CONSTRAINT `dog_color_ibfk_1` FOREIGN KEY (`pet_Id`) REFERENCES `dogs` (`pet_Id`);

--
-- Constraints for table `dog_sponsors`
--
ALTER TABLE `dog_sponsors`
  ADD CONSTRAINT `dog_sponsors_ibfk_1` FOREIGN KEY (`dog_Id`) REFERENCES `dogs` (`pet_Id`);

--
-- Constraints for table `dog_to_breeds`
--
ALTER TABLE `dog_to_breeds`
  ADD CONSTRAINT `dog_to_breeds_ibfk_1` FOREIGN KEY (`breed_Id`) REFERENCES `dog_breed` (`dog_breed_Id`);

--
-- Constraints for table `donors`
--
ALTER TABLE `donors`
  ADD CONSTRAINT `donors_ibfk_1` FOREIGN KEY (`cats_sponsored`) REFERENCES `cats` (`pet_Id`),
  ADD CONSTRAINT `donors_ibfk_2` FOREIGN KEY (`dogs_sponsored`) REFERENCES `dogs` (`pet_Id`);

--
-- Constraints for table `medicalRecordsCats`
--
ALTER TABLE `medicalRecordsCats`
  ADD CONSTRAINT `medicalRecordsCats_ibfk_1` FOREIGN KEY (`pet_Id`) REFERENCES `cats` (`pet_Id`);

--
-- Constraints for table `medicalRecordsDogs`
--
ALTER TABLE `medicalRecordsDogs`
  ADD CONSTRAINT `medicalRecordsDogs_ibfk_1` FOREIGN KEY (`pet_Id`) REFERENCES `dogs` (`pet_Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
