<?php
// Inkludér fil der etablerer forbindelse til databasen (i variablen $link)
require 'db_config.php';

// Array af options til dropdown hvor man kan vælge hvor mange produkter der skal kunne vises per side
$options			= [1,2,3,4,5];

// Standardværdi til hvor mange produkter der skal vises per side, når der ikke er valgt noget i dropdown, altså når URL parametret vis-antal, ikke er angivet
$produkter_per_side	= 3;

// Hvis vis-antal er defineret i URL parametre og værdi heraf matcher en af vores værdier i array $options, overskriver vi variablen $produkter_per_side med værdi herfra. Da $produkter_per_side bruges i SQL-sætning efter LIMIT, skal vi sikre imod SQL injections, som vi her bruger bruger intval(), til at sikre værdi kun indeholder tal
if ( isset($_GET['vis-antal']) && in_array($_GET['vis-antal'], $options) )	$produkter_per_side = intval($_GET['vis-antal']);

// Standardværdi til aktuel side, når der ikke er klikket på at link i sidenavigation, altså når URL parametret side, ikke er angivet
$aktuel_side = 1;

// Hvis side er defineret i URL parametre, henter vi værdi og overskriver variablen $aktuel_side
if ( isset($_GET['side']) )	$aktuel_side = $_GET['side'];
?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Pagination</title>
	<style>
		/* Styling til links i pagination */
		.pagination {
			margin: 10px 0;
		}
		.hellip {
			margin-right: 5px;
			width: 34px;
		}
		.pagination > .link {
			border: 1px solid #000;
			color: #000;
			display: inline-block;
			margin-right: 5px;
			padding: 2px 8px;
			text-align: center;
			text-decoration: none;
			width: 18px;
		}
		.pagination > .link.active {
			background-color: #CCC;
			padding: 4px 10px;
			width: 22px;
		}
	</style>
