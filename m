Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596EA9993C6
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 22:37:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syzsw-0000Tc-Jv; Thu, 10 Oct 2024 16:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1syzsl-0000Sb-RR; Thu, 10 Oct 2024 16:35:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1syzsj-0006M3-6I; Thu, 10 Oct 2024 16:35:35 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJteQP003087;
 Thu, 10 Oct 2024 20:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=nO+IsV8HcAFaJVVq3rV8xEuJHpQRP5Un7yJ4ISmbObg=; b=
 L81DOwr86g72vr3TxEAkcwuI8+m4YAtTPvxURoc2D9L2lQMMwxd/Qsm5drOiL566
 JHOmpvnjE+xxj+PM5m6ClzljGJIc9YuXR00TrPLu7vyxXxvBG7/wDOTIrWZBUjZ/
 nE5gXzzOqv2S+cb5aprplxH4luoNwa96Ix+X/ymhFu1if8Ow4Wz4+gTfov843U9s
 7FDW8EAJsPFPtZb2D7Kgk12QEqzA9/JNWG4OKJx0Y1Y42540mrAw/sPLTR80vplo
 RL9bm7oR0qwHIJVGT/V4VHuFBIpoeIEC0PPCk/ur/c2wsE4+RDsffgdhPcfUTdr8
 9s8hZikfNGyMNJFnhMePew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dunnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:35:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AIrKlu005782; Thu, 10 Oct 2024 20:35:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwgvrdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 20:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErbO17bL2SbDZ84P5BwKLRPlElmJcFpEB97Ef7x31SuPrR8wCtjFZri0mQMbrrvdf8d8IqrG7VO6cO0XCTUwOPYJXMdnSFL676Q+uAVUNnG6yhgkgn7IS2zwzZjV5XpkqUUuVF6KnQ5/aZTGyNbBDDonh18oWXo1qtU4iDV8ugyHUsYr/N2he/vO2k8BY0comNTDOHcdyKo99ryY4DbHNGtT0bEqtUN3iCmgdDGJSmTOrcjTXe7EH7pM8ew2Pg8dN+4kHbo4zPyME7YaHeSaNBNy2opcrze6tDkMWvPt6Cjspj44X/jyIaOx/QAGLkTwvnv4Sy7PeWyM+kC1f1Tsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO+IsV8HcAFaJVVq3rV8xEuJHpQRP5Un7yJ4ISmbObg=;
 b=T72031kuNMGr8PovvelXN+BId/b/OFm4TKsQ3WtkhY7Z/U07U7QgNDGNRuaSZPZbtVaHZFoWi0oMsXQ6zz6cWDp2G/ig5z6BkCvJXVHJx7wzi5vC8WeJ+RELSwAT/fTxXI84ik8xFwGiPYS8y0eqhk46ct0nNibFSPOT1QPz7r2PiHv2k1C9AqmGGDAgmWIERq6IFVGyLxbudVe7UkwG9zeEuX0MzfUqiNnEnwyc1S9M+GWdspGvjKJelwOtm1anBO1ONbXax2dYc5ylmHHmAmgdDqjr/DTPoNE6vvUeIX8tYPOqD2NRNXiFKZyArJNGX929dOd2d7yJ3yM4AJiNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO+IsV8HcAFaJVVq3rV8xEuJHpQRP5Un7yJ4ISmbObg=;
 b=edDeMMCyvCAYk7iF2TeJBykkeXfFIvZHephTsNF6TNWshc6blLTCpOKjWmu3ScVEJnbd/2uuW3RMj10S8mNw/WEJIv8GMbcrUDO8pgclKTFywW4glokfWGd37JiSxYZxP50GQyv3sbctrAsn98iNxr8/XJ2i40GZYPoVYqXspr8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:35:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:35:21 +0000
Message-ID: <14f1abe7-51a7-466b-93ad-53aa6cfb88c2@oracle.com>
Date: Thu, 10 Oct 2024 22:35:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 0/6] hugetlbfs largepage RAS project
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, pbonzini@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, joao.m.martins@oracle.com
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
 <ec3337f7-3906-4a1b-b153-e3d5b16685b6@redhat.com>
 <9f9a975e-3a04-4923-b8a5-f1edbed945e6@oracle.com>
 <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <966bf4bf-6928-44a3-b452-d2847d06bb25@oracle.com>
 <0ef808b0-839d-4078-90cb-d3d56c1f4a71@oracle.com> <ZwalK7Dq_cf-EA_0@x1n>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <ZwalK7Dq_cf-EA_0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0268.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e9c7c-6c70-4c03-7f49-08dce96b0fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDFKRUtKNERmcGRtblorbmI2V1BVVk9BT0dqZnk5OG1KazBXSDRCSFAwSWJM?=
 =?utf-8?B?cjQxMW8xdFlyNjhxeUdNK01ZQytHWDcrOUlWTmhlcEZIMk5LZktuQjhYVXpq?=
 =?utf-8?B?L2NNU2N2S0lVRUlWSDZOL3VQSkJJdjUvODJseUc3aWNMaW0rVTdJS3cyWUt5?=
 =?utf-8?B?clA2RVh2aGRqRDg3Qjk3KzhaMDRzbFhFOTRFU1JIRnB3MTU0YUtqbFBDQzdB?=
 =?utf-8?B?TElBb0VUbUhXbXBwRjZwTW5FaWpNNTFnWmpIdXUydXhrN2hWS2VWMGxZUDZY?=
 =?utf-8?B?Z1hIUXdRWlMvK0dTQzdrZzlZZHlDcnFRUytsNUhRUU93a2xDVmpnaVNEKytO?=
 =?utf-8?B?cWlaQUtWWlpvRHRIVTUxVDVVUkY2K2QwK3BMdGVyRDUrUUdCOEg5SEhoV2pl?=
 =?utf-8?B?WUZ2ZXNBOE04VHBzTWh4Y2Qxb1YyM1F4eDRXUVBtZ0VFTUgrREpFTFNnSlBV?=
 =?utf-8?B?T29FMmw1UDRLdXViclN6a255OHR4ZW5HdGhaTzE1elJ0VTJMRVViVStFancy?=
 =?utf-8?B?bmNwN2dRY3RxOGtnS3ZoTm8xSlQwVHF2Y0hNMkVDTUd1TFdCaUtPejZxczhF?=
 =?utf-8?B?VTVPbzBEQmNYaWFHRlFwV256Q0xXQW5mSEl4R0hpU3BrRm5jcEZtL0d0K3Uz?=
 =?utf-8?B?VS9RcU9qamhaRitFVzQ2WWxHRW5lT2NJL0duWXNUOHhwSUpGbTdhZ2VVSVhJ?=
 =?utf-8?B?eUNhcndmL2JqWmpPc0Z0amE1TU4vM2lZeEpVSTVpaEZjc3RIU2Ywdm9NNWxT?=
 =?utf-8?B?UjdvSHpZY052ZVdwdmhHcGY1dG51YU9TYTM5M0lrdVZ0S3Jqa3EwVW5KSHoz?=
 =?utf-8?B?Um5nRExHd1BSR0s2YWhhV0FxTjdLM2hiZjJOOFFrb2JSK3ExYmRqNUhTVDdB?=
 =?utf-8?B?bFhKRGRvRXo0bVFFcUdtMTV3Y2dIRlc4dmlJWExJQ1NVWU0zdmFpdmJwaWtY?=
 =?utf-8?B?WW1FRENoM0NTc09pOWU5SnlvY1pIN2syY1k1Q2pxNFR5VFdYS2FDWFYwU09I?=
 =?utf-8?B?ZllNUUhEdWJRUGhnTXk4RS8xek5VcG9ZdEhNL2pGN281Y2pseFhtYU5yOTFM?=
 =?utf-8?B?ZndzMWs1NThEYjRUd3pOeDdVMEhueFhES2FLVUpQUFdGQTdzNFBGOVJDL0F3?=
 =?utf-8?B?c0w5NHhWVzhBbVU4ZWJTbXo2YXovZ3BLTjBoRzJCUW91aEgrbXJrQnFCb0tv?=
 =?utf-8?B?cS9TK3puTzF5MzJPLzNTcDhMQkpqbWRHVWpNWjRtM05ncDFWT2IzR0t2M2Ju?=
 =?utf-8?B?OWRtdkR0SjJqVXBMTmF3Vkp0Q2c5NlJJWkY0VXZQb2VoQ2dhajN2VDlpT1RM?=
 =?utf-8?B?YnV4OEhPQTRCMlVqRFgzNTdhQTVuaVcvWHZlWWtYVVhDZFFWLzQ4Nm0xMU1p?=
 =?utf-8?B?b0JUWXV6aEFUUVRYaldmVFpMZ2V6WjZ0Z1ZWcGMzUTkyOGZhSC9WUFpZd3Nk?=
 =?utf-8?B?eGpBdmhsYWg2Rmw3N29PQ3ltT2NWUkNqOFhFYU51WXUyNGkxbExXQUk1TlFE?=
 =?utf-8?B?SGFIaTdTdXlmNGlFR2xjcWlzMnR5WFJIMlRibTk1bjVhNUFEbEpOeENua29E?=
 =?utf-8?B?RElTOGRpOXh2K2Z4alV3Sm9nd2xzdmU5MHRKMnVNeFpuUUpIM25ZRnkrNUlG?=
 =?utf-8?B?MGdDeG9ld0FoQUZzZFh0U1FhdVUwaWEyVFp2VDVmQ1BxMDNYQnpJYi94VlRB?=
 =?utf-8?B?VTNEVldoMVo0bEE2S1RNaHdQTDFyc0F1N05QVDZ1d0dWSlRWNUZvOVIxclNJ?=
 =?utf-8?Q?Xwl/e5eBLoFBA3aOmk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEF6WkNFQjBDaTgvYk5EajlQWDJ2MHZWL09UbytlUUIrRUhTZTMyRXVEWkRF?=
 =?utf-8?B?cCt4OGRRRnN3WjhJZ1pBV0RIZzJIREMvS0Z2NnpCOFhsMHlYTGg0em9Hd3Rh?=
 =?utf-8?B?ejlRS1krZUI0SDVTK0ZGRUE1allWWUdiL3YvMzRVV05VSTFMSkVCajVSeXNj?=
 =?utf-8?B?enZmcmxqdG1UdmFwU3F2Z1VqdDVFTCt4TWN6M25tbjYyYTcvTE9uaHNNOE5t?=
 =?utf-8?B?QU1JNGFmVDdsT2NiNTRSRjlHT05zbllHc095akVpeXd6TlFLZFcwWHFWbm15?=
 =?utf-8?B?NURyOTVmZ2wwMHprVWRoNmN4M2t3VWRHYmZEQWJVOEhWeW1pa2hlNGtFOVYx?=
 =?utf-8?B?WXRLRFZpa2ZvWHRjeHdYd3N1bnFjUW5KUFRQVG8yOGUxeDQzMnFnc09ZcGdH?=
 =?utf-8?B?WHE2d0lGZERaekp0WFlRd2d6cDNFUVlrM3hnV1ZsdEIxTDNROUVINjV3bEV5?=
 =?utf-8?B?Nm1kNFhwL0ZNQWRzRnBOOUpzUEpKNTV2SDdpcDYvK1RHOGI5K1htc2xCV0F6?=
 =?utf-8?B?SFRrUXhBRWZzN21ydGJaV2dFQkFUZC9nRkh2ekRrYjliVXpPaUlkeWVQY2JB?=
 =?utf-8?B?STJva0dROEV0MFpZYWhvYkd2cmN0ZmQzOHRBTmpRR0JCTEc5bkhGcEpHaGtr?=
 =?utf-8?B?RHo3eGN0NEUxTHhVZlFLMERiUFlaR05uTXhKbGVUNElrTm1tRWNSempmSCs1?=
 =?utf-8?B?QUl4QVlFek1aNDRzR0NoVGtncWNrVUt6V2ZjaWN6VHF4TUw3SnE4NWxGaFRY?=
 =?utf-8?B?aWJoWm5YemcvMHFrRHU1R3ZmbEN1RWl4VDFSUEczOUZRNUtJa09TRXRqWE83?=
 =?utf-8?B?eWRZN2ZveWR1TmgrcHc4QUFIdnNpQzB2dW5VZCtIQmxPUkp6RTNuWVNObDBS?=
 =?utf-8?B?RmptWmdIejFqRllnZTlYQ0Q2S01wblBDb3ZuVlZLRnhDWUJxcDJ3Mk9qR1VC?=
 =?utf-8?B?QWRmTDJZNGJrblgrdUxaV2dVS0t5VW92cjl5RjBGakM3dDk4V1VsYkFEVlRq?=
 =?utf-8?B?dmxJeWF5dFNiZTFpOUFmNnh2ZHVjdGNDUkZ0ZE5adENWdDQ4VGtndVdGWkNq?=
 =?utf-8?B?Q0lvTllLbW1IQ24wQXZ4MXNxS3JkT0NkYTN6UWtTTjVJeG9kanJRazRoSDBo?=
 =?utf-8?B?RmZhQUhxVW9VVzlpdDhBZktoQVJrS0d1Q2dEejZaeXZQNTNUOU0xYktSTGUw?=
 =?utf-8?B?Ky9kREkyY3F4TFJRNjVkejNPc3o0Z0tBWUNrS1VzNVpSTHMrL3RYSCt0TjlG?=
 =?utf-8?B?RVZycmlYUkRlWmdvRjBGa3RrYjAvV1ZwTUtNWlhMUStteXo3K1FQTk9HNFFs?=
 =?utf-8?B?VTRwR3d1MzM2eVV5aXgwbTBURVYwMTIvVnljRXNzaHRCSGRaWkFZUmpBbVQx?=
 =?utf-8?B?d3pnV1dWeXAvOXJVWERjOHQ3U3hkNkZHS1QwMW8wOVVNQ0JGTVRjRTFuZEc3?=
 =?utf-8?B?VzVYQ2ZPUXF1MDJyUXliRTBVMlpqR0ZPbHBYUVo3TW8wNy82R0J1ak5XUE9P?=
 =?utf-8?B?WE1DL1R4SSswVGpIZWtrVHhnOFM4Vjd5UUxYNVNSR3JLYW5SMHNqaFZHdElQ?=
 =?utf-8?B?VzB4TWNMbmFGOUxKWXZ3OFlGaHhUTFVYYWEyOTl3VSt6dTh4YngzN2tNMEZ2?=
 =?utf-8?B?b1BiNUdHS2Q3bHlTRTVhNHNrWDhhcDlRRDhONFNBZlljVnlLUmxZWllHYWhq?=
 =?utf-8?B?UDVzYTh4akFVY04yVmRxa0w3ZWQzdG1aa0FZcitEbUtNYk14TDJNYlkxcWhJ?=
 =?utf-8?B?SmdvU3FBYUJSUE9TZWdBbWQzS2wzTitOL1V4Y2NtSkVhZXFzMjFOS1lmSnZj?=
 =?utf-8?B?bnZaT0NEdG91SWc5cXVzMUNqVjVuOS9CYVN1YzUvdVJUeHZNVXN4QndMQWto?=
 =?utf-8?B?N3BkRlc3cXRFc1VaUmd3RTZCY2taa2trakY5ZVI3RDNnQ3N4RTJ5a2IvZXVL?=
 =?utf-8?B?d2U4emd4N2xsUTE3cldmSkZVemN4aWNnTGhlZnNxWUdWSUQzWFlWL1RQQVB1?=
 =?utf-8?B?VXM0VjlCTDdENjJQam9IamVCL2ZXWnc1dHB3eTBaa09kdlVPV0dQQi90VmZs?=
 =?utf-8?B?V05EYXBMV2gycERBeTdELzBlYURDQUR3RDJwSGQ4WGJyb0hockhiQlE2TlBu?=
 =?utf-8?B?b1cvMklOcTlhaVVtRThQdWhtRmZGZlRlMWhLeU1BSlQvNUczRGhuOWVRbmtZ?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H4P1ZbuFZprGRaG1o8brpZUGQobmKa2wSWyGxPw87xWjnKd/z5veJwHVwxwSO4HUcpWxEmsbDgk8sU92I7Z2tR0djKaNe22lZiRzdL7gYM0C0mPHtWE+rMjsjdCK5GyjVyOnkdYzOs5/xASZZ9SHoDHY/TgzShyE4soOaE/XMCC9D5rCCzr5k5JYCSbsxd3Bqd6bzCeN/ctzrsxheoKdmefK9h3MqOSHog/ZPAtyOup+ncvVcixCgK1A+qz+dg6SZUhsaiAATpbR0Lb9J2VTRehr9NVhpRgtmRvWAh5jfr4PovhS1rceS5ySUh60ehfUpESi/KzNIEZraIYd03RLnr/ueIxn9wdoSNN2cYsOv7AbhBCsDaEQrAXcvBi9ZkqcxLu1CPCy0TXE7Okp6I0QuvB75LUPVDt+oYIT0xOwvoL4pMWGR8ZoKy1yE5ZxyAIYguG6Iv9PDUSYZz7phd2huO8s1TIxnxip/KGaiXiJUNpTW8kMmrfaIfoNgdJlCwGISnkIl2LYaFO33yfi6jJHmW2f1T0pgC5H+3h7XEeWRL8XhJL/NaQ3jft3iS+Hmp6T/zeGeI5OHrnsG/Xya9qe4pLAThrHMNoR30AmLC3Xyn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e9c7c-6c70-4c03-7f49-08dce96b0fbe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:35:21.6898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJC7AhFHImK4yth0NEvfv+CLNuV7x8UUqk7wPLqZbO2tI7j+7eIQoHhsCNuRIBN3zuB5Ce3TbmLjjRiBD5IEDj+CwjgHqxXAjts8R+7l5YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_15,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100135
