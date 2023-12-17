% Définition des valeurs des pièces en Euros pour correspondre aux aires théoriques
euroValues = [2, 1, 0.50, 0.20, 0.10, 0.05, 0.02, 0.01];

% Afficher l'image RGB originale
imshow(imageRGB);
hold on;

% Boucler sur chaque région détectée pour identifier la valeur de la pièce
for k = 1:length(stats)
    % Trouver l'aire la plus proche dans les aires théoriques calculées
    [~, closestIndex] = min(abs(theoreticalAreas - stats(k).Area));
    
    % Identifier la valeur de la pièce correspondante
    coinValue = euroValues(closestIndex);
    
    % Afficher la valeur de la pièce sur l'image
    text(stats(k).Centroid(1), stats(k).Centroid(2), sprintf('€%0.2f', coinValue), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'Color', 'yellow', 'FontSize', 14, 'FontWeight', 'bold');
end

hold off;

% Tester le système sur les 3 fichiers image
fileNames = {'pieces1.jpg', 'pieces2.jpg', 'pieces3.jpg'};
for i = 1:length(fileNames)
    % Exécuter l'analyse pour chaque fichier image
    fprintf('Analyse de l\'image %s\n', fileNames{i});
    imageRGB = imread(fileNames{i});
    
    % Ici, vous devriez répéter les étapes 1 et 2 pour chaque nouvelle image.
    % Étant donné que les étapes 1 et 2 nécessitent une interaction utilisateur, elles doivent être exécutées à ce point.
    % Insérez les étapes 1 et 2 ici pour chaque image.
    
    % Puis exécuter l'étape 3
    % Cette partie suppose que vous avez déjà stats et theoreticalAreas pour l'image courante
    % Insérez le code de l'étape 3 ici pour chaque image.
end
