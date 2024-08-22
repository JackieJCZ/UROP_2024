function area = evaluateArea(problem,q)
% This function evaluates the area of the triangles of the mesh
q = reshape(q,2,[]);
% Evaluate the difference vectors
% r13x = q(1,problem.fem.t(3,:))-q(1,problem.fem.t(1,:));
% r13y = q(2,problem.fem.t(3,:))-q(2,problem.fem.t(1,:));
% r12x = q(1,problem.fem.t(2,:))-q(1,problem.fem.t(1,:));
% r12y = q(2,problem.fem.t(2,:))-q(2,problem.fem.t(1,:));
persistent diffQ13x diffQ13y diffQ12x diffQ12y
if (isempty(diffQ13x)) || (isempty(diffQ13y)) || (isempty(diffQ12x)) || (isempty(diffQ12y))
    [diffQ13x, diffQ13y,diffQ12x, diffQ12y]  = generateDiffQArea(problem);
end
% Evaluate difference vectors
r13x = diffQ13x*q(:);
r13y = diffQ13y*q(:);
r12x = diffQ12x*q(:);
r12y = diffQ12y*q(:);

% Evaluate the function
area = 0.5 * (r12x.*r13y-r12y.*r13x);
end
