-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Sze 25. 21:00
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `graph`
--
CREATE DATABASE IF NOT EXISTS `graph` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE `graph`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add user', 7, 'add_user'),
(26, 'Can change user', 7, 'change_user'),
(27, 'Can delete user', 7, 'delete_user'),
(28, 'Can view user', 7, 'view_user'),
(29, 'Can add edge', 8, 'add_edge'),
(30, 'Can change edge', 8, 'change_edge'),
(31, 'Can delete edge', 8, 'delete_edge'),
(32, 'Can view edge', 8, 'view_edge');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `display_edge`
--

CREATE TABLE `display_edge` (
  `id` bigint(20) NOT NULL,
  `weight` int(11) NOT NULL,
  `user1_id` bigint(20) NOT NULL,
  `user2_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `display_edge`
--

INSERT INTO `display_edge` (`id`, `weight`, `user1_id`, `user2_id`) VALUES
(1, 1, 1, 2),
(2, 1, 1, 3),
(3, 3, 1, 4),
(4, 3, 1, 5),
(5, 1, 1, 6),
(6, 1, 1, 7),
(7, 1, 1, 8),
(8, 1, 1, 9),
(9, 3, 1, 10),
(10, 1, 1, 11),
(11, 1, 1, 12),
(12, 1, 1, 13),
(13, 1, 1, 14),
(14, 3, 1, 15),
(15, 1, 1, 16),
(16, 1, 1, 17),
(17, 3, 1, 18),
(18, 1, 2, 1),
(19, 3, 2, 3),
(20, 3, 2, 4),
(21, 1, 2, 5),
(22, 1, 2, 6),
(23, 3, 2, 7),
(24, 1, 2, 8),
(25, 1, 2, 9),
(26, 1, 2, 10),
(27, 1, 2, 11),
(28, 3, 2, 12),
(29, 1, 2, 13),
(30, 1, 2, 14),
(31, 1, 2, 15),
(32, 1, 2, 16),
(33, 1, 2, 17),
(34, 1, 2, 18),
(35, 1, 3, 1),
(36, 3, 3, 2),
(37, 2, 3, 4),
(38, 3, 3, 5),
(39, 2, 3, 6),
(40, 3, 3, 7),
(41, 4, 3, 8),
(42, 1, 3, 9),
(43, 1, 3, 10),
(44, 1, 3, 11),
(45, 1, 3, 12),
(46, 4, 3, 13),
(47, 2, 3, 14),
(48, 3, 3, 15),
(49, 1, 3, 16),
(50, 3, 3, 17),
(51, 1, 3, 18),
(52, 3, 4, 1),
(53, 2, 4, 2),
(54, 1, 4, 3),
(55, 2, 4, 5),
(56, 1, 4, 6),
(57, 1, 4, 7),
(58, 1, 4, 8),
(59, 4, 4, 9),
(60, 1, 4, 10),
(61, 1, 4, 11),
(62, 1, 4, 12),
(63, 1, 4, 13),
(64, 4, 4, 14),
(65, 3, 4, 15),
(66, 1, 4, 16),
(67, 1, 4, 17),
(68, 1, 4, 18),
(69, 3, 5, 1),
(70, 1, 5, 2),
(71, 1, 5, 3),
(72, 2, 5, 4),
(73, 1, 5, 6),
(74, 1, 5, 7),
(75, 1, 5, 8),
(76, 1, 5, 9),
(77, 3, 5, 10),
(78, 1, 5, 11),
(79, 1, 5, 12),
(80, 1, 5, 13),
(81, 1, 5, 14),
(82, 3, 5, 15),
(83, 1, 5, 16),
(84, 1, 5, 17),
(85, 4, 5, 18),
(86, 1, 6, 1),
(87, 1, 6, 2),
(88, 1, 6, 3),
(89, 1, 6, 4),
(90, 1, 6, 5),
(91, 1, 6, 7),
(92, 1, 6, 8),
(93, 1, 6, 9),
(94, 1, 6, 10),
(95, 5, 6, 11),
(96, 1, 6, 12),
(97, 1, 6, 13),
(98, 1, 6, 14),
(99, 1, 6, 15),
(100, 1, 6, 16),
(101, 1, 6, 17),
(102, 1, 6, 18),
(103, 1, 7, 1),
(104, 2, 7, 2),
(105, 1, 7, 3),
(106, 1, 7, 4),
(107, 1, 7, 5),
(108, 1, 7, 6),
(109, 1, 7, 8),
(110, 1, 7, 9),
(111, 1, 7, 10),
(112, 1, 7, 11),
(113, 2, 7, 12),
(114, 1, 7, 13),
(115, 1, 7, 14),
(116, 1, 7, 15),
(117, 1, 7, 16),
(118, 1, 7, 17),
(119, 1, 7, 18),
(120, 1, 8, 1),
(121, 1, 8, 2),
(122, 3, 8, 3),
(123, 1, 8, 4),
(124, 1, 8, 5),
(125, 1, 8, 6),
(126, 1, 8, 7),
(127, 1, 8, 9),
(128, 1, 8, 10),
(129, 1, 8, 11),
(130, 1, 8, 12),
(131, 3, 8, 13),
(132, 5, 8, 14),
(133, 1, 8, 15),
(134, 1, 8, 16),
(135, 1, 8, 17),
(136, 1, 8, 18),
(137, 1, 9, 1),
(138, 1, 9, 2),
(139, 1, 9, 3),
(140, 5, 9, 4),
(141, 1, 9, 5),
(142, 1, 9, 6),
(143, 1, 9, 7),
(144, 1, 9, 8),
(145, 1, 9, 10),
(146, 1, 9, 11),
(147, 1, 9, 12),
(148, 1, 9, 13),
(149, 5, 9, 14),
(150, 1, 9, 15),
(151, 1, 9, 16),
(152, 4, 9, 17),
(153, 1, 9, 18),
(154, 3, 10, 1),
(155, 1, 10, 2),
(156, 1, 10, 3),
(157, 1, 10, 4),
(158, 3, 10, 5),
(159, 1, 10, 6),
(160, 1, 10, 7),
(161, 1, 10, 8),
(162, 1, 10, 9),
(163, 1, 10, 11),
(164, 1, 10, 12),
(165, 2, 10, 13),
(166, 1, 10, 14),
(167, 3, 10, 15),
(168, 1, 10, 16),
(169, 1, 10, 17),
(170, 3, 10, 18),
(171, 1, 11, 1),
(172, 1, 11, 2),
(173, 1, 11, 3),
(174, 1, 11, 4),
(175, 1, 11, 5),
(176, 5, 11, 6),
(177, 1, 11, 7),
(178, 1, 11, 8),
(179, 3, 11, 9),
(180, 1, 11, 10),
(181, 1, 11, 12),
(182, 1, 11, 13),
(183, 1, 11, 14),
(184, 3, 11, 15),
(185, 1, 11, 16),
(186, 1, 11, 17),
(187, 1, 11, 18),
(188, 1, 12, 1),
(189, 3, 12, 2),
(190, 1, 12, 3),
(191, 1, 12, 4),
(192, 1, 12, 5),
(193, 1, 12, 6),
(194, 3, 12, 7),
(195, 1, 12, 8),
(196, 1, 12, 9),
(197, 1, 12, 10),
(198, 1, 12, 11),
(199, 1, 12, 13),
(200, 1, 12, 14),
(201, 1, 12, 15),
(202, 1, 12, 16),
(203, 1, 12, 17),
(204, 1, 12, 18),
(205, 1, 13, 1),
(206, 1, 13, 2),
(207, 3, 13, 3),
(208, 1, 13, 4),
(209, 1, 13, 5),
(210, 1, 13, 6),
(211, 1, 13, 7),
(212, 3, 13, 8),
(213, 1, 13, 9),
(214, 1, 13, 10),
(215, 1, 13, 11),
(216, 1, 13, 12),
(217, 1, 13, 14),
(218, 1, 13, 15),
(219, 1, 13, 16),
(220, 1, 13, 17),
(221, 1, 13, 18),
(222, 1, 14, 1),
(223, 2, 14, 2),
(224, 1, 14, 3),
(225, 4, 14, 4),
(226, 1, 14, 5),
(227, 1, 14, 6),
(228, 1, 14, 7),
(229, 5, 14, 8),
(230, 4, 14, 9),
(231, 1, 14, 10),
(232, 1, 14, 11),
(233, 1, 14, 12),
(234, 1, 14, 13),
(235, 1, 14, 15),
(236, 1, 14, 16),
(237, 3, 14, 17),
(238, 1, 14, 18),
(239, 3, 15, 1),
(240, 1, 15, 2),
(241, 1, 15, 3),
(242, 1, 15, 4),
(243, 3, 15, 5),
(244, 1, 15, 6),
(245, 1, 15, 7),
(246, 1, 15, 8),
(247, 1, 15, 9),
(248, 3, 15, 10),
(249, 2, 15, 11),
(250, 1, 15, 12),
(251, 1, 15, 13),
(252, 1, 15, 14),
(253, 1, 15, 16),
(254, 1, 15, 17),
(255, 3, 15, 18),
(256, 1, 16, 1),
(257, 2, 16, 2),
(258, 1, 16, 3),
(259, 1, 16, 4),
(260, 1, 16, 5),
(261, 1, 16, 6),
(262, 2, 16, 7),
(263, 1, 16, 8),
(264, 1, 16, 9),
(265, 1, 16, 10),
(266, 1, 16, 11),
(267, 2, 16, 12),
(268, 1, 16, 13),
(269, 1, 16, 14),
(270, 1, 16, 15),
(271, 1, 16, 17),
(272, 1, 16, 18),
(273, 1, 17, 1),
(274, 1, 17, 2),
(275, 3, 17, 3),
(276, 1, 17, 4),
(277, 1, 17, 5),
(278, 1, 17, 6),
(279, 1, 17, 7),
(280, 1, 17, 8),
(281, 4, 17, 9),
(282, 1, 17, 10),
(283, 1, 17, 11),
(284, 1, 17, 12),
(285, 1, 17, 13),
(286, 3, 17, 14),
(287, 1, 17, 15),
(288, 1, 17, 16),
(289, 1, 17, 18),
(290, 3, 18, 1),
(291, 1, 18, 2),
(292, 1, 18, 3),
(293, 1, 18, 4),
(294, 3, 18, 5),
(295, 1, 18, 6),
(296, 1, 18, 7),
(297, 1, 18, 8),
(298, 1, 18, 9),
(299, 3, 18, 10),
(300, 1, 18, 11),
(301, 1, 18, 12),
(302, 1, 18, 13),
(303, 1, 18, 14),
(304, 3, 18, 15),
(305, 1, 18, 16),
(306, 1, 18, 17),
(307, 1, 1, 2),
(308, 1, 1, 3),
(309, 3, 1, 4),
(310, 3, 1, 5),
(311, 1, 1, 6),
(312, 1, 1, 7),
(313, 1, 1, 8),
(314, 1, 1, 9),
(315, 3, 1, 10),
(316, 1, 1, 11),
(317, 1, 1, 12),
(318, 1, 1, 13),
(319, 1, 1, 14),
(320, 3, 1, 15),
(321, 1, 1, 16),
(322, 1, 1, 17),
(323, 3, 1, 18),
(324, 1, 2, 1),
(325, 3, 2, 3),
(326, 3, 2, 4),
(327, 1, 2, 5),
(328, 1, 2, 6),
(329, 3, 2, 7),
(330, 1, 2, 8),
(331, 1, 2, 9),
(332, 1, 2, 10),
(333, 1, 2, 11),
(334, 3, 2, 12),
(335, 1, 2, 13),
(336, 1, 2, 14),
(337, 1, 2, 15),
(338, 1, 2, 16),
(339, 1, 2, 17),
(340, 1, 2, 18),
(341, 1, 3, 1),
(342, 3, 3, 2),
(343, 2, 3, 4),
(344, 3, 3, 5),
(345, 2, 3, 6),
(346, 3, 3, 7),
(347, 4, 3, 8),
(348, 1, 3, 9),
(349, 1, 3, 10),
(350, 1, 3, 11),
(351, 1, 3, 12),
(352, 4, 3, 13),
(353, 2, 3, 14),
(354, 3, 3, 15),
(355, 1, 3, 16),
(356, 3, 3, 17),
(357, 1, 3, 18),
(358, 3, 4, 1),
(359, 2, 4, 2),
(360, 1, 4, 3),
(361, 2, 4, 5),
(362, 1, 4, 6),
(363, 1, 4, 7),
(364, 1, 4, 8),
(365, 4, 4, 9),
(366, 1, 4, 10),
(367, 1, 4, 11),
(368, 1, 4, 12),
(369, 1, 4, 13),
(370, 4, 4, 14),
(371, 3, 4, 15),
(372, 1, 4, 16),
(373, 1, 4, 17),
(374, 1, 4, 18),
(375, 3, 5, 1),
(376, 1, 5, 2),
(377, 1, 5, 3),
(378, 2, 5, 4),
(379, 1, 5, 6),
(380, 1, 5, 7),
(381, 1, 5, 8),
(382, 1, 5, 9),
(383, 3, 5, 10),
(384, 1, 5, 11),
(385, 1, 5, 12),
(386, 1, 5, 13),
(387, 1, 5, 14),
(388, 3, 5, 15),
(389, 1, 5, 16),
(390, 1, 5, 17),
(391, 4, 5, 18),
(392, 1, 6, 1),
(393, 1, 6, 2),
(394, 1, 6, 3),
(395, 1, 6, 4),
(396, 1, 6, 5),
(397, 1, 6, 7),
(398, 1, 6, 8),
(399, 1, 6, 9),
(400, 1, 6, 10),
(401, 5, 6, 11),
(402, 1, 6, 12),
(403, 1, 6, 13),
(404, 1, 6, 14),
(405, 1, 6, 15),
(406, 1, 6, 16),
(407, 1, 6, 17),
(408, 1, 6, 18),
(409, 1, 7, 1),
(410, 2, 7, 2),
(411, 1, 7, 3),
(412, 1, 7, 4),
(413, 1, 7, 5),
(414, 1, 7, 6),
(415, 1, 7, 8),
(416, 1, 7, 9),
(417, 1, 7, 10),
(418, 1, 7, 11),
(419, 2, 7, 12),
(420, 1, 7, 13),
(421, 1, 7, 14),
(422, 1, 7, 15),
(423, 1, 7, 16),
(424, 1, 7, 17),
(425, 1, 7, 18),
(426, 1, 8, 1),
(427, 1, 8, 2),
(428, 3, 8, 3),
(429, 1, 8, 4),
(430, 1, 8, 5),
(431, 1, 8, 6),
(432, 1, 8, 7),
(433, 1, 8, 9),
(434, 1, 8, 10),
(435, 1, 8, 11),
(436, 1, 8, 12),
(437, 3, 8, 13),
(438, 5, 8, 14),
(439, 1, 8, 15),
(440, 1, 8, 16),
(441, 1, 8, 17),
(442, 1, 8, 18),
(443, 1, 9, 1),
(444, 1, 9, 2),
(445, 1, 9, 3),
(446, 5, 9, 4),
(447, 1, 9, 5),
(448, 1, 9, 6),
(449, 1, 9, 7),
(450, 1, 9, 8),
(451, 1, 9, 10),
(452, 1, 9, 11),
(453, 1, 9, 12),
(454, 1, 9, 13),
(455, 5, 9, 14),
(456, 1, 9, 15),
(457, 1, 9, 16),
(458, 4, 9, 17),
(459, 1, 9, 18),
(460, 3, 10, 1),
(461, 1, 10, 2),
(462, 1, 10, 3),
(463, 1, 10, 4),
(464, 3, 10, 5),
(465, 1, 10, 6),
(466, 1, 10, 7),
(467, 1, 10, 8),
(468, 1, 10, 9),
(469, 1, 10, 11),
(470, 1, 10, 12),
(471, 2, 10, 13),
(472, 1, 10, 14),
(473, 3, 10, 15),
(474, 1, 10, 16),
(475, 1, 10, 17),
(476, 3, 10, 18),
(477, 1, 11, 1),
(478, 1, 11, 2),
(479, 1, 11, 3),
(480, 1, 11, 4),
(481, 1, 11, 5),
(482, 5, 11, 6),
(483, 1, 11, 7),
(484, 1, 11, 8),
(485, 3, 11, 9),
(486, 1, 11, 10),
(487, 1, 11, 12),
(488, 1, 11, 13),
(489, 1, 11, 14),
(490, 3, 11, 15),
(491, 1, 11, 16),
(492, 1, 11, 17),
(493, 1, 11, 18),
(494, 1, 12, 1),
(495, 3, 12, 2),
(496, 1, 12, 3),
(497, 1, 12, 4),
(498, 1, 12, 5),
(499, 1, 12, 6),
(500, 3, 12, 7),
(501, 1, 12, 8),
(502, 1, 12, 9),
(503, 1, 12, 10),
(504, 1, 12, 11),
(505, 1, 12, 13),
(506, 1, 12, 14),
(507, 1, 12, 15),
(508, 1, 12, 16),
(509, 1, 12, 17),
(510, 1, 12, 18),
(511, 1, 13, 1),
(512, 1, 13, 2),
(513, 3, 13, 3),
(514, 1, 13, 4),
(515, 1, 13, 5),
(516, 1, 13, 6),
(517, 1, 13, 7),
(518, 3, 13, 8),
(519, 1, 13, 9),
(520, 1, 13, 10),
(521, 1, 13, 11),
(522, 1, 13, 12),
(523, 1, 13, 14),
(524, 1, 13, 15),
(525, 1, 13, 16),
(526, 1, 13, 17),
(527, 1, 13, 18),
(528, 1, 14, 1),
(529, 2, 14, 2),
(530, 1, 14, 3),
(531, 4, 14, 4),
(532, 1, 14, 5),
(533, 1, 14, 6),
(534, 1, 14, 7),
(535, 5, 14, 8),
(536, 4, 14, 9),
(537, 1, 14, 10),
(538, 1, 14, 11),
(539, 1, 14, 12),
(540, 1, 14, 13),
(541, 1, 14, 15),
(542, 1, 14, 16),
(543, 3, 14, 17),
(544, 1, 14, 18),
(545, 3, 15, 1),
(546, 1, 15, 2),
(547, 1, 15, 3),
(548, 1, 15, 4),
(549, 3, 15, 5),
(550, 1, 15, 6),
(551, 1, 15, 7),
(552, 1, 15, 8),
(553, 1, 15, 9),
(554, 3, 15, 10),
(555, 2, 15, 11),
(556, 1, 15, 12),
(557, 1, 15, 13),
(558, 1, 15, 14),
(559, 1, 15, 16),
(560, 1, 15, 17),
(561, 3, 15, 18),
(562, 1, 16, 1),
(563, 2, 16, 2),
(564, 1, 16, 3),
(565, 1, 16, 4),
(566, 1, 16, 5),
(567, 1, 16, 6),
(568, 2, 16, 7),
(569, 1, 16, 8),
(570, 1, 16, 9),
(571, 1, 16, 10),
(572, 1, 16, 11),
(573, 2, 16, 12),
(574, 1, 16, 13),
(575, 1, 16, 14),
(576, 1, 16, 15),
(577, 1, 16, 17),
(578, 1, 16, 18),
(579, 1, 17, 1),
(580, 1, 17, 2),
(581, 3, 17, 3),
(582, 1, 17, 4),
(583, 1, 17, 5),
(584, 1, 17, 6),
(585, 1, 17, 7),
(586, 1, 17, 8),
(587, 4, 17, 9),
(588, 1, 17, 10),
(589, 1, 17, 11),
(590, 1, 17, 12),
(591, 1, 17, 13),
(592, 3, 17, 14),
(593, 1, 17, 15),
(594, 1, 17, 16),
(595, 1, 17, 18),
(596, 3, 18, 1),
(597, 1, 18, 2),
(598, 1, 18, 3),
(599, 1, 18, 4),
(600, 3, 18, 5),
(601, 1, 18, 6),
(602, 1, 18, 7),
(603, 1, 18, 8),
(604, 1, 18, 9),
(605, 3, 18, 10),
(606, 1, 18, 11),
(607, 1, 18, 12),
(608, 1, 18, 13),
(609, 1, 18, 14),
(610, 3, 18, 15),
(611, 1, 18, 16),
(612, 1, 18, 17);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `display_user`
--

CREATE TABLE `display_user` (
  `id` bigint(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `display_user`
--

INSERT INTO `display_user` (`id`, `username`, `email`) VALUES
(1, 'Gábor', 'gabor@example.hu'),
(2, 'Eszter', 'eszter@example.hu'),
(3, 'Márk', 'mark@example.hu'),
(4, 'Zsófia', 'zsofia@example.hu'),
(5, 'László', 'laszlo@example.hu'),
(6, 'Katalin', 'katalin@example.hu'),
(7, 'Tamás', 'tamas@example.hu'),
(8, 'Zoltán', 'zoltan@example.hu'),
(9, 'Anikó', 'aniko@example.hu'),
(10, 'Péter', 'peter@example.hu'),
(11, 'Eva', 'eva@example.hu'),
(12, 'András', 'andras@example.hu'),
(13, 'Klára', 'klara@example.hu'),
(14, 'János', 'janos@example.hu'),
(15, 'Krisztina', 'krisztina@example.hu'),
(16, 'Ferenc', 'ferenc@example.hu'),
(17, 'Ildikó', 'ildiko@example.hu'),
(18, 'Mihály', 'mihaly@example.hu');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'display', 'edge'),
(7, 'display', 'user'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-09-20 21:30:04.264351'),
(2, 'auth', '0001_initial', '2023-09-20 21:30:10.029100'),
(3, 'admin', '0001_initial', '2023-09-20 21:30:11.321318'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-09-20 21:30:11.348908'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-09-20 21:30:11.386427'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-09-20 21:30:12.029269'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-09-20 21:30:12.749986'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-09-20 21:30:13.070168'),
(9, 'auth', '0004_alter_user_username_opts', '2023-09-20 21:30:13.138323'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-09-20 21:30:13.534792'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-09-20 21:30:13.668421'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-09-20 21:30:13.739225'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-09-20 21:30:13.821573'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-09-20 21:30:13.910091'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-09-20 21:30:14.015908'),
(16, 'auth', '0011_update_proxy_permissions', '2023-09-20 21:30:14.047064'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-09-20 21:30:14.122833'),
(18, 'display', '0001_initial', '2023-09-20 21:30:15.453025'),
(19, 'sessions', '0001_initial', '2023-09-20 21:30:15.713554');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- A tábla indexei `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- A tábla indexei `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- A tábla indexei `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- A tábla indexei `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- A tábla indexei `display_edge`
--
ALTER TABLE `display_edge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `display_edge_user1_id_4e200bf3_fk_display_user_id` (`user1_id`),
  ADD KEY `display_edge_user2_id_3371a207_fk_display_user_id` (`user2_id`);

--
-- A tábla indexei `display_user`
--
ALTER TABLE `display_user`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- A tábla indexei `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- A tábla indexei `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT a táblához `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `display_edge`
--
ALTER TABLE `display_edge`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=613;

--
-- AUTO_INCREMENT a táblához `display_user`
--
ALTER TABLE `display_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT a táblához `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Megkötések a táblához `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Megkötések a táblához `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Megkötések a táblához `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Megkötések a táblához `display_edge`
--
ALTER TABLE `display_edge`
  ADD CONSTRAINT `display_edge_user1_id_4e200bf3_fk_display_user_id` FOREIGN KEY (`user1_id`) REFERENCES `display_user` (`id`),
  ADD CONSTRAINT `display_edge_user2_id_3371a207_fk_display_user_id` FOREIGN KEY (`user2_id`) REFERENCES `display_user` (`id`);

--
-- Megkötések a táblához `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
