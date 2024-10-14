%Diffraction from a rectangular aperture
%Steven Sahyun 3/3/2016
%includes stl output for 3D printer

clf;
clear;

%Physical modeling
D = 70; % distance to screen in cm
xmax = 4; % x maximum in cm displayed view
ymax = 4; % y maximum in cm displayed view
lambda = 630; %Wavelength of light in nm

dx = 60000;   %Width of aperture in nm
dy = 30000;   %Height of aperture in nm

I0 = 1000;     %Relative intensity to get a good print for these values

k = 2*pi/lambda;

stepsize = xmax/100;
[x,y] = meshgrid(-xmax+stepsize/11: stepsize: xmax); %the 11 is to remove a problem at 0
    alphax2=k*dx*sin(x./sqrt(x.^2+D^2))/2; %alpha = k*d_x/2*sin(theta); sinc function uses alpha/2
    alphay2=k*dy*sin(y./sqrt(y.^2+D^2))/2;

%Kenyon, The Light Fantastic, 2nd Ed. Equation 6.10 
I1=I0*(((sin(alphax2))./alphax2).*((sin(alphay2))./alphay2)).^2;  % Single Aperture Interference term

%Plot as an "overexposed" surface intensity. The eyes respond to the log of
%the intensity, so taking the square root provides a more accurate
%representation of what we see.
surf(x, y, sqrt(I1), 'LineStyle', 'none')

%functions
minz = 0;
maxz = I0;
z=sqrt(I1);
c=255*((z+minz)/maxz);

%Print plot output to stl file
RectAperture = surf2solid(10*x, 10*y, z);
stlwrite('RectAperture.stl',RectAperture)