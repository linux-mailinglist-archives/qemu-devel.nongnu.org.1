Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2CB811737
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRGz-0004vI-ET; Wed, 13 Dec 2023 10:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRGx-0004v5-6f
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:35:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRGv-0000fA-2q
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:35:42 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDER9ur021141; Wed, 13 Dec 2023 15:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EQ9cKhGtkMKKOEVbu9P5IR+GEwq2eIpwxDBZhq+7olk=;
 b=VZ1Sl42hXq9XGDJy15m0VxqvJ/GWF7C+qRg0Ai97nbXLCYQVsDj2ogo42VzD9B6Bz2AN
 iCK6r7zfSQbz6YkLcNAEcbKMjeDHe0Wq2SbPjeKNBDSTIRhyaSFojmuP0HUQj0BARumB
 +MHUPFWz6dgSUbDqlYzkN7a/Asy6VRMfkKw/fpVDedSj4QaUk/eyRMLm2k8XwjJuGdfN
 FSXewlUy05M+aa/367HMUU7WZkkQJSpMPpuTgmWrykbbjOSRqlhy3w8/LMe0WoVIZ54Q
 G88oVQkmVMHPa2hZWaSK697mr38RlDF31UF+FrPuTmWe+WY4UoISEuFkV/1PJAqzsJ/j 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu8grt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:35:39 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDFHLg9008345; Wed, 13 Dec 2023 15:35:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8ea2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBeZW4wEuHNyAUKlbnBB11M/AzRvJ7OquVG1T9JVbRSISKxcmvehzZcNQY0pdUa7LFxwF/vtktFjH2uLsWSMbEVRbG6V90Qx4qnQqDp7kP5jMwTTD91Izu3fOEfXGTgqHENP4yY53IhKYezs/jL0gJW0eKe7fnuvPZTH8GXJgd00ibVJoXW9TyRuNgat2tNH4lbYOhuyal0pYA78Y73rXf4oYn4RJ33QctD4oH5EN7bGNwF9qubbaFMxCLgCYNhchEnUOk9TXuhqgL9I75YTDVw2vjpRYyPISzfhWEOZ999mzBCjVBRuWg2lgnijFAc8V+vC9HBYprxhRiGAJ2dpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ9cKhGtkMKKOEVbu9P5IR+GEwq2eIpwxDBZhq+7olk=;
 b=l7TxV2sud1enujirhXXw5rqtaMEXE3wnwLnEHnzdat2EKfQDGtdFwh9wtmzLwaO8mlzEEzZijUg5B3gXRLtgKeGidHbxZL7LSjT+7tdseokyij/049PLREC3zo4COKN3U3gVzrsUcSCt3v/sVGaZeZiyoE3uGijZnyfqdaM8s9s2Gj+yBTlm4xv4hPi+JDPRUvwRhdx2SeYtBEuofNyfqx3IO0u8C1SYdeAXX4cwgvxKKw1WRnx3pQtSlWEJdSKCPOqn91yyqNz1j+gWGr2Y9xd9PNqUIqSFYCum9Q5ukDXRDlL6ZksCJ2bfEooL8jzo+Y/oXf89eXrEVxnODrafbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ9cKhGtkMKKOEVbu9P5IR+GEwq2eIpwxDBZhq+7olk=;
 b=vpbUksMx4jaoXv0XnDx3caK05BpTLttf3LRDbvskNoRVd6bKG2u1muMmrQCFcf464W5db9//9k03LAGZDOtiTtGyl3vzre0SPVS126yh6KmQtDqL88Z3vO5aBkE5LrxEeArhukBb/OSTl5vjd4/V3449sVNnrjMDNiRlqvTg5pc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB6282.namprd10.prod.outlook.com (2603:10b6:510:1a8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:35:36 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:35:36 +0000
Message-ID: <a9ddc1b2-d4fc-44de-857b-2aeb35fa0925@oracle.com>
Date: Wed, 13 Dec 2023 10:35:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 00/12] fix migration of suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
References: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4e53f8-5bed-4a08-f034-08dbfbf126c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUNpxzpuQIFcvKd1fi2A63kfqxW/pZw/PGiOlvqvtOh7FXKUR9P5Q5eCDeXSUMMeObnFBSvzE8a8VKrjD6JDWlpdA5/CeDoGfLPCaS7Jc3QP5IoWA0J93w+/D9Lt7RAqXgwXw/tpCSYjbRSCKnGmirpSx+bnXBfaPspabEuMVHPUL8ms5UAGV/2Aby/MNa+8uXSaOjcgsXsj2NS7uTjrHzPrqwnWiMe8lEenvRduPbCf2VpbsD2Sdwpnurl+UOZzmGyQldoBqUA2jo1Wte74X+WbcZM+/cPSKMBPdU/yUIjKqlw7g271QoybIDfKhw+6wCN0pIeL0Am1K4IXIJI5Tyfznom3VNZGTTQZzs1Yd2YxEVmGOpwGQwSPJNH37gFHcdL9DJzx5zcsZT+5DmC6p9xN4ohys03/JNCPW+KPj8bR3w9gHXcxTJY9AgmY2fOcdeijkoK/YGsVJJ/S4ayohHofrVfSfeQIo8r9+3eBVLQxZD3tKa62whKTeJriL4zGPXGi61VE0aUOecMM8OuLAaUXCfCdo1mu0uJeFs/hJ+F7jdgLLceCdvFHsq4csQxPaZJDn9CXswuBq9cP5XKulNBLnXF68wGKglxzTmxyYAAXhRWTiEe4mMXqj6h6t+TCbAQBG212/Wuet6Dh8mo6iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(54906003)(66476007)(31686004)(5660300002)(15650500001)(2906002)(44832011)(316002)(6506007)(6916009)(6666004)(36916002)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(31696002)(86362001)(53546011)(83380400001)(6512007)(26005)(2616005)(36756003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3FUM3JKVFppK3EvK3VUa1MvL2lOU3puM2dhMThFM0pXc2V3citjeXhvYWhN?=
 =?utf-8?B?d3hkbTd3cyt0OFRBRlc2NTIzQ2JoSThZenRacE5LNUUvUVV3ZEx2Vk1aZ2dR?=
 =?utf-8?B?VFZZS3JvWHhYWVd6NXJpQUhCK0pvQkxvREtZYkRiaWFPb1pnS2cvbTFwY2d0?=
 =?utf-8?B?WDJJTWMrZzlvem1BK25hVDlQWisvMEwvYjNLMXczaW4rTlNuZGFVRmhTdUN1?=
 =?utf-8?B?dTFoOEM3c0kxR2dhcEZHYVA1ckdvTDdIdTFIR0wvK29nbVdBT0lXWmdETGcw?=
 =?utf-8?B?Z2lxMktOdWs4ZkVrVnlYaXVyQ0F0ajkwQ0E0UzVMTzFFeVhld0l3WUdyd09P?=
 =?utf-8?B?VXFWMnE2N2wwckNwaXFnYWlDdjJBQlNwWlhYQXYrWWtzdmF5NEg4QXFOT1hB?=
 =?utf-8?B?cjdZd0pjcWJQaTZvZ0toK0JYWmFObGwwOTRwV1phLzVOamxITHRicVR1WnJ6?=
 =?utf-8?B?bHNIZmhha0QzbEFTaHF2STZPaGF4SVJsSTYxSFJvc1krd1BRTEJIYmk0WTk5?=
 =?utf-8?B?UTlNbnF4TFdnR2FmZmQ4QXRDZ25zMEVwSDZrbTdGRHlsRXBxYUd0VDB0NXFZ?=
 =?utf-8?B?UVh3b0dwL28rNFpuVmJBVjZzWVNhUEtZSWZXclJjNmJtVE43eG15K21kSXEz?=
 =?utf-8?B?RDQwbDlmcS9CL2FwTmRSTklyZVJHdi9VOXEzaWZPREJZSERQNm5aSVI2VzJO?=
 =?utf-8?B?QnVjMWRUOGpZNWt6d25GSXZVNHVNc2xJelB4UlRuY3AyUVppb2tGY2Ribk5C?=
 =?utf-8?B?RkpvV2tLZWFyNnF0bkNuVkttaEl6ZVZPMVR3elVpdUYxRjdRWjFFeWxFZkRt?=
 =?utf-8?B?ZzNQdzVlejZHNzBiek1FNitYQWlhR0YvK0JzU2tvdEIzcEtUYzY0VFRzc1BX?=
 =?utf-8?B?aDEwNXBWN3dCMXVteFk1QzdSN09Xc3RYeGdNNzZUQ2FEak9ZWGV5b0tKZ3E2?=
 =?utf-8?B?dFNtaDU5eTIyUmlPaWpFckFNYXhxeGNZWndsWHV3amt1MlpQZmpzbnlHdTFS?=
 =?utf-8?B?R1lmQ25OY3kvM3I4S2Z6alhocEdFNVZaVDYxK3NhbVIxbTdML1FtbGlMdEJD?=
 =?utf-8?B?TkNycjNkZ1JPemtkR0xqRDhQaWN1VE9VUEdCbnBWZEVxU241d1Fha1U0ZVE4?=
 =?utf-8?B?S3llM3ZQaG54eld2SzRCRUthWWxWSXI1UzdHM2NsNmQvcDhxSWF4alN0RUla?=
 =?utf-8?B?b3lmdHhGNVJLdVpIOFhjaXJVaFViT1lBZHZIc3RsM1JoN09kbmxLRldmeEUz?=
 =?utf-8?B?U3pWaW1yVjBTcTJiZnl5cFhVTjNXbXU2WjNXLzdaVXNibUI0a3UrcDFJRHRE?=
 =?utf-8?B?eUlNcVY3dVdRa29JbVJRdkZrY0wyMk9tdTI5MHo0eUxIUXhRS3c3KzFDcWFO?=
 =?utf-8?B?bnRmV1g4bHRSSnlJZnl5Yi9zZlBsK0orb1g5VEhNMThFWXdsQnNMeFFNd3RG?=
 =?utf-8?B?WS91eS8yZTFvWm1DT3BPcE5MY3N3eU0xTjNCZ1dnOFdwaWliT2d1MDA3ZlUz?=
 =?utf-8?B?bGo4Q1licUFYTFNUK0lCd0JoM2dRU0NUV2N5Y1Y2SUFJMEZYYjdGd2NMV3Vv?=
 =?utf-8?B?ZG1tTkRLY0xXOXhWY2dMLytFQ2loeVZpSkxqaWtmdi9DYk9OL3FVTDdBOTlj?=
 =?utf-8?B?SHdJWmdOQlA1anRKT3M2a2pZRzNETExNTFlDbXEzc1RrT1Jmd1BsdTkxczRJ?=
 =?utf-8?B?cnRoR1VYckxKcFVhc1U2QVV1ZFF2S3ErU1ExK3hRKzkrTm00M0JSVy9sUWJ6?=
 =?utf-8?B?Q0FHc0ZuVksvekhIZDFVZFQ5SmJjVVZVamtWSlg3cGtQT2cxVFE4NW5CQStD?=
 =?utf-8?B?czZqL2xadlFVdlY5djAyUEhOOXhwQUxUS09UQ0NBRksyOUhsaTA1Z0lyeXZR?=
 =?utf-8?B?YjVNcnRydDVzcjZ3d09RUG1RUHlicmxOZjIybjRVUk9BNTBpcFp3ZlZKSFFF?=
 =?utf-8?B?SGg3R1czT3loMG5HRFZiQiswbmx5bVVaR2k0OW1mQVN6SjZrMDk4a01ETW9r?=
 =?utf-8?B?SkM5SEo1MTk1RzMrWThDM0QyRDNLc2c5VlYzRVd2eHRoVHlzVldDTTlOOXZL?=
 =?utf-8?B?UlYxNlBXTWViY241Wnk2a1BQNlBjOHlLNUZxaTRaVkZaM0pLdGRiQi9JOUYz?=
 =?utf-8?B?UWNXQ2hPb3ZFUzdjbFJ6ZkFDbkV0UGNuYXZzU1JCNERxK0diaEdqb1JvbjhG?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kpoh9P7cjVSPMVcrSThp+V5Ct6cRzsYX+2C63958HRmMNpchauEGglzhadMNpjh+HepT56Mz/BEX5TMdwyP9ZBLHcF6OWk6vap9Vdg7AvfopEsLlf0LiF9fdB8HDsvxjj4y71A+ajYmQ1jT2hppy/ZIDJ9/4dBQtGioljQE/tFgE2Nl0+/EQ9GUCFNK7Ad2qF632oLTpPC0jyo8suphVmjoVB3HeRbRCkYe58daVRneVIGT5QpYbl6tHSv4tB2H2tMnfE9s0eaar7Y5PUc/tUu0lpBwlWvbpSwnSoTcUsWCR0gtGqM3ik94mRoaUXsVKybuWzZJBIU1IlpHYIzrQPYNYDLB8138OVLO/TGTR19JfQodeGQ2IUQloWDQnQxBGaCY4wS4p41fpJhxqvymsfb1hTX7PLbU8mhuV29LlGP4Xg84I3vF8gkbxL1/7W1DkI2lzOJxLytUAEaPyYTht11OHvxOMNoHZ8HjMMvVSzNDFnDZel80/E7nP9w2zggRFESO/dlqsDBU0K9RleNGvBk9di6MGRYRl88ywVopy+njjrttuRVZJpftO1UgHVRGRUx24olhIS/g2cSqlcfofJJ+qHm9qIVANC5jjbM4XpyD740EmHRZ843dKWOtoeSTRuWZARzW5wHINmqRwv8nE+hANNwPEo3c2rfTVR4WPAOYeVpWUyuJO+NHD5gfA4+eyJ3OTJZWlx5Coi2iHQOL6nXwaQDdNhFSLyd5fElErXVfC7l+WMS3oQl1z4G6u/361Tnz+uQk9Y55Gjph4gSUEJE3GwE5i7bPHcXwTDxxmhWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4e53f8-5bed-4a08-f034-08dbfbf126c7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:35:36.0634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 483j+VsWmlTIH79CW9jEp0z8N1pzoMT9i1LQtm9i/Jium4zl+fwuUPjqhWfNtpmf51D4ltfOdZ/nnzFDiAnpe9laCS1mDRzJHLth+jvADls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_08,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130110
X-Proofpoint-GUID: Qo810OnkyIM0Q9wEwR_4dVtWhtPl8_yh
X-Proofpoint-ORIG-GUID: Qo810OnkyIM0Q9wEwR_4dVtWhtPl8_yh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Peter, all have RB's, with all i's dotted and t's crossed - steve

On 12/13/2023 10:30 AM, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> after saving a snapshot in the suspended state and loading it, the vm_start
> fails.  The runstate is RUNNING, but the guest is not.
> 
> See the commit messages for the details.
> 
> Changes in V2:
>   * simplify "start on wakeup request"
>   * fix postcopy, snapshot, and background migration
>   * refactor fixes for each type of migration
>   * explicitly handled suspended events and runstate in tests
>   * add test for postcopy and background migration
> 
> Changes in V3:
>   * rebase to tip
>   * fix hang in new function migrate_wait_for_dirty_mem
> 
> Changes in V4:
>   * rebase to tip
>   * add patch for vm_prepare_start (thanks Peter)
>   * add patch to preserve cpu ticks
> 
> Changes in V5:
>   * rebase to tip
>   * added patches to completely stop vm in suspended state:
>       cpus: refactor vm_stop
>       cpus: stop vm in suspended state
>   * added patch to partially resume vm in suspended state:
>       cpus: start vm in suspended state
>   * modified "preserve suspended ..." patches to use the above.
>   * deleted patch "preserve cpu ticks if suspended".  stop ticks in
>     vm_stop_force_state instead.
>   * deleted patch "add runstate function".  defined new helper function
>     migrate_new_runstate in "preserve suspended runstate"
>   * Added some RB's, but removed other RB's because the patches changed.
> 
> Changes in V6:
>   * all vm_stop calls completely stop the suspended state
>   * refactored and updated the "cpus" patches
>   * simplified the "preserve suspended" patches
>   * added patch "bootfile per vm"
> 
> Changes in V7:
>   * rebase to tip, add RB-s
>   * fix backwards compatibility for global_state.vm_was_suspended
>   * delete vm_prepare_start state argument, and rename patch
>     "pass runstate to vm_prepare_start" to
>     "check running not RUN_STATE_RUNNING"
>   * drop patches:
>       tests/qtest: bootfile per vm
>       tests/qtest: background migration with suspend
>   * rename runstate_is_started to runstate_is_live
>   * move wait_for_suspend in tests
> 
> Changes in V8:
>   * rebase to tip
>   * add RB's
>   * add comment for runstate_is_live
>   * simplify global_state - the needed function, and its use of vm_was_suspended
> 
> Steve Sistare (12):
>   cpus: vm_was_suspended
>   cpus: stop vm in suspended runstate
>   cpus: check running not RUN_STATE_RUNNING
>   cpus: vm_resume
>   migration: propagate suspended runstate
>   migration: preserve suspended runstate
>   migration: preserve suspended for snapshot
>   migration: preserve suspended for bg_migration
>   tests/qtest: migration events
>   tests/qtest: option to suspend during migration
>   tests/qtest: precopy migration with suspend
>   tests/qtest: postcopy migration with suspend
> 
>  backends/tpm/tpm_emulator.c          |   2 +-
>  hw/usb/hcd-ehci.c                    |   2 +-
>  hw/usb/redirect.c                    |   2 +-
>  hw/xen/xen-hvm-common.c              |   2 +-
>  include/migration/snapshot.h         |   7 ++
>  include/sysemu/runstate.h            |  20 ++++
>  migration/global_state.c             |  47 +++++----
>  migration/migration-hmp-cmds.c       |   8 +-
>  migration/migration.c                |  15 +--
>  migration/savevm.c                   |  23 +++--
>  qapi/misc.json                       |  10 +-
>  system/cpus.c                        |  47 +++++++--
>  system/runstate.c                    |   9 ++
>  system/vl.c                          |   2 +
>  tests/migration/i386/Makefile        |   5 +-
>  tests/migration/i386/a-b-bootblock.S |  50 +++++++++-
>  tests/migration/i386/a-b-bootblock.h |  26 +++--
>  tests/qtest/migration-helpers.c      |  27 ++----
>  tests/qtest/migration-helpers.h      |  11 ++-
>  tests/qtest/migration-test.c         | 181 +++++++++++++++++++++++++----------
>  20 files changed, 352 insertions(+), 144 deletions(-)
> 

