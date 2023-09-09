Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1879993C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 16:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qezPQ-0001Hx-RP; Sat, 09 Sep 2023 10:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qezPO-0001Hn-OB
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:58:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qezPK-0001AN-Ex
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:58:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389DWU5e001139; Sat, 9 Sep 2023 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GhN3VtMh0MCH4eH3BzF0fzbMTbij8bvRdt932bd4DC8=;
 b=c1sC/NXYHuq4JmkRAf6yi0HTYthMSJtCVZBsA3RcGsNVRQ76WcIDJnnJKKzU2aOqHCKp
 Otr6mwzEI6C7hJVD46EynlGXqOejNFHSryPTARXJusijunifnqXPuP29qYqg4HHHVA6e
 zgWkuOVks/LvK1dxm5LVJI3WbccV6DH1V4rzyidv38oHF3drUoWUJhOLeMxhEH3gxlfu
 yX3SPy7a/hY6C/54vpgnWBYAQJkGfTFTaA/mVfvot1SELDDOQZ++can1PLQEFdoQgOte
 bDXNMSc8W7GYMvpaEKbIVz4CfDIAiv/WfO/M4BPWdaou8R042FS90Q/t+3meVqPpSBJA 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0sjg01ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:57:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389E0qsM002265; Sat, 9 Sep 2023 14:57:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f58w8c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7KxHSeaX12uUq1zeGYTqQrjK17c2ZC0VH9kHgudaJSKeqEWDboKSkm1Si99Uf4F73xJ2QPGRlDTfLvUwQwIVUvnGyXhpsYsF3bC172ryTvtKRRPQqMdSo+kd20JdMPulJImQ16fZvKoMRqAqaMtidUORGyqHdb/DVY0Ek+StGlp4qZ8c1nSUwMkR4BMOmK48A4h6nFzEfXzXuQ6Y192ZmTqDqtbxmvLclPKrN7TJ3vKdQXzJSnxm6+GoOeTy7tsFLbyyzXInyY/N9UmZztUAwSD0plwFNYa5R2+X4tW7izvfCS3SEtUWSUkkSOnFtPvJEmk8DKEw+Iu1+uWbhl1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhN3VtMh0MCH4eH3BzF0fzbMTbij8bvRdt932bd4DC8=;
 b=VoLD6IyDjdYZm4v3fI9s3fmbWGiDIrNdQlSn48S3WOmimEi8bS2kqeBUk5x4BuDk57XHLdXTCNTqmR5ZegCsBrokIidj3rQ6QcL/2dV2ynI+NOl3z+1gC1XmOnd6XkaLgzu1iB/9uPXNOXAy/RYpIEQtKiOSaeYuYSZ42ZvaWjIyYJ69aVoQeWISK5Xk6XL6Yopid9kCT4csf0JZ9y0pWau0t/8Fw65yP3pbm89u8SxJfbGG5DfIqcrohQ80FuZ5/5Z6/QmJWDmW+d4GtRPFpnByhGtmMD2vL0VLHhN9OuUuiuEjZs75+HzXlyW30I8ZiJ/8oxgiY2Wh/9rNojDo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhN3VtMh0MCH4eH3BzF0fzbMTbij8bvRdt932bd4DC8=;
 b=aXU1ZnjOlPcK9vfU7vU5xYw5IHk7Q4LzNhKR4iLQM8kZxB0EK/70E7H4zAyccGkjJyLp0fWiWlP9KOmfxTkmZ0f+1aCJeT4Sw525BCEsdGmKP/OsSgLbP8klJAytbnb51u/ZDEwlJhRnM7vLF3d4GSzT/YdQqoQU4cO3IBM3pTM=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Sat, 9 Sep
 2023 14:57:52 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 14:57:51 +0000
Message-ID: <40a7a752-7bdd-968d-ec5a-2a58f72a6d32@oracle.com>
Date: Sat, 9 Sep 2023 15:57:44 +0100
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Content-Language: en-US
To: William Roche <william.roche@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
 <e2adce18-7aef-5445-352a-01e789619fac@oracle.com> <ZPiX4YLAT5HjxUAJ@x1n>
 <3968a8e5-4010-0c97-7e1b-0dcba64ade01@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <3968a8e5-4010-0c97-7e1b-0dcba64ade01@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS0PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: a10bc056-c759-4764-785f-08dbb14523a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKOMwAwydhOdYjQTB5juCct1eJKRbQhFpm05UG1WA26/6zKJN7H1yrA8wuCpCSjBr55+doKanimbThflzZEn5Us/2FoCtHOZnORWv7a/J+r1hG1wEgJQJjPgAT31qQTAma+vnreglV3mQ/7/+fvKX1CTWSK+y5mn3IA9V+1QhiC/zXX6n3osy49jDrrjpBzYKOgZdH1pEWWzr9xl46YRMczz5G0i4cQ1S6CTO6ErqtueKkIFdQq14ooMLa9yVB6UOLnPJ6e1EdMe1eR7/CBjmHUXtifQTvA+eSJbGHb89RnhuqMms06VLk1M/8bZ/lMwrj3dqOTOd+QHWKwQrmePrgLkTSd/MITA7jFjFI1V5iA4iXRspzNG5GVVPcm2GKUgoJBI+nEjyTcdZxz9/B6etXlIZriy1mQqDbHVd9g3hTEDvlxG7r4aFfhB7Dns8iAouG7tGcXuzRL1Gxa6W2mu12BXn1h8r2DqSnPjhZPqIWtdjmjsoZOkcv6ZreFjT+r2kZJDYNe3+DswV97NHY0RKK8XgaEbZGYzc9sR72O3WceGjbF/OyJJJUJtN1yG5ukXRVotAeJ1aUS6JroZgUniCA/9+HL10+khd05LqjMUOjp+9wxokJ2uQ7Nmk6kP3e6f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(1800799009)(186009)(451199024)(31686004)(36756003)(86362001)(31696002)(66899024)(478600001)(38100700002)(2616005)(26005)(5660300002)(83380400001)(2906002)(6512007)(41300700001)(6666004)(6486002)(53546011)(6506007)(66556008)(66476007)(66946007)(54906003)(4326008)(8676002)(110136005)(8936002)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRtRkFQT0xkVUhPV0NyRG1kV2ZnWGZnU0JqdDV6emtod3VDbUo0NXloQjg5?=
 =?utf-8?B?TmZKcGF1SUNKMURMSnBXN2MxNW0zc0FCblh1b05MbXJaNDZJNXU1YjZCcEdl?=
 =?utf-8?B?bnhLUVpsWXh3TnRtZGFxeDhWQXhNNExDQ3RhQWNmaDFNbEQrUU16WG5YRXo2?=
 =?utf-8?B?K1REVWtsYll0eFpmS2RYa1VvYzVveWlWd0tQWDhpSFVKUnB5OC9NM2V6Vkda?=
 =?utf-8?B?YXo3VkphWi81ODliUUliUWZOSmtiRjJtZ2RGOXNwQ1FSaG5vdjJQc0t6Ky81?=
 =?utf-8?B?Q1h0UTJ1d0VqWnVZL2FFR1FheVNRc0wxV0g5bmtXZW9QWXIrR0x5aEh1eEhj?=
 =?utf-8?B?MTYzTHZzUFVSSTgrdnR1bEhHbWZYUmU4TWNZdnBpVWNyZjRMVmpFME5FSWF0?=
 =?utf-8?B?Y2dYckNYd3ZtRnRuSFE0c1Z1SEVPKzlIOWJuSURkcnNyUlV4c2NDMHkvakNk?=
 =?utf-8?B?SkE5eHp1RXh0SVRtVVlxYlpQbzVHd3BqbzhVVmo5bTMzUktwdDZUbXJrblNj?=
 =?utf-8?B?STFpWC9wdk5DdWo1UHNMeEFaM2RCNGtjeVVqMG1MVFFjWFdWUHJiVFJ6bjJu?=
 =?utf-8?B?N0NzRXdWZldRbWNYTHhRTndBdmllMHgyTHQ0d2p6VHNsOElZNTVtK0pneGJL?=
 =?utf-8?B?NDgwMXRiS2l2NTkvUkJIZEM1ODhmTmFJUnBzQnBtRVROalJTNnhyUjhlZVJ6?=
 =?utf-8?B?VHV1TWNPS0piQ0hiaGU5ZFNVbVV5ZTRSWmhxenRnV0VyNVk3WDI3TmRRUjVE?=
 =?utf-8?B?MWoxS2xyVVdGOE1ySXpYbk5KeXowdjFjNHdKZHNoc2dyQ0Z6cllLbXQzUW5k?=
 =?utf-8?B?L3dVSEtMT3piVUpNNnZUbXJSQmx1MWZqK1JCMHQ3ak1DeWZyd05tZUI5R3J2?=
 =?utf-8?B?Zlp1U3U5MStLUXlzS3kxUmEzSXlvQ1R6a2JiMkh3WDdzenFkd3YxL29GL1VO?=
 =?utf-8?B?VndpV1VEdDA3ZzdXRmlKSWNRcUE4WFVDLzNQaVhRV21EM0w5Ti9Ka016RnR1?=
 =?utf-8?B?dGdXRUlMQmJPVGc2eDVmQlBxLzcvZGR4MzBzb1U5WXNSM1g5dU9MOVY5VWFa?=
 =?utf-8?B?dGU2S2c5VjRGUXpyblZ4TXhpT3RwV1NnL2xsR3BrL1ZidFkxOG04WEozMUt6?=
 =?utf-8?B?WmNERWQ2MGtxSUVnd1Bvb09pclVjYkNpUG1WR1dySERjUEJ6MmVBbDZJMjBH?=
 =?utf-8?B?MTh3eUcxYnNiVzdlSExQYjhVTTZFUzFpL096cnZuSVIycGF2Tlk1Tm5QOGlL?=
 =?utf-8?B?TmRqSmZ2dEVSdkM4T2ZicWxwOSt3MzZiRUFwV0V1UlI1NzdxVk1HY0g3Mnp4?=
 =?utf-8?B?S1I4TkpNd2c0Q2NNWG9saTY2S0dpeCtTQ3VJZ2gvUFNPenRIVnJ3NE5oQS9X?=
 =?utf-8?B?dC9ZQ2gvSUhJVnJZaVJNMlhCK2FUSzVvUTlHMjA0QThsVnZhUThBdTVqSmhJ?=
 =?utf-8?B?OWQyZEsrLzVueXNteXZrUEhmWWxhMkxIK1k1MUdvSDBiMkVyUVFub1R2aUpG?=
 =?utf-8?B?R21BbEpTdkdhbExLNEZzVURKVkdMcXJmT1FVWlJyOHQ4K1QvQi9OOGlVR21O?=
 =?utf-8?B?ajZOTXdqZk5XVUxvMlVuK1U3RWhUbU5OZndqZGhoL2VFeTZGRE90eVk4OXZW?=
 =?utf-8?B?cURpc1dKU29jbEpTdmVRMy9GOWFWbmt3dXA5dStvZGRiWjB1QjNjd2tMSWpZ?=
 =?utf-8?B?VWtCQlhRUHAwZXM2VDRMc09WM2FzejhOSkdXZzcrSGE5NkZucFFoc2J0K0Zl?=
 =?utf-8?B?dzhhblNLdnJDdUhDZlRwVWV1eDRVajEwbmhOTnFnU3l2ZTRFVzZQNWNydEo1?=
 =?utf-8?B?S2ZnNXpNZURxOWp2Ni9BeWtJNEJRU2xhQ2wzRnNuMWdVM08wWGI1dkJSUXFz?=
 =?utf-8?B?M1IvaUpiWjZpczVjc25tbzFoNThhQ21XZmJKeGFYSVBWWHp6NHJWL1RhY0Vl?=
 =?utf-8?B?Zi9XekVIV05RbjZzQkRvSFhGQll3b0xkbHlsSWtPZlcrZ2ZoL0tnUzJBVGZM?=
 =?utf-8?B?eTJzT0c4cVVDLzFqdmZDNmo1M2JqMFRNQW91QzcyakQrTkltNTdxbEtDL1Qx?=
 =?utf-8?B?V3EwcVlCNTB5czVyOWlqZ3R0K3pQTzVNZHdYZklJc05HRkRIUTJZUzdpWXFN?=
 =?utf-8?B?VlMwS3IvaCthak1DQldLOGd0M01EaFIySVF6dTN5RS9qWm1lVFNsRWliOFpG?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E7qCG+l8zZtWkxH4d1VanSmwA7e6mbTLoIJsZiIYJESlOCutR0H/t3cL0sHDocxyykSedieltm1hGFhpK3G0USj0NtWOEDj5OnW/dUksHyC1UYwtw9m/y+bFUM/ELFIuZUR/TPoJFG+mX+eKsVcG/n52I3VwxM617PVLb+5EWNHnYu5v1W1j/PemINnr/aUQtZtZla9Jpo8TvcH9kGhxiEYPznDsWpNPKmAP9/cpGTZtujaHwLoRHE9xWdrRJj/FInRD0YJnVhg/ZMnaL+pX/t17sst2m2v5N5DIXktPKtUWVqYEmkCixRmYmvQcmXLzSct7MSYPxINRQzgaZAVzsTh5v82n1bwLlCZJNdMUrzwpPXMMR7BoHJfWTICPqvUwXdW5TKcSZoLwTVJFSxZ8SJma8nwlbQBpfQyxR//bd8lyQPsnV2dMWg8K5MYqs/Lhxz27lJ2Z+njP4BC2XifSfVnjlh6oAo//hnBe4hqKaafrRdYC07IKqj4eT1wOSCsN/3H1whLCHPBsOEulEMU5+0dmWougY+TnND3ysW0GK+yuNR/Uk4G419ehTZ05i+hXYYk8sScFlE/eJkjiOM4TAhdGllNhOkx7PAdsEQqey2wIIcQtslYkMdmSYqCSLJE5Is0z6xDM7gXYugJYLamqbzpsHX7M7ZKJ3a9dQUpVDQevfPu5sMdQJmXybq7RHHJWY5DDH85j+AHkw5eCnHGPw6RlADh+d/3cFinqOs5EZF8na01fkV2ijHv7PJSZQkNBX/LLJSv4l+FGYf86fixhZw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10bc056-c759-4764-785f-08dbb14523a1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 14:57:51.3593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuE0tyNbM6X24zVr5GELSpsLHjJCp0ynucdb5wgZIu+1AIi4yiVS9cG4whcDxqz/j4AtTHks0OPBEotrrxBy+UgINDmvzAiN/ctbv59Uc2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090135
