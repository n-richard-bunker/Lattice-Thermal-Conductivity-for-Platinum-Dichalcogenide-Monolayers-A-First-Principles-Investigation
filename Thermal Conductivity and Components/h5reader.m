clear;close;

addpath(genpath('/Users/nathaniel/Desktop/Data_and_Codes/yamlmatlab'));

% yaml_file1 = 'PtSe2_mesh.yaml';

yaml_file1 = 'PtTe2_mesh.yaml';
yaml_file2 = 'PtTe2_mode-grun_biaxialstrain.yaml';
YamlStruct1 = yaml.ReadYaml(yaml_file1);
YamlStruct2 = yaml.ReadYaml(yaml_file2);

recipvecs=YamlStruct1.reciprocal_lattice;
R=[cos(pi/3) (-sin(pi/3)) 0;(1*sin(pi/3)) cos(pi/3) 0;0 0 1];
phts=length(YamlStruct1.phonon);
nbands=length(YamlStruct1.phonon{1,1}.band);

qpts=zeros(phts,3);
qreal=zeros(phts,3);
qrot=zeros(phts,3);

grun_QHA=zeros(9,phts);
qptsQHA=zeros(phts,3);
for i=1:phts
    qptsQHA(i,1)=YamlStruct2.phonon{1,i}.q0x2Dposition{1,1};
    qptsQHA(i,2)=YamlStruct2.phonon{1,i}.q0x2Dposition{1,2};
    qptsQHA(i,3)=YamlStruct2.phonon{1,i}.q0x2Dposition{1,3};
    if qptsQHA(i,1) > 0
    else
        qptsQHA(i,1) = qptsQHA(i,1) + 1.0;
    end
    for j=1:9
        grun_QHA(j,i)=YamlStruct2.phonon{1,i}.band{1,j}.gruneisen;
    end
end

info=h5info('Te2-m81811-iso-avepp.hdf5');

iso_kappa=h5read('Te2-m81811-iso-avepp.hdf5','/kappa');
qpts=h5read('Te2-m81811-iso-avepp.hdf5','/qpoint')';

% qdiff=zeros(phts,3);
% for i=1:phts
%     qdiff(i,1)=qpts(i,1)-qptsQHA(i,1);
%     qdiff(i,2)=qpts(i,2)-qptsQHA(i,2);
%     qdiff(i,3)=qpts(i,3)-qptsQHA(i,3);
% end
% sum(sum(qdiff(:,:)))

noiso_gamma=h5read('Te2-m81811-iso-avepp.hdf5','/gamma');

iso_mode_kappa=h5read('Te2-m81811-iso-avepp.hdf5','/mode_kappa');
iso_mode_avepp=h5read('Te2-m81811-iso-avepp.hdf5','/ave_pp');
iso_gamma_isotope=h5read('Te2-m81811-iso-avepp.hdf5','/gamma_isotope');
iso_gamma=h5read('Te2-m81811-iso-avepp.hdf5','/gamma');
iso_mode_kappa_weights=double(h5read('Te2-m81811-iso-avepp.hdf5','/weight'));
version=h5read('Te2-m81811-iso-avepp.hdf5','/version');

gru=h5read('PtTe2_anharmonic_gruneisen.hdf5','/gruneisen');

grutens=h5read('PtTe2_anharmonic_gruneisen.hdf5','/gruneisen_tensor');
% qmesh=h5read('PtTe2_anharmonic_gruneisen.hdf5','/qpoint');


for i=1:phts
    % qpts(i,1)=(YamlStruct1.phonon{1,i}.q0x2Dposition{1,1});
    % qpts(i,2)=(YamlStruct1.phonon{1,i}.q0x2Dposition{1,2});
    % qpts(i,3)=(YamlStruct1.phonon{1,i}.q0x2Dposition{1,3});
    if qpts(i,1) <= -0.005
        qpts(i,1)=qpts(i,1)+1;
    elseif qpts(i,2) <= -0.005
        qpts(i,2)=qpts(i,2)+1;
    end

    qreal(i,1)=(qpts(i,1)*recipvecs{1,1})+(qpts(i,2)*recipvecs{2,1})+(qpts(i,3)*recipvecs{3,1})/sqrt((recipvecs{1,1}^2)+(recipvecs{1,2}^2)+(recipvecs{1,3}^2));
    qreal(i,2)=(qpts(i,1)*recipvecs{1,2})+(qpts(i,2)*recipvecs{2,2})+(qpts(i,3)*recipvecs{3,2})/sqrt((recipvecs{2,1}^2)+(recipvecs{2,2}^2)+(recipvecs{2,3}^2));
    qreal(i,3)=(qpts(i,1)*recipvecs{1,3})+(qpts(i,2)*recipvecs{2,3})+(qpts(i,3)*recipvecs{3,3})/sqrt((recipvecs{3,1}^2)+(recipvecs{3,2}^2)+(recipvecs{3,3}^2));

    qrot(i,:)=R*[qreal(i,1);qreal(i,2);qreal(i,3)]; %rotate by 60 degrees
