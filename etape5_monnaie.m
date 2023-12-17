% Définition du seuil de circularité
circularityThreshold = 0.9; % à ajuster selon le degré de tolérance souhaité

% Calcul des caractéristiques géométriques supplémentaires pour chaque région
stats = regionprops(labeledImage, 'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength');

% Filtrer pour éliminer les régions non circulaires
circularityRatio = [stats.MinorAxisLength] ./ [stats.MajorAxisLength];
validCircularStats = stats(circularityRatio > circularityThreshold & ...
                           [stats.Area] >= minArea & [stats.Area] <= maxArea);

% Afficher l'image RGB originale
imshow(imageRGB);
hold on;

% Boucler sur chaque région valide pour identifier la valeur de la pièce
for k = 1:length(validCircularStats)
    % Trouver l'aire la plus proche dans les aires théoriques calculées
    [~, closestIndex] = min(abs(theoreticalAreas - validCircularStats(k).Area));
    
    % Identifier la valeur de la pièce correspondante
    coinValue = euroValues(closestIndex);
    
    % Afficher la valeur de la pièce sur l'image
    text(validCircularStats(k).Centroid(1), validCircularStats(k).Centroid(2), sprintf('€%0.2f', coinValue), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'Color', 'yellow', 'FontSize', 14, 'FontWeight', 'bold');
end

hold off;

% Testez ce code pour les 9 fichiers images
fileNames = {'pieces1.jpg', 'pieces2.jpg', 'pieces3.jpg', 'pieces4.jpg', 'pieces5.jpg', 'pieces6.jpg', 'pieces7.jpg', 'pieces8.jpg', 'pieces9.jpg'};
for i = 1:length(fileNames)
    % Exécuter l'analyse pour chaque fichier image
    fprintf('Analyse de l\'image %s\n', fileNames{i});
    imageRGB = imread(fileNames{i});
    
    % Ici, vous devriez répéter les étapes 1, 2 et 3 pour chaque nouvelle image.
    % Étant donné que les étapes 1 et 2 nécessitent une interaction utilisateur, elles doivent être exécutées à ce point.
    % Insérez les étapes 1 et 2 ici pour chaque image, puis calculez les aires théoriques.
    
    % Ensuite, exécutez l'étape 4 avec le filtrage de circularité inclus pour chaque image.
end
