clear;

addpath(genpath('/Users/nathaniel/Desktop/Data_and_Codes/yamlmatlab'));

yaml_fileequi = 'unipa_PtTe2+0.0.yaml';

yaml_filem2p5 = 'unipa_PtTe2-2.5.yaml';
yaml_filem2p0 = 'unipa_PtTe2-2.0.yaml';
yaml_filem1p5 = 'unipa_PtTe2-1.5.yaml';
yaml_filem1p0 = 'unipa_PtTe2-1.0.yaml';
yaml_filem0p5 = 'unipa_PtTe2-0.5.yaml';
yaml_filep0p5 = 'unipa_PtTe2+0.5.yaml';
yaml_filep1p0 = 'unipa_PtTe2+1.0.yaml';
yaml_filep1p5 = 'unipa_PtTe2+1.5.yaml';
yaml_filep2p0 = 'unipa_PtTe2+2.0.yaml';
yaml_filep2p5 = 'unipa_PtTe2+2.5.yaml';

gammapt_freqs=zeros(9,11);
mpt_freqs=zeros(9,11);
kpt_freqs=zeros(9,11);

yaml_structm2p5 = yaml.ReadYaml(yaml_filem2p5);
for i=1:9
    gammapt_freqs(i,1)=yaml_structm2p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,1)=yaml_structm2p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,1)=yaml_structm2p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structm2p5 i;

yaml_structm2p0 = yaml.ReadYaml(yaml_filem2p0);
for i=1:9
    gammapt_freqs(i,2)=yaml_structm2p0.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,2)=yaml_structm2p0.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,2)=yaml_structm2p0.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structm2p0 i;

yaml_structm1p5 = yaml.ReadYaml(yaml_filem1p5);
for i=1:9
    gammapt_freqs(i,3)=yaml_structm1p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,3)=yaml_structm1p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,3)=yaml_structm1p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structm1p5 i;

yaml_structm1p0 = yaml.ReadYaml(yaml_filem1p0);
for i=1:9
    gammapt_freqs(i,4)=yaml_structm1p0.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,4)=yaml_structm1p0.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,4)=yaml_structm1p0.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structm1p0 i;

yaml_structm0p5 = yaml.ReadYaml(yaml_filem0p5);
for i=1:9
    gammapt_freqs(i,5)=yaml_structm0p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,5)=yaml_structm0p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,5)=yaml_structm0p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structm0p5 i;

yaml_structequi = yaml.ReadYaml(yaml_fileequi);
for i=1:9
    gammapt_freqs(i,6)=yaml_structequi.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,6)=yaml_structequi.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,6)=yaml_structequi.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structequi i;

yaml_structp0p5 = yaml.ReadYaml(yaml_filep0p5);
for i=1:9
    gammapt_freqs(i,7)=yaml_structp0p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,7)=yaml_structp0p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,7)=yaml_structp0p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structp0p5 i;

yaml_structp1p0 = yaml.ReadYaml(yaml_filep1p0);
for i=1:9
    gammapt_freqs(i,8)=yaml_structp1p0.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,8)=yaml_structp1p0.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,8)=yaml_structp1p0.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structp1p0 i;

yaml_structp1p5 = yaml.ReadYaml(yaml_filep1p5);
for i=1:9
    gammapt_freqs(i,9)=yaml_structp1p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,9)=yaml_structp1p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,9)=yaml_structp1p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structp1p5 i;

yaml_structp2p0 = yaml.ReadYaml(yaml_filep2p0);
for i=1:9
    gammapt_freqs(i,10)=yaml_structp2p0.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,10)=yaml_structp2p0.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,10)=yaml_structp2p0.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structp2p0 i;

yaml_structp2p5 = yaml.ReadYaml(yaml_filep2p5);
for i=1:9
    gammapt_freqs(i,11)=yaml_structp2p5.phonon{1,1}.band{1,i}.frequency;
    mpt_freqs(i,11)=yaml_structp2p5.phonon{1,201}.band{1,i}.frequency;
    kpt_freqs(i,11)=yaml_structp2p5.phonon{1,402}.band{1,i}.frequency;
end
clear yaml_structp2p5 i;

gammapt_diffs=zeros(9,11);
mpt_diffs=zeros(9,11);
kpt_diffs=zeros(9,11);
for i=1:9
    for j=1:11
        gammapt_diffs(i,j)=gammapt_freqs(i,j)-gammapt_freqs(i,6);
        mpt_diffs(i,j)=mpt_freqs(i,j)-mpt_freqs(i,6);
        kpt_diffs(i,j)=kpt_freqs(i,j)-kpt_freqs(i,6);
    end
end
strain_pctg=[-2.5 -2.0 -1.5 -1.0 -0.5 0.0 0.5 1.0 1.5 2.0 2.5];

figure('Position',[0 0 1000 1000])
for i=1:9
    plot(strain_pctg,gammapt_diffs(i,:),'LineWidth',2)
    hold on
end

% figure('Position',[0 0 1000 1000])
% for i=1:9
%     plot(strain_pctg,mpt_diffs(i,:),'LineWidth',2)
%     hold on
% end
% 
% figure('Position',[0 0 1000 1000])
% for i=1:9
%     plot(strain_pctg,kpt_diffs(i,:),'LineWidth',2)
%     hold on
% end

% yaml_structequi = yaml.ReadYaml(yaml_fileequi);
% yaml_structp0p5 = yaml.ReadYaml(yaml_filep0p5);
% yaml_structp1p0 = yaml.ReadYaml(yaml_filep1p0);
% yaml_structp1p5 = yaml.ReadYaml(yaml_filep1p5);
% yaml_structp2p0 = yaml.ReadYaml(yaml_filep2p0);
% yaml_structp2p5 = yaml.ReadYaml(yaml_filep2p5);