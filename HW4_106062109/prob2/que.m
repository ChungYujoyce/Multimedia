clear all; close all; clc; 

%% Read OBJ file
obj = readObj('trump.obj');
tval = display_obj(obj,'tumpLPcolors.png');
%==============================================================%
%{
[r,c] = size(tval); 
S = zeros(1,3);
Mean = zeros(1,3);
for i=1:3
    S(i) = sum(tval(:,i));
    Mean(i) = S(i)/r;
    Mean(i)
    tval(:,i) = tval(:,i) - Mean(i);
    %tval(:,i)
end
%}
obj.v(:,1) = obj.v(:,1) - (max(obj.v(:,1)) + min(obj.v(:,1)))/2;
obj.v(:,2) = obj.v(:,2) - (max(obj.v(:,2)) + min(obj.v(:,2)))/2;
obj.v(:,3) = obj.v(:,3) - (max(obj.v(:,3)) + min(obj.v(:,3)))/2;
%==============================================================%

%% a.
f = figure; 
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
saveas(f, '2a.png');
%==============================================================%
% Code here. Other Problems
H = repmat(linspace(0, 1, 100), 100, 1);     % 100-by-100 hues
S = repmat([linspace(0, 1, 50) ...           % 100-by-100 saturations
            linspace(1, 0, 50)].', 1, 100);  %'
V = repmat([ones(1, 50) ...                  % 100-by-100 values
            linspace(1, 0, 50)].', 1, 100);  %'
hsvImage = cat(3, H, S, V);                  % Create an HSV image
C = hsv2rgb(hsvImage);                       % Convert it to an RGB image

% Next, create the conical surface coordinates:
A=repmat(-1.4,1,100);
B=zeros(2, 100)-0.4;
theta = linspace(0, 2*pi, 100);  % Angular points
X = [zeros(1, 100); ...          % X coordinates
     cos(theta); ...
     zeros(1, 100)];
Y = [zeros(1, 100); ...          % Y coordinates
     sin(theta); ...
     zeros(1, 100)];
Z = [B; ...           % Z coordinates
     A];
% Finally, plot the texture-mapped surface:
f = figure; 
surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
%axis equal
hold on
todo = trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
saveas(f, '2b.png');
%==============================================================%
f = figure; 
subplot(1, 2, 1);
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[-1 0 0],'Style','local');
title('Positional light')
%directional light
subplot(1, 2, 2);
trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[-1 0 0],'Style','infinite');
title('Directional light')

saveas(f, '2c.png');

%------------------------------------

%I. (ka , kd , ks) = (1.0, 0.0, 0.0)
f=figure;
subplot(2, 2, 1);
first= trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
first1= surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[0 0 1], 'Style', 'infinite');   
lighting phong;
first.AmbientStrength = 1;
first.DiffuseStrength = 0;
first.SpecularStrength = 0;
first1.AmbientStrength = 1;
first1.DiffuseStrength = 0;
first1.SpecularStrength = 0;
title('(1.0, 0.0, 0.0)')
%II. (ka , kd , ks) = (0.1, 1.0, 0.0)
subplot(2, 2, 2);
second1=trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
second= surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[0 0 1], 'Style', 'infinite');    
lighting phong;
second.AmbientStrength = 0.1;
second.DiffuseStrength = 1;
second.SpecularStrength = 0;
second1.AmbientStrength = 0.1;
second1.DiffuseStrength = 1;
second1.SpecularStrength = 0;
title('(0.1, 1.0, 0.0)')
%III. (ka , kd , ks) = (0.1, 0.1, 1.0)
subplot(2, 2, 3);
Third1= trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
Third= surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[0 0 1], 'Style', 'infinite');    
lighting phong;
Third.AmbientStrength = 0.1;
Third.DiffuseStrength = 0.1;
Third.SpecularStrength = 1.0;
Third1.AmbientStrength = 0.1;
Third1.DiffuseStrength = 0.1;
Third1.SpecularStrength = 1.0;
title('(0.1, 0.1, 1.0)')
%IV. (ka , kd , ks) = (0.1, 0.5, 1.0)
subplot(2, 2, 4);
Four1=trisurf(obj.f.v, obj.v(:,1), obj.v(:,2), obj.v(:,3), ...
    'FaceVertexCData', tval, 'FaceColor', 'interp', 'EdgeAlpha', 0,'FaceLighting', 'gouraud');
xlabel('X'); ylabel('Y'); zlabel('Z');
axis equal;
hold on
Four= surf(X, Y, Z, C, 'FaceColor', 'texturemap', 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
light('Position',[0 0 1], 'Style', 'infinite');    
lighting phong;
Four.AmbientStrength = 0.1;
Four.DiffuseStrength = 0.5;
Four.SpecularStrength = 1.0;
Four1.AmbientStrength = 0.1;
Four1.DiffuseStrength = 0.5;
Four1.SpecularStrength = 1.0;
title('(0.1, 0.5, 1.0)')
saveas(f,'2d.png');
