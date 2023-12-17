% Afficher l'image pour la sélection de l'utilisateur
imshow(imageRGB);
title('Cliquez sur une pièce de monnaie et entrez sa valeur en Euros');

% Permettre à l'utilisateur de sélectionner une pièce de monnaie
[x, y] = ginput(1);

% Demander à l'utilisateur la valeur de la pièce sélectionnée
coinValue = input('Entrez la valeur de la pièce en Euros (par exemple, 0.05 pour 5 centimes): ');

% Trouver l'indice de la pièce sélectionnée en comparant la distance au centroid
distances = sqrt(([stats.Centroid] - [x y]).^2);
[~, selectedIndex] = min(distances);

% Diamètre en pixels de la pièce sélectionnée
selectedCoinDiameter = sqrt(4 * stats(selectedIndex).Area / pi);

% Tableau des diamètres en mm pour chaque valeur de pièce
diametersInMm = [25.75, 23.25, 24.25, 22.25, 19.75, 21.25, 18.75, 16.25];

% Trouver l'index de la valeur de la pièce sélectionnée dans le tableau
valueIndex = find([2, 1, 0.50, 0.20, 0.10, 0.05, 0.02, 0.01] == coinValue);

% Calculer la taille en mm d'un pixel
mmPerPix = diametersInMm(valueIndex) / selectedCoinDiameter;

% Calculer le diamètre en pixels pour chaque type de pièce
diametersInPix = diametersInMm / mmPerPix;

% Calculer l'aire théorique en pixels pour chaque type de pièce
theoreticalAreas = pi * (diametersInPix / 2).^2;

% Afficher les résultats
disp('Diamètre en pixels de chaque valeur de pièce:');
disp(array2table(diametersInPix', 'VariableNames', {'Diameter_in_Pixels'}, 'RowNames', {'2€', '1€', '50c', '20c', '10c', '5c', '2c', '1c'}));
disp('Aire théorique en pixels de chaque valeur de pièce:');
disp(array2table(theoreticalAreas', 'VariableNames', {'Theoretical_Area_in_Pixels'}, 'RowNames', {'2€', '1€', '50c', '20c', '10c', '5c', '2c', '1c'}));
