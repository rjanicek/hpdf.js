#!/bin/bash
set -e -x

EMSCRIPTEN=emscripten
EMCC=$EMSCRIPTEN/emcc
CFLAGS=
COFFEE=/usr/bin/coffee
INCLUDES="./zlib/*.c \
  ./libpng/png.c \
  ./libpng/pngerror.c \
  ./libpng/pngget.c \
  ./libpng/pngmem.c \
  ./libpng/pngpread.c \
  ./libpng/pngread.c \
  ./libpng/pngrio.c \
  ./libpng/pngrtran.c \
  ./libpng/pngrutil.c \
  ./libpng/pngset.c \
  ./libpng/pngtrans.c \
  ./libpng/pngwio.c \
  ./libpng/pngwrite.c \
  ./libpng/pngwtran.c \
  ./libpng/pngwutil.c \
  ./libharu/src/*.c \
  -I./libharu/include \
  -I./libpng \
  -I$EMSCRIPTEN/system/include/emscripten main.c"


$COFFEE -c post.coffee

EXPORTED_FUNCTIONS="['_HPDF_AddPage','_HPDF_Annot_SetBorderStyle','_HPDF_CreateExtGState','_HPDF_CreateOutline','_HPDF_Destination_SetXYZ','_HPDF_ExtGState_SetAlphaFill','_HPDF_ExtGState_SetAlphaStroke','_HPDF_ExtGState_SetBlendMode','_HPDF_Font_GetFontName','_HPDF_Free','_HPDF_GetCurrentPage','_HPDF_GetEncoder','_HPDF_GetError','_HPDF_GetFont','_HPDF_GetVersion','_HPDF_Image_GetHeight','_HPDF_Image_GetWidth','_HPDF_LinkAnnot_SetBorderStyle','_HPDF_LinkAnnot_SetHighlightMode','_HPDF_LoadJpegImageFromFile','_HPDF_LoadPngImageFromFile','_HPDF_LoadRawImageFromFile','_HPDF_LoadTTFontFromFile','_HPDF_LoadType1FontFromFile','_HPDF_New','_HPDF_Outline_SetDestination','_HPDF_Outline_SetOpened','_HPDF_Page_Arc','_HPDF_Page_BeginText','_HPDF_Page_Circle','_HPDF_Page_Clip','_HPDF_Page_ClosePathFillStroke','_HPDF_Page_Concat','_HPDF_Page_CreateDestination','_HPDF_Page_CreateLinkAnnot','_HPDF_Page_CreateTextAnnot','_HPDF_Page_CreateURILinkAnnot','_HPDF_Page_CurveTo','_HPDF_Page_CurveTo2','_HPDF_Page_CurveTo3','_HPDF_Page_DrawImage','_HPDF_Page_EndText','_HPDF_Page_Fill','_HPDF_Page_FillStroke','_HPDF_Page_GetCurrentPos','_HPDF_Page_GetCurrentTextPos','_HPDF_Page_GetHeight','_HPDF_Page_GetLineWidth','_HPDF_Page_GetTextMatrix','_HPDF_Page_GetWidth','_HPDF_Page_GRestore','_HPDF_Page_GSave','_HPDF_Page_LineTo','_HPDF_Page_MoveTextPos','_HPDF_Page_MoveTo','_HPDF_Page_MoveToNextLine','_HPDF_Page_Rectangle','_HPDF_Page_SetDash','_HPDF_Page_SetExtGState','_HPDF_Page_SetFillRGB','_HPDF_Page_SetFontAndSize','_HPDF_Page_SetGrayFill','_HPDF_Page_SetGrayStroke','_HPDF_Page_SetHeight','_HPDF_Page_SetLineCap','_HPDF_Page_SetLineJoin','_HPDF_Page_SetLineWidth','_HPDF_Page_SetRGBFill','_HPDF_Page_SetRGBStroke','_HPDF_Page_SetSize','_HPDF_Page_SetTextLeading','_HPDF_Page_SetTextMatrix','_HPDF_Page_SetWidth','_HPDF_Page_ShowText','_HPDF_Page_ShowTextNextLine','_HPDF_Page_Stroke','_HPDF_Page_TextOut','_HPDF_Page_TextRect','_HPDF_Page_TextWidth','_HPDF_SaveToFile','_HPDF_SetCompressionMode','_HPDF_SetCurrentEncoder','_HPDF_SetOpenAction','_HPDF_SetPageMode','_HPDF_SetPassword','_HPDF_TextAnnot_SetIcon','_HPDF_TextAnnot_SetOpened','_HPDF_UseJPEncodings','_HPDF_UseJPFonts']"

$EMCC -O2 $CFLAGS \
  -D 'HPDF_EXPORT(type)=__attribute__((used)) type' \
  $INCLUDES --post-js post.js -o hpdf.js -s TOTAL_MEMORY=536870912 -s EXPORTED_FUNCTIONS=$EXPORTED_FUNCTIONS
