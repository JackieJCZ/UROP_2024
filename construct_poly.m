function U = construct_poly(points,n,r)
corners = zeros(n, 2);

sl = floor(points/n);
extra = points - sl * (n - 1);

for i = 1:n
    theta = (i-1) * 2 * pi / n;
    corners(i, :) = [-r*cos(theta) -r*sin(theta)];
end
U = zeros(points, 2);
for i = 1:n
    x1 = corners(i, :);
    if i == n
        x2 = corners(1, :);
        for k = 1:extra
            U((i-1)*sl+k, :) = x1 + (x2-x1) * (k-1) / extra;
        end
    else
        x2 = corners(i+1, :);
        for k = 1:sl
            U((i-1)*sl+k, :) = x1 + (x2-x1) * (k-1) / sl;
        end
    end
end


