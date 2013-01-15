�
 TLEAKSUBFRM 0�  TPF0TLeakSubFrm
LeakSubFrmLeft�Top� WidthzHeight�CaptionLeak current subtractionColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChild
KeyPreview	OldCreateOrder	PositionpoScreenCenterVisible	
OnActivateFormActivateOnClose	FormClose	OnKeyDownFormKeyDownOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight TScopeDisplay	scDisplayLeft� TopWidth�Height� 	OnMouseUpscDisplayMouseUpOnCursorChangescDisplayCursorChangeCursorChangeInProgressNumChannels	NumPoints	MaxPoints XMin XMax�XOffset CursorsEnabled	TScale       ��?TUnitssTCalBar       ���ZoomDisableHorizontalZoomDisableVerticalDisableChannelVisibilityButtonPrinterFontSize PrinterPenWidth PrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorPrinterShowLabels	PrinterShowZeroLevels	MetafileWidth MetafileHeight StorageModeRecordNumber�DisplayGrid	MaxADCValue�MinADCValue �NumBytesPerSampleFixZeroLevelsDisplaySelectedFontSize  	TGroupBox	RecordGrpLeftTopWidth� Height� Caption RecordFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TLabelLabel2LeftTop@WidthHeightCaptionTypeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel3LeftTopXWidth"HeightCaptionGroup  	TComboBoxcbRecordTypeLeft8Top@WidthAHeightHintType of recordStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbRecordTypeChange  	TCheckBoxckBadRecordLeftToppWidthQHeightHint7Rejected records are excluded from the leak subtractionCaptionRejectedParentShowHintShowHint	TabOrderOnClickckBadRecordClick  
TScrollBarsbRecordNumLeftTop(WidthqHeightHintMove slider to display recordsPageSize ParentShowHintShowHint	TabOrderOnChangesbRecordNumChange  TValidatedEditedGroupLeft8TopXWidthAHeightText 0 Scale       ��?NumberFormat%gLoLimit     ���b�HiLimit     ���b@  
TRangeEditedRecordNumLeftTopWidthqHeightAutoSizeText 0 / 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat%.0f / %.0f   	TGroupBoxAnalysisGrpLeftTop� Width� Height� Caption	 Average Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel1LeftTop@WidthXHeightCaptionVoltage channelFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel6LeftTophWidthXHeightCaptionCurrent channelFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel5LeftTop� Width%HeightCaptionRangeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TButtonbDoSubtractionLeftTopWidthqHeightHintStart leak subtractionCaptionDo SubtractionFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbDoSubtractionClick  TButtonbAbortLeftTop(Width1HeightHintAbort leak subtractionCaptionAbortEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbAbortClick  	TComboBox	cbVoltageLeftTopPWidthqHeightHint7Input channel containing cell membrane potential signalStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrderOnChangecbVoltageChange  	TComboBox	cbCurrentLeftTopxWidthqHeightHint5Input channel containing cell membrane current signalStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrderOnChangecbCurrentChange  
TRangeEditedRangeLeft8Top� WidthAHeightAutoSizeText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   	TGroupBoxModeGrpLeft� TopWidth� HeightICaption Leak records Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TRadioButtonrbGroupModeLeftTopWidthYHeightHint@Use when each recording group has its own leak current record(s)Caption
From groupChecked	ParentShowHintShowHint	TabOrder TabStop	OnClickrbGroupModeClick  TRadioButton
rbFileModeLeftTop WidthiHeightHint?Use when leak current records are separate from recording groupCaptionFrom whole fileParentShowHintShowHint	TabOrderOnClickrbFileModeClick  	TCheckBoxckSaveLeaksLeftTop.WidthyHeightCaptionSave Leak recordsTabOrder   	TGroupBox
ScalingGrpLeft TopWidthqHeightICaption	 Scaling Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TRadioButtonrbAutoScalingLeftTopWidthaHeightHint:Calculate leak current scaling factor from voltage channelCaption From voltageChecked	ParentShowHintShowHint	TabOrder TabStop	OnClickrbAutoScalingClick  TRadioButtonrbFixedScalingLeftTop"Width9HeightHint'Use a fixed leak current scaling factorCaptionFixedParentShowHintShowHint	TabOrderOnClickrbFixedScalingClick  TValidatedEditedIScaleLeft:Top$Width'HeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@   	TGroupBoxSubtractGrpLeft�TopWidthyHeightJCaption
 Subtract Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TRadioButtonrbSubtractWholeLeakCurrentLeftTopWidthaHeightHint;Subtract both ionic and capacity components of leak currentCaptionI(cap) + I(leak)Checked	ParentShowHintShowHint	TabOrder TabStop	  TRadioButtonrbSubtractILeakOnlyLeftTop"WidthiHeightHint-Subtract ionic component of leak current onlyCaptionI(leak)ParentShowHintShowHint	TabOrder   	TCheckBoxckFixedZeroLevelsLeft� Top� WidthfHeightCaptionFix Zero LevelsFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickckFixedZeroLevelsClick   