% Créer un objet VideoReader
vObj = VideoReader('video.avi');

% Obtenir les dimensions de la vidéo
Height = vObj.Height;
Width = vObj.Width;

% Boucle pour lire et afficher chaque image de la vidéo
for iter = 1:vObj.NumberOfFrames
    % Lire l'image courante
    im = read(vObj, iter);

    % Afficher l'image
    imshow(im);
  
    % Pause pour une meilleure visualisation
    pause(0.01);
end
