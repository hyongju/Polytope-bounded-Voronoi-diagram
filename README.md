# Polytope-bounded-Voronoi-diagram
The function cacluates arbitrary polytope bounded Voronoi diagram in 2D/3D. The function calculates Voronoi diagram with the finite set of points that are bounded by an arbitrary polytope. The function calculates Voronoi diagram using linear ineqaulities formed with persendicular bisecters between any two connected points in the Deluanay triangulation.

Here are the description of the uploaded files:

"demo.m" an example

"polybnd_voronoi.m" main function that obtains polytope bounded Voronoi diagram 

"pbisec.m" obtains half space created with perpendicular bisector of two points in the form Ax <= b

"MY_con2vert.m" convert a convex set of constraint inequalities into the set of vertices at the intersections of those inequalities (written by Michael Keder)

"vert2lcon.m" used for finding the %linear constraints defining a polyhedron in R^n given its vertices (written by Matt Jacobson and Michael Keder)

"inhull.m" tests if a set of points are inside a convex hull (written by John D'Errico)

"MY_setdiff.m", "MY_intersect.m" are much fasten than MATLAB built-in "setdiff.m", "intersect.m". Two functions are written by Nick (http://www.mathworks.com/matlabcentral/profile/authors/1739467-nick)
