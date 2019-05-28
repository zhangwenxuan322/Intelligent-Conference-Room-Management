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
#import <arcsoft_fsdk_face_tracking/arcsoft_fsdk_face_tracking.h>

#include <stdlib.h>


#define ARC_APP_ID              ""
#define ARC_FT_SDK_KEY          ""
#define ARC_FT_MAX_FACE_NUM     5
#define ARC_FT_MEM_SIZE         1024*1024*5

MRESULT doFaceTracking()
{
    // init
    MVoid* pMemBuffer = MMemAlloc(MNull, ARC_FT_MEM_SIZE);
    MHandle hEngine = MNull;
    MRESULT mr = AFT_FSDK_InitialFaceEngine((MPChar)ARC_APP_ID, (MPChar)ARC_FT_SDK_KEY, (MByte*)pMemBuffer, ARC_FT_MEM_SIZE, &hEngine, AFT_FSDK_OPF_0_HIGHER_EXT, 16, ARC_FT_MAX_FACE_NUM);
    if (MOK != mr) {
        // check the error code
    }
    
    // tracking face on video frame
    do {
        ASVLOFFSCREEN offScreenIn = {0};                  // video frame data, replaced with your data
        offScreenIn.u32PixelArrayFormat = ASVL_PAF_NV12;  // data format
        offScreenIn.i32Width = 1280;                      // frame width
        offScreenIn.i32Height = 720;                      // frame height
        offScreenIn.pi32Pitch[0] = offScreenIn.i32Width;  // pitch of plane 0, may not be equal to width
        offScreenIn.pi32Pitch[1] = offScreenIn.i32Width;  // pitch of plane 1, may not be equal to width
        offScreenIn.ppu8Plane[0] = MNull;                 // data address of plane 0
        offScreenIn.ppu8Plane[1] = MNull;                 // data address of plane 1
        
        LPAFT_FSDK_FACERES pFaceRes = MNull;
        mr = AFT_FSDK_FaceFeatureDetect(hEngine, &offScreenIn, &pFaceRes);
    } while (MFalse);
    
    // uninit
    mr = AFT_FSDK_UninitialFaceEngine(hEngine);
    if(pMemBuffer != MNull)
    {
        MMemFree(MNull,pMemBuffer);
        pMemBuffer = MNull;
    }
    
    return mr;
}