end
qx=qrot(:,1);
qy=qrot(:,2);


modekappa_fiftykelv=zeros(size(iso_mode_kappa,2),size(iso_mode_kappa,3));
modekappa_threehundkelv=zeros(size(iso_mode_kappa,2),size(iso_mode_kappa,3));


for i=1:size(iso_mode_kappa,2)
    for j=1:size(iso_mode_kappa,3)
        modekappa_fiftykelv(i,j)=(iso_mode_kappa(1,i,j,1)+iso_mode_kappa(2,i,j,1))/2;
        modekappa_threehundkelv(i,j)=(iso_mode_kappa(1,i,j,2)+iso_mode_kappa(2,i,j,2))/2;
    end
end
clear i j;

offdiagcheck=iso_mode_kappa(3:6,:,:,:);
for i=1:4
    for j=1:9
        for k=1:588
            for l=1:2
                if offdiagcheck(i,j,k,l) >= 0.2
                    fprintf('Sizable off-diagonal elements!')
                else
                end
            end
        end
    end
end
clear offdiagcheck i j k l;

% mathcheck=sum(sum(modekappa_fiftykelv(:,:)))/sum(Se2iso_mode_kappa_weights);

% size(Se2_mode_kappa);
% 1st dimension is xx yy zz yz xz xy
% 2nd dimension is phonon mode
% 3rd dimension is irreducible q-point
% 4th dimension is temperature, 1st value is 50 K 2nd value is 300 K

weightedkappas=zeros(size(modekappa_threehundkelv));
for i=1:size(modekappa_threehundkelv,1)
    for j=1:size(modekappa_threehundkelv,2)
        weightedkappas(i,j)=modekappa_threehundkelv(i,j)/sum(iso_mode_kappa_weights(:,1));
    end
end
clear i j;

% fiftykelvgammas=zeros(size(iso_gamma,1),size(iso_gamma,2));
% threehundkelvgammas=zeros(size(iso_gamma,1),size(iso_gamma,2));
% threehundkelvlw_iso=zeros(size(iso_gamma,1),size(iso_gamma,2));
% threehundkelvlw_noiso=zeros(size(iso_gamma,1),size(iso_gamma,2));
% fiftykelvlw_iso=zeros(size(iso_gamma,1),size(iso_gamma,2));
% fiftykelvlw_noiso=zeros(size(iso_gamma,1),size(iso_gamma,2));
% for i=1:size(iso_gamma,1)
%     for j=1:size(iso_gamma,2)
%         fiftykelvgammas(i,j)=iso_gamma(i,j,1);
%         threehundkelvgammas(i,j)=iso_gamma(i,j,2);
%         fiftykelvlw_noiso(i,j)=(2*fiftykelvgammas(i,j));
%  %       if fiftykelvlw_noiso(i,j) == 0
%  %           fiftykelvlw_noiso(i,j)=NaN;
%  %       else
%  %       end
%         threehundkelvlw_noiso(i,j)=(2*threehundkelvgammas(i,j)); % in THz
%  %       if threehundkelvlw_noiso(i,j) == 0
%  %           threehundkelvlw_noiso(i,j)=NaN;
%  %       else
%  %       end
%         fiftykelvlw_iso(i,j)=(2*(fiftykelvgammas(i,j)+iso_gamma_isotope(i,j)));
% %        if fiftykelvlw_iso(i,j) == 0
% %            fiftykelvlw_iso(i,j)=NaN;
% %        else
% %        end
%         threehundkelvlw_iso(i,j)=(2*(threehundkelvgammas(i,j)+iso_gamma_isotope(i,j)));
% %        if threehundkelvlw_iso(i,j) == 0
% %            threehundkelvlw_iso(i,j)=NaN;
% %        else
% %        end
%     end
% end

