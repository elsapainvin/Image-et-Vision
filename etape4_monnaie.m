% Définition des limites d'aire pour identifier les intrus
minArea = min(theoreticalAreas); % Aire la plus petite correspondant à la pièce de 1 centime
maxArea = max(theoreticalAreas); % Aire la plus grande correspondant à la pièce de 2 euros

% Filtrer les régions qui ne correspondent pas à l'aire d'une pièce de monnaie valide
validStats = stats([stats.Area] >= minArea & [stats.Area] <= maxArea);

% Afficher l'image RGB originale
imshow(imageRGB);
hold on;

% Boucler sur chaque région valide pour identifier la valeur de la pièce
for k = 1:length(validStats)
    % Trouver l'aire la plus proche dans les aires théoriques calculées
    [~, closestIndex] = min(abs(theoreticalAreas - validStats(k).Area));
    
    % Identifier la valeur de la pièce correspondante
    coinValue = euroValues(closestIndex);
    
    % Afficher la valeur de la pièce sur l'image
    text(validStats(k).Centroid(1), validStats(k).Centroid(2), sprintf('€%0.2f', coinValue), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'Color', 'yellow', 'FontSize', 14, 'FontWeight', 'bold');
end

hold off;
