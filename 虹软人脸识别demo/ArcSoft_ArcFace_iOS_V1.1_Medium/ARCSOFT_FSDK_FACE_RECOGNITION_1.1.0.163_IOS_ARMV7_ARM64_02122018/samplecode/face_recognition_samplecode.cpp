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
#import <arcsoft_fsdk_face_recognition/arcsoft_fsdk_face_recognition.h>

#include <stdlib.h>
#include <string.h>


#define ARC_APP_ID                            ""                  
#define ARC_FR_SDK_KEY                        ""
#define ARC_FR_MEM_SIZE                       1024*1024*40

#define ARC_FR_MAX_FEATURE_COUNT_PER_PERSON      5
#define ARC_FR_SCORE_THRESHOLD                   (0.56f)

typedef struct
{
    MInt32 lFeatureSize;		// The size of feature in bytes
    MByte *pbFeature;		// The extracted face feature
}AFR_FSDK_FACEDATA, *LPAFR_FSDK_FACEDATA;

typedef struct
{
    MLong lPersonID;
    MChar szPersonName[128];
    AFR_FSDK_FACEDATA* pFaceFeatureArray;
    MInt32               nFeatureCount;
}AFR_FSDK_PERSON, *LPAFR_FSDK_PERSON;

MRESULT detectFace(LPASVLOFFSCREEN pOff, AFR_FSDK_FACEINPUT* pFaceInput)
{
    // detect face using face tracking or face detection
    return MOK;
}

MRESULT addPersonToDB(LPAFR_FSDK_PERSON person)
{
    return  MOK;
}

MRESULT loadPersonsFromDB(LPAFR_FSDK_PERSON* persons, MLong* pPersonCount)
{
    return MOK;
}


MRESULT doRegister()
{
    // init
    MVoid* pMemBuffer = MMemAlloc(MNull, ARC_FR_MEM_SIZE);
    MHandle hEngine = MNull;
    MRESULT mr = AFR_FSDK_InitialEngine((MPChar)ARC_APP_ID, (MPChar)ARC_FR_SDK_KEY, (MByte*)pMemBuffer, ARC_FR_MEM_SIZE, &hEngine);
    if (MOK != mr) {
        // check the error code
    }
    
    // register
    do {
        ASVLOFFSCREEN offScreenIn = {0};                  // image data, replaced with your data
        offScreenIn.u32PixelArrayFormat = ASVL_PAF_NV12;  // data format
        offScreenIn.i32Width = 1280;                      // image width
        offScreenIn.i32Height = 720;                      // image height
        offScreenIn.pi32Pitch[0] = offScreenIn.i32Width;  // pitch of plane 0, may not be equal to width
        offScreenIn.pi32Pitch[1] = offScreenIn.i32Width;  // pitch of plane 1, may not be equal to width
        offScreenIn.ppu8Plane[0] = MNull;                 // data address of plane 0
        offScreenIn.ppu8Plane[1] = MNull;                 // data address of plane 1
        
        // get face information using face tracking or face detection
        AFR_FSDK_FACEINPUT faceInput = {0};
        mr = detectFace(&offScreenIn, &faceInput);
        if (MOK != mr) // no face detected, one face in image is recommended
        {
            continue;
        }
        
        AFR_FSDK_FACEMODEL faceModel = {0};
        mr = AFR_FSDK_ExtractFRFeature(hEngine, &offScreenIn, &faceInput, &faceModel);
        if (MOK != mr)
        {
            continue;
        }
        
        AFR_FSDK_FACEDATA featureData = {0};
        featureData.lFeatureSize = faceModel.lFeatureSize;
        featureData.pbFeature = (MByte*)MMemAlloc(MNull, featureData.lFeatureSize);
        MMemCpy(featureData.pbFeature, faceModel.pbFeature, featureData.lFeatureSize);
        
        AFR_FSDK_PERSON person = {0};
        person.lPersonID = 330; // input id
        strncpy(person.szPersonName , "Jack", strlen("Jack")); // input name
        person.nFeatureCount = 1;
        person.pFaceFeatureArray = (AFR_FSDK_FACEDATA*)MMemAlloc(MNull, sizeof(AFR_FSDK_FACEDATA) * person.nFeatureCount);
        person.pFaceFeatureArray[0] = featureData;
        
        addPersonToDB(&person);
        
      } while (MFalse);
    
    // uninit
    mr = AFR_FSDK_UninitialEngine(hEngine);
    if(pMemBuffer != MNull)
    {
        MMemFree(MNull,pMemBuffer);
        pMemBuffer = MNull;
    }
    
    return mr;
}


