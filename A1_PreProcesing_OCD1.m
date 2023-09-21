clc;clear;close all

Add = 'D:\ATIEH_DATA\Ahmadi Roshan_OCD\EDF_Data1';

for j=1
    k=1
    for i=1:46

        name_dire = sprintf('OCD_subj%d.EDF',i); %OCD_subj
        EEG = pop_biosig(fullfile(Add,name_dire)); %,'blockrange',[305 355]);
        varial=1;
        event_list= ["Eyes clo";'EC'];
        Eve=EEG.event;
        for m=1:length(Eve)
            for s=1:length(event_list)
                a1=[];
                a1 = event_list(s);
                if(Eve(m).type(1:2) == a1)|| (Eve(m).type(1:8) == a1)
                    start_time=round ((Eve(m).latency)/EEG.srate);
                    EEG = pop_select( EEG, 'time',[start_time+5 start_time+55] );
                    varial=varial+1;
                end
            end
        end
        if varial==1
            EEG = pop_select( EEG, 'time',[5 55] );
        end
        varial
        %EEG = pop_biosig(fullfile(Add,name_dire),'blockrange',[5 60]);
        EEG = pop_resample(EEG, 250);
        EEG = pop_select( EEG, 'channel',{'Fp1' 'Fp2' 'F7' 'F3' 'F4' 'F8' 'T3' 'C3' 'C4' 'T4' 'T5' 'P3' 'P4' 'T6' 'O1' 'O2' 'Fz' 'Cz' 'Pz'});
        EEG = pop_chanedit(EEG, 'lookup','D:\\eeglab_current\\eeglab2022.1_old\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc','eval','chans = pop_chancenter( chans, [],[]);');
        originalEEG = EEG;  EEG = clean_rawdata(EEG, 5, [0.25 0.75], 0.85, 4,20, 0.25);
        EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical');
        EEG.nbchan = EEG.nbchan+1;
        EEG.data(end+1,:) = zeros(1, EEG.pnts);
        EEG.chanlocs(1,EEG.nbchan).labels = 'initialReference';
        EEG = pop_reref(EEG, []);
        EEG = pop_select( EEG,'nochannel',{'initialReference'});
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        epoch_length=5000;

        EEG_delta = pop_eegfiltnew(EEG, 'locutoff',.5,'hicutoff',4,'plotfreqz',0);
        deltaband=EEG_delta.data(:,1:epoch_length);

        EEG_theta = pop_eegfiltnew(EEG, 'locutoff',4,'hicutoff',8,'plotfreqz',0);
        thetaband=EEG_theta.data(:,1:epoch_length);

        EEG_alpha = pop_eegfiltnew(EEG, 'locutoff',8,'hicutoff',12,'plotfreqz',0);
        alphaband=EEG_alpha.data(:,1:epoch_length);

        EEG_beta1 = pop_eegfiltnew(EEG, 'locutoff',12,'hicutoff',20,'plotfreqz',0);
        beta1band=EEG_beta1.data(:,1:epoch_length);

        EEG_beta2 = pop_eegfiltnew(EEG, 'locutoff',20,'hicutoff',30,'plotfreqz',0);
        beta2band=EEG_beta2.data(:,1:epoch_length);

%         %%%%%
%         pop_eegplot( EEG_alpha, 1, 1, 1);
%         %%%%%

        EEG_gamma = pop_eegfiltnew(EEG, 'locutoff',30,'hicutoff',40,'plotfreqz',0);
        gammaband=EEG_gamma.data(:,1:epoch_length);

        EEG_fullband = pop_eegfiltnew(EEG, 'locutoff',.5,'hicutoff',40,'plotfreqz',0);
        fullband=EEG.data(:,1:epoch_length);
        %%%%%%%%%%%%%%%%%%%%%%%%
        if (size(deltaband,2) >= 5000)
            OCD_delta(k,:,:) = deltaband(:,1:5000);
            OCD_theta(k,:,:) = thetaband(:,1:5000);
            OCD_alpha(k,:,:) = alphaband(:,1:5000);
            OCD_beta1(k,:,:) = beta1band(:,1:5000);
            OCD_beta2(k,:,:) = beta2band(:,1:5000);
            OCD_gamma(k,:,:) = gammaband(:,1:5000);
            OCD_full(k,:,:) = fullband(:,1:5000);
            k=k+1
        else
            j
            i
        end
    end
end

EC_EEG_OCD1{1,1} = OCD_delta;
EC_EEG_OCD1{2,1} = OCD_theta;
EC_EEG_OCD1{3,1} = OCD_alpha;
EC_EEG_OCD1{4,1} = OCD_beta1;
EC_EEG_OCD1{5,1} = OCD_beta2;
EC_EEG_OCD1{6,1} = OCD_gamma;
EC_EEG_OCD1{7,1} = OCD_full;


save('D:\6-OCD\Final_Codes\EC_EEG_OCD1.mat','EC_EEG_OCD1')
