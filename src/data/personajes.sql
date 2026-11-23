-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-10-2026 a las 21:08:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `personajes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_personajes`
--

CREATE TABLE `equipo_personajes` (
  `id` int(11) NOT NULL,
  `fk_ranking` int(11) NOT NULL,
  `fk_personaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipo_personajes`
--

INSERT INTO `equipo_personajes` (`id`, `fk_ranking`, `fk_personaje`) VALUES
(1, 1, 63),
(2, 1, 297),
(3, 1, 136),
(7, 3, 159),
(8, 3, 274),
(9, 3, 251),
(10, 4, 266),
(11, 4, 40),
(12, 4, 82),
(13, 5, 95),
(14, 5, 240),
(15, 5, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaje`
--

CREATE TABLE `personaje` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `img` varchar(100) NOT NULL,
  `poder` int(3) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `universo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personaje`
--

INSERT INTO `personaje` (`id`, `nombre`, `img`, `poder`, `tipo_id`, `universo_id`) VALUES
(1, 'Lionel Messi', '/jugadores/1_messi.avif', 14, 1, 1),
(2, 'Guido Kaczka', '/jugadores/2_guido.avif', 6, 1, 1),
(3, 'Manuel Adorni', '/jugadores/3_adorni.avif', 5, 1, 1),
(4, 'Javier Milei', '/jugadores/4_milei.avif', 6, 1, 1),
(5, 'Vladimir Putin', '/jugadores/5_putin.avif', 11, 2, 1),
(6, 'Donald Trump', '/jugadores/6_trump.avif', 4, 1, 1),
(7, 'Cristina Fernández de Kirchner', '/jugadores/7_cristina.avif', 3, 1, 1),
(8, 'Super Hijitus', '/jugadores/8_hijitus_sombreritus.avif', 90, 3, 2),
(9, 'Hijitus (sin sombreritus)', '/jugadores/9_hijitus.avif', 8, 4, 2),
(10, 'Larguirucho', '/jugadores/10_larguirucho.avif', 12, 5, 2),
(11, 'Pichichus', '/jugadores/11_pichichus.avif', 6, 6, 2),
(12, 'Profesor Neurus', '/jugadores/12_profesor neurus.avif', 15, 7, 2),
(13, 'Pucho', '/jugadores/13_pucho.avif', 8, 6, 2),
(14, 'Serrucho', '/jugadores/14_serrucho.avif', 10, 6, 2),
(15, 'Calculín', '/jugadores/15_calculin.avif', 10, 5, 2),
(16, 'Anteojito', '/jugadores/16_anteojito.avif', 5, 4, 2),
(17, 'Antifaz', '/jugadores/17_antifaz.avif', 5, 1, 2),
(18, 'Manuel García Ferré (cameo)', '/jugadores/18_manuel garcia ferre.avif', 2, 1, 2),
(19, 'Mafalda', '/jugadores/19_mafalda.avif', 3, 8, 3),
(20, 'Felipe', '/jugadores/20_felipe.avif', 2, 4, 3),
(21, 'Manolito', '/jugadores/21_manolito.avif', 3, 4, 3),
(22, 'Susanita', '/jugadores/22_susanita.avif', 2, 8, 3),
(23, 'Libertad', '/jugadores/23_libertad.avif', 2, 8, 3),
(24, 'Gaturro', '/jugadores/24_gaturro.avif', 4, 6, 3),
(25, 'Ágatha', '/jugadores/25_agatha.avif', 3, 1, 3),
(26, 'Inodoro Pereyra', '/jugadores/26_inodoro pereyra.avif', 8, 9, 3),
(27, 'Mendieta', '/jugadores/27_mendieta.avif', 8, 6, 3),
(28, 'Boogie el Aceitoso', '/jugadores/28_boogie el aceitoso.avif', 18, 10, 3),
(29, 'Clemente', '/jugadores/29_clemente.avif', 2, 6, 3),
(30, 'Patoruzú', '/jugadores/30_patoruzu.avif', 95, 11, 3),
(31, 'Isidoro Cañones', '/jugadores/31_isidoro cañones.avif', 6, 1, 3),
(32, 'Patoruzito', '/jugadores/32_patoruzito.avif', 88, 11, 3),
(33, 'Ñancul', '/jugadores/33_ñancul.avif', 55, 12, 3),
(34, 'Walter White', '/jugadores/34_walter white.avif', 28, 1, 4),
(35, 'Jesse Pinkman', '/jugadores/35_jesse pinkman.avif', 22, 1, 4),
(36, 'Saul Goodman', '/jugadores/36_saul goodman.avif', 12, 1, 4),
(37, 'Mike Ehrmantraut', '/jugadores/37_mike ehrmantraut.avif', 36, 1, 4),
(38, 'Gustavo Fring', '/jugadores/38_gustavo fring.avif', 24, 1, 4),
(39, 'Hank Schrader', '/jugadores/39_hank schrader.avif', 26, 1, 4),
(40, 'Tuco Salamanca', '/jugadores/40_tuco salamanca.avif', 42, 1, 4),
(41, 'Lalo Salamanca', '/jugadores/41_lalo salamanca.avif', 46, 1, 4),
(42, 'Nacho Varga', '/jugadores/42_nacho varga.avif', 30, 1, 4),
(43, 'Hector Salamanca', '/jugadores/43_hector salamanca.avif', 10, 1, 4),
(44, 'Don Eladio', '/jugadores/44_don eladio.avif', 15, 1, 4),
(45, 'Juan Bolsa', '/jugadores/45_juan bolsa.avif', 18, 1, 4),
(46, 'Leonel Salamanca', '/jugadores/46_leonel salamanca.avif', 48, 1, 4),
(47, 'Marco Salamanca', '/jugadores/47_marco salamanca.avif', 48, 1, 4),
(48, 'Todd Alquist', '/jugadores/48_todd alquist.avif', 24, 1, 4),
(49, 'Jack Welker', '/jugadores/49_jack welker.avif', 32, 1, 4),
(50, 'Kim Wexler', '/jugadores/50_kim wexler.avif', 10, 1, 4),
(51, 'Howard Hamlin', '/jugadores/51_howard hamlin.avif', 8, 1, 4),
(52, 'Mr. Incredible', '/jugadores/52_mr increible.avif', 86, 13, 5),
(53, 'Elastigirl', '/jugadores/53_elastigirl.avif', 74, 13, 5),
(54, 'Violet Parr', '/jugadores/54_violet parr.avif', 82, 13, 5),
(55, 'Dash Parr', '/jugadores/55_dash parr.avif', 68, 13, 5),
(56, 'Jack-Jack', '/jugadores/56_jack jack.avif', 99, 13, 5),
(57, 'Frozone', '/jugadores/57_frozone.avif', 80, 13, 5),
(58, 'Syndrome', '/jugadores/58_syndrome.avif', 72, 14, 5),
(59, 'Mirage', '/jugadores/59_mirage.avif', 22, 1, 5),
(60, 'Edna Mode', '/jugadores/60_edna mode.avif', 12, 1, 5),
(61, 'Bomb Voyage', '/jugadores/61_bomb voyage.avif', 38, 15, 5),
(62, 'The Underminer', '/jugadores/62_the underminer.avif', 70, 14, 5),
(63, 'Green Goblin', '/jugadores/63_green goblin.avif', 58, 13, 6),
(64, 'Doctor Octopus', '/jugadores/64_doctor octopus.avif', 52, 16, 6),
(65, 'Venom', '/jugadores/65_venom.avif', 75, 17, 6),
(66, 'Carnage', '/jugadores/66_carnage.avif', 82, 17, 6),
(67, 'Sandman', '/jugadores/67_sandman.avif', 78, 18, 6),
(68, 'Electro', '/jugadores/68_electro.avif', 84, 18, 6),
(69, 'Lizard', '/jugadores/69_lizard.avif', 72, 18, 6),
(70, 'Mysterio', '/jugadores/70_mysterio.avif', 48, 19, 6),
(71, 'Vulture', '/jugadores/71_vulture.avif', 58, 20, 6),
(72, 'Kraven the Hunter', '/jugadores/72_kraven the hunter.avif', 55, 16, 6),
(73, 'Kingpin', '/jugadores/73_kingpin.avif', 45, 21, 6),
(74, 'Rhino', '/jugadores/74_rhino.avif', 70, 22, 6),
(75, 'Scorpion', '/jugadores/75_scorpion.avif', 65, 18, 6),
(76, 'Shocker', '/jugadores/76_shocker.avif', 54, 23, 6),
(77, 'Chameleon', '/jugadores/77_chameleon.avif', 30, 24, 6),
(78, 'Morbius', '/jugadores/78_morbius.avif', 72, 25, 6),
(79, 'Hobgoblin', '/jugadores/79_hobgoblin.avif', 56, 13, 6),
(80, 'Tombstone', '/jugadores/80_tombstone.avif', 48, 18, 6),
(81, 'Hammerhead', '/jugadores/81_hammerhead.avif', 38, 16, 6),
(82, 'Mister Negative', '/jugadores/82_mister negative.avif', 80, 13, 6),
(83, 'Luther Hargreeves', '/jugadores/83_luther hargreeves.avif', 72, 13, 7),
(84, 'Diego Hargreeves', '/jugadores/84_diego hargreeves.avif', 54, 26, 7),
(85, 'Allison Hargreeves', '/jugadores/85_allison hargreeves.avif', 88, 13, 7),
(86, 'Klaus Hargreeves', '/jugadores/86_klaus hargreeves.avif', 82, 13, 7),
(87, 'Five Hargreeves', '/jugadores/87_five hargreeves.avif', 92, 13, 7),
(88, 'Ben Hargreeves', '/jugadores/88_ben hargreeves.avif', 74, 13, 7),
(89, 'Viktor Hargreeves', '/jugadores/89_viktor hargreeves.avif', 99, 13, 7),
(90, 'Reginald Hargreeves', '/jugadores/90_reginald hargreeves.avif', 30, 27, 7),
(91, 'Lila Pitts', '/jugadores/91_lila pitts.avif', 94, 13, 7),
(92, 'The Handler', '/jugadores/92_the handler.avif', 20, 28, 7),
(93, 'Cha-Cha', '/jugadores/93_cha-cha.avif', 35, 26, 7),
(94, 'Hazel', '/jugadores/94_hazel.avif', 35, 26, 7),
(95, 'Kratos', '/jugadores/95_kratos.avif', 100, 29, 8),
(96, 'Atreus', '/jugadores/96_atreus.avif', 88, 29, 8),
(97, 'Zeus', '/jugadores/97_zeus.avif', 99, 30, 8),
(98, 'Odin', '/jugadores/98_odin.avif', 98, 30, 8),
(99, 'Thor', '/jugadores/99_thor.avif', 98, 30, 8),
(100, 'Baldur', '/jugadores/100_baldur.avif', 95, 30, 8),
(101, 'Freya', '/jugadores/101_freya.avif', 95, 31, 8),
(102, 'Ares', '/jugadores/102_ares.avif', 99, 30, 8),
(103, 'Athena', '/jugadores/103_athena.avif', 90, 31, 8),
(104, 'Poseidón', '/jugadores/104_poseidon.avif', 97, 30, 8),
(105, 'Hades', '/jugadores/105_hades.avif', 97, 30, 8),
(106, 'Hermes', '/jugadores/106_hermes.avif', 90, 30, 8),
(107, 'Heimdall', '/jugadores/107_heimdall.avif', 94, 30, 8),
(108, 'Tyr', '/jugadores/108_tyr.avif', 92, 30, 8),
(109, 'Brok', '/jugadores/109_brok.avif', 18, 32, 8),
(110, 'Sindri', '/jugadores/110_sindri.avif', 20, 32, 8),
(111, 'Mimir', '/jugadores/111_mimir.avif', 15, 33, 8),
(112, 'Freyr', '/jugadores/112_freyr.avif', 90, 30, 8),
(113, 'Magni', '/jugadores/113_magni.avif', 84, 29, 8),
(114, 'Modi', '/jugadores/114_modi.avif', 78, 29, 8),
(115, 'Homero Simpson', '/jugadores/115_homero.avif', 8, 1, 9),
(116, 'Marge Simpson', '/jugadores/116_marge.avif', 6, 1, 9),
(117, 'Bart Simpson', '/jugadores/117_bart.avif', 7, 1, 9),
(118, 'Lisa Simpson', '/jugadores/118_lisa.avif', 7, 1, 9),
(119, 'Maggie Simpson', '/jugadores/119_maggie.avif', 10, 1, 9),
(120, 'Ned Flanders', '/jugadores/120_ned.avif', 5, 1, 9),
(121, 'Moe Szyslak', '/jugadores/121_moe.avif', 10, 1, 9),
(122, 'Apu Nahasapeemapetilon', '/jugadores/122_apu.avif', 6, 1, 9),
(123, 'Montgomery Burns', '/jugadores/123_burns.avif', 12, 1, 9),
(124, 'Waylon Smithers', '/jugadores/124_smithers.avif', 8, 1, 9),
(125, 'Krusty el Payaso', '/jugadores/125_krusty.avif', 7, 1, 9),
(126, 'Chief Wiggum', '/jugadores/126_wiggum.avif', 8, 1, 9),
(127, 'Seymour Skinner', '/jugadores/127_skinner.avif', 8, 1, 9),
(128, 'Nelson Muntz', '/jugadores/128_nelson.avif', 10, 1, 9),
(129, 'Milhouse Van Houten', '/jugadores/129_milhouse.avif', 5, 1, 9),
(130, 'Comic Book Guy', '/jugadores/130_comic.avif', 4, 1, 9),
(131, 'Groundskeeper Willie', '/jugadores/131_willie.avif', 24, 1, 9),
(132, 'Sideshow Bob', '/jugadores/132_bob.avif', 18, 1, 9),
(133, 'Otto Mann', '/jugadores/133_otto.avif', 8, 1, 9),
(134, 'Professor Frink', '/jugadores/frink.avif', 14, 1, 9),
(135, 'Billy Butcher', '/jugadores/135_billy butcher.avif', 55, 1, 10),
(136, 'Homelander', '/jugadores/136_homelander.avif', 88, 34, 10),
(137, 'Hughie Campbell', '/jugadores/137_hughie campbell.avif', 25, 1, 10),
(138, 'Annie January', '/jugadores/138_annie january.avif', 63, 34, 10),
(139, 'Queen Maeve', '/jugadores/139_queen maeve.avif', 76, 34, 10),
(140, 'A-Train', '/jugadores/140_a-train.avif', 68, 34, 10),
(141, 'The Deep', '/jugadores/141_the deep.avif', 40, 34, 10),
(142, 'Black Noir', '/jugadores/142_black noir.avif', 67, 34, 10),
(143, 'Soldier Boy', '/jugadores/143_soldier boy.avif', 85, 34, 10),
(144, 'Kimiko', '/jugadores/144_kimiko.avif', 58, 34, 10),
(145, 'Frenchie', '/jugadores/145_frenchie.avif', 18, 1, 10),
(146, 'Mother\'s Milk', '/jugadores/146_mothers milk.avif', 18, 1, 10),
(147, 'Stormfront', '/jugadores/147_stormfront.avif', 82, 34, 10),
(148, 'Victoria Neuman', '/jugadores/148_victoria neuman.avif', 80, 34, 10),
(149, 'Firecracker', '/jugadores/149_firecracker.avif', 35, 34, 10),
(150, 'Sister Sage', '/jugadores/150_sister sage.avif', 20, 35, 10),
(151, 'Ryan Butcher', '/jugadores/151_ryan butcher.avif', 90, 34, 10),
(152, 'Stan Edgar', '/jugadores/152_stan edgar.avif', 10, 1, 10),
(153, 'Translucent', '/jugadores/153_translucent.avif', 50, 34, 10),
(154, 'Tek Knight', '/jugadores/154_tek knight.avif', 30, 34, 10),
(155, 'Spider-Man', '/jugadores/155_spider-man.avif', 72, 36, 11),
(156, 'Iron Man', '/jugadores/156_iron man.avif', 84, 23, 11),
(157, 'Captain America', '/jugadores/157_captain america.avif', 60, 37, 11),
(158, 'Thor', '/jugadores/158_thor.avif', 95, 30, 11),
(159, 'Hulk', '/jugadores/159_hulk.avif', 96, 13, 11),
(160, 'Black Widow', '/jugadores/160_black widow.avif', 32, 26, 11),
(161, 'Hawkeye', '/jugadores/161_hawkeye.avif', 33, 26, 11),
(162, 'Wolverine', '/jugadores/162_wolverine.avif', 78, 38, 11),
(163, 'Deadpool', '/jugadores/163_deadpool.avif', 74, 18, 11),
(164, 'Doctor Strange', '/jugadores/164_strange.avif', 96, 39, 11),
(165, 'Scarlet Witch', '/jugadores/165_scarlet.avif', 99, 40, 11),
(166, 'Vision', '/jugadores/166_vision.avif', 90, 41, 11),
(167, 'Black Panther', '/jugadores/167_panther.avif', 68, 16, 11),
(168, 'Captain Marvel', '/jugadores/168_captain marvel.avif', 95, 42, 11),
(169, 'Ant-Man', '/jugadores/169_ant-man.avif', 82, 23, 11),
(170, 'Wasp', '/jugadores/170_wasp.avif', 70, 23, 11),
(171, 'Loki', '/jugadores/171_loki.avif', 92, 30, 11),
(172, 'Thanos', '/jugadores/172_thanos.avif', 98, 43, 11),
(177, 'Magneto', '/jugadores/177_magneto.avif', 96, 38, 11),
(178, 'Professor X', '/jugadores/178_x.avif', 94, 38, 11),
(179, 'Mystique', '/jugadores/179_mystique.avif', 48, 38, 11),
(180, 'Beast', '/jugadores/180_beast.avif', 58, 38, 11),
(181, 'Cyclops', '/jugadores/181_cyclops.avif', 68, 38, 11),
(182, 'Jean Grey', '/jugadores/182_jean.avif', 100, 44, 11),
(183, 'Storm', '/jugadores/183_storm.avif', 90, 38, 11),
(184, 'Nightcrawler', '/jugadores/184_nightcrawler.avif', 64, 38, 11),
(185, 'Gambit', '/jugadores/185_gambit.avif', 70, 38, 11),
(186, 'Rogue', '/jugadores/186_rogue.avif', 88, 38, 11),
(187, 'Daredevil', '/jugadores/187_daredevil.avif', 42, 26, 11),
(188, 'Punisher', '/jugadores/188_punisher.avif', 34, 26, 11),
(189, 'Ghost Rider', '/jugadores/189_ghost.avif', 99, 45, 11),
(190, 'Moon Knight', '/jugadores/190_moon.avif', 62, 46, 11),
(191, 'Silver Surfer', '/jugadores/191_silver.avif', 99, 47, 11),
(192, 'Galactus', '/jugadores/192_galactus.avif', 100, 47, 11),
(193, 'Ultron', '/jugadores/193_ultron.avif', 92, 48, 11),
(194, 'Kang', '/jugadores/194_kang.avif', 94, 49, 11),
(195, 'Nick Fury', '/jugadores/195_nick fury.avif', 22, 26, 11),
(196, 'Batman', '/jugadores/196_batman.avif', 42, 26, 12),
(197, 'Superman', '/jugadores/197_superman.avif', 99, 50, 12),
(198, 'Wonder Woman', '/jugadores/198_wonder.avif', 96, 51, 12),
(199, 'Flash', '/jugadores/199_flash.avif', 99, 13, 12),
(200, 'Green Lantern', '/jugadores/200_green.avif', 95, 52, 12),
(201, 'Aquaman', '/jugadores/201_aquaman.avif', 82, 53, 12),
(202, 'Cyborg', '/jugadores/202_cyborg.avif', 78, 54, 12),
(203, 'Martian Manhunter', '/jugadores/203_martian.avif', 98, 55, 12),
(204, 'Robin', '/jugadores/204_robin.avif', 30, 26, 12),
(205, 'Nightwing', '/jugadores/205_nightwing.avif', 36, 26, 12),
(206, 'Red Hood', '/jugadores/206_red hood.avif', 34, 26, 12),
(207, 'Batgirl', '/jugadores/207_batgirl.avif', 31, 26, 12),
(208, 'Harley Quinn', '/jugadores/208_harley.avif', 28, 26, 12),
(209, 'Joker', '/jugadores/209_joker.avif', 20, 1, 12),
(210, 'Catwoman', '/jugadores/210_catwoman.avif', 25, 26, 12),
(211, 'Bane', '/jugadores/211_bane.avif', 48, 56, 12),
(212, 'Scarecrow', '/jugadores/212_scarecrow.avif', 30, 57, 12),
(213, 'Two-Face', '/jugadores/213_two-face.avif', 18, 1, 12),
(214, 'Riddler', '/jugadores/214_riddler.avif', 18, 1, 12),
(215, 'Penguin', '/jugadores/215_penguin.avif', 16, 1, 12),
(216, 'Poison Ivy', '/jugadores/216_ivy.avif', 82, 18, 12),
(217, 'Mr. Freeze', '/jugadores/217_freeze.avif', 55, 23, 12),
(218, 'Deathstroke', '/jugadores/218_deathstroke.avif', 68, 16, 12),
(219, 'Darkseid', '/jugadores/219_darkseid.avif', 100, 58, 12),
(220, 'Lex Luthor', '/jugadores/220_luthor.avif', 55, 59, 12),
(221, 'Doomsday', '/jugadores/221_doomsday.avif', 99, 60, 12),
(222, 'Shazam', '/jugadores/222_shazam.avif', 97, 29, 12),
(223, 'Black Adam', '/jugadores/223_blackadam.avif', 97, 29, 12),
(224, 'Green Arrow', '/jugadores/224_green arrow.avif', 35, 26, 12),
(225, 'Constantine', '/jugadores/225_constantine.avif', 88, 39, 12),
(226, 'Raven', '/jugadores/226_raven.avif', 99, 61, 12),
(227, 'Beast Boy', '/jugadores/227_beastboy.avif', 74, 62, 12),
(228, 'Starfire', '/jugadores/228_starfire.avif', 88, 55, 12),
(229, 'Blue Beetle', '/jugadores/229_bluebeetle.avif', 85, 63, 12),
(230, 'Peacemaker', '/jugadores/230_peacemaker.avif', 36, 16, 12),
(231, 'Invincible', '/jugadores/231_invincible.avif', 92, 64, 13),
(232, 'Omni-Man', '/jugadores/232_omniman.avif', 95, 65, 13),
(233, 'Atom Eve', '/jugadores/233_atomeve.avif', 97, 18, 13),
(234, 'Allen the Alien', '/jugadores/234_allen.avif', 96, 55, 13),
(235, 'Rex Splode', '/jugadores/235_rexsplode.avif', 55, 13, 13),
(236, 'Robot', '/jugadores/236_robot.avif', 70, 66, 13),
(237, 'Monster Girl', '/jugadores/237_monstergirl.avif', 72, 18, 13),
(238, 'Dupli-Kate', '/jugadores/238_duplikate.avif', 52, 13, 13),
(239, 'Bulletproof', '/jugadores/239_bulletproof.avif', 80, 20, 13),
(240, 'Immortal', '/jugadores/240_immortal.avif', 83, 67, 13),
(241, 'War Woman', '/jugadores/241_warwoman.avif', 76, 55, 13),
(242, 'Red Rush', '/jugadores/242_redrush.avif', 68, 68, 13),
(243, 'Darkwing', '/jugadores/243_darkwing.avif', 35, 23, 13),
(244, 'Green Ghost', '/jugadores/244_greenghost.avif', 60, 13, 13),
(245, 'Aquarius', '/jugadores/245_aquarius.avif', 50, 13, 13),
(246, 'Cecil Stedman', '/jugadores/246_cecil.avif', 25, 1, 13),
(247, 'Angstrom Levy', '/jugadores/247_angstrom.avif', 90, 69, 13),
(248, 'Conquest', '/jugadores/248_conquest.avif', 98, 65, 13),
(249, 'Thragg', '/jugadores/249_tragg.avif', 100, 65, 13),
(250, 'Battle Beast', '/jugadores/250_battlebeast.avif', 99, 55, 13),
(251, 'Oliver Grayson', '/jugadores/251_oliver.avif', 88, 64, 13),
(252, 'Anissa', '/jugadores/252_anissa.avif', 95, 65, 13),
(253, 'Lucan', '/jugadores/253_lucan.avif', 90, 65, 13),
(254, 'Thaedus', '/jugadores/254_thaedus.avif', 96, 65, 13),
(255, 'Donald Ferguson', '/jugadores/255_donald.avif', 30, 23, 13),
(256, 'Goku', '/jugadores/256_goku.avif', 99, 70, 14),
(257, 'Vegeta', '/jugadores/257_vegeta.avif', 99, 70, 14),
(258, 'Gohan', '/jugadores/258_gohan.avif', 98, 71, 14),
(259, 'Trunks', '/jugadores/259_trunks.avif', 94, 71, 14),
(260, 'Goten', '/jugadores/260_goten.avif', 88, 71, 14),
(261, 'Piccolo', '/jugadores/261_piccolo.avif', 96, 72, 14),
(262, 'Krillin', '/jugadores/262_krillin.avif', 78, 26, 14),
(263, 'Yamcha', '/jugadores/263_yamcha.avif', 62, 26, 14),
(264, 'Tien Shinhan', '/jugadores/264_tienshinhan.avif', 74, 26, 14),
(265, 'Chiaotzu', '/jugadores/265_chiaotzu.avif', 55, 26, 14),
(266, 'Master Roshi', '/jugadores/266_maestroroshi.avif', 70, 26, 14),
(267, 'Bulma', '/jugadores/267_bulma.avif', 8, 1, 14),
(268, 'Chi-Chi', '/jugadores/268_chichi.avif', 18, 26, 14),
(269, 'Videl', '/jugadores/269_videl.avif', 26, 26, 14),
(270, 'Mr. Satan', '/jugadores/270_mrsatan.avif', 15, 26, 14),
(271, 'Majin Buu', '/jugadores/271_majinbuu.avif', 98, 73, 14),
(272, 'Freezer', '/jugadores/272_frieza.avif', 98, 55, 14),
(273, 'Cell', '/jugadores/273_cell.avif', 97, 74, 14),
(274, 'Android 17', '/jugadores/274_android17.avif', 97, 75, 14),
(275, 'Android 18', '/jugadores/275_android18.avif', 88, 75, 14),
(276, 'Android 16', '/jugadores/276_android16.avif', 90, 76, 14),
(277, 'Dr. Gero', '/jugadores/277_drgero.avif', 58, 77, 14),
(278, 'Nappa', '/jugadores/278_nappa.avif', 70, 70, 14),
(279, 'Raditz', '/jugadores/279_raditz.avif', 60, 70, 14),
(280, 'Bardock', '/jugadores/280_bardock.avif', 84, 70, 14),
(281, 'Broly', '/jugadores/281_broly.avif', 100, 70, 14),
(282, 'Beerus', '/jugadores/282_beerus.avif', 100, 78, 14),
(283, 'Whis', '/jugadores/283_whis.avif', 100, 79, 14),
(284, 'Gogeta', '/jugadores/284_gogeta.avif', 100, 80, 14),
(285, 'Vegito', '/jugadores/285_vegito.avif', 100, 80, 14),
(286, 'Ben Tennyson', '/jugadores/286_ben.avif', 100, 81, 15),
(287, 'Gwen Tennyson', '/jugadores/287_gwen.avif', 85, 82, 15),
(288, 'Kevin Levin', '/jugadores/288_kevin.avif', 82, 83, 15),
(289, 'Grandpa Max', '/jugadores/289_abuelomax.avif', 25, 26, 15),
(290, 'Vilgax', '/jugadores/290_vilgax.avif', 92, 55, 15),
(291, 'Albedo', '/jugadores/291_albedo.avif', 95, 84, 15),
(292, 'Charmcaster', '/jugadores/292_charmcaster.avif', 76, 82, 15),
(293, 'Hex', '/jugadores/293_hex.avif', 72, 82, 15),
(294, 'Zombozo', '/jugadores/294_zombozo.avif', 40, 82, 15),
(295, 'Dr. Animo', '/jugadores/295_dranimo.avif', 58, 23, 15),
(296, 'Ghostfreak', '/jugadores/296_ghostfreak.avif', 85, 55, 15),
(297, 'Four Arms', '/jugadores/297_fourarms.avif', 70, 85, 15),
(298, 'Heatblast', '/jugadores/298_heatblast.avif', 72, 85, 15),
(299, 'XLR8', '/jugadores/299_XLR8.avif', 76, 85, 15),
(300, 'Diamondhead', '/jugadores/300_diamondhead.avif', 80, 85, 15),
(301, 'Cannonbolt', '/jugadores/301_cannonbolt.avif', 72, 85, 15),
(302, 'Wildmutt', '/jugadores/302_wildmutt.avif', 45, 85, 15),
(303, 'Upgrade', '/jugadores/303_upgrade.avif', 75, 85, 15),
(304, 'Grey Matter', '/jugadores/304_greymatter.avif', 20, 85, 15),
(305, 'Stinkfly', '/jugadores/305_stinkfly.avif', 48, 85, 15),
(306, 'Ripjaws', '/jugadores/306_ripjaws.avif', 46, 85, 15),
(307, 'Wildvine', '/jugadores/307_wildvine.avif', 60, 85, 15),
(308, 'Blitzwolfer', '/jugadores/308_blitzwolfer.avif', 58, 85, 15),
(309, 'Snare-oh', '/jugadores/309_snareoh.avif', 60, 85, 15),
(310, 'Frankenstrike', '/jugadores/310_frankenstrike.avif', 68, 85, 15),
(311, 'Echo Echo', '/jugadores/311_echoecho.avif', 82, 85, 15),
(312, 'Humungousaur', '/jugadores/312_humongousaur.avif', 84, 85, 15),
(313, 'Big Chill', '/jugadores/313_bigchill.avif', 86, 85, 15),
(314, 'Swampfire', '/jugadores/314_swampfire.avif', 85, 85, 15),
(315, 'Chromastone', '/jugadores/315_chromastone.avif', 90, 85, 15),
(316, 'Jetray', '/jugadores/316_jetray.avif', 82, 85, 15),
(317, 'Rath', '/jugadores/317_rath.avif', 72, 85, 15),
(318, 'Alien X', '/jugadores/318_alienX.avif', 100, 86, 15),
(319, 'Lodestar', '/jugadores/319_lodestar.avif', 76, 85, 15),
(320, 'Brainstorm', '/jugadores/320_brainstorm.avif', 60, 85, 15),
(321, 'Goop', '/jugadores/321_goop.avif', 70, 85, 15),
(322, 'Spidermonkey', '/jugadores/322_spidermonkey.avif', 65, 85, 15),
(323, 'NRG', '/jugadores/323_NRG.avif', 90, 85, 15),
(324, 'Armodrillo', '/jugadores/324_armodrillo.avif', 72, 85, 15),
(325, 'Water Hazard', '/jugadores/325_waterhazard.avif', 70, 85, 15),
(326, 'AmpFibian', '/jugadores/326_ampfiibian.avif', 84, 85, 15),
(327, 'Clockwork', '/jugadores/327_clockwork.avif', 99, 86, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ranking`
--

CREATE TABLE `ranking` (
  `id` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `poder` int(3) NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ranking`
--

INSERT INTO `ranking` (`id`, `usuario`, `poder`, `fecha`) VALUES
(1, 'keke', 216, '2026-10-20'),
(3, 'kke', 281, '2026-10-20'),
(4, 'gyuguygyu', 192, '2026-10-20'),
(5, 'wow', 278, '2026-10-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id`, `nombre`) VALUES
(1, 'Humano'),
(2, 'Humano (entrenamiento en judo)'),
(3, 'Superhéroe (humano con poderes)'),
(4, 'Humano (niño)'),
(5, 'Robot'),
(6, 'Animal antropomórfico'),
(7, 'Humano (genio villano)'),
(8, 'Humano (niña)'),
(9, 'Humano (gaucho)'),
(10, 'Humano (mercenario)'),
(11, 'Humano (fuerza sobrehumana)'),
(12, 'Animal (caballo)'),
(13, 'Superhumano'),
(14, 'Humano (tecnología avanzada)'),
(15, 'Humano (criminal experto)'),
(16, 'Humano potenciado'),
(17, 'Simbionte / Superhumano'),
(18, 'Superhumano (mutación)'),
(19, 'Humano (tecnología/ilusionismo)'),
(20, 'Humano potenciado (tecnología)'),
(21, 'Humano (fuerza/criminal)'),
(22, 'Superhumano (traje/mutación)'),
(23, 'Humano (tecnología)'),
(24, 'Humano (técnica)'),
(25, 'Superhumano (vampiro viviente)'),
(26, 'Humano entrenado'),
(27, 'Humano/Alienígena'),
(28, 'Humano (Comisión)'),
(29, 'Semidiós'),
(30, 'Dios'),
(31, 'Diosa'),
(32, 'Enano semidivino'),
(33, 'Humano mágico'),
(34, 'Superhumano (Compuesto V)'),
(35, 'Superhumano (inteligencia potenciada)'),
(36, 'Superhumano (mutación accidental)'),
(37, 'Superhumano (supersoldado)'),
(38, 'Mutante'),
(39, 'Humano (mago)'),
(40, 'Mutante / Diosa del caos'),
(41, 'Androide'),
(42, 'Superhumano cósmico'),
(43, 'Eterno (Titán)'),
(44, 'Mutante cósmica (Fénix)'),
(45, 'Entidad sobrenatural'),
(46, 'Humano (avatar divino)'),
(47, 'Entidad cósmica'),
(48, 'Inteligencia artificial'),
(49, 'Humano potenciado (viajero del tiempo)'),
(50, 'Extraterrestre (kryptoniano)'),
(51, 'Semidiosa (amazona)'),
(52, 'Humano potenciado (anillo)'),
(53, 'Semidiós (atlante)'),
(54, 'Humano cibernético'),
(55, 'Extraterrestre'),
(56, 'Humano potenciado (Venom)'),
(57, 'Humano (toxinas)'),
(58, 'Dios (Nuevo Dios)'),
(59, 'Humano (tecnología/genio)'),
(60, 'Extraterrestre (bioarma)'),
(61, 'Semidiosa (demonio)'),
(62, 'Metahumano'),
(63, 'Humano (tecnología alienígena)'),
(64, 'Viltrumita (híbrido)'),
(65, 'Viltrumita'),
(66, 'Humano (cuerpo artificial)'),
(67, 'Inmortal / Superhumano'),
(68, 'Superhumano (velocidad)'),
(69, 'Humano potenciado (dimensional)'),
(70, 'Saiyajin'),
(71, 'Saiyajin/Humano híbrido'),
(72, 'Namekiano'),
(73, 'Entidad mágica'),
(74, 'Bioandroide'),
(75, 'Androide (humano modificado)'),
(76, 'Androide artificial'),
(77, 'Humano (cíborg)'),
(78, 'Dios de la Destrucción'),
(79, 'Ángel (deidad)'),
(80, 'Saiyajin (fusión)'),
(81, 'Humano (alienígena vía Omnitrix)'),
(82, 'Humano (mágico)'),
(83, 'Humano potenciado (absorción)'),
(84, 'Extraterrestre (vía Omnitrix)'),
(85, 'Extraterrestre (transformación)'),
(86, 'Extraterrestre (transformación, cósmico)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universo`
--

CREATE TABLE `universo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `universo`
--

INSERT INTO `universo` (`id`, `nombre`) VALUES
(1, 'Figuras públicas reales (escala de capacidad física/combate)'),
(2, 'Ficción argentina — Universo de Hijitus / Manuel García Ferré'),
(3, 'Otros personajes de la ficción argentina'),
(4, 'Breaking Bad / Better Call Saul'),
(5, 'Los Increíbles (The Incredibles)'),
(6, 'Villanos de Spider-Man'),
(7, 'Umbrella Academy'),
(8, 'God of War'),
(9, 'Los Simpson'),
(10, 'The Boys'),
(11, 'Marvel'),
(12, 'DC'),
(13, 'Invencible (Invincible)'),
(14, 'Dragon Ball Z'),
(15, 'Ben 10');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `equipo_personajes`
--
ALTER TABLE `equipo_personajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ranking` (`fk_ranking`),
  ADD KEY `fk_personaje` (`fk_personaje`);

--
-- Indices de la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_personaje_tipo` (`tipo_id`),
  ADD KEY `universo_id` (`universo_id`) USING BTREE;

--
-- Indices de la tabla `ranking`
--
ALTER TABLE `ranking`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `universo`
--
ALTER TABLE `universo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `equipo_personajes`
--
ALTER TABLE `equipo_personajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `personaje`
--
ALTER TABLE `personaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT de la tabla `ranking`
--
ALTER TABLE `ranking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `universo`
--
ALTER TABLE `universo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equipo_personajes`
--
ALTER TABLE `equipo_personajes`
  ADD CONSTRAINT `equipo_personajes_ibfk_1` FOREIGN KEY (`fk_ranking`) REFERENCES `ranking` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `equipo_personajes_ibfk_2` FOREIGN KEY (`fk_personaje`) REFERENCES `personaje` (`id`);

--
-- Filtros para la tabla `personaje`
--
ALTER TABLE `personaje`
  ADD CONSTRAINT `id_personaje_tipo` FOREIGN KEY (`tipo_id`) REFERENCES `tipo` (`id`),
  ADD CONSTRAINT `id_personaje_universo` FOREIGN KEY (`universo_id`) REFERENCES `universo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
