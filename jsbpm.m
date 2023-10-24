%This function implements BPM ('beam propagation method') over one step in
%the axial direction. Input electric field must be square matrix. Ein is
%the trasverse complex amplitude of the electric field (square matrix),
%lambda is the central wavelength (vacuum), dz is step size, n is the
%transverse refractive index, and xwidth is the spatial width of the frame.
%The method is to transform to the transverse
%spatio-spectral domain, step the equation forward diffractively, transform
%back to spatial domain and then step the equation forward refractively. 

function[Eout] = jsbpm(Ein, lambda, dz, n, xwidth)
    
    %vacuum wavevector
    k_0 = 2*pi/lambda;
    
    %2D Fourier transform of Ein
    N = size(Ein,1);
    Ef = fft2(Ein);
    
    %momentum values
    %arrange momentum values from 0 -->N/2, -N/2 --> -1 as in DFT
    krange = (2*pi/xwidth)*((1:N) - round((N+1)/2));
    krange = ifftshift(krange);
    
    %now create fraunhoff matrix to step solution forward on axis
    arg = (krange.^2)/(2*k_0);

    temp = ones(1,N);
    fraunhoff = (arg'*temp + temp'*arg)*dz;
    fraunhoff = exp(-1i*fraunhoff);
    
    %Step the electric field forward in z in the spatio-spectral domain
    %(the diffractive step)
    Efnew = Ef.*fraunhoff;
    
    %Transform back to spatial domain
    Eout = ifft2(Efnew);
    
    %Step the electric field forward in z in the spatial domain
    %(the refractive step)
    Eout = Eout.*exp(1i*k_0*n*dz);
    
end

