% Charger l'image en couleurs
imageRGB = imread('pieces1.jpg'); % Remplacer par le chemin de l'image approprié

% Convertir l'image RGB en niveaux de gris
imageGray = rgb2gray(imageRGB);

% Seuillage automatique pour obtenir une image binaire
level = graythresh(imageGray);
imageBW = im2bw(imageGray, level);

% Remplissage des trous dans les pièces de monnaie
imageFilled = imfill(imageBW, 'holes');

% Étiquetage des composantes connexes
[labeledImage, numRegions] = bwlabel(imageFilled);

% Calcul des caractéristiques géométriques pour chaque région
stats = regionprops(labeledImage, 'Area', 'Centroid');

% Affichage de l'image étiquetée en couleur
imshow(label2rgb(labeledImage));
hold on;

% Définition du seuil pour l'aire (à ajuster en fonction de la taille de l'image)
seuil = 100; % Ce seuil est un exemple, il doit être défini en fonction des dimensions des pièces

% Filtrage des régions par aire
validRegions = find([stats.Area] > seuil);

% Conservation uniquement des régions valides
validStats = stats(validRegions);

% Affichage du texte pour chaque région valide
for k = 1 : length(validStats)
    centroid = validStats(k).Centroid;
    area = validStats(k).Area;
    text(centroid(1), centroid(2), sprintf('+\nArea: %d', area), 'HorizontalAlignment', 'center', 'Color', 'red');
end

hold off;
