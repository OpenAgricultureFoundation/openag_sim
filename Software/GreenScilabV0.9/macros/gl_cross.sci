function C=gl_cross(A,B)
// cross production of two 3D vectors A and B

C=zeros(A);

C(1)=A(2)*B(3)-B(2)*A(3);
C(2)=A(3)*B(1)-B(3)*A(1);
C(3)=A(1)*B(2)-B(1)*A(2);

endfunction;