X-Proofpoint-ORIG-GUID: T_kE36D2UV4NfU0Gpzql2OSpg-hhMKn9
X-Proofpoint-GUID: T_kE36D2UV4NfU0Gpzql2OSpg-hhMKn9
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

On 06/09/2023 22:29, William Roche wrote:
> On 9/6/23 17:16, Peter Xu wrote:
>>
>> Just a note..
>>
>> Probably fine for now to reuse block page size, but IIUC the right thing to
>> do is to fetch it from the signal info (in QEMU's sigbus_handler()) of
>> kernel_siginfo.si_addr_lsb.
>>
>> At least for x86 I think that stores the "shift" of covered poisoned page
>> (one needs to track the Linux handling of VM_FAULT_HWPOISON_LARGE for a
>> huge page, though.. not aware of any man page for that).  It'll then work
>> naturally when Linux huge pages will start to support sub-huge-page-size
>> poisoning someday.  We can definitely leave that for later.
>>
> 
> I totally agree with that !
>

Provided this bug affects all qemu versions thus far, perhaps should be a follow
up series, to make the changer easier to bring into stable tree.

> 
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -1145,7 +1145,8 @@ static int save_zero_page_to_file(PageSearchStatus
>>>> *pss, QEMUFile *file,
>>>>       uint8_t *p = block->host + offset;
>>>>       int len = 0;
>>>>   -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>>>> +    if ((kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) ||
>>
>> Can we move this out of zero page handling?  Zero detection is not
>> guaranteed to always be the 1st thing to do when processing a guest page.
>> Currently it'll already skip either rdma or when compression enabled, so
>> it'll keep crashing there.
>>
>> Perhaps at the entry of ram_save_target_page_legacy()?
> 
> Right, as expected, using migration compression with poisoned pages crashes even
> with this fix...
> 
> The difficulty I see to place the poisoned page verification on the
> entry of ram_save_target_page_legacy() is what to do to skip the found poison
> page(s) if any ?
> 
> Should I continue to treat them as zero pages written with
> save_zero_page_to_file ? 

MCE had already been forward to the guest, so guest is supposed to not be using
the page (nor rely on its contents). Hence destination ought to just see a zero
page. So what you said seems like the best course of action.

> Or should I consider the case of an ongoing compression
> use and create a new code compressing an empty page with save_compress_page() ?
> 
The compress code looks to be a tentative compression (not guaranteed IIUC), so
I am not sure it needs any more logic that just adding at the top of
ram_save_target_page_legacy() as Peter suggested?

> And what about an RDMA memory region impacted by a memory error ?
> This is an important aspect.
> Does anyone know how this situation is dealt with ? And how it should be handled
> in Qemu ?
> 

If you refer to guest RDMA MRs that is just guest RAM, not sure we are even
aware of those from qemu. But if you refer to the RDMA transport that sits below
the Qemu file (or rather acts as an implementation of QemuFile), so handling in
ram_save_target_page_legacy() already seems to cover it.

> -- 
> Thanks,
> William.

