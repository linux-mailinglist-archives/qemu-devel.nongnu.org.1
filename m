Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB278FBC6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:31:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1Qn-0002M9-Gm; Fri, 01 Sep 2023 06:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc1Ql-0002ED-3m
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:31:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc1Qg-0006dN-Sj
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:31:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VMx9UO025876; Fri, 1 Sep 2023 10:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sQ03eJ5fqnM83Za5/zsSu+KUW/zUJ+ZpG6oKumtByzA=;
 b=qaSKfv/A1aqfkpwEvwrYzunHjcMD9cksE8ZyCIBLeD0Jivf33kF0DDjvjJf/A9FMBfW9
 hhzkt5PRXQ+yDCR/wBW8uwJQFiZ++FJUg591CFkb9ppfsfu/I6wGU+LvJoK63dovy4c2
 duVSKihf53qsS0vVRqHP8SQtJDOgIOq5sFZqOF2Li9CgqkWUkvlNnDvHu2OOLzXpTFte
 a4mDdhyui6P9t43zhgQhLE4T8wW7lPSNGmvdLGP5VFaIPzHCjrxgy9ibhxLO0k98pnOl
 C3Q1PBUIxf+/VLq9TsEi+h0XnUHMPOt/44U5hcT8xQWqigj/Xr7Hbwt6IYB+bkpS5QEu aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcup18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 10:31:03 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38190B1M014264; Fri, 1 Sep 2023 10:31:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6hs67ty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 10:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+SuvpP9/xeCCfmT+ifa4RPyL9bOpOP5WNnWR/xHuXbVJpXsD39KEMHL5tR4IAa/s/B5Pd0CeWQ26FcYhaxXQHjomRgjObuyBDiVpzIYwKkkH/PP3OtVQ6Ph4HwpZA9NWsTWJUyHsRQ24qn7eeaVEamkIpIOS3a6OpRVSWkPJSpeXA2CdZaSji7Rae/Zz1VQbrdgdAQGP/nPGm5A+V5NeX/1L2ZB7bZW74Wi/a2feLyPYyxHRHjQD2Ic0VbTiA1DLvNfJNKRbfANtp/oPbLm1SCKc5EMo2LCTehBuC1B3OsGzIfe/LD0KPdhyce4HinQT2dzpmPsBL9OYJOmtuCsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ03eJ5fqnM83Za5/zsSu+KUW/zUJ+ZpG6oKumtByzA=;
 b=SyoQ4UIDxPMukyY0CXbb2pTMxelfMYN4VqIn4pLp/GdP+jALm6nZZxGntMCKDWn5gvltmrd76do/VNe9UHA4WEYQKE9ZKFVnlaXR3URKjzcZr7RbOsbtEEFc/Bn0GSt6J85X82FGsabDtgwnE8Dx89fyWJHkZaxFjMi8AmxqCyEUi3p7sr7Ko1xPzolkVvwTU0fXBbjnK53PtcI5L0twAdeKWkwscsZ7X2EjbPSPtFZ9lTmmXodTmR3yM8st9n0Oryqy8OhdWNED8dTB6F4VAU2Kp1JhFDj2xceB8FzEeU76HTYHc8xs2HFwryH2AXkJN4ZaDz56aIz+BTIpQqvEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ03eJ5fqnM83Za5/zsSu+KUW/zUJ+ZpG6oKumtByzA=;
 b=E7zNGg3ZN1JTptNhXgA4/Sdf5/cOJK+vh/3k/QJ5ceIuX34e/ZCR5oJTChxbwIAc2mkWJrcFkAxkh3ewjoyejDUMkoZU6mcvNunTxjiXpcB+FQGBJCPI7UZhg/ZCIYQCW/Vpk8laTwR4Tuy8s5H1umxRpyz49Nc9EE5yPMqQBnc=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7797.namprd10.prod.outlook.com (2603:10b6:408:1e5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 10:30:59 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 10:30:59 +0000
Message-ID: <3856285a-a612-382b-905e-77ac1627de29@oracle.com>
Date: Fri, 1 Sep 2023 11:30:53 +0100
Subject: Re: [PATCH v2 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: John Allen <john.allen@amd.com>
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 william.roche@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
References: <20230726204157.3604531-1-john.allen@amd.com>
 <20230726204157.3604531-2-john.allen@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230726204157.3604531-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::29) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ea31bb-2af8-4e35-b998-08dbaad68852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ora25EpWq9xcZE/BNem5t/kvBaIrfJw6b/NVCFYLpe66HJwt9ElnPzUwSeiMMwGPuVKdcm2guCicGyvuWqLVG//AhY2C9KX0a6W26qrZzNExmCRxjIrw7gYR2w2R9sR9kjGuIQCvz39f1/eC4Lkfg9zTciw97NGgvMvGTI7oDtsmTWZgewiAbs322nJ/A/q48kNrlrRQqZGQE2jRcKeUxv/Ovec/3YG+IOQxF9JRF+13hGBhYBI1L9kTpJ9QZ3mzWiptjP5fWoqq/TJGdu71yQA1UroAkveHJN8+jCRL3SzHV/uX6TB/5pm3FGQLC4Fef9QyJuPaw3gxqiLLCQKDOrQ5bAz3oEVrEu07/EfX1B1iB5iJyQ1E4RFU5+rflHrtJElO2R6dUHNyBo4rFvH2S8p+qaa0eywvcRQZ8ZDySMKdFw539N2F0T7/OfnbSJ1umceDGJk8Iwr9WhMPeTllCaReGjBIbXj2TWnsTUZTh8YKzuJ/cK5aXYuQ7ipwgdg/1622FnKCQdUJN1cK2QEXt0L5HEeWLaN9SrUEKtNm3lj1irZXRbJ0sKaIeyLhcNv4ASn3ll80Sxmi/kNUy+ZwD4fitK/rbc9dbbJxmZ6DYuiMKK5zTJ97VIL/r18nTCPO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(66556008)(66476007)(2906002)(66946007)(316002)(36756003)(6916009)(41300700001)(6512007)(53546011)(6506007)(6666004)(5660300002)(6486002)(26005)(31686004)(2616005)(83380400001)(86362001)(31696002)(8936002)(38100700002)(8676002)(4326008)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDU4VGN1cHFlelFUcWtqUTJGZkI3TmorMkdJVFEwZWlUVnQ5RVRvSVdhRDBq?=
 =?utf-8?B?cldEN0lvbUY2ZmtNVE5EakdIR1N0Ykc4Y3N2cGpGaU9WdUtjSmVvcm9nR2RS?=
 =?utf-8?B?MzhWQXREWEdzMExBcS9NUnRZblpaS0h4WE1vWDl1Y25PYUI4TzI3S0pWNjlV?=
 =?utf-8?B?SkdXNWtQWmFMMTVEdnVDV1R5dGhNUEdxZ3lFd0drR0lhNHNHeGJNSHdQSmxt?=
 =?utf-8?B?TmZ1a3dHTUVCMmxoSFk5ZWdCV2wzMVptYWwyMGZ5NmRwZFZ4UDZGZ1dGbHVC?=
 =?utf-8?B?b2lEK1hNTjhyU0hoSHd2MEh4KzFTazRDU2hoRW1ucW5hR0FVVGdGVkZJSTFR?=
 =?utf-8?B?b1FPaVFtdk5vSlUvZzRrejhDSFFGR3JkTmNxamM0cjByRkNLYnhJeUd0MWta?=
 =?utf-8?B?TzRxbjk3V042MHJZU2FGSnpSYUJwZ0Yza255ZkJ5M2dWT0Ewc0w3cysxUVBG?=
 =?utf-8?B?N0NoRCtidCtYUGROMXhkMUpSOWkydmJYQ1dhTDRqemhIWW44ZS9KNnVIZ2lm?=
 =?utf-8?B?TFIxazNBUzJVQUlMOUpaYWpuSUFNM2JaZ1d3RVpVendBSlh5WWRmV1hjY2hC?=
 =?utf-8?B?MzZ6TGs5WlgwM1NEWTViRlZhZFZIVjZjY3BQMVNyRDJrcVVGdjQ3WG5LUGsw?=
 =?utf-8?B?SnNyc0gwWUxSTi9zTmx4cWNxNlA1Smkzd3VOdHd3WitIcDhVRkF5Y0hWVkVX?=
 =?utf-8?B?TE8xQW1PZUUrZ2twUlZGcHNrWmtmYlZVbVNxZjd3ZnlOUlhrN1hNRWRFV2d1?=
 =?utf-8?B?RXVYNllNemtxVUdGZEhySmZEajBIMTA5ZmNRRWFudTBJNjVFVE9NaDRjc0ZS?=
 =?utf-8?B?ZXZrOHpKdlkzNGhwSVBHWTBrcEdZT2hSQndRelNoL0JEcFNPU1pBd0pRZEJy?=
 =?utf-8?B?OWpSa1ZUbWxkdXpOS0xRQnowUHNsRzZRTEc0NkEvS0crZkMzaG8zYk9RMksy?=
 =?utf-8?B?Y0tIMnU0ekJPdGlyNnczWFU4VEhiSHQ0a1BQL2FBanR5QTdQdDYySERoS1la?=
 =?utf-8?B?VmJxbDlySEFLZStrTzBnYmlLUWszODZvczk2ZS9qaUQ4dW03L1dDNXpVbll4?=
 =?utf-8?B?dnRBS2pYRk1OZGNPZ3F1dm9uaXViUERlcURhdzNvblhYeGM0VStIeU0rcW91?=
 =?utf-8?B?MGlGNk5CMDR1dG5OZ1VXMk1NNXlJVkJkdWxORlZMY0NSRk56NUZmS0F3RFFt?=
 =?utf-8?B?bTZDQWp5Vitkckh0ZTZaTUtpdWpRL0pjcW51SndiWmhzbVpYS3NGK2UzVERx?=
 =?utf-8?B?dUFoUENyK0htWVVQRTdXdHg3V21lWUltL2w1N3Ywd0hIenB2dFprMnRicHR5?=
 =?utf-8?B?OVIvWVZhenJwL0VEVmZ3UXJIQTFXS0o2bzJTcDFvSCtaQWtPYXRGclBENkRO?=
 =?utf-8?B?VjJHR1p6RHVFY01Qc2hMbGJMbm13cW1Ub3JxVkROR2VoenByK1FwdVJlR0FC?=
 =?utf-8?B?RXV1eFVjWkp4UVZlbXl1MjIxOUxVVnBVazhibllicTFKM0RBN0pCblhPYXJY?=
 =?utf-8?B?bmtzRVV2cnBqNzA5MUl0YnJWbTZZZ0VndFRNeXVtS3UyVDlzejRhTE5LTm1O?=
 =?utf-8?B?a0NZNlBsZXBEVFo2aGJ2Y1NUR0Jnc3VmWjBTd0puMW9FL3VpVE5FUE9MRzFU?=
 =?utf-8?B?M0FoZlQ2ckYzb0JqSVpPd1NMeXFJazBFcm4yRjVaaFo2Q0g5c0dYSVZDTGxC?=
 =?utf-8?B?MkdzVm5WOUJwTnErenExSnRzanZHYzdzY1F4UkowUzhocjl6dnlWUTE2elBX?=
 =?utf-8?B?VVlzTk5COXBMUmV4c2w4SEFPSUFKZG5EaWlIcDl1VVIzWVoyUHdVR0pWZWJM?=
 =?utf-8?B?MmllakFyZTVrb0dhSzVBWGJuRTRZSnFTZlkvdnJ4ZWRCWlJ6RUNjcDdrL2x6?=
 =?utf-8?B?a21Ha0pUbjVGaWVLWXVIeWRGK0d4TjJIN3g1R3VHVEdBemJ2NHpycDMzUFRQ?=
 =?utf-8?B?a1pTT1haNDd1QVJZbGVDWjhhYXpHTTNieklKWXJCR1lZLzJIc0pDNXlsZjEr?=
 =?utf-8?B?OEV0YzIwS2IwUTN1bjFDbUp0SVpRdjc2blBFNUZ1VkdXNUxVQUxKVUlTeTJx?=
 =?utf-8?B?ZmxZR0JER2RpZTRyNTlGTkluTmo1a01EUWRhR1cyK1NWM0x2dytTb0VmWmVE?=
 =?utf-8?B?ZFBaOXBvcE5VcFNFaDljeElOSWN6ZzdmLzBNV0xqWVZyMjVSMTZ3WUs1TGp6?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GvnnSZcUh3hxiCouVor9Hvz9R6pFZ3lCF61JqNUwoWA4lHBHv1SK4KYwr7GeqLVB+HI1XTMV7hUnnFGHiIJ205TeGqZ2mwzU3DsbWVxapFrqOBizmefR6XV4JxsczyIxY21QJsIbWwok09RDYsqlMSGkAXoekOExvzh1BxXaQrBeaBUSvpwrgtOYKUiQk2b2KrCOUmaX/JodQpBEmDjqIvzBkQ0euFng1S++H+2aozM/AoUXi0+fWHdve/CUmh3oa1igfiEfEflRvmtwARZLZitSlY6QGQGqeLwjWG9+M+P3KH/HRJpUiFUSHAfA6nY8yXjpmy6TwV8U4lgr9eFtaqLAIrWx8R0sFdLVxCjLc/PVMGPDlch6lf/HeiYaekwvQMNANqEJ+XdVOF0/VIPIlg3L7zvs9kaumaDQIl8J+A0cd7iduZQG1SPqiufNN46bOGQmzHJxwZD71Alu4K0qajlOgJlo5rJOL6gJAeKuzRnl/2hIGRTzXWYV9BHvHlGbMl0amZm6+eS4V+YanFSt22vIrxVAvuB75DIWLCOYm4Ry/4fCXjHuOTbIFkyiRdhLvvusAFUgnvBZNTL1VKl28zEDxolAFMlSGDBOPbV2kByeUGljU5bCwvo5rjtnJ9iRok2j32c2srDBRxMWAk/aah+fS3IwbQeLStoDbwVHIp0+Yl0YGrCMexv8SY/5wR+5YaRjFg7IXGItneGk0Z+OhjNOAfLoTK0aky+gTVNDAT9QYv9nHoNOZUvhAAS/xW45p69PF5YXYHMTNCxVaDdSPpPoBovDInQXSzRtR5p30aj3WwItR8Rjw4T6DhInwWM+ZdahPVQ7JMeiPvAkeDgOt8UYTHx556WnlF0JHMrFY5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ea31bb-2af8-4e35-b998-08dbaad68852
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 10:30:59.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieK8o89dwlZydCUzNNvQXSOZi96h9XkCJS0dRiVDm0kZhvAONfMw6g+hD/vGS66J5OTB1BqFVObY7KqsK92/9Xlrg23QhbL4ydWEskMbnx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=733 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010098
X-Proofpoint-ORIG-GUID: iAheB79L2muFKSzXx2ebZA5gFS_dEj2X
X-Proofpoint-GUID: iAheB79L2muFKSzXx2ebZA5gFS_dEj2X
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/07/2023 21:41, John Allen wrote:
> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
> be exposed to guests to allow them to handle machine check exceptions on AMD
> hosts.
> 
> Reported-by: William Roche <william.roche@oracle.com>
> Signed-off-by: John Allen <john.allen@amd.com>

I think this is matching the last discussion:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

The patch ordering doesn't look correct though. Perhaps we should expose succor
only after MCE is fixed so this patch would be the second, not the first?

Also, this should in generally be OK for -cpu host, but might be missing a third
patch that adds "succor" to the AMD models e.g.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8ba3..d132cb3bbbbe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4731,6 +4731,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Rome-v5 Processor" },
+                    { "succor", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -4806,6 +4816,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v2_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Milan-v3 Processor" },
+                    { "succor", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
@@ -4880,6 +4900,20 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { "succor", "on" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },

