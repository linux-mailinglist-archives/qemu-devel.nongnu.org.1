Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E4803A9D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:44:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAC2E-0005SD-4Y; Mon, 04 Dec 2023 11:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAC29-0005Rt-1f
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAC27-0003ZB-6L
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4GfFMj029981; Mon, 4 Dec 2023 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mFSYXZLgDDLfPSZpm+YkGeJ59D8QeFRuDMq3isNeTW4=;
 b=lpYzo6NPV5gBk8hCslt33ifnDK9jtfpyMdbvfp5xTJFnQ2w0slF/ciTI8y70HeMv8Hub
 INScPNPWjr788CXH/PtqjgsCcJ1XRHScpF8PDPUDPGvEFwpI0kOd1x2MAWWCJmN7kgCS
 jw076OXfSETM9tYBDm+mY/SabvMV14gwPFwGjd9D5C6AK0xVLICp39c3bSI1DCykHaaT
 b9BqWY9WQgacS7AY8EwGzpg7D0yE9seT+7PDiYNK8xzJHahJriIrCoHBQ8qc4E1WZiId
 lqufQdZSO0UI1vOKOTa9waUZAEatpR+oXcFzIaD3jUB3cLUe7QGPi3AZpTw++tMFXXdN yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usj3703py-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 16:42:55 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4FmGWD020024; Mon, 4 Dec 2023 16:41:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu163qv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 16:41:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAQ5XtDiB7IjbPwLy5mO+5B4UHsvxHO+Ylx7Bgpb4McsMPFmW36gdOc5+A9BmhgoMjU+jwISCgBaNnW/Lze9fwmaqxgsd3V0lu29eZtStBjs+qhhGTXdN+QhZoWk3X56mNkix9hXhRf2TQQMPfRFureYfHM+bAtXZMrxVUKOFV1I/QYuLxR0NGPo4aezgAUAJGKYW+uQ5HtHKSpZWHbQvS/gGA9HTWntnyZkeptHnWI9Ug05+gnvIkc9011ZbVJfmdt/+C6cccOyywX6O7k/To8dmsepP8sXQGk2eS293VH84NGz2IAOxnSPEf8Apu93bvMqD4khnPfGPeiilUjWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFSYXZLgDDLfPSZpm+YkGeJ59D8QeFRuDMq3isNeTW4=;
 b=Rmrt8QHDk2S7L+Fxhf8OjPLNAO+1fXDMCVCE0JKi8HIPF0zIlMWUCXq4yErAHCq5g7F9W5basQCPoKU/aSmoi93A1gimuLsukbtCsPAhK7DEwaFMKSQq1T8YQ2cfWouk94r1tDD5YIyjW2juuBTmZUB2ANoUSsVn2FHaYXGVGa9PqRRCKMuJFHJnwhAXG+jQZlg4a74xKO5UNxFPjDN3v5kJ3+9L6ak5IUFb6hUskPOz/V+00Vu9V2fLDRx86mgvNHKWRYvph8rL6msTGQVyx1Bwhs/GsXX7UR22P2Zx+0HfrGTZ3ksz+HBSUm8M2a7RPu0XV3zgwsNt0iAuStqVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFSYXZLgDDLfPSZpm+YkGeJ59D8QeFRuDMq3isNeTW4=;
 b=R3wEIoQySM2AiS3CIoG3bNzI2INQKHMiJgRuPci+a7DPkO3p/IPEEA7S/P55wnqVlt+ronMTO7dJzCQ4ipPstc8A3/CePANShpyAIHx569xEuU1et+dH4p6cjjG+97/5RniFiLXXuMP5eZgK96w8KwYqGYyhFix+CcIJYM9kNNY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:41:41 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 16:41:41 +0000
