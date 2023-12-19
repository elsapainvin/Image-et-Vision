function PrefT = transformation(param, Pref, Xc, Yc)
    % Extract parameters
    tx = param(1);
    ty = param(2);
    lambda = param(3);
    theta = param(4);

    % Convert theta from degrees to radians for the rotation matrix
    theta_rad = deg2rad(theta);

    % Initialize the output array with the same size as Pref
    PrefT = zeros(size(Pref));

    % Construct the rotation matrix
    R = [lambda*cos(theta_rad) -lambda*sin(theta_rad); 
         lambda*sin(theta_rad)  lambda*cos(theta_rad)];

    % Apply the transformation to each point
    for i = 1:size(Pref, 1)
        % Translate the point coordinates with respect to the center of rotation
        point = Pref(i, :) - [Xc Yc];
        
        % Apply the rotation and scaling
        transformed_point = R * point';
        
        % Translate back and add the translation component
        transformed_point = transformed_point' + [Xc Yc] + [tx ty];
        
        % Store the result
        PrefT(i, :) = transformed_point;
    end
end
