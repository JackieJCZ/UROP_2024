% This scripts generates a matrix which will be persistent and helps us
% computing the derivative of the area. 
% The matrix has 6*nt rows and 2*nq columns
% the first 2*nt columns correspond to the indices associated to the
% derivative of the sum of squared edge lengths w.r.t. the first node of
% each triangle 

function [diffQ13x,diffQ13y,diffQ12x,diffQ12y] = generateDiffQArea(problem)


    % matrix which represents 
    % q(1,problem.fem.t(3,:))-q(1,problem.fem.t(1,:))
    ix = [1:problem.fem.nt, 1:problem.fem.nt]';
	jx = [2*problem.fem.t(3,:)-1, 2*problem.fem.t(1,:)-1]';
	vals = [ones(1,problem.fem.nt), -ones(1,problem.fem.nt)];
    diffQ13x = sparse(ix,jx,vals,problem.fem.nt,2*problem.fem.nq);
    
    % q(2,problem.fem.t(3,:))-q(2,problem.fem.t(1,:))
    jx = [2*problem.fem.t(3,:), 2*problem.fem.t(1,:)]';
	vals = [ones(1,problem.fem.nt), -ones(1,problem.fem.nt)];
    diffQ13y = sparse(ix,jx,vals,problem.fem.nt, 2*problem.fem.nq);

    
    % q(1,problem.fem.t(2,:))-q(1,problem.fem.t(1,:))
    jx = [2*problem.fem.t(2,:)-1, 2*problem.fem.t(1,:)-1]';
	vals = [ones(1,problem.fem.nt), -ones(1,problem.fem.nt)];
    diffQ12x = sparse(ix,jx,vals,problem.fem.nt, 2*problem.fem.nq);


    % q(2,problem.fem.t(2,:))-q(2,problem.fem.t(1,:));
    jx = [2*problem.fem.t(2,:), 2*problem.fem.t(1,:)]';
	vals = [ones(1,problem.fem.nt), -ones(1,problem.fem.nt)];
    diffQ12y = sparse(ix,jx,vals,problem.fem.nt,2*problem.fem.nq);
end % function