% This script creates a mesh from a boundary given in a txt file
% Used to generate compatible triangulation
clear all

%  READ txt files into matrices
data_file = input('enter file name: \n','s');
boundary_points = readmatrix(data_file);

if isequal(data_file,'ant-source.txt') | isequal(data_file,'bird-source.txt') | isequal(data_file,'cat-source.txt') | isequal(data_file,'dog-source.txt') | isequal(data_file,'donkey-source.txt')
    boundary_points(:,2) = -boundary_points(:,2);
end

% creates polygon associated to the boundary
polygon = polyshape(boundary_points(:,1)',boundary_points(:,2)');

% WARNING: DEPENDING ON THE  SOURCE WE MAY NEED TO DELETE USELESS POINTS
if isequal(data_file,'ant-source.txt')
    x = polygon.Vertices(:,1);
    y = polygon.Vertices(:,2);
    if ispolycw(x,y)
        x = flipud(x);
        y = flipud(y);
    end
    % deleting useless points
    x_f = [x(22),x(27),x(28),x(33),x(39), x(43) x(44), (x(45:490))',x(495), x(501), x(506), x(510), x(522), (x(523:end))'];
    y_f = [y(22),y(27),y(28),y(33),y(39), y(43) y(44), (y(45:490))',y(495), y(501), y(506), y(510), y(522), (y(523:end))'];

    % deleting useless point
    x_g = [x_f([1,3,4,5,6,9,10,15,20,25,26]),x_f(27:457),x_f([458,467,472,475,479,484]),x_f(485:end)];
    y_g = [y_f([1,3,4,5,6,9,10,15,20,25,26]),y_f(27:457),y_f([458,467,472,475,479,484]),y_f(485:end)];

    % deleting useless points
    x = x_g(1:3:end);
    y = y_g(1:3:end);

    clear polygon 
    polygon = polyshape(x,y);
elseif isequal(data_file,'cat-source.txt') | isequal(data_file,'donkey-source.txt')
    x = polygon.Vertices(:,1);
    y = polygon.Vertices(:,2);
    %if ispolycw(x,y)
    %    x = flipud(x);
    %    y = flipud(y);
    %end
    x = x(1:2:end);
    y = y(1:2:end);
    clear polygon 
    polygon = polyshape(x,y);
    
end
% create a Delanuay triangulation
% This triangulation has BAD QUALITY
% to plot this triangulation use
% triplot(ConnectivityList,Points(:,1),Points(:,2))
triangulation_1 = triangulation(polygon);

% create PDE model to use PDETOOLBOX machinery
pde_1 = createpde;

%create geometry from mesh
pde_1.geometryFromMesh(triangulation_1.Points',triangulation_1.ConnectivityList');

% create mesh
% we need to include the 'Geometric order'=linear otherwise the mesh 
% contains also the midpoints of each edge
% Additionaly, to guarantee the mesh containts interior nodes 
% the parameter 'Hmax' could need tunning
if isequal(data_file,'ant-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',1);
elseif isequal(data_file,'bird-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',5);
elseif isequal(data_file,'bird-to-horse-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',2);
elseif isequal(data_file,'cat-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',1);
elseif isequal(data_file,'dog-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',1.5);
elseif isequal(data_file,'dolphin-to-fish-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',0.2);
elseif isequal(data_file,'donkey-source.txt')
    Mesh = generateMesh(pde_1,'GeometricOrder','linear','Hmax',3);
end
% Transforms mesh structure into P E T

[p,e,t] = meshToPet(Mesh);

% save PET_ant p e t

save("cat_source.mat","p","e","t")