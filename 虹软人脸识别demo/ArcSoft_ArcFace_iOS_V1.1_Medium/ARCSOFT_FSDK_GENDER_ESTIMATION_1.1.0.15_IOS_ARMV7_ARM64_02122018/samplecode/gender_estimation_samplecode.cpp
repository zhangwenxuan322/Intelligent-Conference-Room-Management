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
#import <arcsoft_fsdk_gender_estimation/arcsoft_fsdk_gender_estimation.h>

#include <stdlib.h>


#define ARC_APP_ID                  ""
#define ARC_GENDER_SDK_KEY          ""
#define ARC_GENDER_MAX_FACE_NUM     5
#define ARC_GENDER_MEM_SIZE         1024*1024*30

MRESULT doGenderEstimation()
{
    // init
    MVoid* pMemBuffer = MMemAlloc(MNull, ARC_GENDER_MEM_SIZE);
    MHandle hEngine = MNull;
    MRESULT mr = ASGE_FSDK_InitGenderEngine((MPChar)ARC_APP_ID, (MPChar)ARC_GENDER_SDK_KEY, (MByte*)pMemBuffer, ARC_GENDER_MEM_SIZE, &hEngine);
    if (MOK != mr) {
        // check the error code
    }
    
    ASGE_FSDK_GENDERFACEINPUT genderFaceInput = {0};
    genderFaceInput.lFaceNumber = 0;
    genderFaceInput.pFaceRectArray = (MRECT *)MMemAlloc(MNull, sizeof(MRECT)*ARC_GENDER_MAX_FACE_NUM);
    genderFaceInput.pFaceOrientArray = (MInt32 *)MMemAlloc(MNull, sizeof(MInt32)*ARC_GENDER_MAX_FACE_NUM);
    
    // estimation
    ASVLOFFSCREEN offScreenIn = {0};                  // image data, replaced with your data
    offScreenIn.u32PixelArrayFormat = ASVL_PAF_NV12;  // image format
    offScreenIn.i32Width = 1280;                      // image width
    offScreenIn.i32Height = 720;                      // image height
    offScreenIn.pi32Pitch[0] = offScreenIn.i32Width;  // pitch of plane 0, may not be equal to width
    offScreenIn.pi32Pitch[1] = offScreenIn.i32Width;  // pitch of plane 1, may not be equal to width
    offScreenIn.ppu8Plane[0] = MNull;                 // data address of plane 0
    offScreenIn.ppu8Plane[1] = MNull;                 // data address of plane 1
    
    genderFaceInput.lFaceNumber = 1;                  // set face number from face detection or face tracking result
    //genderFaceInput.pFaceRectArray                  // set face rect array from face detection or face tracking result
    //genderFaceInput.pFaceOrientArray                // set face orient array from face detection or face tracking result
    
    ASGE_FSDK_GENDERRESULT genderResult = {0};
    MBool previewData = MTrue;                         // do preview data or static data gender estimation
    if(previewData)
        mr = ASGE_FSDK_GenderEstimation_Preview(hEngine, &offScreenIn, &genderFaceInput, &genderResult);
    else
        mr = ASGE_FSDK_GenderEstimation_StaticImage(hEngine, &offScreenIn, &genderFaceInput, &genderResult);
    
    // unit
    if (genderFaceInput.pFaceRectArray)
    {
        MMemFree(MNull, genderFaceInput.pFaceRectArray);
        genderFaceInput.pFaceRectArray = MNull;
    }
    if (genderFaceInput.pFaceOrientArray)
    {
        MMemFree(MNull, genderFaceInput.pFaceOrientArray);
        genderFaceInput.pFaceOrientArray = MNull;
    }
    mr = ASGE_FSDK_UninitGenderEngine(hEngine);
    if(pMemBuffer != MNull)
    {
        MMemFree(MNull,pMemBuffer);
        pMemBuffer = MNull;
    }
    
    return mr;
}
