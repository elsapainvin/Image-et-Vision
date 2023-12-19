% Créer un objet VideoReader
vObj = VideoReader('video.avi');

% Lire la première image de la vidéo
im1 = read(vObj, 1);

% Convertir en espace de couleur HSV et extraire la composante de mesure M
imHSV = rgb2hsv(im1);
M = imHSV(:,:,3); % ou la composante de votre choix

% Sélectionner la ROI sur la première image
figure, imshow(M);
[mq, ~, ~] = roipoly();

% Extraire les valeurs de M dans la ROI
vec = M(mq == 1);

% Estimation de μ et σ
mu = median(vec);
sigma = 1.4826 * median(abs(vec - mu));

% Traitement des images suivantes
for iter = 2:vObj.NumberOfFrames
    % Lire l'image courante
    im = read(vObj, iter);

    % Convertir et extraire la composante M
    imHSV = rgb2hsv(im);
    M = imHSV(:,:,3); % ou la composante de votre choix

    % Calcul de l'image de probabilité P
    P = 1 / (sigma * sqrt(2 * pi)) * exp(-((M - mu).^2 / (2 * sigma^2)));

    % Seuil
    seuil = 1 / (sigma * sqrt(2 * pi)) * exp(-1);

    % Seuillage pour la détection
    detect = zeros(size(P,1), size(P,2));
    detect(P > seuil) = 1;

    % Mise en surbrillance des pixels détectés
    imHighlighted = im;
    imHighlighted(repmat(detect, [1, 1, 3])) = 255;

    % Affichage du résultat
    figure, imshow(imHighlighted), title(['Image ', num2str(iter), ' avec détection']);
end