MRESULT doRecognition()
{
    // init
    MVoid* pMemBuffer = MMemAlloc(MNull, ARC_FR_MEM_SIZE);
    MHandle hEngine = MNull;
    MRESULT mr = AFR_FSDK_InitialEngine((MPChar)ARC_APP_ID, (MPChar)ARC_FR_SDK_KEY, (MByte*)pMemBuffer, ARC_FR_MEM_SIZE, &hEngine);
    if (MOK != mr) {
        // check the error code
    }
    
    // recognize
    do {
        ASVLOFFSCREEN offScreenIn = {0};                  // image data, replaced with your data
        offScreenIn.u32PixelArrayFormat = ASVL_PAF_NV12;  // data format
        offScreenIn.i32Width = 1280;                      // image width
        offScreenIn.i32Height = 720;                      // image height
        offScreenIn.pi32Pitch[0] = offScreenIn.i32Width;  // pitch of plane 0, may not be equal to width
        offScreenIn.pi32Pitch[1] = offScreenIn.i32Width;  // pitch of plane 1, may not be equal to width
        offScreenIn.ppu8Plane[0] = MNull;                 // data address of plane 0
        offScreenIn.ppu8Plane[1] = MNull;                 // data address of plane 1
        
        // get face information using face tracking or face detection
        AFR_FSDK_FACEINPUT faceInput = {0};
        mr = detectFace(&offScreenIn, &faceInput);
        if (MOK != mr) // no face detected, one face in image is recommended
        {
            continue;
        }
        
        AFR_FSDK_FACEMODEL faceModel = {0};
        mr = AFR_FSDK_ExtractFRFeature(hEngine, &offScreenIn, &faceInput, &faceModel);
        if (MOK != mr)
        {
            continue;
        }
        
        AFR_FSDK_FACEMODEL probeFaceModel = faceModel;
        
        AFR_FSDK_PERSON personRecognized = {0};
        MFloat fMaxScore = 0;
        
        LPAFR_FSDK_PERSON persons = MNull;
        MLong lPersonCount = 0;
        loadPersonsFromDB(&persons, &lPersonCount);
        for (int i = 0; i < lPersonCount; ++i)
        {
            AFR_FSDK_PERSON person = persons[i];
            for (int j = 0; j < person.nFeatureCount; ++j)
            {
                AFR_FSDK_FACEMODEL refFaceModel = {0};
                refFaceModel.lFeatureSize = person.pFaceFeatureArray[j].lFeatureSize;
                refFaceModel.pbFeature = person.pFaceFeatureArray[j].pbFeature;
                
                MFloat fScore = 0.0;
                MRESULT mr = AFR_FSDK_FacePairMatching(hEngine, &refFaceModel, &probeFaceModel, &fScore);
                if (mr == MOK && fScore > fMaxScore) {
                    fMaxScore = fScore;
                    
                    personRecognized = person;
                }
            }
        }
        
        if (fMaxScore > ARC_FR_SCORE_THRESHOLD) {
            // show recognized person's info
        }
 
    } while (MFalse);
    
    // uninit
    mr = AFR_FSDK_UninitialEngine(hEngine);
    if(pMemBuffer != MNull)
    {
        MMemFree(MNull,pMemBuffer);
        pMemBuffer = MNull;
    }
    
    return mr;
}
