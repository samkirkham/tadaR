#' Converts nested tibble created by readTADA to unnested columns for each articulatory variable
#'
#' @description Unnests readTADA object into long format
#' Note that the audio signal is excluded from this object due to a different sampling rate (see getAudioLong function to unnest audio object)
#' see TADA manual for what each abbreviation corresponds to: https://sail.usc.edu/~lgoldste/ArtPhon/TADA%20stuff/TADA_manual_v09.pdf
#' @param d tibble produced by readTADA function
#' @return long format tibble with one column per tract variable

unnestTADA <- function(d){
  tibble::tibble(
    Sample = 1:nrow(d$TBCL$SIGNAL),
    Time = Sample/200,
    UL = d$UL$SIGNAL[,2], LL = d$LL$SIGNAL[,2], JAW = d$JAW$SIGNAL[,2], TT = d$TT$SIGNAL[,2],
    TF = d$TF$SIGNAL[,2], TD = d$TD$SIGNAL[,2], TR = d$TR$SIGNAL[,2], LX = d$LX$SIGNAL[,1],
    JA = d$JA$SIGNAL[,1], CL = d$CL$SIGNAL[,1], CA = d$CA$SIGNAL[,1], GW = d$GW$SIGNAL[,1],
    TL = d$TL$SIGNAL[,1], TA = d$TA$SIGNAL[,1], F0a = d$F0a$SIGNAL[,1], PIa = d$PIa$SIGNAL[,1],
    SPIa = d$SPIa$SIGNAL[,1], HX = d$HX$SIGNAL[,1], LX_vl = d$LX_vl$SIGNAL[,1],
    JA_vl = d$JA_vl$SIGNAL[,1], UY_vl = d$UY_vl$SIGNAL[,1], LY_vl = d$LY_vl$SIGNAL[,1],
    CL_vl = d$CL_vl$SIGNAL[,1], CA_vl = d$CA_vl$SIGNAL[,1], NA_vl = d$NA_vl$SIGNAL[,1],
    GW_vl = d$GW_vl$SIGNAL[,1], TL_vl = d$TL_vl$SIGNAL[,1], TA_vl = d$TA_vl$SIGNAL[,1],
    F0a_vl = d$F0a_vl$SIGNAL[,1], PIa_vl = d$PIa_vl$SIGNAL[,1], SPIa_vl = d$SPIa_vl$SIGNAL[,1],
    HX_vl = d$HX_vl$SIGNAL[,1], PRO = d$PRO$SIGNAL[,1], LA = d$LA$SIGNAL[,1],
    TBCL = d$TBCL$SIGNAL[,1], TBCD = d$TBCD$SIGNAL[,1], VEL = d$VEL$SIGNAL[,1],
    GLO = d$GLO$SIGNAL[,1], TTCL = d$TTCL$SIGNAL[,1], TTCD = d$TTCD$SIGNAL[,1],
    TTCR = d$TTCR$SIGNAL[,1], F0 = d$F0$SIGNAL[,1], PI = d$PI$SIGNAL[,1],
    SPI = d$SPI$SIGNAL[,1], TRt = d$TRt$SIGNAL[,1], gPRO = d$gPRO$SIGNAL[,1],
    gLA = d$gLA$SIGNAL[,1], gTBCL = d$gTBCL$SIGNAL[,1], gTBCD = d$gTBCD$SIGNAL[,1],
    gVEL = d$gVEL$SIGNAL[,1], gGLO = d$gGLO$SIGNAL[,1], gTTCL = d$gTTCL$SIGNAL[,1],
    gTTCD = d$gTTCD$SIGNAL[,1], gTTCR = d$gTTCR$SIGNAL[,1], gF0 = d$gF0$SIGNAL[,1],
    gPI = d$gPI$SIGNAL[,1], gSPI = d$gSPI$SIGNAL[,1], gTR = d$gTR$SIGNAL[,1]
  )
}
