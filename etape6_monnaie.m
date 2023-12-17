% Dimension de l'élément structurant basé sur la pièce de référence choisie
% (peut nécessiter un ajustement basé sur l'échelle de l'image et la résolution)
elementSize = 3; % À ajuster si nécessaire
E = strel('disk', elementSize);

% Boucle pour traiter chaque fichier image
fileNames = {'pieces1.jpg', 'pieces2.jpg', 'pieces3.jpg', 'pieces4.jpg', 'pieces5.jpg', 'pieces6.jpg', 'pieces7.jpg', 'pieces8.jpg', 'pieces9.jpg', 'contact1.jpg', 'contact2.jpg', 'contact3.jpg', 'contact4.jpg'};
for i = 1:length(fileNames)
    fprintf('Analyse de l\'image %s\n', fileNames{i});
    imageRGB = imread(fileNames{i});
    
    % Ici, répétez les étapes 1 et 2 pour chaque nouvelle image
    % Puis continuez avec l'érosion pour dissocier les pièces en contact
    
    % Érosion pour séparer les pièces de monnaie
    Ie = imerode(imageBW, E);
    
    % Étiquetage des régions érodées
    Ilab = bwlabel(Ie, 8);
    
    % Calcul des caractéristiques pour les régions érodées
    stats = regionprops(Ilab, 'Area', 'Centroid');
    
    % Dilatation individuelle par région pour restaurer la taille
    for ind = 1:length(stats)
        Iregion = bwselect(Ie, stats(ind).Centroid(1), stats(ind).Centroid(2));
        IregionDilated = imdilate(Iregion, E);
        stats(ind) = regionprops(bwlabel(IregionDilated), 'Area', 'Centroid');
    end
    
    % Afficher l'image RGB originale
    imshow(imageRGB);
    hold on;
    
    % Afficher les caractéristiques des pièces de monnaie identifiées
    for k = 1:length(stats)
        % Calcul pour associer à la valeur de pièce la plus proche
        % ... (insérer ici le code de l'étape 3 avec les aires théoriques)
        
        % Affichage de la valeur sur l'image
        text(stats(k).Centroid(1), stats(k).Centroid(2), sprintf('€%0.2f', coinValue), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
            'Color', 'yellow', 'FontSize', 14, 'FontWeight', 'bold');
    end
    
    hold off;
end
