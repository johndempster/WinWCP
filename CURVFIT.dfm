�
 TFITFRM 0eM  TPF0TFitFrmFitFrmLeftTopTWidth�HeightHCaption	Curve FitColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChild
KeyPreview	OldCreateOrder	PositionpoScreenCenterVisible	
OnActivateFormActivateOnClose	FormClose	OnKeyDownFormKeyDownOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight TPageControlPageLeftTopWidth�Height
ActivePageCurveFitTabFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder OnChange
PageChange 	TTabSheetCurveFitTabCaption
Fit Curves TScopeDisplay	scDisplayLeft� TopWidthIHeight	OnMouseUpscDisplayMouseUpOnCursorChangescDisplayCursorChangeCursorChangeInProgressNumChannels	NumPoints	MaxPoints XMin XMax�XOffset CursorsEnabled	TScale       ��?TUnitssTCalBar       ���ZoomDisableHorizontalZoomDisableVerticalDisableChannelVisibilityButtonPrinterFontSize PrinterPenWidth PrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorPrinterShowLabels	PrinterShowZeroLevels	MetafileWidth MetafileHeight StorageModeRecordNumber�DisplayGrid	MaxADCValue�MinADCValue �NumBytesPerSampleFixZeroLevelsDisplaySelectedFontSize  	TGroupBox	RecordGrpLeftTop Width� HeightqCaption RecordFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder  TLabelLabel2Left'Top@WidthHeight	AlignmenttaRightJustifyCaptionTypeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TCheckBoxckBadRecordLeftTopXWidthQHeightHint1Reject currently displayed recorded from analysisCaptionRejectedParentShowHintShowHint	TabOrder OnClickckBadRecordClick  
TScrollBarsbRecordNumLeftTop(Width� HeightHintMove slider to display recordsPageSize TabOrderOnChangesbRecordNumChange  	TComboBoxcbRecordTypeLeftHTop@WidthQHeightHintType of recordStylecsDropDownListFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ItemHeight
ParentFontParentShowHintShowHint	TabOrderOnChangecbRecordTypeChange  
TRangeEditedRecordNumLeftTopWidth� Height
OnKeyPressedRecordNumKeyPressAutoSizeText 1 / 1.00000001504746624E30 LoValue       ��?HiValue     ���b@LoLimit       ��?HiLimit     ���b@Scale       ��?NumberFormat%.0f / %.0f   	TGroupBoxAnalysisGrpLeftTopqWidth� Height�Caption	 Analyse Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbDoFitLeftTopWidthYHeightHintStart curve fittingCaptionDo FitFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbDoFitClick  TButtonbAbortLefthTopWidth1HeightHintAbort curve fittingCaptionAbortEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbAbortClick  TButtonbSetParametersLeftTop� Width� HeightHint;Set parameters as fixed/variable and initial fitting valuesCaptionSet ParametersFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbSetParametersClick  	TGroupBox
CursorsGrpLeftTop� Width� HeightyCaption Data Cursors Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel1LeftTopKWidth"HeightCaptionLimitsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  	TComboBoxcbDataLimitCursorsLeftTop2Width� HeightHint:Region of waveform selected for automatic cursor placementStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder Items.StringsOn RiseOn Decay
Rise+Decay   TRadioButtonrbManualCursorsLeftTopWidthYHeightHint&Fit data cursors to be placed manuallyCaptionManualChecked	ParentShowHintShowHint	TabOrderTabStop	  TRadioButtonrbAutoCursorsLeftTop WidthQHeightHint/Fitting data cursors to be placed automaticallyCaption	AutomaticTabOrder  
TRangeEditedLimitsLeftTopZWidth� HeightAutoSizeText 5.0-95.0 %LoValue     ����?HiValue     33��?HiLimit       ��?Scale       �@Units%NumberFormat	%.1f-%.1f   	TGroupBoxRangeGrpLeftTop<Width� Height� Caption	 Records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel7Left*TopzWidthHeight	AlignmenttaRightJustifyCaptionType  TLabelLabel6LeftTopZWidth/HeightCaptionChannel  TRadioButtonrbThisRecordLeftTop WidthaHeightHint3Do curve fit only on the currently displayed recordCaption This RecordChecked	ParentShowHintShowHint	TabOrder TabStop	  TRadioButtonrbRecordRangeLeftTop0WidthAHeightCaptionRangeParentShowHintShowHintTabOrder  	TComboBoxcbTypeToBeAnalysedLeftHTopxWidthAHeightHintUse only records of this typeStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder  	TComboBoxcbFitChannelLeft@TopZWidthIHeightHint"Channel selected for curve fittingStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrderOnChangecbFitChannelChangeItems.Strings    TRadioButtonrbAllRecordsLeftTopWidthQHeightHint"Do curve fit on all record in fileCaptionAll recordsParentShowHintShowHint	TabOrder  
TRangeEdit
edRecRangeLeftTop@WidthqHeightAutoSizeText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   	TComboBox
cbEquationLeftTop$Width� Height
ItemHeightTabOrderText
cbEquationOnChangecbEquationChange  TButtonbGetCursorsLeftTopoWidth� HeightCaptionGet CursorsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbGetCursorsClick   	TGroupBox
ResultsGrpLeft� TopWidth�Height� Caption	 Results TabOrder 	TRichEdit	erResultsLeftTopWidth�Height� Lines.Strings	erResults TabOrder    	TCheckBoxckFixedZeroLevelsLeft�Top� Width� HeightCaptionFix Zero LevelsFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickckFixedZeroLevelsClick   	TTabSheet	XYPlotTabCaptionX/Y Plot TXYPlotDisplayplPlotLeft� TopWidth�HeightIMaxPointsPerLine XAxisMax       ��?	XAxisTick     ����?XAxisLawaxLinear
XAxisLabelX AxisXAxisAutoRangeYAxisMax       ��?	YAxisTick     ����?YAxisLawaxLinear
YAxisLabelY AxisYAxisAutoRangeYAxisLabelAtTopScreenFontNameArialScreenFontSize
	LineWidth
MarkerSize	ShowLines	ShowMarkers	HistogramFullBordersHistogramFillColorclWhiteHistogramFillStylebsClearHistogramCumulativeHistogramPercentagePrinterFontSize
PrinterFontNameArialPrinterLineWidthPrinterMarkerSizePrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorMetafileWidth�MetafileHeight�  	TGroupBox	XYPlotGrpLeftTop Width� Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButton
bNewXYPlotLeftTopTWidth� HeightHintCreate a new X/Y plotCaptionNew PlotFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbNewXYPlotClick  	TGroupBoxXGroupLeftTop|Width� Height9Caption X Axis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TComboBoxcbXVariableLeftTopWidth� HeightHint Variable to be plotted on X axisStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder    	TGroupBoxYGroupLeftTop� Width� Height9Caption Y Axis Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TComboBoxcbYVariableLeftTopWidth� HeightHint Variable to be plotted on Y axisStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder    TButtonbSetPlotAxesLeftTophWidth� HeightHint"Change X & Y axes range and labelsCaptionSet AxesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbSetPlotAxesClick  	TGroupBox	GroupBox1LeftTop� Width� Height1Caption Filter records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbFilterLeftTopWidth� HeightCaptionFilterFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbFilterClick     	TTabSheetHistogramTabCaption	Histogram TXYPlotDisplayplHistLeft� TopWidth�Height1MaxPointsPerLine XAxisMax       ��?	XAxisTick     ����?XAxisLawaxLinear
XAxisLabelX AxisXAxisAutoRangeYAxisMax       ��?	YAxisTick     ����?YAxisLawaxLinear
YAxisLabelY AxisYAxisAutoRangeYAxisLabelAtTopScreenFontNameArialScreenFontSize
	LineWidth
MarkerSize
	ShowLines	ShowMarkers	HistogramFullBordersHistogramFillColorclWhiteHistogramFillStylebsClearHistogramCumulativeHistogramPercentagePrinterFontSize
PrinterFontNameArialPrinterLineWidthPrinterMarkerSizePrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorMetafileWidth�MetafileHeight�  	TGroupBoxHistGrpLeftTop Width� Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButtonbNewHistogramLeftTop\Width� HeightHintPlot a new histogramCaptionNew HistogramFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbNewHistogramClick  	TGroupBox	GroupBox3LeftTop� Width� Height� Caption Histogram  Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel11Left Top0Width;Height	AlignmenttaRightJustifyCaptionNo. of binsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel18LeftTopXWidth"Height	AlignmenttaRightJustifyCaptionLowerFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel19LeftToppWidth"Height	AlignmenttaRightJustifyCaptionUpperFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel8Left0TopHWidth%HeightCaptionRange  	TComboBoxcbHistVariableLeftTopWidth� HeightHint(Variable to be used to compile histogramStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbHistVariableChange  TValidatedEdit	edNumBinsLeft`Top0Width)HeightAutoSizeText 50 Value       �@Scale       ��?NumberFormat%.0fLoLimit       � @HiLimit       �@  TValidatedEdit	edHistMinLeft@TopXWidthIHeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@  TValidatedEdit	edHistMaxLeft@ToppWidthIHeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@  	TCheckBoxckPercentageLeftTop� WidthaHeightCaption
PercentageFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  	TCheckBoxckCumulativeLeftTop� WidthQHeightCaption
CumulativeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder   TButtonbSetHistAxesLeftToppWidth� HeightHintSet X & Y axis range and labelsCaptionSet AxesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickbSetHistAxesClick    	TTabSheet
SummaryTabCaptionSummary TStringGridSummaryLeft� TopWidth�Height9DefaultRowHeightFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder   	TGroupBox
SummaryGrpLeftTop Width� Height�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TGroupBoxVariablesGrpLeftTop`Width� Height� Hint#Variables to be included in summaryCaption Variables Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder  	TCheckBoxckVariable0LeftTopWidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrder OnClickckVariable0Click  	TCheckBoxckVariable1LeftTop WidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable2LeftTop0WidthaHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable3LeftTop@WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable4LeftTopPWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable5LeftTop`WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable6LeftToppWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable7LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBoxckVariable8LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder  	TCheckBoxckVariable9LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder	OnClickckVariable0Click  	TCheckBoxckVariable10LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder
OnClickckVariable0Click     	TTabSheet	TablesTabCaptionTables TStringGridTableLeft� TopWidth1HeightQColCountDefaultColWidthdDefaultRowHeight	FixedCols RowCount	FixedRowsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder OnMouseDownTableMouseDown	ColWidths\ddddddd   	TGroupBox	GroupBox2LeftTop Width� Height�Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbClearTableLeftTop�Width� HeightCaption
ClearTableFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder OnClickbClearTableClick  	TGroupBox
GroupBox11LeftTopPWidth� HeightiHint/Waveform measurements to be included in summaryCaption Variables Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrder 	TCheckBox	ckTabVar0LeftTopWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder OnClickckVariable0Click  	TCheckBox	ckTabVar1TagLeftTop WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar2TagLeftTop0WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar3TagLeftTop@WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar4LeftTopPWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar5LeftTop`WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar6LeftToppWidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar7LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar8LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrderOnClickckVariable0Click  	TCheckBox	ckTabVar9LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder	OnClickckVariable0Click  	TCheckBox
ckTabVar10LeftTop� WidthYHeightCaptionckVariable0Checked	State	cbCheckedTabOrder
OnClickckVariable0Click  TButtonbAddVariableLeftTop� Width� HeightCaptionAdd VariablesFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbAddVariableClick  TButtonbClearAllTableVariablesLeftTop� Width<HeightCaption	Clear AllFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbClearAllTableVariablesClick  TButtonbSetLeftTop� Width<HeightCaptionSet AllFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClick	bSetClick  	TGroupBox
BadFitsGrpLeftTopWidth}HeightPCaption
 Bad fits TabOrder TLabelLabel3Left	Top"WidthHHeightCaptionBad data flagFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  	TCheckBoxckIncludeBadFitsLeftTopWidthAHeightCaptionIncludeFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrder   TValidatedEditedBadFitFlagLeftTop2Width1HeightAutoSizeText 0.0 Scale       ��?NumberFormat%.1fLoLimit     ���b�HiLimit     ���b@    TButtonbSaveTableToFileLeftTop�Width� HeightCaptionSave to FileFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbSaveTableToFileClick     	TGroupBox
RecordsGrpLeftTop Width� HeightICaption	 Records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel12Left0Top.WidthHeight	AlignmenttaRightJustifyCaptionType  TEditedPlotRecTypeLeftPTop.Width9HeightAutoSizeReadOnly	TabOrder TextedRecordType  
TRangeEditedPlotRangeLeftTopWidth� Height
OnKeyPressedPlotRangeKeyPressAutoSizeText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   TSaveDialog
SaveDialogLeftTop(   