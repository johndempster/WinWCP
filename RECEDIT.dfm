�
 TEDITFRM 0!  TPF0TEditFrmEditFrmLeftQTop� WidthHeight�Caption Edit RecordColor	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.Style 	FormStyle
fsMDIChild
KeyPreview	OldCreateOrder	PositionpoScreenCenterVisible	
OnActivateFormActivateOnClose	FormClose	OnKeyDownFormKeyDownOnResize
FormResizeOnShowFormShowPixelsPerInch`
TextHeight TScopeDisplay	scDisplayLeft� TopWidth1Height� 	OnMouseUpscDisplayMouseUpOnCursorChangescDisplayCursorChangeCursorChangeInProgressNumChannels	NumPoints	MaxPoints XMin XMax�XOffset CursorsEnabled	TScale       ��?TUnitssTCalBar       ���ZoomDisableHorizontalZoomDisableVerticalDisableChannelVisibilityButtonPrinterFontSize PrinterPenWidth PrinterLeftMargin PrinterRightMargin PrinterTopMargin PrinterBottomMargin PrinterDisableColorPrinterShowLabels	PrinterShowZeroLevels	MetafileWidth MetafileHeight StorageModeRecordNumber�DisplayGrid	MaxADCValue�MinADCValue �NumBytesPerSampleFixZeroLevelsDisplaySelectedFontSize  	TGroupBox	RecordGrpLeftTop Width� Height� Caption Record Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TLabelLabel2LeftTop`WidthHeight	AlignmenttaRightJustifyCaptionTypeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel1Left%Top|WidthHeight	AlignmenttaRightJustifyCaptionTime  TLabelGroupLeftTop� Width"Height	AlignmenttaRightJustifyCaptionGroup  TLabelLabel3LeftTop� Width;Height	AlignmenttaRightJustifyCaption	A/D RangeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel7Left
Top� Width7Height	AlignmenttaRightJustifyCaption
Samp. Int.WordWrap	  TLabelLabel4LeftTop@WidthHeight	AlignmenttaRightJustifyCaptionCh.  	TComboBoxcbRecordTypeLeft@Top`WidthQHeightHintRecord typeStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder OnChangecbRecordTypeChange  	TCheckBoxckBadRecordLeftTop� WidthQHeightHint+Rejected records are excluded from analysisCaptionRejectedParentShowHintShowHint	TabOrderOnClickckBadRecordClick  
TScrollBarsbRecordNumLeftTop(Width� HeightPageSize TabOrderOnChangesbRecordNumChange  TValidatedEditedADCVoltageRangeLeftXTop� Width9Height
OnKeyPressedADCVoltageRangeKeyPressAutoSizeText 0 VScale       ��?UnitsVNumberFormat%.5gLoLimit     ���b�HiLimit     ���b@  TValidatedEditedGroupLeftHTop� WidthIHeight
OnKeyPressedGroupKeyPressAutoSizeText 0 Scale       ��?NumberFormat%.0fLoLimit     ���b�HiLimit     ���b@  TValidatedEditedTimeLeftHTop|WidthIHeightAutoSizeText 0 Scale       ��?NumberFormat%.4gLoLimit     ���b�HiLimit     ���b@  
TRangeEditedRecordNumLeftTopWidth� Height
OnKeyPressedRecordNumKeyPressText 1 / 1.00000001504746624E30 LoValue       ��?HiValue     ���b@LoLimit       ��?HiLimit     ���b@Scale       ��?NumberFormat%.0f / %.0f  TValidatedEditedSamplingIntervalLeftHTop� WidthIHeight
OnKeyPressedGroupKeyPressAutoSizeText
 1E-027 msValue     `B��?Scale       �@UnitsmsNumberFormat%.3gLoLimit     `B��?HiLimit     ���b@  	TComboBox	cbChannelLeft0Top@WidthaHeightHintChannel to be editedStylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrderOnChangecbChannelChange   	TGroupBoxEditGrpLeftTop� Width�Height� Caption Edit Options Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder 	TGroupBoxHorGrpLeft� TopWidth� Height)Caption	 X Shift Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder  TButtonbLeftLeftTopWidthHeightHintShift signal to the leftCaption   � Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.Name	Wingdings
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClick
bLeftClick  TButtonButton1Left� TopWidthHeightHintShift signal to the rightCaption   � Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.Name	Wingdings
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClickButton1Click  TValidatedEditedXShiftLeft(TopWidthYHeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@   	TGroupBoxVertGrpLeft� Top8Width� Height)Caption	 Y Shift Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbUpLeftTopWidthHeightHintShift signal level upCaption   � Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.Name	Wingdings
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbUpClick  TButtonbDownLeft� TopWidthHeightHintShift signal level downCaption   � Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.Name	Wingdings
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrderOnClick
bDownClick  TValidatedEditedYShiftLeft(TopWidthYHeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@   	TGroupBox	YScaleGrpLeft� Top`Width� Height)Caption	 Y Scale Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TButtonbScaleLeftTopWidth;HeightHintScale signal CaptionScale byFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontParentShowHintShowHint	TabOrder OnClickbScaleClick  TValidatedEditedYScaleLeftHTopWidth9HeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@   	TGroupBox	GroupBox8LeftTopWidth� HeightYTabOrder TRadioButtonrbAllRecordsLeftTopWidthQHeightHint$Analysis all record in the data fileCaptionAll recordsParentShowHintShowHint	TabOrder   TRadioButtonrbThisRecordLeftTopWidthQHeightHint+Analyse the currently displayed record onlyCaptionThis recordChecked	ParentShowHintShowHint	TabOrderTabStop	  TRadioButtonrbRangeLeftTop(WidthQHeightHint8Analysis a limited range of records within the data fileCaptionRangeParentShowHintShowHint	TabOrder  
TRangeEdit
edRecRangeLeftTop8WidthiHeightAutoSizeText 0 - 1.00000001504746624E30 HiValue     ���b@HiLimit     ���b@Scale       ��?NumberFormat	%.f - %.f   	TGroupBox	GroupBox1LeftHTopWidth� HeightyCaption Artefact Removal  Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrder TLabelLabel6LeftTopWidth[HeightCaptionSelected RegionFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFont  TLabelLabel5LeftTop<WidthHeightCaptionBlank ValueFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontWordWrap	  TValidatedEdit
edSetValueLeft0Top=WidthIHeightAutoSizeText 0 Scale       ��?NumberFormat%.3gLoLimit     ���b�HiLimit     ���b@  
TRangeEditedRegionLeftTop WidthqHeight
OnKeyPressedRegionKeyPressAutoSizeText 1 - 1 LoValue       ��?HiValue       ��?HiLimit     ���b@Scale       ��?NumberFormat%.3g - %.3g  TButton
bSetRegionLeftTop`WidthqHeightCaptionRemove ArtefactFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickbSetRegionClick   TButtonbUndoLeftToppWidth� HeightCaptionUndoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClick
bUndoClick   	TCheckBoxckFixedZeroLevelsLeft� Top� WidthfHeightCaptionFix Zero LevelsFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickckFixedZeroLevelsClick   