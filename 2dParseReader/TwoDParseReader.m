c=1;
globalP=zeros(1,3);
robotP=zeros(1,3);
velocT=zeros(1,3);
timE=1;
localP=zeros(2,541);
globalPs=zeros(3,541);
onesM=ones(541,1);
tempPose=zeros(3,1);
splitNMerge=zeros(2);
scan=struct('count',c,'time',timE,'velo',velocT,'robotPose',robotP,'globalPose',globalP,'localPose',localP,'globalPoses',globalPs,'splitAndMerge',splitNMerge);
filename = 'df.2dparse';
fid = fopen(filename);
N=1055;
for n = 1:N
    scan(n).count = fscanf(fid, '\nScan %d', 1);
    scan(n).time = fscanf(fid, '%f', [1,1]);
    scan(n).velo = fscanf(fid, '%f',[1,3]);
    scan(n).robotPose = fscanf(fid, '%f',[1,3]);
    scan(n).globalPose = fscanf(fid, '%f',[1,3]);
    localP = fscanf(fid, '%f', [2,541]);
    scan(n).localPoses=localP';
    scan(n).localPoses(:,3:3)=onesM;
    scan(n).localPoses=scan(n).localPoses';
    for m=1:541
        scan(n).globalPoses(:,m)=toGlobal(scan(n).localPoses(:,m),scan(n).globalPose,scan(1).globalPose);
    end
    [scan(n).splitAndMerge]=splitAndMerge(scan(n).globalPoses(1:2,:),300);
    
end
fclose(fid);
save('data','scan');
%plotGlobal(25,scan);
%t5t6=lsFit(scan,25,26);
%getUnion(25,scan);
%lines=iFit(scan(1).globalPoses(:,:));