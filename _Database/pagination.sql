-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Vært: 127.0.0.1
-- Genereringstid: 30. 11 2016 kl. 14:00:21
-- Serverversion: 10.1.10-MariaDB
-- PHP-version: 7.0.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pagination`
--

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `kategorier`
--

CREATE TABLE `kategorier` (
  `kategori_id` smallint(5) UNSIGNED NOT NULL,
  `kategori_navn` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Data dump for tabellen `kategorier`
--

INSERT INTO `kategorier` (`kategori_id`, `kategori_navn`) VALUES
(1, 'Skærm'),
(2, 'Bærbar'),
(3, 'Mus'),
(4, 'Tastatur');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `producenter`
--

CREATE TABLE `producenter` (
  `producent_id` smallint(5) UNSIGNED NOT NULL,
  `producent_navn` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Data dump for tabellen `producenter`
--

INSERT INTO `producenter` (`producent_id`, `producent_navn`) VALUES
(1, 'Apple'),
(2, 'Asus'),
(3, 'Lenovo'),
(4, 'Samsung'),
(5, 'Dell'),
(6, 'Logitech'),
(7, 'Razer');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `produkter`
--

CREATE TABLE `produkter` (
  `produkt_id` mediumint(8) UNSIGNED NOT NULL,
  `produkt_status` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=Inaktiv, 1=Aktiv',
  `produkt_varenr` int(10) UNSIGNED NOT NULL,
  `produkt_navn` varchar(50) NOT NULL,
  `produkt_beskrivelse` text NOT NULL,
  `produkt_pris` decimal(7,2) NOT NULL,
  `fk_kategori_id` smallint(5) UNSIGNED NOT NULL,
  `fk_producent_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Data dump for tabellen `produkter`
--