%% plotting slices %%%%%%%%%%%%%%%
% T=delaunay(qrot(:,1),qrot(:,2));
% 
% for k=2
%    figure('Position',[100 100 1200 1200])
%    trisurf(T,qrot(:,1),qrot(:,2),weightedkappas(k,:));
%    hold on
%    for l=1:phts % phts
%     pl=scatter3(qrot(l,1),qrot(l,2),60,36,weightedkappas(k,l),'o','filled','MarkerEdgeColor','k'); % 60 height
%     hold on
%    end
%    xlim([-0.2 0])
%    ylim([0 0.2])
%    % zlim([0 65])
%    colormap('turbo')
%    colorbar;
%    clim([0 0.1])
%    axis off; grid off;
%    hold off
%    view(2)
%    saveas(gcf,"PtTe2" + k + "band_slice.jpg")
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure('Position',[0 0 1000 1000])
% boxchart(weightedkappas','LineWidth',4);
% ylim([0 0.12])
% hold on
% 
% scatter(zeros(1,size(weightedkappas,2))+1,weightedkappas(1,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+2,weightedkappas(2,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+3,weightedkappas(3,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+4,weightedkappas(4,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+5,weightedkappas(5,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+6,weightedkappas(6,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+7,weightedkappas(7,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+8,weightedkappas(8,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on
% scatter(zeros(1,size(weightedkappas,2))+9,weightedkappas(9,:),48,'MarkerFaceColor','#D95319','MarkerEdgeColor','k')
% hold on

acousticgruntensxx=zeros(9,phts);
for i=1:phts
    acousticgruntensxx(1,i)=grutens(2,3,1,i);
    acousticgruntensxx(2,i)=grutens(2,3,2,i);
    acousticgruntensxx(3,i)=grutens(2,3,3,i);
    % acousticgruntensxx(1,i)=grutens(1,1,4,i);
    % acousticgruntensxx(2,i)=grutens(1,1,5,i);
    % acousticgruntensxx(3,i)=grutens(1,1,6,i);
    % acousticgruntensxx(1,i)=grutens(1,1,7,i);
    % acousticgruntensxx(2,i)=grutens(1,1,8,i);
    % acousticgruntensxx(3,i)=grutens(1,1,9,i);
end
% ZAavek=sum(weightedkappas(1,:))/phts;ZAavegrun=sum(gru(1,:))/phts;
% TAavek=sum(weightedkappas(2,:))/phts;TAavegrun=sum(gru(2,:))/phts;
% LAavek=sum(weightedkappas(3,:))/phts;LAavegrun=sum(gru(3,:))/phts;

figure('Position',[0 100 1800 300]); % 1800 300
colors=[(229/255) (57/255) (53/255);(142/255) (36/255) (170/255);(57/255) (73/255) (171/255);(3/255) (155/255) (229/255);0 (137/255) (123/255);(109/255) (76/255) (65/255);(124/255) (179/255) (66/255);(253/255) (216/255) (53/255);(251/255) (140/255) (0/255)];
colave=orderedcolors('gem');
for i=1:3
    % scatter(vgave(:,i),grun(:,i),72,'x','MarkerEdgeColor',colors(i,:),'LineWidth',3)
    % hold on
    scatter(weightedkappas(i,:),grun_QHA(i,:),160,'x','MarkerEdgeColor',colors(i,:),'LineWidth',3)
    hold on
    % scatter(ZAavek,ZAavegrun,160,'hexagram','MarkerFaceColor',[(229/255) (57/255) (53/255)],'MarkerEdgeColor',colave(2,:),'LineWidth',1)
    % hold on
    % scatter(TAavek,TAavegrun,160,'hexagram','MarkerFaceColor',[(142/255) (36/255) (170/255)],'MarkerEdgeColor',colave(2,:),'LineWidth',1)
    % hold on
    % scatter(LAavek,LAavegrun,160,'hexagram','MarkerFaceColor',[(57/255) (73/255) (171/255)],'MarkerEdgeColor',colave(2,:),'LineWidth',1)
    % hold on
end
% xline(7.84,'LineStyle','--','Color',[0.2 0.2 0.2],'LineWidth',3)
xlim([0 0.12])
ylim([-1 1])

% figure('Position',[0 100 1600 1600]);
% colors=[(229/255) (57/255) (53/255);(142/255) (36/255) (170/255);(57/255) (73/255) (171/255);(3/255) (155/255) (229/255);0 (137/255) (123/255);(109/255) (76/255) (65/255);(124/255) (179/255) (66/255);(253/255) (216/255) (53/255);(251/255) (140/255) (0/255)];
% for i=1:9
%     scatter(acousticgruntensxx(i,:),grun_QHA(i,:),72,'x','MarkerEdgeColor',colors(i,:),'LineWidth',3)
%     hold on
% end
% plot([-100 0 100],[-100 0 100],'k')
% xlim([-10 10])
% ylim([-10 10])