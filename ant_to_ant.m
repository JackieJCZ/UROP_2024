source = load("Data/ant_pet.mat");
num_nodes = size(source.p, 2);
scale = 0;
source.p(3, :) = scale * rand(1, num_nodes);

target = source.p(1:2, 1:477).';

U_new = fit(source, target, 0.5, 0.5);

surfaceMeshShow(source.p.', source.t(1:3, :).')
figure
pdeplot(U_new.', source.t(1:3, :))

angle = pi /3;
scale = 3;
target2 = target * [cos(angle) -sin(angle); sin(angle) cos(angle)] * scale;
U_new2 = fit(source, target2, 0.5, 0.5);

figure
pdeplot(U_new2.', source.t(1:3, :))
