function d = Dist2Line(pt, v1, v2)
%Find the distance between a line (created by v1 and v2) and the point pt 
%in 2D.
a = v1 - v2;
b = pt - v2;
c = [a(2),-a(1)];
d = norm(dot(c,b)) / norm(c);
end