X-Proofpoint-ORIG-GUID: Jk-J-3n9VvpQGcABSc_OgLKFUsNyq94f
X-Proofpoint-GUID: Jk-J-3n9VvpQGcABSc_OgLKFUsNyq94f
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/24 17:45, Peter Xu wrote:
> On Thu, Sep 19, 2024 at 06:52:37PM +0200, William Roche wrote:
>> Hello David,
>>
>> I hope my last week email answered your interrogations about:
>>      - retrieving the valid data from the lost hugepage
>>      - the need of smaller pages to replace a failed large page
>>      - the interaction of memory error and VM migration
>>      - the non-symmetrical access to a poisoned memory area after a recovery
>>        Qemu would be able to continue to access the still valid data
>>        location of the formerly poisoned hugepage, but any other entity
>>        mapping the large page would not be allowed to use the location.
>>
>> I understand that this last item _is_ some kind of "inconsistency".
>> So if I want to make sure that a "shared" memory region (used for vhost-user
>> processes, vfio or ivshmem) is not recovered, how can I identify what
>> region(s)
>> of a guest memory could be used for such a shared location ?
>> Is there a way for qemu to identify the memory locations that have been
>> shared ?
> 
> When there's no vIOMMU I think all guest pages need to be shared.  When
> with vIOMMU it depends on what was mapped by the guest drivers, while in
> most sane setups they can still always be shared because the guest OS (if
> Linux) should normally have iommu=pt speeding up kernel drivers.
> 
>>
>> Could you please let me know if there is an entry point I should consider ?
> 
> IMHO it'll still be more reasonable that this issue be tackled from the
> kernel not userspace, simply because it's a shared problem of all
> userspaces rather than QEMU process alone.
> 
> When with that the kernel should guarantee consistencies on different
> processes accessing these pages properly, so logically all these
> complexities should be better done in the kernel once for all.
> 
> There's indeed difficulties on providing it in hugetlbfs with mm community,
> and this is also not the only effort trying to fix 1G page poisoning with
> userspace workarounds, see:
> 
> https://lore.kernel.org/r/20240924043924.3562257-1-jiaqiyan@google.com
> 
> My gut feeling is either hugetlbfs needs to be fixed (with less hope) or
> QEMU in general needs to move over to other file systems on consuming huge
> pages.  Poisoning is not the only driven force, but at least we want to
> also work out postcopy which has similar goal as David said, on being able
> to map hugetlbfs pages differently.
> 
> May consider having a look at gmemfd 1G proposal, posted here:
> 
> https://lore.kernel.org/r/cover.1726009989.git.ackerleytng@google.com
> 
> We probably need that in one way or another for CoCo, and the chance is it
> can easily support non-CoCo with the same interface ultimately.  Then 1G
> hugetlbfs can be abandoned in QEMU.  It'll also need to tackle the same
> challenge here either on page poisoning, or postcopy, with/without QEMU's
> specific solution, because QEMU is also not the only userspace hypervisor.
> 
> Said that, the initial few small patches seem to be standalone small fixes
> which may still be good.  So if you think that's the case you can at least
> consider sending them separately without RFC tag.
> 
> Thanks,

Thank you very much Peter for your answer, pointers and explanations.

I understand and agree that having the Kernel to deal with huge pages
errors is a much better approach.
Not an easy one...

I'll submit a trimmed down version of my first patches to fix some
problems that currently exist in Qemu.

Thanks again,
William.