Message-ID: <87df3590-7643-4ca8-b0d6-5fa8072f53b1@oracle.com>
Date: Mon, 4 Dec 2023 11:41:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <ZWkIV1k7n7xW5doM@x1n> <0533cef9-2499-4480-b0a2-e5c00787ceda@oracle.com>
 <ZW3_6H4ZK_NUS5FM@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW3_6H4ZK_NUS5FM@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::18) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 367a0376-09d2-4f06-390d-08dbf4e7e49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMJ45SHjiQDSBlZyNIxUfusiFRyTbXPs6zWTPHNNWwUkFzNHnjMnxZWR+TE2TPAI4Cy6uL8mz2RTAakcRrzEu0wydTp6e02CKPrl05hHQ+1WfMybagTUJP0mDo7AYqyQgc7JUQpX4BaGcekthAPA8XTIwUr1Ss25KwMfOclG6x5mjUfs03HUGye3y1CZUxwB4gaASFqotHtzbQ8EcDnA8X542VLgMKBmjX2sPOTho8tcazitCbjkKRir5P40kzBbZzauMzpLtqSnWbWWgH373cAOEIx1WKSkOlqBzWO1xvm5c0yEUAjRa9gmYY7JrAk4epVO9QfA4MCdQOQ4dSCGstI0qGNehxZfbG3VUVQaLAnkOIIHtk5NtI7/NRNtr9yQPSwM/QRcbqYyQza7GSGK7LBGe5rPf/DnU50BjVYGDKjB9rCiFPHZSY8uJrOPDblB1Q91JxgdmJvW2z3pefm0EqUqF7R25LyVlqf95y3ddLi25A9ePMGitO2A9T/t0JmBThm8AMhVoc94G/wYSTtkPj8mhFOK/uOoxgAqZRpGApajfsCkY2lSs+NIWVQD/2r070T7y5OGLdKO3BHUL76IpAo2LoNDWCoLBHEAT1FJUGqpc8ByjixSW9rpLXQMwgHAm+vlmpOAeONCdyKH+vd+Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(5660300002)(15650500001)(2906002)(7416002)(86362001)(31696002)(44832011)(41300700001)(36916002)(53546011)(6506007)(6666004)(2616005)(26005)(6512007)(478600001)(6486002)(83380400001)(8936002)(4326008)(8676002)(38100700002)(31686004)(66476007)(66946007)(6916009)(316002)(66556008)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZjM0lTVkltaUc2dEpLTlRBeVY0YldWaXhNeEFlNkk4VEh2dDlEUnFpVElI?=
 =?utf-8?B?UWptckVrNkNiSkJtWWUvVVFBREdJb09nbzdOTHgyRFgwV3FTc2N1RVlGYmNF?=
 =?utf-8?B?RGhDZ2FkR25aN3RrbWJncUxMcllkTjZFaVBVUjZyb1dialY3cUFTejFMNFFU?=
 =?utf-8?B?SlZvc2FLNjkvR0NOMDRPaUJWTTM2b3pCU1k4VStSV3lUTXhkVDdYcWFTTDRk?=
 =?utf-8?B?QlJJVWlpYldwUmoxWjZPQUdhaVAraHdrbDVxWUhKcmxoT1NoUXVtdzAzTmxx?=
 =?utf-8?B?aXBMbC90Q0dIVDRwY3VlRy9CUG9valdEUm9GVzY5YlB1T0NxYk9vdDNBNWcr?=
 =?utf-8?B?K240WnJqTFBrRFpER0V2ZVZXOThtb0tXaUdVSFRBNThGV2IzQzF1eUVOeWVG?=
 =?utf-8?B?dXJNc09rTno3MGV2ZERUVEJUb0VieFcxWjBoODJ1L0FNSy91ZFRGekRGWmJS?=
 =?utf-8?B?ZVhmR2x1eHpyZjB3ckRPRmNQQkt4OWQxRnRyYzNueUt6TzRWL3UxckFLbmFv?=
 =?utf-8?B?eUtncUFPM2w1d1VMMDNIMzhvS3VibUQybGxxb1pHQXcvSVluRDF3d0tjb0xp?=
 =?utf-8?B?UU8xUTlPWG1pc3VjRkYzVE5tSG9vS2x0S1dxbFFTdjNZdlc4cTZoM1BTc2ph?=
 =?utf-8?B?dVk3TnlmVERZVWZsQ3RuK2FUN09Gd2k0a3E4RFJjN0EvSmRxV1cwWm9kN0Fl?=
 =?utf-8?B?aDcvQ0JreU5EWmZ3MXhlaVU1aDdRVkRRWmpsNFh5ZFJ5L1ptaUdKUjU1Vnp5?=
 =?utf-8?B?bitrMDhkWUsxWXpPeDRJQkJ6aC9ETzhqQkNrVXNiZGRGdUdKczVpamE4eWx3?=
 =?utf-8?B?a2gwSVNPTXlxS0xxWFBXNDBMNHFCZjFtUUo0eldUTHE2VmlWQmE4enVsancw?=
 =?utf-8?B?Z3QxZHNCVVJONUgwdWd4d0FNdHU4enV4RE05UW5MYjJVeWlSeXY1MlA2elZy?=
 =?utf-8?B?SXdMREdWY2duaktXR0lGd3BudGQyT3N2ZkpqdS84cmlrcCtzWlZRb2RoNzVp?=
 =?utf-8?B?U2VJMjFNZGJUNERsRnBYc05jTjlRaGJ2alpRRU5xUHpwS0xaWXJnK1F2NXMv?=
 =?utf-8?B?dnl2aGcxTXFJK2tGMHd2YzRtdHg2b2xzMUtRTG1RM3pXa3ZVbHJmYm13Z3Vi?=
 =?utf-8?B?U2c4S2VxQ1dLR280Sys0U2tvWVhzOW04c2JlamFrczRDWGVKRzZkaUVxajk2?=
 =?utf-8?B?bTdGVHRxWVB5SkZNSGVROCtpMmZqSVpLdjEyWnF4ZzZkRUNRb0drRDg5VmtU?=
 =?utf-8?B?dUFRdDRQck0vMWFrWTNSTWRKNThoaGxqUlhObHhrbWZERE9TTXNnOFI3YW5r?=
 =?utf-8?B?eVVZK05nVUczZE1QamV4a1l0Ynl6dWNCV0ZLSHJJL2M0UkpGTDQ2NTgzNlJ6?=
 =?utf-8?B?L0gxdW04Nitkd09XYmFGTkF5VEhWamVyOWFtelJGdnBGMWg4TE9qUnU1d0w5?=
 =?utf-8?B?Qm96c25yeGZZSVI5V2lMa0srUklBYkxGaUF1Z0JmcWYrOHZDZUtlemhiakk4?=
 =?utf-8?B?SHNsQnJWVlFTTHJKZGs4cmI4S3NmOTR6S2FwSVpsRzlwS0ZlWURXYnkreC9D?=
 =?utf-8?B?QXh1WGZMbTJXazRmd2lXVytHSmZLVFhpdzFWeS8xWHJ1ZE1WRmJGaTRNWXdC?=
 =?utf-8?B?M2VFSFdKUG4yQThPN1NBdXNpczhtZ3RIdjgvWS9VSVFkTlZkUTMzbEI4RHZu?=
 =?utf-8?B?elNrREFvNldqd3N3WFhXY2ZZZ0J4Y0NkejZBSUdHOXpEd2pBRFZZM3VQaDlF?=
 =?utf-8?B?MllOUUdFNXhOTFNUOENzdFEwYm1VenFDdDVIVXlwb0pUR1JWS3kvNFJWQ0NZ?=
 =?utf-8?B?TU1sYlpJdzFUWGdpcVdYcG54dHRsRnFDZnFiSzNwZElVZGxRejNHT1lKQjh4?=
 =?utf-8?B?NlhqaTR0eEVBdHo2Nk5YMDdpRHpKQWdSc2l2WGlmT3EreGJTeFdFVlhkc2l0?=
 =?utf-8?B?VFp2OUVZSCtMcXp3UjNEWHhIVHVUMDRPa3F5SGE5aE01VWRZd1p2YUpwU3Iv?=
 =?utf-8?B?Um9ocmUwVzBsYzJOVHBRUFNKQWhrWktsS0l5ZzJkV3QzRFR1NUplaHBCb0F5?=
 =?utf-8?B?ZG1pM0s2N3ltVSs1cEVQZ1NZUllSY2ZTVlFIbVdhenlhdjlKOWhheDlxRXBt?=
 =?utf-8?B?K1JSNXZabEJ2VHFvS1B1U3pHSk9BK1hlSk9HZEVSMFNId2kzWEZLMlBFUWxx?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pjyq0QldUDum2T02h8M799j4Tgv8iCS+el5TOnEmxL5gLJX71mlLmfXHgHH7emA+SfpyIy6OCKB2Tb8I/bCTWd0UlePZf1zxnhPR0vNrIkKXB83PCwSAwqGtdB/4HQb9sIVnXcTntlbawwfdS3LqUUaAxge61/eSzFyuALm586FTso8Gm8cHC8HXKXGY5iNgHWrztTMl+M4tDTIELOv1Ylsw+4wV80fyWE+Wn9zPW31cXOD7k4nimbd/LDJ7A9pXef2g+c+pNbXtL0pdhbqoWTLE5YFEUPLeEbs3yz2/pzdM6bcW/z6F0rhqXn6g3fJXrmwxU1O2Vr4iuQzfkakf7cOM1aPeNjmiZcp04z0JWZ+I3abq4rp8sb5qS6TEeZbJ8bBDxUldEEQiw8CtvNFnnBUCRfffR6niLsHg+XhM4nynMikD20T3+swb9QFM71ePYMY65j8Y60Oa52CyYUGqJHydaxPj96oy7+4KJwSoXRUYLQaCuhXalr5H7Q5bMwtDSS8eDdepFVJxUCQfDUHIqnbGkaMeHcOCWTRPZnW4CcYltQSahK6CxrPEJ3O3KNRcEvhgzRWVW09mJs8EThBacaYtIHe/QOtiydkeOMVRdLFf7/H8OlGaFQoEhKSCJ39q3SWdfmmShAhTrZ4d7fSit+HhiMEMTmqkelo/fA7yerrjXksngiNLvvHreWilTHDFZf5W+Hi3c7p7nsApiC/CvFMkI5wfwUFzh21wMsUC5oisyhi2QeiiolHQxcWM/hjMDrourR4aR2VgYfY+FfB47g3TMOI7eOBKdpg8OJ90YJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a0376-09d2-4f06-390d-08dbf4e7e49d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:41:41.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97H3miLAswc5U4jnKsJXMerUxw57phha3wGv1MINIP+IJriIAX9Hx56FvUxoNmP6YtLm9u/8IWJTDcTLw16FkHdqRUlmVYrQwGEkGwWqNhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040127
