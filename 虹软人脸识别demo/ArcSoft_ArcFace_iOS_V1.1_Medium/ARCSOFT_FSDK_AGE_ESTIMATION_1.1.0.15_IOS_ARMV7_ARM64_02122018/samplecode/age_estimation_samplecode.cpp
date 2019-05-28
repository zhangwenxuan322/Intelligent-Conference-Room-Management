/*******************************************************************************
 Copyright(c) ArcSoft, All right reserved.
 
 This file is ArcSoft's property. It contains ArcSoft's trade secret, proprietary
 and confidential information.
 
 The information and code contained in this file is only for authorized ArcSoft
 employees to design, create, modify, or review.
 
 DO NOT DISTRIBUTE, DO NOT DUPLICATE OR TRANSMIT IN ANY FORM WITHOUT PROPER
 AUTHORIZATION.
 
 If you are not an intended recipient of this file, you must not copy,
 distribute, modify, or take any action in reliance on it.
 
 If you have received this file in error, please immediately notify ArcSoft and
 permanently delete the original and any copy of any file and any printout
 thereof.
 *******************************************************************************/

#include "ammem.h"
#include "merror.h"
#import <arcsoft_fsdk_age_estimation/arcsoft_fsdk_age_estimation.h>

#include <stdlib.h>


#define ARC_APP_ID               ""
#define ARC_AGE_SDK_KEY          ""
#define ARC_AGE_MAX_FACE_NUM     5
#define ARC_AGE_MEM_SIZE         1024*1024*30

MRESULT doAgeEstimation()
{
    // init
    MVoid* pMemBuffer = MMemAlloc(MNull, ARC_AGE_MEM_SIZE);
    MHandle hEngine = MNull;
    MRESULT mr = ASAE_FSDK_InitAgeEngine((MPChar)ARC_APP_ID, (MPChar)ARC_AGE_SDK_KEY, (MByte*)pMemBuffer, ARC_AGE_MEM_SIZE, &hEngine);
    if (MOK != mr) {
        // check the error code
    }
    
    ASAE_FSDK_AGEFACEINPUT ageFaceInput = {0};
    ageFaceInput.lFaceNumber = 0;
    ageFaceInput.pFaceRectArray = (MRECT *)MMemAlloc(MNull, sizeof(MRECT)*ARC_AGE_MAX_FACE_NUM);
    ageFaceInput.pFaceOrientArray = (MInt32 *)MMemAlloc(MNull, sizeof(MInt32)*ARC_AGE_MAX_FACE_NUM);
    
    // estimation
    ASVLOFFSCREEN offScreenIn = {0};                  // image data, replaced with your data
    offScreenIn.u32PixelArrayFormat = ASVL_PAF_NV12;  // image format
    offScreenIn.i32Width = 1280;                      // image width
    offScreenIn.i32Height = 720;                      // image height
    offScreenIn.pi32Pitch[0] = offScreenIn.i32Width;  // pitch of plane 0, may not be equal to width
    offScreenIn.pi32Pitch[1] = offScreenIn.i32Width;  // pitch of plane 1, may not be equal to width
    offScreenIn.ppu8Plane[0] = MNull;                 // data address of plane 0
    offScreenIn.ppu8Plane[1] = MNull;                 // data address of plane 1
    
    ageFaceInput.lFaceNumber = 1;                     // set face number from face detection or face tracking result
    //ageFaceInput.pFaceRectArray                     // set face rect array from face detection or face tracking result
    //ageFaceInput.pFaceOrientArray                   // set face orient array from face detection or face tracking result
    
    ASAE_FSDK_AGERESULT ageResult = {0};
    MBool previewData = MTrue;                         // do preview data or static data age estimation
    if(previewData)
        mr = ASAE_FSDK_AgeEstimation_Preview(hEngine, &offScreenIn, &ageFaceInput, &ageResult);
    else
        mr = ASAE_FSDK_AgeEstimation_StaticImage(hEngine, &offScreenIn, &ageFaceInput, &ageResult);
    
    // unit
    if (ageFaceInput.pFaceRectArray)
    {
        MMemFree(MNull, ageFaceInput.pFaceRectArray);
        ageFaceInput.pFaceRectArray = MNull;
    }
    if (ageFaceInput.pFaceOrientArray)
    {
        MMemFree(MNull, ageFaceInput.pFaceOrientArray);
        ageFaceInput.pFaceOrientArray = MNull;
    }
    mr = ASAE_FSDK_UninitAgeEngine(hEngine);
    if(pMemBuffer != MNull)
    {
        MMemFree(MNull,pMemBuffer);
        pMemBuffer = MNull;
    }
    
    return mr;
}
