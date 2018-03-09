-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Mrz 2018 um 16:28
-- Server-Version: 10.1.30-MariaDB
-- PHP-Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr11_erik_djamgarian_php_car_rental`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cars`
--

CREATE TABLE `cars` (
  `car_id` int(11) NOT NULL,
  `car_model` varchar(50) NOT NULL,
  `car_tank` int(100) DEFAULT NULL,
  `car_location` varchar(50) DEFAULT NULL,
  `fk_office_id` int(11) DEFAULT NULL,
  `seats` int(10) DEFAULT NULL,
  `return_station` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `cars`
--

INSERT INTO `cars` (`car_id`, `car_model`, `car_tank`, `car_location`, `fk_office_id`, `seats`, `return_station`) VALUES
(1, 'Mercedes Benz S-class', 100, 'at office', 1, 5, NULL),
(2, 'BMW 5 series', 100, 'at office', 5, 5, NULL),
(3, 'Porsche Cayenne', 85, 'at office', 4, 4, NULL),
(4, 'Ford Mondeo', 19, 'GPS Data ...', NULL, 6, 3),
(5, 'Tesla Model S', 33, 'at office', 1, 7, NULL),
(6, 'Volkswagen polo', 35, 'GPS Data ...', NULL, 3, 4),
(7, 'Tesla S', 20, 'GPS Data ...', NULL, 2, 3),
(8, 'Audi A7', 95, 'GPS Data ...', NULL, 5, 5),
(9, 'Seat Ibiza', 72, 'at office', 3, 9, NULL),
(10, 'Mitsubishi Subaru', 45, 'at office', 2, 2, NULL),
(11, 'Mercedes Benz C-class', 85, 'GPS Data ...', NULL, 6, 2),
(12, 'Dodge Viper', 63, 'at office', 5, 4, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `insurance`
--

CREATE TABLE `insurance` (
  `insurance_id` int(11) NOT NULL,
  `covers` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `fk_cars_id` int(11) DEFAULT NULL,
  `fk_insurance` int(11) DEFAULT NULL,
  `bill_price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `office`
--

CREATE TABLE `office` (
  `office_id` int(11) NOT NULL,
  `office_city` varchar(55) DEFAULT NULL,
  `fk_cars_id` int(11) DEFAULT NULL,
  `carnumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `office`
--

INSERT INTO `office` (`office_id`, `office_city`, `fk_cars_id`, `carnumber`) VALUES
(1, 'Geweygasse 4', NULL, 3),
(2, 'Pilgramgasse 1', NULL, 2),
(3, 'Hohe Warte 89', NULL, 5),
(4, 'Armenierplatz 1', NULL, 3),
(5, 'Gallmeyergasse 6', NULL, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `fk_cars_id` int(11) DEFAULT NULL,
  `fk_office_id` int(11) DEFAULT NULL,
  `pickup_office_id` int(11) DEFAULT NULL,
  `return_office_id` int(11) DEFAULT NULL,
  `fk_invoice_id` int(11) DEFAULT NULL,
  `fk_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_email` varchar(60) NOT NULL,
  `user_pass` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_email`, `user_pass`) VALUES
(0, 'Erik Djamgarian', 'Djamgarian0702@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
(1, 'Erik', 'E@g.com', '123454321');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `fk_office_id` (`fk_office_id`),
  ADD KEY `return_station` (`return_station`);

--
-- Indizes für die Tabelle `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`insurance_id`);

--
-- Indizes für die Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `fk_cars_id` (`fk_cars_id`),
  ADD KEY `fk_insurance` (`fk_insurance`);

--
-- Indizes für die Tabelle `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`office_id`),
  ADD KEY `fk_cars_id` (`fk_cars_id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_cars_id` (`fk_cars_id`),
  ADD KEY `fk_office_id` (`fk_office_id`),
  ADD KEY `fk_user_id` (`fk_user_id`),
  ADD KEY `fk_invoice_id` (`fk_invoice_id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `userEmail` (`user_email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
