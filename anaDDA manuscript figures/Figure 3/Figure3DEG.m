%% Script to make figures 3DEG of Vink et al.(2020) Extracting transition rates in particle tracking using analytical diffusion distribution analysis
filepath = mfilename('fullpath');
filepath = fileparts(filepath);
load([filepath '\inputFigure3DEG.mat']); %Loads input file if stored in same location as this script
%%Sphere and rods
totalparticles = input.Nparticles;
Dlistdata = [];
ratio = [2 8];
size = [5];
Drange = 4;
koffrange = 20;
for i = ratio
for ii = 1:numel(koffrange)
   input.koff1_A = koffrange(ii);
   input.kon1_A = koffrange(ii); 
for j = size
input.radiusofcell = sqrt(j*4*0.01);
input.lengthcell = i*input.radiusofcell;
input.confinement = 1;
Dlistdata = [];
for k = 1:5
    for w = 1:length(input.frametimerange)
    input.frametime= input.frametimerange(w);
    for u = input.framerange
        input.NumberofFrames = u;
        input.Nparticles = round(totalparticles*input.distributionNparticles(u));
        [Dlistdatatemp] = SimulationLocalizationandConfinement(input,false);
        Dlistdatatemp(2,:) = u;
        Dlistdatatemp(3,:) = input.frametime;
        Dlistdata = [Dlistdata Dlistdatatemp];
    end
    end
parameters = anaDDA(input,Dlistdata');
koffout(ii,1,k) = parameters(2);
konout(ii,1,k) = parameters(3);
Dfreeout(ii,1,k)= parameters(4);
input.confinement = 0;
parameters = anaDDA(input,Dlistdata');
koffout_notcom(ii,1,k) = parameters(2);
konout_notcom(ii,1,k) = parameters(3);
Dfreeout_notcom(ii,1,k)= parameters(4);
end
end
end
figure
hold on
plotgeometricvariance(koffout(:,1,:),koffrange,koffrange)
plotgeometricvariance(koff_notcom(:,1,:),koffrange,koffrange)
figure
hold on
plotgeometricvariance(konout(:,1,:),koffrange,koffrange)
plotgeometricvariance(kon_notcom(:,1,:),koffrange,koffrange)
figure
hold on
plotgeometricvariance(Dfreeout(:,1,:),Drange,koffrange)
plotgeometricvariance(Dfreeout_notcom(:,1,:),Drange,koffrange)
end

            
%%Trackingwindow
trackingwindow = [10];
for ii = 1:numel(koffrange)
   input.koff1_A = koffrange(ii);
   input.kon1_A = koffrange(ii); 
for i = trackingwindow
input.trackingwindow = sqrt(i*4*0.01);
Dlistdata = [];
input.compensatetracking = 1;
for w = 1:length(input.frametimerange)
    input.frametime= input.frametimerange(w);
    for u = input.framerange
        input.NumberofFrames = u;
        input.Nparticles = round(totalparticles*input.distributionNparticles(u));
        [Dlistdatatemp] = SimulationLocalizationandConfinement(input,false);
        Dlistdatatemp(2,:) = u;
        Dlistdatatemp(3,:) = input.frametime;
        Dlistdata = [Dlistdata Dlistdatatemp];
    end
end
parameters = anaDDA(input,Dlistdata');
koffout(ii,1,k) = parameters(2);
konout(ii,1,k) = parameters(3);
Dfreeout(ii,1,k)= parameters(4);
input.compensatetracking = 0;
parameters = anaDDA(input,Dlistdata');
koffout_notcom(ii,1,k) = parameters(2);
konout_notcom(ii,1,k) = parameters(3);
Dfreeout_notcom(ii,1,k)= parameters(4);
end
end
figure
hold on
plotgeometricvariance(koffout(:,1,:),koffrange,koffrange)
plotgeometricvariance(koff_notcom(:,1,:),koffrange,koffrange)
figure
hold on
plotgeometricvariance(konout(:,1,:),koffrange,koffrange)
plotgeometricvariance(kon_notcom(:,1,:),koffrange,koffrange)
figure
hold on
plotgeometricvariance(Dfreeout(:,1,:),Drange,koffrange)
plotgeometricvariance(Dfreeout_notcom(:,1,:),Drange,koffrange)