INSERT INTO `produkter` (`produkt_id`, `produkt_status`, `produkt_varenr`, `produkt_navn`, `produkt_beskrivelse`, `produkt_pris`, `fk_kategori_id`, `fk_producent_id`) VALUES
(1, 1, 1159311, 'Samsung UD590 Series U28E590D', 'The Samsung UE590 UHD monitor offers PC viewing, gaming and more, all in stunning Ultra HD picture quality. Superb images that boast a staggering 8 million pixels are delivered at a resolution 4x greater than Full HD. See your 4K content the way it was meant to be seen, with realistic detail that makes you feel like you''re really there. Experience a new level of clarity in Ultra High Definition.', '2689.00', 1, 4),
(2, 1, 130312, 'Dell UltraSharp U3417W', 'Oplev perfekt præcision på en buet 34"-skærm, der optimerer arbejde, gaming og underholdning.\r\nStørre skærmkrumning øger dit synsfelt ved at give et stort set ensartet fokus, så du kan kaste dig ud i arbejde eller spil.\r\nWQHD-opløsning på 3440 x 1440 giver imponerende klarhed, mens den flimmerfri skærm med ComfortView giver øjnene mere komfort.\r\nArbejd fra to pc''er samtidigt på én enkelt skærm. Arranger din skærm ved hjælp af layoutapps i Dell Easy Arrange samt funktionerne billede-i-billede og billede-ved-billede. Få endnu mere ud af dine arbejdsprojekter og din hjemmeunderholdning med en utrolig skærm, imponerende detaljer og en ydeevne af høj kvalitet.', '6498.00', 1, 5),
(3, 1, 855005, 'Dell UltraSharp U2515H', 'Uovertruffen skærmklarhed og komplet farvenøjagtighed giver en fabelagtig billedoplevelse. Arbejd på den måde, du vil. Placer skærmen, så du opnår maksimal komfort med en lang række funktioner til hældning, rotation, drejning og højdejustering sammen med nem tilslutning til din pc og eksterne enheder. U2515H er fremstillet med miljøvenlige materialer og er BFR/PVC-fri (med undtagelse af eksterne kabler) samt med glas uden arsen og en LED-skærm uden kviksølv. Bedre styring af strømforbruget med PowerNap aktiverer Dell Display Manager for at dæmpe skærmens lysstyrke helt eller sætte den i slumretilstand, når den ikke er i brug.', '2479.00', 1, 5),
(4, 1, 2569350, 'Lenovo 310S-15IKB 80UW', 'Affordable 15.6" laptop with a choice of options, including integrated or discrete graphics.', '5261.00', 2, 3),
(5, 1, 872160, 'Apple MacBook Pro', 'MacBook Pro er fyldt med stærke funktioner, der gør en fantastisk bærbar endnu mere fantastisk. MacBook Pro er fremstillet af et enkelt stykke aluminium - en ingeniørmæssig bedrift, som har gjort det muligt at erstatte mange dele med en enkelt. Det kaldes unibody. Og den første gang du løfter en MacBook Pro op, mærker du forskellen. Hele kabinettet er tyndere og lettere end på andre bærbare computere. Det ser elegant og raffineret ud. Og det føles solidt og robust - perfekt til livet i (og uden for) din taske eller rygsæk.', '8299.00', 2, 1),
(6, 1, 1840349, 'ASUS ZENBOOK UX305CA PURE4', 'ZenBook UX305CA er designet til at komme med dig overalt. Med en vægt på kun 1,2 kg og en tykkelse på blot 1,23 cm er den aldrig en byrde, altid til glæde. Men det er mere end blot en fantastisk smuk letvægts-bærbar: den er også særdeles kraftig, pakket med den nyeste højteknologiske performance. Med ZenBook UX305CA kan du klare alle de fantastiske ting, som du altid har ønsket dig at kunne, hvorend du er.', '6999.00', 2, 2),
(7, 1, 1140675, 'Logitech MX Master', 'Håndformet med behagelige kurver\r\nDen perfekte form på denne mus er som støbt i hånden* så hånden og håndleddet støttes i en behagelig og naturlig stilling.\r\n\r\nDu kan styre den med meget fine og flydende bevægelser takket være knapperne og hjulene der sidder de helt rigtige steder.', '594.00', 3, 6),
(8, 1, 757583, 'Razer Mamba Tournament Edition', 'Den mest præcise gaming mus sensor i verden med 16.000 dpi \r\nTakket være verdens mest præcise gaming mus sensor med 16.000 dpi du støtte din Razer Mamba Tournament Edition med uopnåelig præcision, så kan du få en endnu større fordel i forhold til konkurrenterne. Razer Mamba Tournament Edition kan opdage og har en lift-off cut-off præcision på 0,1 mm, så du reagere hurtigt og trygt bringe dig sejr kan ændre med op til 1 dpi.', '645.00', 3, 7),
(9, 1, 408208, 'Logitech M705', 'Formgivet til højre hånd\r\nDen svungne form med en skjult tommelfingerknap passer perfekt til højre hånd som hviler naturligt og behageligt på musen. Det er desuden nemt at tilpasse knappernes funktioner. Komfortable hænder holder af komfortable mus', '298.00', 3, 6),
(10, 1, 534207, 'Logitech Wireless Illuminated Keyboard K800', 'Med dette elegante og komfortable tastatur går tastearbejdet strålende, både dag og nat.', '594.00', 4, 6),
(11, 1, 631908, 'Apple Keyboard with Numeric Keypad', 'The Apple keyboard with numeric keypad features an elegant, ultrathin anodized aluminum enclosure with low-profile keys that provide a crisp, responsive feel. It also has function keys for one-touch access to a variety of Mac features such as screen brightness, volume, eject, play/pause, fast-forward and rewind, Exposé, and Dashboard.', '385.00', 4, 1),
(12, 1, 516792, 'Razer BlackWidow Ultimate Stealth 2016', 'Designed specifically for gaming, the Razer Mechanical Switch actuates at an optimal distance, giving you speed and responsiveness like never before. The Razer Mechanical Switch has been lauded as the new standard for all mechanical gaming keyboards since its introduction.\r\nNo matter how intense your gaming marathons get, each Razer Mechanical Switch is engineered to withstand up to 60 million keystrokes, so you''ll enjoy the Razer advantage for longer.\r\nThe all-new Razer BlackWidow Ultimate features individually programmable backlit keys along with dynamic lighting effects all set easily through Razer Synapse.', '899.00', 4, 7);

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `kategorier`
--
ALTER TABLE `kategorier`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Indeks for tabel `producenter`
--
ALTER TABLE `producenter`
  ADD PRIMARY KEY (`producent_id`);

--
-- Indeks for tabel `produkter`
--
ALTER TABLE `produkter`
  ADD PRIMARY KEY (`produkt_id`),
  ADD KEY `fk_kategori_id` (`fk_kategori_id`),
  ADD KEY `fk_producent_id` (`fk_producent_id`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `kategorier`
--
ALTER TABLE `kategorier`
  MODIFY `kategori_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Tilføj AUTO_INCREMENT i tabel `producenter`
--
ALTER TABLE `producenter`
  MODIFY `producent_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Tilføj AUTO_INCREMENT i tabel `produkter`
--
ALTER TABLE `produkter`
  MODIFY `produkt_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