X-Proofpoint-GUID: QvGBlEkzFeZodIE8olqCqh0yKfY7Qfnz
X-Proofpoint-ORIG-GUID: QvGBlEkzFeZodIE8olqCqh0yKfY7Qfnz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/4/2023 11:35 AM, Peter Xu wrote:
> On Fri, Dec 01, 2023 at 12:11:32PM -0500, Steven Sistare wrote:
>>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>>> index f6a337b..1d6828f 100644
>>>> --- a/include/sysemu/runstate.h
>>>> +++ b/include/sysemu/runstate.h
>>>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>>>  }
>>>>  
>>>> +static inline bool runstate_is_started(RunState state)
>>>
>>> Would runstate_has_vm_running() sound better?  It is a bit awkward when
>>> saying something like "start a runstate".
>>
>> I have been searching for the perfect name for this accessor.
>> IMO using "running" in this accessor is confusing because it applies to both
>> the running and suspended state.  So, I invented a new aggregate state called
>> started.  vm_start transitions the machine to a started state.
>>
>> How about runstate_was_started?  It works well at both start and stop call sites:
>>
>>     void vm_resume(RunState state)
>>         if (runstate_was_started(state)) {
> 
> This one looks fine, but...
> 
>>             vm_start();
>>
>>     int vm_stop_force_state(RunState state)
>>         if (runstate_was_started(runstate_get())) {
> 
> .. this one makes the past tense not looking good.
> 
>>             return vm_stop(state);
> 
> How about runstate_is_alive()?  So far the best I can come up with. :)
> 
> Even if you prefer "started", I'd vote for not using past tense, hence
> runstate_is_started().

runstate_is_live also occurred to me.  I'll use that.

- Steve

