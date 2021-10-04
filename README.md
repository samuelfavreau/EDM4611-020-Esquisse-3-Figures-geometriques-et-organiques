# EDM4611-020-Esquisse-3-Figures-geometriques-et-organiques

![rendu](https://user-images.githubusercontent.com/48024730/135884514-c08421d0-2874-4b14-a967-0d1387abfdf1.png)

Cette esquisse a pour but de générer automatiquement un paysage vectoriel comportant des feux d’artifice et des chaines de montagnes.

--

Chacun des feux d’artifice est créé à l’aide de 2 objets : le chemin et l’explosion. Le chemin est créé en traçant une **courbe de Béziers** débutant à un endroit aléatoire au bas de l’esquisse et se terminant à un endroit aléatoire dans la partie supérieure de l’esquisse. Les poignées de cette courbe sont placées plus haut sur le même axe des **x** que leurs points respectifs afin que la courbe prenne une forme semi-parabolique. Une fois cette courbe de **Béziers** est constituée, son tracé est utilisé pour identifier la position de 4 points en utilisant la fonction **bezierPoints()**. Ces 4 points sont ensuite utilisés pour construire une courbe à l’aide de la fonction **curve()**. Les points sont mis à jour à chaque frame afin que la courbe **curve()** suive le tracé de **Béziers** d’un bout à l’autre. Une fois que la courbe **curve()** a terminé sont déplacement, un objet de type explosion est généré au dernier emplacement atteint par la courbe. L’explosion est générée à l’aide de la même technique de combinaison de courbes de **Béziers** et de **curve()** utilisée pour le chemin. Cette dernière a toutefois la particularité de générer un nombre aléatoire de tracés avec des points finaux se positionnant autour du point initial à l’aide de calculs trigonométriques et des poignées se positionnant à une distance aléatoire au-dessus de leur point respectif. 
 
Ces feux d’artifice sont générés sur un fond de montagnes Rocheuses en contre-jour. Ces montagnes sont créées à l’aide d’une fonction **curveVertex()** dans laquelle est entrées des informations provenant d’un **noise** et adaptées pour être utilisées pour déterminer la hauteur des montagnes. Ces montagnes sont donc différentes à chaque fois que le programme est ouvert. Le décor est également constitué d’un ciel représentant un coucher de soleil et d’un lac affichant la réflexion des feux d’artifice et des montagnes. 

--

Il est également possible de sauvegarder une image **vectorielle** au format **PDF** de l’esquisse en effectuant un **clic de souris**. Le PDF sauvegarder ira dans un dossier **export** situé à la racine du projet. La librairie **processing.pdf** est utilisée pour effectuer l’exportation.
