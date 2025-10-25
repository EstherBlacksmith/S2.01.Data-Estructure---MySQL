USE `YouTube`;
TRUNCATE TABLE channel;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `comments_interactions`;
TRUNCATE TABLE `comments`;
TRUNCATE TABLE `playlist_videos`;
TRUNCATE TABLE `video_interactions`;
TRUNCATE TABLE `subscriptors`;
TRUNCATE TABLE `labels`;
TRUNCATE TABLE `reproductions`;
TRUNCATE TABLE `playlist`;
TRUNCATE TABLE `video`;
TRUNCATE TABLE `channel`;
TRUNCATE TABLE `user`;
TRUNCATE TABLE `password`;
SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- Passwords
-- -----------------------------------------------------
INSERT INTO `password` (`password`) VALUES
('metallica123'),
('ironmaiden666'),
('nirvana1991'),
('rockfan01'),
('megadeth777');

-- -----------------------------------------------------
-- Users
-- -----------------------------------------------------
INSERT INTO `user` (`name`, `password_idpassword`, `gender`, `country`, `postal_code`, `birth_date`) VALUES
('JamesHetfield', 1, 'man', 'USA', '94102', '1963-08-03'),
('BruceDickinson', 2, 'man', 'UK', 'E1 6AN', '1958-08-07'),
('KurtCobain', 3, 'man', 'USA', '98101', '1967-02-20'),
('MetalFan99', 4, 'non-binary', 'Argentina', 'C1043', '1999-05-14'),
('DaveMustaine', 5, 'man', 'USA', '90001', '1961-09-13');

-- -----------------------------------------------------
-- Channels
-- -----------------------------------------------------
INSERT INTO `channel` (`name`, `description`, `user_id`) VALUES
('Metallica Official', 'Canal oficial de Metallica. Videos, giras y documentales.', 1),
('Iron Maiden Channel', 'Videos, actuaciones y entrevistas de Iron Maiden.', 2),
('Nirvana Archive', 'Videos clásicos y rarezas de Nirvana.', 3);

-- -----------------------------------------------------
-- Videos
-- -----------------------------------------------------
INSERT INTO `video` (`title`, `description`, `video_file_name`, `thumbnail`, `duration`, `state`, `user_id`)
VALUES
('Enter Sandman', 'Video musical de Metallica, 1991.', 'enter_sandman.mp4', '', 331, 'public', 1),
('Nothing Else Matters', 'Metallica - Balada clásica.', 'nothing_else_matters.mp4', '', 388, 'public', 1),
('The Trooper', 'Iron Maiden - Live en 1983.', 'the_trooper.mp4', '', 272, 'public', 2),
('Fear of the Dark', 'Iron Maiden - Live at Donington.', 'fear_of_the_dark.mp4', '', 437, 'public', 2),
('Smells Like Teen Spirit', 'Nirvana - MTV Live.', 'teen_spirit.mp4', '', 301, 'public', 3),
('Come As You Are', 'Nirvana - Versión en vivo.', 'come_as_you_are.mp4', '', 240, 'public', 3);

-- -----------------------------------------------------
-- Reproductions
-- -----------------------------------------------------
INSERT INTO `reproductions` (`video_id`, `reproductions`) VALUES
(1, 1050000000),
(2, 850000000),
(3, 700000000),
(4, 620000000),
(5, 980000000),
(6, 500000000);

-- -----------------------------------------------------
-- Labels (tags)
-- -----------------------------------------------------
INSERT INTO `labels` (`name`, `video_id`) VALUES
('Metal', 1),
('Metal', 2),
('Heavy Metal', 3),
('Classic Rock', 4),
('Grunge', 5),
('Alternative', 6);

-- -----------------------------------------------------
-- Playlists
-- -----------------------------------------------------
INSERT INTO `playlist` (`name`, `user_id`) VALUES
('Best of Metal', 4),
('Live Legends', 5),
('90s Rock Vibes', 3);

-- -----------------------------------------------------
-- Playlist Videos
-- -----------------------------------------------------
INSERT INTO `playlist_videos` (`playlist_id`, `video_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6);

-- -----------------------------------------------------
-- Subscriptors (fans suscritos a videos)
-- -----------------------------------------------------
INSERT INTO `subscriptors` (`video_id`, `user_id_subscriber`) VALUES
(1, 4),
(2, 5),
(3, 4),
(5, 1);

-- -----------------------------------------------------
-- Comments
-- -----------------------------------------------------
INSERT INTO `comments` (`text`, `video_id`, `user_id_coments`) VALUES
('¡Clásico eterno! ', 1, 4),
('La mejor balada metalera de la historia.', 2, 5),
('Esa guitarra no tiene comparación.', 3, 1),
('Qué energía transmite este tema ', 4, 2),
('Esto marcó mi adolescencia ', 5, 4),
('Increíble presentación en vivo.', 6, 3);

-- -----------------------------------------------------
-- Comments Interactions
-- -----------------------------------------------------
INSERT INTO `comments_interactions` (`like`, `comments_id`, `user_id_interact`) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 4),
(0, 5, 5),
(1, 6, 1);

-- -----------------------------------------------------
-- Video Interactions
-- -----------------------------------------------------
INSERT INTO `video_interactions` (`video_id`, `user_id_interact`, `like`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 1, 1),
(4, 4, 1),
(5, 5, 1),
(6, 2, 1);