</head>
<body>
	<h1>Pagination</h1>

	<form>
		<label>
			Produkter per side
			<select name="vis-antal" onchange="this.form.submit()">
				<?php
				foreach($options as $option)
				{
					// Hvis den aktuelle option er lig værdi gemt i $produkter_per_side, gemmer vi attributten selected i variablen $selected der bruges i option nedenfor
					if ($option == $produkter_per_side) $selected = ' selected';
					// Hvis ikke den aktelle option matcher værdi i $produkter_per_side, gemmer vi tom værdi i variablen $selected der bruges i option nedenfor
					else $selected = '';

					echo "<option$selected>$option</option>";
				}
				?>
			</select>
		</label>
	</form>

	<?php
	// Forespørgsel til at hente alle aktive produkter fra databasen
	$query =
		"SELECT
			produkt_id, produkt_varenr, produkt_navn, produkt_beskrivelse, produkt_pris, kategori_navn, producent_navn
		FROM
			produkter
		LEFT JOIN
			kategorier ON produkter.fk_kategori_id = kategorier.kategori_id
		LEFT JOIN
			producenter ON produkter.fk_producent_id = producenter.producent_id
		WHERE
			produkt_status = 1";

	// Send forespørgsel af produkter til databasen med mysqli_query(). Hvis der er fejl heri, stoppes videre indlæsning og fejlbesked vises
	$result = mysqli_query($link, $query) or die( mysqli_error($link) . '<pre>' . $query . '</pre>' . 'Fejl i forespørgsel på linje: ' . __LINE__ . ' i fil: ' . __FILE__);

	// Brug mysqli_num_rows() til at se hvor mange rækker der er i vores resultat
	$produkter_i_alt		= mysqli_num_rows($result);

	// Beregn hvor mange sider der skal springes over, ved at tage den aktuelle side minus 1 og gange med produkter per sider. Hvis vi f.eks. er på side 3: (3-1) * 2 = 4. Så der skal springes 4 produkter over på side 3, hvilket passer, da vi har set de første 2 produkter på side 1, og de næste 2 på side 2
	$produkter_spring_over	= ($aktuel_side - 1) * $produkter_per_side;

	// Sorter produkter efter kategori, dernæst pris og begræns udtræk (LIMIT) til 2 produkter per side samt spring over (OFFSET) det beregnede antal produkter
	$query .=
		"
		ORDER BY
			kategori_navn, produkt_pris
		LIMIT
			$produkter_per_side
		OFFSET
			$produkter_spring_over";

	// Send forespørgsel til databasen med mysqli_query(). Hvis der er fejl heri, stoppes videre indlæsning og fejlbesked vises
	$result = mysqli_query($link, $query) or die( mysqli_error($link) . '<pre>' . $query . '</pre>' . 'Fejl i forespørgsel på linje: ' . __LINE__ . ' i fil: ' . __FILE__);

	// Vis antallet af produkter med funktionen mysqli_num_rows() der returnerer antaller af rækker fra resultat ($result)
	echo '<h2>Viser ' . mysqli_num_rows($result) . ' produkter af ' . $produkter_i_alt . '</h2>';

	// mysqli_fetch_assoc() returner data fra forespørgslen som et assoc array og vi gemmer data i variablen $row. Brug while til at løbe igennem alle rækker med produkter fra databasen
	while( $row = mysqli_fetch_assoc($result) )
	{
		?>
		<hr>
		<h3><?php echo $row['produkt_navn'] ?></h3>
		Varenr. <?php echo $row['produkt_varenr'] ?>
		<br><?php echo substr($row['produkt_beskrivelse'], 0, 100) . '...' // Brug substr() til kun at vise de første 100 karakterer af produktets beskrivelse ?>
		<br><strong><?php echo number_format($row['produkt_pris'], 2, ',', '.') // Brug number_format() til at formatere prisen med 2 decimaler, komma til adskillelse af decimaler og punktum for hvert tusinde i beløb. F.eks. 123.456,78 ?> kr.</strong>
		<?php
	}

	// Hvis der er flere produkter i alt, end der skal vises per side, skal vi vise links til sidenavigation
	if ($produkter_i_alt > $produkter_per_side)
	{
		?>
		<div class="pagination">
		<?php
		// Beregn hvor mange sider der skal være i alt, ved at dividere antal produkter i alt med hvor mange der skal vises per side
		$sider_i_alt = ceil($produkter_i_alt / $produkter_per_side);

		// Vi laver en sidenavigation, med max. 9 links til sider. Der skal vises min. 3 sider før og efter den aktuelle side vi er på. Vi vil altid vise link til første og sidste side.

		// Beregn hvad side vi skal starte på. Tag den aktuelle side og minus de 3 links der skal vises før
		$side_start = $aktuel_side - 3;

		// Hvis den aktuelle side, er i blandt den sidste halvdel af de synlige links i sidenavigationen, sætter vi $side_start lig det totale antal sider, minus 6 (de 3 ekstra links før og efter)
		if ($aktuel_side > $sider_i_alt - 3 - 2)
			$side_start = $sider_i_alt - (3 * 2 + 2);

		// Hvis beregning af hvilken side vi skal starte på er lavere end 2, sætter vi den til 2, da det er det laveste vi kan starte med, da første side altid vises
		if ($side_start < 2)
			$side_start = 2;

		// Beregn hvad side vi skal slutte på. Tag den aktuelle side og plus de 3 links der skal vises efter
		$side_slut = $aktuel_side + 3;

		// Hvis den aktuelle side, er i blandt den første havldel af de synlige links i sidenavigationen, sætter vi $side_slut, lig 6 (de 3 ekstra links før og efter)
		if ($aktuel_side <=  3 * 2)
			$side_slut = 3 * 2 + 3;

		// Hvis beregning af hvilken side vi skal slutte på er højere eller lig antal sider i alt, sætter vi $side_slut til antal sider i alt minus 1, da den sidste side altid vises.
		if ($side_slut >= $sider_i_alt)
			$side_slut = $sider_i_alt - 1;

		// Links til første side
		?>
		<a class="link<?php if ($aktuel_side == 1) echo ' active'; // Hvis den aktuelle side er lig 1, tilføjes klassen active ?>" href="index.php?side=1&vis-antal=<?php echo $produkter_per_side ?>">
			1
		</a>
		<?php

		// If $side_start er større end 2, har vi sprunger nogle sider over og det viser vi med &hellip, som er ...
		if ($side_start > 2)
		{
			echo '<span class="hellip">&hellip;</span>';
		}

		// Brug en for-løkke til at genere sidelinks med start på værdi fra $side_start, og slut på værdi fra $side_slut. Forøg med 1 side hver gang løkken kører
		for($side = $side_start; $side <= $side_slut; $side++)
		{
			?>
			<a class="link<?php if ($aktuel_side == $side) echo ' active'; // Hvis side er lig den aktuelle side, tilføjes klassen active ?>" href="index.php?side=<?php echo $side ?>&vis-antal=<?php echo $produkter_per_side ?>">
				<?php echo $side ?>
			</a>
			<?php
		}

		// Hvis If page_to is smaller than the second last page, we have skipped some pages in the end, so we show 3 dots
		if ($side_slut < $sider_i_alt - 1)
		{
			echo '<span class="hellip">&hellip;</span>';
		}

		// Links til sidste side
		?>
		<a class="link<?php if ($aktuel_side == $sider_i_alt) echo ' active'; // Hvis den aktuelle side er lig $sider_i_alt, tilføjes klassen active ?>" href="index.php?side=<?php echo $sider_i_alt ?>>&vis-antal=<?php echo $produkter_per_side ?>">
			<?php echo $sider_i_alt ?>
		</a>

		</div>
		<?php
	}
	?>
</body>
</html>
<?php
// Inkludér fil, der lukker forbindelsen til databasen og tømmer vores output buffer
require 'db_close.php';