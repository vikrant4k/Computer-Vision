function x = find_transformation(fa, fb, matches)

    xa = fa(1,matches(1,:)) ;    
    ya = fa(2,matches(1,:)) ;
    
    yb = fb(2,matches(2,:)) ;
    xb = fb(1,matches(2,:)) ;

    A = [];
    b = [];
    for i = 1:size(xa,2)
        A = cat(1,A,[xa(i), ya(i), 0, 0, 1, 0; 0, 0, xa(i), ya(i), 0, 1]);
        b = cat(1,b,[xb(i); yb(i)]);
    end
    
    x = pinv(A)*b;
    
end