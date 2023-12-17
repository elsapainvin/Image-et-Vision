% Créer un objet VideoReader
vObj = VideoReader('video.avi');

% Boucle pour lire et afficher chaque image de la vidéo
for iter = 1:vObj.NumberOfFrames
    % Lire l'image courante
    im = read(vObj, iter);
    
    % Convertir l'image RGB en HSV
    imHSV = rgb2hsv(im);

    % Extraire les composantes Rouge, Verte, Bleue, Teinte, Saturation, Luminance
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);
    H = imHSV(:,:,1);
    S = imHSV(:,:,2);
    V = imHSV(:,:,3);

    % Afficher les composantes
    figure, subplot(2,3,1), imshow(R), title('Rouge');
    subplot(2,3,2), imshow(G), title('Verte');
    subplot(2,3,3), imshow(B), title('Bleue');
    subplot(2,3,4), imshow(H), title('Teinte');
    subplot(2,3,5), imshow(S), title('Saturation');
    subplot(2,3,6), imshow(V), title('Luminance');
  
    % Pause pour une meilleure visualisation
    pause(0.01);
end
