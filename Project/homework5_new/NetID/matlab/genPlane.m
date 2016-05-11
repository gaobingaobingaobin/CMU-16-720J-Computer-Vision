function plane = genPlane(P1, P2, P3)

    normal_line = cross(P2-P1, P3-P1);
    p = - dot(normal_line, P1);
    plane = [normal_line p];
    plane = plane/norm(plane);
    
end