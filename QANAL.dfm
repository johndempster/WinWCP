�
 TQUANTFRM 0�  TPF0	TQuantFrmQuantFrmLeftTop� Width)Height�CaptionQuantal AnalysisColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChildOldCreateOrder	PositionpoScreenCenterVisible	OnClose	FormCloseOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox
ControlGrpLeftTop WidthyHeightICaption
 Analysis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButtonbDoAnalysisLeftTopWidthaHeightHintStart quantal content analysisCaptionDo AnalysisFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbDoAnalysisClick  TRadioButton	rbPoissonLeftTop"WidthiHeightHint/Use Poisson distribution statistics in analysisCaptionPoissonParentShowHintShowHint	TabOrder  TRadioButton
rbBinomialLeftTop0WidthYHeightHint0Use binomial distribution statistics in analysisCaption	Binomial Checked	ParentShowHintShowHint	TabOrderTabStop	   	TGroupBox	GroupBox2LeftTop� WidthyHeight1Caption Evoked event Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel5LeftTopWidthHeightCaptionType  	TComboBoxcbEvokedTypeLeft(TopWidthIHeightHint;Record type which contains stimulus-evoked synaptic signals
ItemHeightParentShowHintShowHint	TabOrder TextcbEvokedType   	TGroupBoxMiniGrpLeftTop� WidthyHeight� Caption Quantum event Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel2LeftTop(WidthHeightCaptionType  TLabelLabel3Left(TopPWidth7HeightCaption	Amplitude  TLabelLabel4Left TopxWidthMHeightCaptionStandard Dev.  	TComboBox
cbMiniTypeLeft(Top#WidthIHeightHintCRecord type  containing spontaneous single-quantum synaptic signals
ItemHeightParentShowHintShowHint	TabOrder TextcbEvokedType  TRadioButtonrbMiniEventsAvailableLeftTopWidthiHeightHintZThe data file contains records with single quantum "mini" signal. Use them in the analysisCaptionEvents in fileChecked	ParentShowHintShowHint	TabOrderTabStop	OnClickrbMiniEventsAvailableClick  TRadioButtonrbUserEnteredLeftTop@WidthiHeightHintKUse a manually-entered value for the amplitude of the single-quantum signalCaptionUser enteredParentShowHintShowHint	TabOrderOnClickrbUserEnteredClick  TValidatedEditedMiniAmplitudeLeft Top`WidthQHeightAutoSizeText 0 Scale       ��?NumberFormat%gLoLimit     ���b�HiLimit     ���b@  TValidatedEditedMiniStDevLeft Top� WidthQHeightAutoSizeText 0 Scale       ��?NumberFormat%gLoLimit     ���b�HiLimit     ���b@   	TGroupBoxModeGrpLeft� Top0WidthAHeightYCaption Mode Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel1LeftXTopWidthAHeight)AutoSizeCaptionResting potentialFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel6Left� TopWidthAHeight!AutoSizeCaptionReversal potentialFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel7Left� TopWidthAHeight!AutoSizeCaptionCorrection FactorFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  TRadioButton	rbCurrentLeftTopWidthIHeightHint%Synaptic currents are to be analysed CaptionCurrentsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder TabStop	OnClickrbCurrentClick  TRadioButtonrbPotentialsLeftTop WidthIHeightHintISynaptic potentials are to analysed (use non-linear summation correction)Caption
PotentialsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickrbPotentialsClick  TValidatedEditedVRestLeftXTop5WidthAHeightAutoSizeText	 -90.0 mVValue       ��Scale       ��?UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedVRevLeft� Top5WidthAHeightAutoSizeText 0.0 mVScale       ��?UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedCorrectionFactorLeft� Top5Width9HeightAutoSizeText 1 Value       ��?Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit       ��?   TMemo	mmResultsLeft� TopWidthAHeight!Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  	TGroupBox	GroupBox8LeftTopHWidthyHeightiCaption Record Range Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel8LeftTopHWidthHeightCaptionCh.  TRadioButtonrbAllRecordsLeftTopWidthQHeightHint$Analysis all record in the data fileCaptionAll recordsChecked	ParentShowHintShowHint	TabOrder TabStop	  TRadioButtonrbRangeLeftTop WidthQHeightHint8Analysis a limited range of records within the data fileCaptionRangeParentShowHintShowHint	TabOrder  	TComboBox	cbChannelLeft TopHWidthQHeightHintInput channel to be analysed
ItemHeightParentShowHintShowHint	TabOrderText	cbChannelOnChangecbChannelChange  
TRangeEdit
edRecRangeLeftTop0WidthYHeightText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f    