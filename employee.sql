-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2025 at 04:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `employee`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployeeInfo` (IN `emp_id` INT)   BEGIN
    SELECT 
        E.Name,
        E.Position,
        D.DeptDescription
    FROM 
        EmployeeInfo E
    JOIN 
        DepartmentInfo D ON E.DeptCode = D.DeptCode
    WHERE 
        E.Eid = emp_id;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CategorizeAge` (`age` INT) RETURNS VARCHAR(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE category VARCHAR(20);
    IF age BETWEEN 1 AND 12 THEN
        SET category = 'Young';
    ELSEIF age BETWEEN 13 AND 19 THEN
        SET category = 'Teen';
    ELSEIF age BETWEEN 20 AND 49 THEN
        SET category = 'Adult';
    ELSE
        SET category = 'Senior';
    END IF;
    RETURN category;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `departmentinfo`
--

CREATE TABLE `departmentinfo` (
  `DeptCode` varchar(10) NOT NULL,
  `DeptDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departmentinfo`
--

INSERT INTO `departmentinfo` (`DeptCode`, `DeptDescription`) VALUES
('BPD', 'BODY AND PAINT DEPARTMENT'),
('CRD', 'CUSTOMER RELATION DEPARTMENT'),
('SD', 'SALES DEPARTMENT');

-- --------------------------------------------------------

--
-- Table structure for table `employeeinfo`
--

CREATE TABLE `employeeinfo` (
  `Eid` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `DeptCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employeeinfo`
--

INSERT INTO `employeeinfo` (`Eid`, `Name`, `Position`, `Salary`, `Age`, `Address`, `DeptCode`) VALUES
(1, 'Juan Santos', 'Manager', 20000.00, 35, 'San Pablo', 'BPD'),
(2, 'Miguel Lopez', 'Secretary', 14000.00, 30, 'San Pablo', 'CRD'),
(3, 'Jude King', 'Sales', 12000.00, 34, 'Calauan', 'SD'),
(4, 'Pedro Lao', 'Manager', 20000.00, 28, 'Rizal', 'SD'),
(5, 'Jamar Perez', 'Sales', 12000.00, 30, 'Rizal', 'CRD');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `LoanID` int(11) NOT NULL,
  `Eid` int(11) DEFAULT NULL,
  `LoanAmount` decimal(10,2) DEFAULT NULL,
  `Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`LoanID`, `Eid`, `LoanAmount`, `Date`) VALUES
(1, 1, 5000.00, '2022-10-10'),
(2, 2, 2000.00, '2022-09-10'),
(3, 4, 4000.00, '2021-12-31'),
(4, 5, 1500.00, '2021-11-18'),
(5, 5, 7000.00, '2021-10-10');

-- --------------------------------------------------------

--
-- Table structure for table `positioninfo`
--

CREATE TABLE `positioninfo` (
  `PositionID` int(11) NOT NULL,
  `Position` varchar(50) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `positioninfo`
--

INSERT INTO `positioninfo` (`PositionID`, `Position`, `Salary`) VALUES
(1, 'Manager', 20000.00),
(2, 'Secretary', 14000.00),
(3, 'Sales', 12000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_employeeinfo`
-- (See below for the actual view)
--
CREATE TABLE `view_employeeinfo` (
`Eid` int(11)
,`Name` varchar(100)
,`Position` varchar(50)
,`Salary` decimal(10,2)
,`Age` int(11)
,`Address` varchar(100)
,`DeptCode` varchar(10)
);

-- --------------------------------------------------------

--
-- Structure for view `view_employeeinfo`
--
DROP TABLE IF EXISTS `view_employeeinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_employeeinfo`  AS SELECT `employeeinfo`.`Eid` AS `Eid`, `employeeinfo`.`Name` AS `Name`, `employeeinfo`.`Position` AS `Position`, `employeeinfo`.`Salary` AS `Salary`, `employeeinfo`.`Age` AS `Age`, `employeeinfo`.`Address` AS `Address`, `employeeinfo`.`DeptCode` AS `DeptCode` FROM `employeeinfo` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departmentinfo`
--
ALTER TABLE `departmentinfo`
  ADD PRIMARY KEY (`DeptCode`);

--
-- Indexes for table `employeeinfo`
--
ALTER TABLE `employeeinfo`
  ADD PRIMARY KEY (`Eid`),
  ADD KEY `DeptCode` (`DeptCode`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `Eid` (`Eid`);

--
-- Indexes for table `positioninfo`
--
ALTER TABLE `positioninfo`
  ADD PRIMARY KEY (`PositionID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `LoanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `positioninfo`
--
ALTER TABLE `positioninfo`
  MODIFY `PositionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employeeinfo`
--
ALTER TABLE `employeeinfo`
  ADD CONSTRAINT `employeeinfo_ibfk_1` FOREIGN KEY (`DeptCode`) REFERENCES `departmentinfo` (`DeptCode`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`Eid`) REFERENCES `employeeinfo` (`Eid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
