<?php
// Luk forbindelsen til databasen, for at at undgå for mange åbne forbindelser
mysqli_close($link);

// Tøm output bufferen, når al html er genereret, for at forhindre performance problemer på server
ob_end_flush();