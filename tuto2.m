%=========================================================================
%                       Détection des contours d'une image
%=========================================================================
close all;
clear all;

% On reprend le minimum du tutorial1
% -> "Igray" : image d'intensité en niveaux de gris
filename = 'chemin_vers_votre_image.jpg'; % Remplacer par le chemin de votre image
Igray = imread(filename);
if size(Igray, 3) == 3
    Igray = rgb2gray(Igray);
end

% Passage en réel pour le calcul de la dérivée (valeurs négatives ...)
Igray = double(Igray);

% filtre de Sobel qui approxime une dérivée horizontale
sobelHorizontal = fspecial('sobel');

% Approximation de la dérivée Horizontale appliquée à Igray
derivativeHorizontal = imfilter(Igray, sobelHorizontal, 'replicate');

% Approximation de la dérivée Verticale appliquée à Igray
sobelVertical = sobelHorizontal';
derivativeVertical = imfilter(Igray, sobelVertical, 'replicate');

% Approximation de la norme du gradient appliquée à Igray
gradientMagnitude = sqrt(derivativeHorizontal.^2 + derivativeVertical.^2);

% Norme du gradient le long d'un profil
% Ceci nécessite une sélection de profil ou un chemin prédéfini.
% Utilisez improfile avec interaction utilisateur ou définissez un chemin.

% Détection des contours de Igray -> Ifiltree binarisée
% Impact du seuil sur l'image des contours
% Utilisation d'un seuil pour binariser l'image des gradients
seuil = 0.5 * max(gradientMagnitude(:));
Icontours = gradientMagnitude >= seuil;

% Affichage des résultats
figure;
subplot(2,2,1), imshow(Igray, []), title('Image Originale en niveaux de gris');
subplot(2,2,2), imshow(derivativeHorizontal, []), title('Dérivée Horizontale');
subplot(2,2,3), imshow(derivativeVertical, []), title('Dérivée Verticale');
subplot(2,2,4), imshow(Icontours), title('Contours de l\'image');

% Approximation de Sobel du gradient + maximum de la norme du gradient + seuillage
% Ce code est déjà inclus dans les étapes ci-dessus.

% Détection à l'aide d'autre approches ... (paramètres automatiques)
% Utilisation de la fonction edge pour différentes méthodes
IcontoursCanny = edge(Igray, 'Canny');
IcontoursSobel = edge(Igray, 'Sobel');

% Affichage des résultats des autres méthodes
figure;
subplot(1,2,1), imshow(IcontoursCanny), title('Contours avec Canny');
subplot(1,2,2), imshow(IcontoursSobel), title('Contours avec Sobel');
