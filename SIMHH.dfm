�
 TVCLAMPSIM 0
7  TPF0
TVClampSim	VClampSimLeft�TopTWidth�Height�Caption%Voltage-activated Currents SimulationColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChildOldCreateOrder	PositionpoScreenCenterVisible	OnClose	FormCloseOnCloseQueryFormCloseQueryOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight TLabelLabel10Left0TopWidth!HeightCaptionG.MaxFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TScopeDisplay	scDisplayLeft� TopWidth�Height	OnCursorChangescDisplayCursorChangeCursorChangeInProgressNumChannels	NumPoints	MaxPoints XMin XMax�XOffset CursorsEnabled	TScale       ��?TUnitssTCalBar       ���ZoomDisableHorizontal	ZoomDisableVerticalDisableChannelVisibilityButtonPrinterFontSize PrinterPenWidth PrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorPrinterShowLabels	PrinterShowZeroLevels	MetafileWidth MetafileHeight StorageModeRecordNumber�DisplayGrid	MaxADCValue�MinADCValue �NumBytesPerSampleFixZeroLevelsDisplaySelectedFontSize  	TGroupBox
QuantumGrpLeftTop� Width� Height9Caption Noise Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TLabelLabel9LeftTopWidthaHeight!AutoSizeCaptionBackground noise (R.M.S.)WordWrap	  TValidatedEdit
edNoiseRMSLeft`TopWidthAHeightAutoSizeText 0.02 nAValue     ���?Scale     (k�@UnitsnANumberFormat%.3gLoLimit     ���b�HiLimit     ���b@   	TGroupBox	GroupBox1LeftTop Width� Height9Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbStartLeftTopWidth� HeightCaptionStart SimulationFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbStartClick  TButtonbAbortLeftTop Width9HeightCaptionAbortFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbAbortClick   	TGroupBox	GroupBox2LeftTop:Width� HeightYCaption Voltage protocol Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel8LeftTopWidthYHeightAutoSizeCaptionHolding voltageFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabel LeftTop(WidthDHeightCaptionVoltage stepFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabel LeftTop@WidthBHeightCaptionNo. of stepsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TValidatedEditedVHoldLeft`TopWidthAHeightAutoSizeText	 -90.0 mVValue     �Q���Scale       �@UnitsmVNumberFormat%.1fLoLimit     �����HiLimit     ����?  TValidatedEditedVStepLeft`Top(WidthAHeightAutoSizeText 10.0 mVValue     
ף�?Scale       �@UnitsmVNumberFormat%.1fLoLimit     �����HiLimit     ����?  TValidatedEdit
edNumStepsLeft`Top@WidthAHeightAutoSizeText 16 Value       �@Scale       ��?NumberFormat%gLoLimit       ��?HiLimit     ���b@   	TGroupBox	GroupBox7LeftTop� Width� HeightACaption Leak subtraction Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TRadioButtonrbNoLeakSubtractionLeftTopWidthAHeightCaptionNoneChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TabStop	  TRadioButtonrbLeakSubtractionLeftTop WidthYHeightCaptionDivide by NFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TValidatedEditedLeakDivByLeft`Top Width!HeightAutoSizeText 4 Value       �@Scale       ��?NumberFormat%gLoLimit     ���b�HiLimit     ���b@   	TGroupBoxEquationGrpLeftTop<Width�HeightITabOrder 	TGroupBox	GroupBox4LeftTopWidth� Height9Caption Conductance TabOrder  
THTMLLabel
HTMLLabel1Left(Top(Width2HeightCaptionG<sub>max</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel2Left(TopDWidth2HeightCaptionG<sub>leak</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel3Left(Top`Width2HeightCaptionG<sub>series</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel4LeftTopWidth� HeightCaptionK I<sub>m</sub> = G<sub>max</sub> x  m<sup>p</sup> x h (V - V<sub>rev</sub>)	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   
THTMLLabel
HTMLLabel5Left8Top� Width HeightCaptionV<sub>rev</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel6Left8Top� Width HeightCaptionP	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel7Left8Top� Width HeightCaptionC<sub>m</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  TValidatedEditedGMaxLeftXTop(WidthPHeightHintMaximum conductance
OnKeyPressedGMaxKeyPressAutoSizeShowHint	Text 20 nSValue     w̫�?Scale     (k�@UnitsnSNumberFormat%.5gLoLimit     `B��?HiLimit     ���b@  TValidatedEditedGLeakLeftXTopDWidthPHeightHintLeak conductance
OnKeyPressedGLeakKeyPressAutoSizeShowHint	Text 1 nSValue     _p��?Scale     (k�@UnitsnSNumberFormat%.5gLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edGSeriesLeftXTop`WidthPHeightHintPipette series conductanceAutoSizeShowHint	Text 200 nSValue     ����?Scale     (k�@UnitsnSNumberFormat%.5gLoLimit     ���b�HiLimit     ���b@  TValidatedEditedVRevLeftXTop� WidthPHeightHintReversal potential
OnKeyPressedVRevKeyPressAutoSizeShowHint	Text
 -100.0 mVValue     �����Scale       �@UnitsmVNumberFormat%.1fLoLimit     �����HiLimit     ����?  TValidatedEditedPowerLeftXTop� WidthPHeightHintm-gate power factorAutoSizeShowHint	Text 1 Value       ��?Scale       ��?NumberFormat%.0fLoLimit       ��?HiLimit       �@  TValidatedEditedCmLeftXTop� WidthPHeightHintCell capacitanceAutoSizeShowHint	Text 30 pFValue     ����?Scale     ���&@UnitspFNumberFormat%.5gLoLimit     `B��?HiLimit     ���b@   	TGroupBoxMGroupLeft� TopWidthHeight9Caption Activation (m) TabOrder 
THTMLLabelHTMLLabel11LeftTopWidth� HeightCaptionI m = (m<sub>inf</sub>{V} - m<sub>inf</sub>{V<sub>h</sub>}) exp(-t/tau{V})	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   	TGroupBox	GroupBox3LeftTop(Width� Height^Caption m.inf (V) TabOrder  
THTMLLabel
HTMLLabel8LeftXTop(Width,HeightCaptionV<sub>1/2</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabel
HTMLLabel9LeftXTop@Width,HeightCaptionV<sub>slope</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel22LeftTopWidth� HeightCaption@ m<sub>inf</sub>=1/(1+exp((V-V<sub>1/2</sub>)/V<sub>slope</sub>)	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   TValidatedEditedMInfVHalfLeft� Top(WidthPHeightAutoSizeText -1.0 mVValue     o���Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedMinfVSlopeLeft� Top@WidthPHeightAutoSizeText	 -11.0 mVValue     X9���Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@   	TGroupBox	GroupBox5LeftTop� Width� Height� Caption tau(V) TabOrder 
THTMLLabelHTMLLabel10LefthTopXWidth,HeightCaptionV<sub>1/2</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel16LefthToppWidth,HeightCaptionV<sub>slope</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel17LefthTop(Width,HeightCaption(<Font face=symbol>t</Font><sub>min</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel18LefthTop@Width,HeightCaption(<Font face=symbol>t</Font><sub>max</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel24LeftTopWidth� HeightCaption�<Font face=symbol>t</Font>=<Font face=symbol>t</Font><sub>min</sub>+(<Font face=symbol>t</Font><sub>max</sub>-<Font face=symbol>t</Font><sub>min</sub>)exp(-(V-V<sub>1/2</sub>)/V<sub>slope</sub>)<sup>2</sup>	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   TValidatedEditedMTauVhalfLeft� TopXWidthPHeightAutoSizeText 0.0 mVScale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedMTauVSlopeLeft� ToppWidthPHeightAutoSizeText 30.0 mVValue     ����?Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edMtauMinLeft� Top(WidthPHeightAutoSizeText 1.5 msValue     ����?Scale       �@UnitsmsNumberFormat%.1fLoLimit     `B��?HiLimit     ���b@  TValidatedEdit	edMTauMaxLeft� Top@WidthPHeightAutoSizeText 3.5 msValue     B`��?Scale       �@UnitsmsNumberFormat%.1fLoLimit     `B��?HiLimit     ���b@    	TGroupBox	GroupBox6Left�TopWidthHeight9Caption Inactivation (h) TabOrder 
THTMLLabelHTMLLabel15LeftTopWidth� HeightCaptionI h = (h<sub>inf</sub>{V} - h<sub>inf</sub>{V<sub>h</sub>}) exp(-t/tau{V})	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   	TCheckBoxckInactivationLeftTopWidthqHeightCaptionUse InactivationFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder   	TGroupBox	GroupBox8LeftTop(Width� Height^Caption h.inf (V) TabOrder 
THTMLLabelHTMLLabel12LeftXTop(Width,HeightCaptionV<sub>1/2</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel13LeftXTop@Width,HeightCaptionV<sub>slope</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel23LeftTopWidth� HeightCaption@ h<sub>inf</sub>=1/(1+exp((V-V<sub>1/2</sub>)/V<sub>slope</sub>)	AlignmenttaLeftJustifyLineSpacing       ��?ColorclActiveBorderFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   TValidatedEditedHinfVhalfLeft� Top(WidthPHeightAutoSizeText	 -45.0 mVValue     �Q���Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedHinfVslopeLeft� Top@WidthPHeightAutoSizeText 11.5 mVValue     j��?Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@   	TGroupBox	GroupBox9LeftTop� Width� Height� Caption tau(V) TabOrder 
THTMLLabelHTMLLabel14LefthTopXWidth,HeightCaptionV<sub>1/2</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel19LefthToppWidth,HeightCaptionV<sub>slope</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel20LefthTop(Width,HeightCaption(<Font face=symbol>t</Font><sub>min</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel21LefthTop@Width,HeightCaption(<Font face=symbol>t</Font><sub>max</sub>	AlignmenttaLeftJustifyLineSpacing       ��?  
THTMLLabelHTMLLabel25LeftTopWidth� HeightCaption�<Font face=symbol>t</Font>=<Font face=symbol>t</Font><sub>min</sub>+(<Font face=symbol>t</Font><sub>max</sub>-<Font face=symbol>t</Font><sub>min</sub>)exp(-(V-V<sub>1/2</sub>)/V<sub>slope</sub>)<sup>2</sup>	AlignmenttaLeftJustifyLineSpacing       ��?Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style   TValidatedEditedHtauVhalfLeft� TopXWidthPHeightAutoSizeText	 -52.5 mVValue     =
���Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedHtauVslopeLeft� ToppWidthPHeightAutoSizeText 15.0 mVValue     ����?Scale       �@UnitsmVNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edHtauMinLeft� Top(WidthPHeightAutoSizeText 14.0 msValue     B`��?Scale       �@UnitsmsNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edHtauMaxLeft� Top@WidthPHeightAutoSizeText	 482.6 msValue     Y��?Scale       �@UnitsmsNumberFormat%.1fLoLimit     ���b�HiLimit     ���b@     	TGroupBox
GroupBox10LeftTopWidth� Height)TabOrder TLabelLabel12LeftTopWidthHHeight	AlignmenttaRightJustifyCaptionNo. SamplesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TValidatedEditedNumSamplesLeft`TopWidthAHeightHintNo. of sample points per record
OnKeyPressedNumSamplesKeyPressAutoSizeShowHint	Text 512 Value       �@Scale       ��?NumberFormat%.0fLoLimit       �@HiLimit     ���b@    