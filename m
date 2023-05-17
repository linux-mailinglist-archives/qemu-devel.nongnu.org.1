Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F2706F37
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKnW-0002ae-Av; Wed, 17 May 2023 13:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1pzKnU-0002ZR-MY
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:18:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1pzKnS-0006p8-EU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:18:44 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4Dbl032163; Wed, 17 May 2023 17:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=L125pYq/ylcDxaWm1Tsw/nk0sb84aoCPX6DaLoAGAQ0=;
 b=JLc6h7FiPPzwxzj3kF0XRQwgyu+Rn9Jb764POrwpXtpFEd9tTycSHtJhY9S3L+uNVqcy
 pKwMOPQoAF682k4W1g4DrQk62E0b9DOk5Kzcehc38WWwLE06VVt9OYyuoO1BmDTh30CB
 E877ehEdzqjRsjuFq+b4ZkxA4JfrQG/Qwo5KNx0OMgCQ2X4Po9wND44i7azaDW/Szy5Y
 1jLoD+yXwddpD9Q1YXD8t7eFH4E5eDBbuVWvv3xQl+BYhQBVjp3Lic1G4K7ir8gHwJ7R
 PKpO9sxr+j28SzonKrktOecW4CdYylIx/A1tohi0TAY/c1tmOVWDCbj4/KNDL/cYFeQK gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpfwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 17:18:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HH23RZ004161; Wed, 17 May 2023 17:18:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10c0bxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 17:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR/+7NX0oknoF7wBlshBsFZlKCNUmSN9s6K95a/j8X61KjO1AZe3S0qsTGSFdyl4HFIywbCD3rW825fVEzM2gCCJ/Z5pGaQWFQyjbSAle5llYIkYHQ5gaAIBSCJDUzh2efrUZHFPO1+rV3tCLYnvvdQfnNqwVk3GIrLBA5s9VtS7fxvqPNKLLFGKgSrFVaFHC4umHx6nLoMci1JGXLMzwGGNvx4IQkb19jnFcs8qXT56tPwRCxihMeWSFkx+W/RzHtj1zS7BxHDvfHdTwCG3mb/7vq43KBqp7GN5DmJjR33JIqgN326ctePZPmb8bdOVy/bKDFtkUJ1d2B+Qj1PBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L125pYq/ylcDxaWm1Tsw/nk0sb84aoCPX6DaLoAGAQ0=;
 b=W9VqyHOG0Kj2+PheK2KieMaQ2cv3jGAtu4e7jyWVOMp9YKpqwXj7Jhh0eRcX21VWkwifo5aXs+5P4Y7fKakjXLxPMYPabMFWJ5iaAjB+aPMe6gGX5P7KftbR1bwCqu0SPJXfaVT6l1WXs4bZg11dSKoDVdDtQ/b70ma3I6Epjz7NZ8vi8pXADH/sWCO8VgGDxL8R3pa0+zUEtQlewLZyOTbn+ZkauGX8JZn/jcrnSBu/7RjYBVdWObCqaeeFLGocmBSTbp36/UWPEACL6I2OPVl/Z5iwtYaWYqSaOhX9mkN2dvDyseywvNGf508PT5VbV2msHt47D6pAtBBfAhWMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L125pYq/ylcDxaWm1Tsw/nk0sb84aoCPX6DaLoAGAQ0=;
 b=Hx8M4tslnH9l7R+jFeocbFKe9Rg4qeqdC3QgYasUeRo3xTPz6Z6uuqB+Gphdrv6sEk1k5qWyAUGaQtREmT/Cd4bXcihPeOylItKDM8/UEqcz5JbmXJSUKRn+M1NjfKUvZ4XWXvpY9v7RfCYX1y7+dQ9aKJ3Z5TPrUwzjlsKffmM=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:18:30 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::af8a:9631:5562:7dd0]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::af8a:9631:5562:7dd0%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 17:18:30 +0000
Message-ID: <c8a583ee-60b9-c3c1-5b49-53c793ef58fb@oracle.com>
Date: Wed, 17 May 2023 10:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/i386: Clear xsave pkru bit when KVM XCR0 not
 support
To: Yuchen <yu.chen@h3c.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 Chengchiwen <chengchiwen@h3c.com>
References: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0102.namprd06.prod.outlook.com
 (2603:10b6:5:336::35) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfac0a4-b170-489b-628d-08db56fabc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuDVe37zv3pnMLdDy7pFpVi8W4ea/S/YFgWRBy9eZp1l5CfmcBYyuUnu+t4pvC3LbOD/3dAC5eOxdJELs1R4fhAQhjwQu5m5FWk5FFCf7IPND3HFvZu2eUhHHOh7qOY3yb5Dk/l8dAQIZcqZKsYBdgrDDkEtXcDFIFnhyT9IogTbJoLyk5ZyP8QWXPv0JXtMWYrmsvMok9FJEhfKp1F2bi1A8ZAFKJIMCuWtskMjRF8VjLYM0z9MXkmkBEhFMGOQNoi0f46SDrFk90uVe7w4FMzk9YzPsB2xLy2qKQ+KcqCRTmfN8Vj+l2sh9gM0jNwwqYXYNi2fjlqtIgXsYhs69qhx0nbb6dY0VNBSwMuls/a9zVWCxzKdHHo1QcO0ISkWHZSU5flfGLWsEpLUsU1ShA8YBDngvsss8dpYbywzgMnNBZQAAlW+OctiT5YjA/2nd83ZkmeI2Ef7oajNFJwym/tsEVmZprsLhMhZsMu8OsCEpId+Pro7D/iDV7uuUjKfwPDnCrABgEzeTI+IrsOpekNDalN6ccYJMQdynK6fojW2z/lZmUl6rKTNu0ayEa0/z8oejwu6+yNX0EBD3k3CJ5J8DWlv4t8WIpq1oI/xOuj5FTKufyDpRQJnZkygnhznijAP+baGCT88XGOwxwjLiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(5660300002)(8676002)(8936002)(86362001)(44832011)(2616005)(83380400001)(966005)(6506007)(186003)(6512007)(53546011)(38100700002)(26005)(41300700001)(110136005)(6486002)(6666004)(54906003)(478600001)(66946007)(31696002)(66556008)(36756003)(4326008)(316002)(66476007)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFiSmZnV2V6MlUrQS9jUHlSN0tkVHpuWlJleUNXOXBuMHhLL3VYSWZCK2sx?=
 =?utf-8?B?N2FhVHdLeHFwZkF2eVFLNnJCN09TWmY1WnQzcFRiejJBMHNUSjBrWGI2TW9r?=
 =?utf-8?B?MkpObE9Ob0svUmsxa0tPbmFvWWg5L2ZOeUYyUG1sTXl0eFpSUXJYbTNidDFI?=
 =?utf-8?B?bDF0bjJMRlcvbjJRTHpmOExkcUNzSkp1aEVJUmtETk5zWHliUmNvMjV1RTc3?=
 =?utf-8?B?UFB0Z3RWU3I5bGQrdk0waE8yVENSbjlOM08xV05vaU5kTzZGQ2JYUFhoQ2Fu?=
 =?utf-8?B?M1JFdlcySmJDVHVqUkFBbFFNQ2Fia3prOTNNRGhFNFgxSFF2enVUMllhSGJy?=
 =?utf-8?B?b0dFVHlTenVJaUNieFh3RFBHVUNlVzBINlN6RzJZdms1dG1LZ01XNlpaQlpt?=
 =?utf-8?B?ekxDMk1TWm5yZGJHYVJMdlhoVGV2OWhkZWhBblNCSmJ6T2ZmNXliU2FiN1Iw?=
 =?utf-8?B?M08yNWpUVlljUTcyRGJjd3hVSjU2ZmRqbDI5RnJEbnVsQWpBY3ZyNkJyZWJq?=
 =?utf-8?B?VkExUmRNSU1MOE5jc2tnYk0vZG9sT2NEUFJ5R0w0cGFUZzRNSFdSNlQrZHlH?=
 =?utf-8?B?ZFRKb0k4bU9YT2RFS0xpQlZJNDByektFY0RoSm56eTdVcUJYVFFyc1BFWUc5?=
 =?utf-8?B?Nmt0aFNXeG1qNHEvd3M2TFl1a3JTU281QmUzdThqekZLVXZIZkJSWVVidWxI?=
 =?utf-8?B?L0wyTmNMTFZnWEJvQTM0ZzVJRlpFMEF1bStpRTJ6NCtsZkp5ZEVlbml0NXVs?=
 =?utf-8?B?b09hSWl5VE5xWkJGMHBtdmxHN09qRUlJdVdUVzVnSXRvbzFVSzV1T1ZieXBJ?=
 =?utf-8?B?bXVGSWlDWEFYM1Naenk2S1RCaDh0S21sL2ZrMkRPUDFEWTdWbGR3YXVuZ3cz?=
 =?utf-8?B?aDA0NkF4Rmo2cDEwVEV2aGFWejBGUERvQ2tkb2dUNzdQQ042TERLcytGNjBi?=
 =?utf-8?B?eDNsdlhHSURoYURRS2FBdFFiYzlNQXp3Q0RSdTMwUHlXTjZpcFF5cjN0eXRl?=
 =?utf-8?B?RWFySUhmL0pPMGdudlBvOTZtQXpQd3lJRlFVb2drU1R4Y3puaU5FeXFQQnhu?=
 =?utf-8?B?N1lEUG9jWFd6YUZWWnM4WUR0dE1zbDVzNk5kbXdCVHhRVHhHcSsweURCenIv?=
 =?utf-8?B?enA2eTV2dGMrNjBiMngzNWNPK1BrYmlOdUtpaHllTGNnQ2M1Kzd6UmdtSDlt?=
 =?utf-8?B?c3RHU2hwd0gxZCszQTVjbGhkSjVWR3lVb0wvcEFESEZDbjM0MnlHUytjekZ2?=
 =?utf-8?B?K01ZbWh4NGlDcmhBdjZmQkFyZjNtamVIeXZ5dGl5U2c3ZW1Nc3d1UkIxN2Ev?=
 =?utf-8?B?bTdLZ0Y5MVQ2YzF1YXkwTC94R1lsOCtXNXRmR2NKTVNCdkt5bVVNS2FjSHYv?=
 =?utf-8?B?MFRMYlJjZitRUFFnT1ZRUkx3Ujd2YnhjOFdBV3FKUjdqVVpNa3hwZ2tjeS9t?=
 =?utf-8?B?enp3bWRVOW9LVzFBOTJUa2dVTUh0SmJqcjVNTm9qMStpc2V4KzJhUGdzZnZS?=
 =?utf-8?B?M3ZhSlh5MFdjUXNlcXF1TUZ2dEZQeUtyTXpab2tlMndSY0xla2tnT1dLRHBD?=
 =?utf-8?B?R3JMK3Zsb3NFRjdLMWl3YnloOU9MM3J0MlJKZDRKaXpLbmlyRlZTMlBEUyti?=
 =?utf-8?B?V3ZhUHZjR2VtNXV1VTlQdDVQZDVZc3loWmw4SWVwbzl4R05COWtzYTVSay9Q?=
 =?utf-8?B?OGl2T2tBNzJrSHk0cDBjT3BmQXg2K2NqbnhmaWh6aEFjWU5ZYmZvSVE4cDVU?=
 =?utf-8?B?OEZZc0IyRUpjZVAvbm1aYTgzNS9iYjRBRnZuSTNENzNjQkRGS1lqcWhmSHBD?=
 =?utf-8?B?WHdqMXJJZm55SXc2bVZrY1BBWWJaRmZUeld3YWw1QjBFWkVWTDlUWnRMUE03?=
 =?utf-8?B?ZDhiT3I4a0YrOUNxTC9qa29RUUYxdEFIOTFHNTFaTU5ERS91K1NlL09oMzFj?=
 =?utf-8?B?bGVtOWx1L1hTM2dsWTk1b2RYelpodnozazkwUHliOXh6R2tORW92RUNuV3hJ?=
 =?utf-8?B?TFRpTWRTbE5DS1YyMW83R2RlZW1XMVBNSk5aU0NscHpoVHlhY2g4RWtGUVR0?=
 =?utf-8?B?QkNTZGNPSWZDajI0TG1zN0xKVzROcktPMzVTTXZ2Vm5YR0RGcGR2SmJobGN3?=
 =?utf-8?Q?2wtB14uzVR3uXd2LWV7jpVz9O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5gMGcWCL0ugm6BbII5QbsDBEmmC2neCvskzBZdf/xND7eNB8AgF+UkdTntUGgoDY+8ZkXJjAnLk3qRkT6cbXNYJOrXiuLUhiF11qWNpIeXaiBL8WYkxB/IxskDElaArc6et/ewVltwcL7IAxQCwc+TntCTXfW4crafrVyx6RrdjB+LCsGr0EYGhIN1yuhYfpmvhvyZNyQt29s6IfqddCkWtk7PgNPN+wiaRmEXGndbNxFPhBhdRbrgJHm6SGPMKTzjhyb/HCf+18WdepAFddUuRJqlWJirFY4tlaBWd//Fm3FWR+1KAPWzIjqno3y+/uxCNOnyqlyEUS/n/WgzgucNtB+rPvsfjxdGtbIV0ZixsfUV9Lf1cGwlzYkrHFaD+BsvhzWlNGX80N1yOUyUeTK7AHVVa6AEAV1tHtxMH2FZzOqxPiR9KJ/XA2PB839CnB1n+8joOuIbQaHWDbRDbZyZ/UcUL35tEmB+BPPrsg/GfaofQi/hgNrgZNJD66N7VUb7MYtivvJQYdOPX9GiRsbzlviVfoBOcNeKEdKll8we4BpTF0/alSQN4W350nxabzqYVUS4QuKYkuVWeFP9jyWNF9GRu5aUp2gwQIq2ZQfYhRsIqAbk6UgdnfsMbnKLBIpJ67oeTL3WBgceH4qdsO1WWx9bv1RTgEowqTB1LF0qptm7zTkj034LBnEROy6aQj3Ap/7gWwDLobCHkcfcJsI/1OOmWqlqtYRnA9Ied1LYvKO0OrqunJMEd/Xxg1aN13cA6Zf14ugq1F4aPg8/eynnAryGnAugTQ+fc8I7lntCvQob7FD34RHvBjvb+iDohLJfxusYKqX9MKnJi8ugbG2A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfac0a4-b170-489b-628d-08db56fabc43
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:18:30.5612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F+Swigk78KTXavRaFr/EUxXuWc05cxy29NmfXFaAewuYWpYlXgO9mjYKjN1d5lpc9nzWxAjSWliGdLhRP0HMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170142
X-Proofpoint-GUID: pdSZrDNUF5zLHH-n9tGNj7DVZRtjRfME
X-Proofpoint-ORIG-GUID: pdSZrDNUF5zLHH-n9tGNj7DVZRtjRfME
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Yuchen,

