# Polytope-bounded-Voronoi-diagram
This is a MATLAB script

## What is this for?
The function calculates Voronoi diagram with the finite set of points that are bounded by an arbitrary polytope. The Voronoi diagram is obtained using linear ineqaulities formed with perpendicular bisecters between any two connected points in the Deluanay triangulation.

## Description


| File name                     | Description                                                          |
| ----------------------------- | ---------------------------------------------------------------------|
| demo.m                        | an example script                                                    |
| polybnd_voronoi.m             | main function that obtains polytope bounded Voronoi diagram          |
| pbisec.m                      | a function computes perpendicular bisectors of two points            |
| MY_con2vert.m                 | inequality constraints to set of vertices (written by Michael Keder) |
| vert2lcon.m                   | a function is used to find linear inequalities from a polyhedron     |
|                               | (written by Matt Jacobson and Michael Keder)                         |
| inhull.m                      | a test function to see if a set of points are inside some convex hull|
|                               | (written by John D'Errico)                                           |
| MY_setdiff.m, MY_intersect.m  | fuctions which are much faster than MATLAB built-in functions        |
|                               | (written by Nick, see http://www.mathworks.com/matlabcentral/profile |
|                               | authors/1739467-nick)                                                |



**Note:** This is still for experimental use ONLY!
