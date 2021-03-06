�
 TMEASUREFRM 0}g  TPF0TMeasureFrm
MeasureFrmLeft=Top)Width�Height�CaptionWaveform Analysis Color	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChild
KeyPreview	OldCreateOrder	PositionpoScreenCenterVisible	
OnActivateFormActivateOnClose	FormClose	OnKeyDownFormKeyDownOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight TPageControlPageLeftTopWidthHeightw
ActivePageAnalysisTabFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder OnChange
PageChange 	TTabSheetAnalysisTabCaptionAnalysis TScopeDisplay	scDisplayLeft� TopWidth�Height1	OnMouseUpscDisplayMouseUpOnCursorChangescDisplayCursorChangeCursorChangeInProgressNumChannels	NumPoints	MaxPoints XMin XMax�XOffset CursorsEnabled	TScale       ��?TUnitssTCalBar       ���ZoomDisableHorizontalZoomDisableVerticalDisableChannelVisibilityButtonPrinterFontSize PrinterPenWidth PrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorPrinterShowLabels	PrinterShowZeroLevels	MetafileWidth MetafileHeight StorageModeRecordNumber�DisplayGrid	MaxADCValue�MinADCValue �NumBytesPerSampleFixZeroLevelsDisplaySelectedFontSize  	TGroupBox	RecordGrpLeftTop Width� HeightlCaption RecordFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TLabelLabel2Left Top<WidthHeight	AlignmenttaRightJustifyCaptionTypeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TComboBoxcbRecordTypeLeft@Top<WidthAHeightHint#Type of record currently on displayStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbRecordTypeChange  	TCheckBoxckBadRecordLeftTopTWidthQHeightHint.Rejected records are exclude from the analysisCaptionRejectedParentShowHintShowHint	TabOrderOnClickckBadRecordClick  
TScrollBarsbRecordNumLeftTop&WidthxHeightPageSize TabOrderOnChangesbRecordNumChange  
TRangeEditedRecordNumLeftTopWidthxHeight
OnKeyPressedRecordNumKeyPressAutoSizeText 0 / 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat%.0f / %.0f   	TGroupBoxAnalysisGrpLeftToptWidth� Height�Caption	 Analyse Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbDoAnalysisLeftTopWidthxHeightHintStart waveform analysisCaptionDo AnalysisFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbDoAnalysisClick  TButtonbAbortLeftTop%Width1HeightCaptionAbortEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbAbortClick  	TGroupBox	GroupBox8LeftTop6WidthxHeightUTabOrder TRadioButtonrbAllRecordsLeftTopWidthQHeightHint$Analysis all record in the data fileCaptionAll recordsChecked	ParentShowHintShowHint	TabOrder TabStop	  TRadioButtonrbThisRecordLeftTopWidthQHeightHint+Analyse the currently displayed record onlyCaptionThis recordParentShowHintShowHint	TabOrder  TRadioButtonrbRangeLeftTop(WidthQHeightHint8Analysis a limited range of records within the data fileCaptionRangeParentShowHintShowHint	TabOrder  
TRangeEdit
edRecRangeLeftTop8WidthYHeightAutoSizeText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   	TGroupBox	GroupBox4LeftTop� WidthyHeightACaption Peak  Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel4LeftTop(WidthCHeight	AlignmenttaRightJustifyCaptionPoints Avgd.  	TComboBox
cbPeakModeLeftTopWidthkHeightHintBType of peak amplitude to be searched for during waveform analysisStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbPeakModeChangeItems.StringsAbsolutePositiveNegative   TValidatedEdit	edPeakAvgLeftXTop(WidthHeightHint6No. of points to be averaged  at signal peak amplitudeAutoSizeText 0 Scale       ��?NumberFormat%.0fLoLimit       ��HiLimit       �@   	TGroupBox	GroupBox5LeftTop� WidthyHeight,Caption Rate of rise Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TComboBoxcbRateofRiseModeLeftTopWidthkHeightHint&Algorithm used to compute rate of riseStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbRateofRiseModeChangeItems.StringsForward Diff.Quadratic (5)Quadratic (7)    	TGroupBox	GroupBox6LeftTop� WidthyHeight)Caption Type Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TComboBoxcbTypeToBeAnalysedLeftTopWidthiHeightHint%Type of record to be used in analysisStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder    	TGroupBox	GroupBox7LeftTop(WidthyHeight,Caption Rise time Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 
TRangeEdit
edRiseTimeLeftTopWidthiHeightHint;Fraction of signal rising edge used to calculated rise time
OnKeyPressedPlotRangeKeyPressAutoSizeShowHint	Text  10 - 90 %LoValue     ����?HiValue     ff��?HiLimit       �@Scale       �@Units%NumberFormat
 %.f - %.f   	TGroupBox	GroupBox9LeftTopXWidthyHeight-Caption T.x% decay time Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel1Left!TopWidthHeight	AlignmenttaRightJustifyCaptionx%Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TValidatedEditedDecayTimePercentageLeft8TopWidth9HeightHint5Wave decay time end-point (% fall from peak amplitude
OnKeyPressedDecayTimePercentageKeyPressAutoSizeShowHint	Text 1.0 %Value       ��?Scale       ��?Units%NumberFormat%.1fLoLimit       ��?HiLimit       �@   	TGroupBox
GroupBox12LeftTop�WidthyHeightQCaption	 Cursors TabOrder TButtonbGetCursorsLeftTopWidthiHeightHint8Move all cursors on to displayed region of signal recordCaptionGet CursorsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbGetCursorsClick  	TCheckBoxckLockChannelCursorsLeftTop&WidthiHeightHint,Lock cursors for all input channels togetherCaptionLock ChannelsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	State	cbCheckedTabOrderOnClickckLockChannelCursorsClick    	TGroupBox
ResultsGrpLeft� Top@Width�Height� Caption	 Results Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TStringGrid	sgResultsLeftTopWidth�Height� ColCountDefaultColWidthPDefaultRowHeightRowCountFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 
RowHeights    	TCheckBoxckFixedZeroLevelsLeft� Top6WidthfHeightCaptionFix Zero LevelsFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickckFixedZeroLevelsClick   	TTabSheet	XYPlotTabCaptionX/Y Plot TXYPlotDisplayplPlotLeft� TopWidth�Height� MaxPointsPerLine XAxisMax       ��?	XAxisTick     ����?XAxisLawaxLinear
XAxisLabelX AxisXAxisAutoRangeYAxisMax       ��?	YAxisTick     ����?YAxisLawaxLinear
YAxisLabelY AxisYAxisAutoRangeYAxisLabelAtTopScreenFontNameArialScreenFontSize
	LineWidth
MarkerSize	ShowLines	ShowMarkers	HistogramFullBordersHistogramFillColorclWhiteHistogramFillStylebsClearHistogramCumulativeHistogramPercentagePrinterFontSize
PrinterFontNameArialPrinterLineWidthPrinterMarkerSizePrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorMetafileWidth�MetafileHeight�  	TGroupBox	XYPlotGrpLeftTop Width� HeightIFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButton
bNewXYPlotLeftTop\WidthwHeightHintPlot a new graphCaptionNew PlotFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbNewXYPlotClick  	TGroupBoxXGroupLeftTop� WidthyHeightQHint/Waveform measurement to be plotted along X axisCaption X Axis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder TLabelLabel15LeftTop,WidthHeightCaptionCh.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TComboBoxcbXVariableLeftTopWidthiHeightStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder   	TComboBox
cbXChannelLeft Top,WidthQHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder   	TGroupBoxYGroupLeftTop� WidthyHeightHint/Waveform measurement to be plotted along Y axisCaption Y Axis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder 	TComboBoxcbYVariableLeftTopWidthiHeightStylecsDropDownList
ItemHeight TabOrder OnChangecbYVariableChange  TPanelPanConductanceLeftTop,WidthiHeight� 
BevelOuterbvNoneTabOrder TLabelLabel3LeftTopWidthEHeightCaptionCurrent fromFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel5LeftTop0WidthHeightCaptionCh.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel6LeftTopJWidthEHeightCaptionVoltage fromFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel7LeftTopxWidthHeightCaptionCh.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel8LeftTop� WidthIHeightCaptionReversal Pot.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel9LeftTop� WidthHeight	AlignmenttaRightJustifyCaptionUnits  	TComboBox
cbCondIVarLeftTopWidthfHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder   	TComboBoxcbCondIChanLeftTop0WidthNHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder  	TComboBox
cbCondVVarLeftTopZWidthfHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder  	TComboBoxcbCondVChanLeftTopxWidthNHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder  TValidatedEditedVRevLeftTop� WidthfHeightAutoSizeText 0 mVScale       �@UnitsmVNumberFormat%.4gLoLimit     ���b�HiLimit     ���b@  	TComboBoxcbCondUnitsLeft8Top� Width1HeightStylecsDropDownList
ItemHeight	ItemIndexTabOrderTextnSItems.StringspSnSuSmSS    TPanelPanVarLeftTop,WidthiHeight)
BevelOuterbvNoneTabOrder TLabelLabel16LeftTopWidthHeightCaptionCh.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TComboBox
cbYChannelLeftTopWidthNHeightHintInput channelStylecsDropDownList
ItemHeight ParentShowHintShowHintTabOrder     TButtonbSetPlotAxesLeftToppWidthwHeightHint'Set X and Y axes type, range and labelsCaptionSet AxesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbSetPlotAxesClick  	TGroupBox	GroupBox1LeftTop�WidthyHeight/Caption Filter records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbFilterLeftTopWidthiHeightCaptionFilterFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbFilterClick    	TGroupBoxXYFitGrpLeft� Top� Width�Height� Caption
 Analysis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbXYFitLeftTopWidthiHeightCaption	Fit CurveFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbXYFitClick  	TComboBoxcbXYEquationLeftTop$WidthiHeightStylecsDropDownList
ItemHeightTabOrderItems.StringsNoneGaussian2 Gaussians3 Gaussians   	TRichEditerXYResultsLeftxTopWidth!Height� Lines.Strings  ReadOnly	
ScrollBars
ssVerticalTabOrder    	TTabSheetHistogramTabCaption	Histogram TXYPlotDisplayplHistLeft� TopWidth�Height� MaxPointsPerLine XAxisMax       ��?	XAxisTick     ����?XAxisLawaxLinear
XAxisLabelX AxisXAxisAutoRangeYAxisMax       ��?	YAxisTick     ����?YAxisLawaxLinear
YAxisLabelY AxisYAxisAutoRangeYAxisLabelAtTopScreenFontNameArialScreenFontSize
	LineWidth
MarkerSize	ShowLines	ShowMarkers	HistogramFullBordersHistogramFillColorclWhiteHistogramFillStylebsClearHistogramCumulativeHistogramPercentagePrinterFontSize
PrinterFontNameArialPrinterLineWidthPrinterMarkerSizePrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorMetafileWidth�MetafileHeight�  	TGroupBoxHistGrpLeftTop Width� Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButtonbNewHistogramLeftTop\WidthqHeightHintPlot a new histogramCaptionNew HistogramFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbNewHistogramClick  	TGroupBox	GroupBox3LeftTop� WidthyHeightCaption Histogram  Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder TLabelLabel10LeftTop+Width/HeightCaptionChannelFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel11LeftTopXWidth.Height	AlignmenttaRightJustifyCaptionNo. binsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TComboBoxcbHistVariableLeftTopWidthiHeightHint1Waveform measurement to used to compile histogramStylecsDropDownList
ItemHeight TabOrder OnChangecbHistVariableChange  	TComboBoxcbHistChannelLeftTop;WidthiHeightHint&Input channel to take measurement fromStylecsDropDownList
ItemHeight ParentShowHintShowHint	TabOrder  TValidatedEdit	edNumBinsLeftHTopXWidth)HeightAutoSizeText 50 Value       �@Scale       ��?NumberFormat%.0fLoLimit       � @HiLimit       �	@  	TCheckBoxckPercentageLeftTop� WidthaHeightCaption
PercentageFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  	TCheckBoxckCumulativeLeftTop� WidthQHeightCaption
CumulativeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  	TGroupBox
GroupBox10LeftToppWidthiHeightqCaption Range TabOrder TLabelLabel18LeftTopWidth8HeightCaptionLower LimitFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel19LeftTop<Width1HeightCaptionUpper limitFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TValidatedEdit	edHistMinLeftTop!WidthYHeightAutoSizeText 0 Scale       ��?NumberFormat%.4gLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edHistMaxLeftTopMWidthYHeightAutoSizeText 0 Scale       ��?NumberFormat%.4gLoLimit     ���b�HiLimit     ���b@    TButtonbSetHistAxesLeftToppWidthqHeightHint'Set X and Y axes type, range and labelsCaptionSet AxesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbSetHistAxesClick   	TGroupBox
HistFitGrpLeft� Top!Width�Height� Caption
 Analysis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbHistFitLeftTopWidthiHeightCaption	Fit CurveFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbHistFitClick  	TComboBoxcbHistEquationLeftTop$WidthiHeightStylecsDropDownList
ItemHeightTabOrderItems.StringsNoneGaussian2 Gaussians3 Gaussians   	TRichEditerHistResultsLeftxTopWidth!Height� Lines.Strings  ReadOnly	
ScrollBars
ssVerticalTabOrder    	TTabSheet
SummaryTabCaptionSummary 	TGroupBox
SummaryGrpLeftTop Width� Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  	TGroupBoxVariablesGrpLeftTopXWidthyHeight9Hint/Waveform measurements to be included in summaryCaption Variables Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder  	TCheckBoxckVariable0LeftTop0WidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrder OnClickckVariable0Click  	TCheckBoxckVariable1TagLeftTop@WidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable2TagLeftTopPWidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable3TagLeftTop`WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable4LeftToppWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable5LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable6LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable7LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable8LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable9LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder	OnClickckVariable0Click  	TCheckBoxckVariable10LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder
OnClickckVariable0Click  	TCheckBoxckVariable11LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable12LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable13LeftTop WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TComboBoxcbSummaryChannelLeftTopWidthiHeightHintInput channel to be summarised
ItemHeight ParentShowHintShowHint	TabOrderTextcbSummaryChannelOnChangecbSummaryChannelChange  	TCheckBoxckVariable14LeftTopWidthYHeightCaptionckVariable14Checked	State	cbCheckedTabOrderOnClickckVariable0Click    TStringGridSummaryLeft� TopWidth�Height9DefaultRowHeight	FixedCols 	FixedRows Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder	ColWidths@@@@@ 
RowHeights    	TTabSheet	TablesTabCaptionTables TStringGridTableLeft� TopWidth�Height1Hint6Double-click at top of a column to change its contentsColCountDefaultColWidthdDefaultRowHeight	FixedCols RowCount	FixedRowsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	ColWidths_   	TGroupBox	GroupBox2LeftTopPWidthyHeight�Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbClearTableLeftTop�WidthiHeightCaption
ClearTableFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbClearTableClick  	TGroupBox
GroupBox11LeftTopWidthiHeightqHint/Waveform measurements to be included in summaryCaption Variables Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder 	TCheckBox	ckTabVar0LeftTop0WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder OnClickckVariable0Click  	TCheckBox	ckTabVar1TagLeftTop@WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar2TagLeftTopPWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar3TagLeftTop`WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar4LeftToppWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar5LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar6LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar7LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar8LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar9LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder	OnClickckVariable0Click  	TCheckBox
ckTabVar10LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder
OnClickckVariable0Click  	TCheckBox
ckTabVar11LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox
ckTabVar12LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox
ckTabVar13LeftTop WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  TButtonbAddVariableLeftTop,WidthYHeightCaptionAdd VariableFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbAddVariableClick  	TComboBoxcbTableChannelLeftTopWidthYHeightStylecsDropDownListFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ItemHeight 
ParentFontTabOrder  TButtonbClearAllTableVariablesLeftTopBWidth<HeightCaption	Clear AllFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbClearAllTableVariablesClick  TButtonbSetLeftTopXWidth<HeightCaptionSet AllFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClick	bSetClick  	TCheckBox
ckTabVar14TagLeftTopWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click   TButtonbSaveTableToFileLeftTop�WidthiHeightCaptionSave to FileFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbSaveTableToFileClick     	TGroupBox
RecordsGrpLeft Top@WidthyHeightICaption	 Records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel12Left(Top)WidthHeight	AlignmenttaRightJustifyCaptionType  TEditedPlotRecTypeLeftHTop)Width)HeightAutoSizeReadOnly	TabOrder TextedRecordType  
TRangeEditedPlotRangeLeftTopWidthiHeight
OnKeyPressedPlotRangeKeyPressAutoSizeText 1 - 1.00000001504746624E30 LoValue       ��?HiValue     ���b@LoLimit       ��?HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   TSaveDialog
SaveDialogLeft� Top@   