On 5/17/23 03:55, Yuchen wrote:
> Migrating guest from Intel new CPU (as Gold 6230) to old CPU (as
> E5-2650 v4) will pause on the destination host. Because old CPU
> not support xsave pkru feature, and KVM KVM_SET_XSAVE ioctl
> return EINVAL.
> 
> This kernel commit introduces the problem:
> ea4d6938d4c0 x86/fpu: Replace KVMs home brewed FPU copy from user

This kernel commit issue should be resolved by the below kernel commit.

x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad856280ddea3401e1f5060ef20e6de9f6122c76

Since the old target server does not support pkru, I assume the VM's cpu type
should not support pkru. Therefore, the pkru should never be migrated away from
source server.

Dongli Zhang

> 
> Signed-off-by: YuChen <yu.chen@h3c.com>
> ---
> target/i386/xsave_helper.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
> index 996e9f3bfe..64e2b969fe 100644
> --- a/target/i386/xsave_helper.c
> +++ b/target/i386/xsave_helper.c
> @@ -6,6 +6,8 @@
>  #include "cpu.h"
> +static bool has_xsave_pkru;
> +
> void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
> {
>      CPUX86State *env = &cpu->env;
> @@ -47,6 +49,9 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
>          stq_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
>      }
> +    if (!has_xsave_pkru) {
> +        env->xstate_bv &= ~XSTATE_PKRU_MASK;
> +    }
>      header->xstate_bv = env->xstate_bv;
>      e = &x86_ext_save_areas[XSTATE_YMM_BIT];
> @@ -181,6 +186,9 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
>          env->xmm_regs[i].ZMM_Q(1) = ldq_p(xmm + 8);
>      }
> +    if (xsave->header.xstate_bv & XSTATE_PKRU_MASK) {
> +        has_xsave_pkru = true;
> +    }
>      env->xstate_bv = header->xstate_bv;
>      e = &x86_ext_save_areas[XSTATE_YMM_BIT];
> --
> 2.34.1
> -------------------------------------------------------------------------------------------------------------------------------------
> ?????????????????????????????????
> ????????????????????????????????????????
> ????????????????????????????????????????
> ???
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
> 

