Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02E57A7DEF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw3m-000716-H2; Wed, 20 Sep 2023 08:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qiw3i-00070F-2k
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:11:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qiw3e-0004R4-OK
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:11:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38K9scmR003333; Wed, 20 Sep 2023 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rQklv/znhU/Y/mcyW6H4XpKl9WX7H8O7n8GzSsWV/Ow=;
 b=KFqWWk4jv0KT0i6DAqmn2bTS7H4TnsKOIkRzCRighW2Rurl8ac8PEdmqliPz5gce0QS5
 fY1QWSeFbzv0WRtywa5WdxuYUYONleOZXN38OiLp3P9ALus5I9IwWFu8WFman93NNNcR
 H8ejBuY4HFco+YtUnNyYTa8vA3TUPPeH+GGJqRVJ0idct0T5ZdA4CfcvWRGg3XKf2/S2
 OFSK8IW2Azt6beegJQlyiIEnDNaF1BKXTAg8pgFqMrFEFSl0VzhjHktHWxmePwuG376J
 7xAUvmNbLIWYoSzj5SPVwoYnCzUptSZr9M+K2EksAKiT0S9+B+Z+7X1LxFxSj8ENlbAL 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wuq3hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 12:11:45 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KALZDq030083; Wed, 20 Sep 2023 12:11:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t70736-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 12:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw9ESZxQB382L5/gy4QPDPLz3LuEiKEywVl1WWQ0iDWYEPkZWNWUw4tYdOCwvBWqprG/0hijDWnyl0x17z3Jw9971m6WeeMKl8FPgvd0MRVbdhnw05tSAW1jZXxmUEvksrIB+n4ArK3TuoqbmSa08+KOLUFIt/10gjUMBBmwAdCzX9lb7x652AtmAG96BZavgbPzSwGTa8eFOJdbVh6/sngRYJzFcR9UmApH8M1TEDMbmyuBavwOHU/k03k9g3KJovOI+yleBG3mHy9mvjOAh3EzK78+BXZw462ccY2c2Q5WMW/HFPaVjELXl6xak6uG6wEGdfuEpuffkMZZJBJwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQklv/znhU/Y/mcyW6H4XpKl9WX7H8O7n8GzSsWV/Ow=;
 b=lWCSB7XKS79Q1gMHwxdwUNMIlz/SjOn6FlMxDHv2ObSaH+NZghoM4wNhHqnftwa2/jGH2JsSe7663SvLAvtnMzo79BZpD9S5kUeVog3BdcbDATrmOCT0sGhtVWszBc4PuSf9Iwflgsx2lvFmOF4BoQYYmScB2H5s/tHj9Ez5dFtWBlnpnaxZKisEnDKexC3Obd/xoE72vzAnWHpGdAcIjLvLRSXd5PgGCxdGqQCq5Ctll8Lxb8Fyux2PjwJALP/dWfGjaS57nbHq0/VlNhx1mKMrRtxbwCAn6LaEW+alydb/ZQMdw8xqdja/S/txfhsF3rlSQBV7NCWgNXdV1LwbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQklv/znhU/Y/mcyW6H4XpKl9WX7H8O7n8GzSsWV/Ow=;
 b=LZjTCAC8PnogmY9SGh9TqSGap3EV1XA43C3/EKFxTxYHv9F3H3mDftfQf5XLfWMJ73O09e4INNyBfkFb7x/5PTi3NHkZAnVAo4Jk//6pj6FSM0fcR9baYXTPur7XOgMxDy2n5uJA1CMIvL8sK4eBXL8xmf8+qtUi0Dwf2+9uTV4=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 12:11:41 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:11:40 +0000
Message-ID: <2f088b44-801d-37a3-0edc-0286ac58d0be@oracle.com>
Date: Wed, 20 Sep 2023 14:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Content-Language: en-US, fr
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "lidongchen@tencent.com" <lidongchen@tencent.com>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
 <20230914202054.3551250-2-william.roche@oracle.com>
 <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
 <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
 <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::17) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|IA1PR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 030f2481-de69-4900-f8db-08dbb9d2bf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBY93jTZhMDv5pMTEG7ABQHOgGwRZTHMEcBmdzj0gOvYeiPUulQ8sx1pGzqo+5ekh7qhhRhqhMlX3NriYJDWWarDdGBOUyoJkFL/yy2soWtyekxH0WNjJhCF74g6FydhaVE+1+yEXvTTve9rCIfnMZmfg5YVp69hT1BSThJFaDzOTUvHzQlaAZ8+3OB4Ly7fi9IC1l/jFnuh+oqcTaPpYiPJPufQHGKKIwOHrhDw7FNKIDfCNzZqhxr7uyyjOr5uvKB3wZVnXExQGZ8V8LHZf/i9WysRdWKvdrSetlzMxZorQ+7vezKStNGWq1N2F5s3dL5F/KdvUgXXvxjFH4fcAmjHfKUXSiqeAxJGuX/KSrwKUM+Kv55/zOw8FyjStXla+m5yHOacZ6p2KtHWX4K+CPc31Z10Ih2dtsGSbovbVF+nAotlfdSUlBnD5zsRaqF4NH0YUBTG8osG6r/1cRfGhm7f14/wlYLTKjqIEgVyteyFnALkGlEOjUxsm9AZX+GFucQzBJ+zbIa2Ciuxq1duvS8I2Cu7af/rMjhWXvwbisH6voh5DYietDyRjUcdDqp1VoMLq52tMfoWt36PEla0sIz1y5S8/Oy2jBDeZa/mYDYRVacagztMqXDoaa17kp7/4BRbl2DL+6NEucPTKvS3EIv1DAq2UYncviEXvbOCequ51VQyyNsVBp7qayr1I95X5uzip5SPe+mb8d3gK+fttg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(53546011)(6512007)(83380400001)(478600001)(2616005)(44832011)(316002)(2906002)(8936002)(66556008)(54906003)(66946007)(8676002)(66476007)(110136005)(5660300002)(4326008)(41300700001)(31696002)(86362001)(26005)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0NrRnR1bENXTms1WVNJbWwrVGY0U2k1dXBnZUYzbkQ5QWJhR3Q1VktDbFZ5?=
 =?utf-8?B?RzRyNU02c2wvZFlYUnAyWU5OdmwwK0ZNWUpDVHFDRDlqYWNLelZ3eFdDM0ND?=
 =?utf-8?B?aENvQnhTRjBKcnV4VTdTMWRlaFVCNUMzTkdnOW5uVlNJWjNLNVBDTm1uVFd4?=
 =?utf-8?B?bis1cE5Kakk4TGNaVFNFemhvWWZLaTZqWnN0d1hybUVxQUc2Y2xSMkliaFFG?=
 =?utf-8?B?Q0tYdm5DRFVGZytBZk5XK1FCd1dGS0hHS1VvK0VhZk5DWXVWb3k1eVpWZGVi?=
 =?utf-8?B?dTBvMU1ZdjVSa2V1YUxqTHg2K1UweEtsclpIMUM1cTVYTWVSR2wwSjFybTYr?=
 =?utf-8?B?UVVtK1AyK0hnQVRBdTRIbGFUQkJNNHhJUitvVVB4VVVzUk8yOWtSbUZjU25B?=
 =?utf-8?B?RlN0LzNFZndHR3ZyY1NHUmFWbkFyTUN2TVc0dDRQOFNPWUZrNGlmWWtkejU4?=
 =?utf-8?B?QmlPNkc1THY2OWh4akc3Z1BoM2RWWFpvYjB3NHoxZnJHcXpkYTBmWmhwYnpa?=
 =?utf-8?B?TVhZTXlwbHB4OUd6MFhCYkxVZUZuWTgxUGNnNUxCdHhwaStqWC9NdkVUY256?=
 =?utf-8?B?Q1U5RUF2cmVWVnN1djF3emRVVW8veTh2eGhJaG9YUXYzR21qUi9kRElrSDJT?=
 =?utf-8?B?RUZBV3F0eFh0N0gyUG9SNHREei93OXVWMG9MVis2aGpQcWx4ZDUraHozZXZs?=
 =?utf-8?B?MzZRQU4rZ0NoMmd3NGdCR1hlcTV2aFZKNlFwR1NDWkFxTFBMZjhOTkJSRTlz?=
 =?utf-8?B?enZWYnlKOXNrTit6VzAvZk9VWWVKdlJla2pIRm5sSSs1OEpPa0FiSkwwSnRv?=
 =?utf-8?B?cXNQSEkyalB4Vk4wNUMxaXlUbmpJYUVqYjFnWll2VzI3anlKbUl1VWliTjJy?=
 =?utf-8?B?K0pyVVU0OEVpZGJ5ZU96eUhqQkJDYmw0QTZHQkZCTGd3Sk9Lcy81VmNJMGtC?=
 =?utf-8?B?d3IxVUFmU0laZmo0eTM1Z0xIYzBVOE1tN0ZUZXdVb2lxdzRPVXp1WklJT29M?=
 =?utf-8?B?QWg5dVM0b3JmZ3pmWWN4cTYzRUhMVVhldmJQZzRnWHBTQUx0elNrUCsvTVJq?=
 =?utf-8?B?SnIwYWFiQUJTSEJUZDhEM2cxNm16Y3RZazZ1ejRnaHJYaE9RaWRUbXhVKzJu?=
 =?utf-8?B?THZ6TVlKSUFreGRuSGRmM1VWM3Mwbi92T3lFUjRWQ0J0MGdrQTZsSDRIbytL?=
 =?utf-8?B?bVVFaHBObTliUWExTTc2em9paFB3NUNqM05ITmxEYUhQZ2o5ei9OK3B5WXFo?=
 =?utf-8?B?TUJsYnBOZXEycmpVWFd5RVplMXhLam1jKzlNeEZVUUQ1eGZsU05WcFB0QitU?=
 =?utf-8?B?eW1wZjdBWkJxcGtuTU1vMW9GL0ZvOFY0MDZRcXM4RUVrakVQTjN0V2h1SDNN?=
 =?utf-8?B?OCtHTWFjZStaRkxWT2xydVFGYWZUTk9xTEJyNnR1bXhqL3RnQ1JRSnhVS2hZ?=
 =?utf-8?B?SEdydCtEc0I2dGtBMDk0Y2ZMNHF5T0tHWUtkR1ZmRWtzVWQxWXFMRlJwaERp?=
 =?utf-8?B?bHdJcHp2UGJ3dlNzVWhOSGg2ZENPUURIVTJhQWtXekExY2NLVzZlT2Z4OFBQ?=
 =?utf-8?B?K0VXK1YxY2xneGZmQ01MS2dXMXpqN2JIcmE5RUFlZkY3TVVVNk1DL05CVEJ5?=
 =?utf-8?B?TGxhcWxLVU5pd2QwREx4QmhtbWZkZ1VHT3VjVGM5Qk56L1FYTzVHeVVGMjA4?=
 =?utf-8?B?dEFvSWtRVlN2azliRXJhV0JJM2kvTkZ3Mng0cEFVbmErYUY4MWdjaTFuOCtO?=
 =?utf-8?B?dXY2MGp4Mi8zcStsYjRkUUdSUEpkK0pSZjBLYzZCTjg3L2VsRGZJSDhVMnFh?=
 =?utf-8?B?dURtVFNveHJSSnQrbmZuSUNnVmF2SVJhU3d4QWh6bnROSi8vRnFpdUJRS3N2?=
 =?utf-8?B?dWYzbm43WjJQbUxQUllCZTlPRGRVaGR2amZqcGY4ZUkvZnJiS3BqcDB0K0Rt?=
 =?utf-8?B?TnJMeUNzK2N2VUxoMnFmSmFpMm9PSUUyc2ZuSm44YWwvQ2U3Q0dadGgvcERI?=
 =?utf-8?B?N1JDT3pJbjlKWEU3V21LckZ6U0x3aVFCT0RRblJ0Q3ROY0FVSzVDcVVmbVJz?=
 =?utf-8?B?LzBsM1BXR1FSbTk3RGF4MlU2eGlaT0ZrL2g3eHdCYmw3TFBIS2lqb293ZzN5?=
 =?utf-8?B?Wk02bzB4YnlKR0w4aUMzbURZTWk2endxeTFpd3lTeWFtaldmVkVVSXNNQXJO?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UT8Jmg/IR36dPdAe0ENROV6SVqfUSc68Dq+06R3+LUWlbTrJt+EAVQsT8u80nrrW+YUVCeLF623+ssDW6pM5VUn7P3DclQSz2p3M3giRjCC0Rnl5NF+xRcitoF9g+ck2TbjhJDTeh3nDARUlvCOn82KNt1h7FacscstMhKyDvOC6Om78iyKPx8GtE8s1rca+LOy4+Mpv3L685t6bOWdvCM05bFQqfnBJC81OZNaFUfkyY+7pkHfO3hgciV8g0hhubpIk65ulsCZKk0rw2TFMLYQbz8uxyRiRJba1d6+/67KlCTFSrXBEEx++whmVvmCM6FuTq0AjXnhhfCvi/+A5XKNuD4vaDV+ONUmDEb4I+L3lQnDmBOtQmynCwRKkjvHolF/J+WrzQqw07N6+eoK9WwAYdMjIC31fTgiskuyB35kF9Agb16cQ+MJXrvMKfZZ0W+WMQH8j935RszwzRp54bG1M1ZpfeY5EnTQ8REQdfYGbrwG6xyM9ub63yazP9rrrgH5h80oEJYUOHICUgVIwgM6w3qudd+FWcyGPTpJp0l0a086SZqWvYDuZmzFqc4XDLURV4rJmXWGlE0BPzW0sxYv159MVTbJuo/AXRfzpJMicTak2UJ3KhurCUJ8UH2UgKBu9NQbMx0oY7ZjeW4RWuZwTeIdxBqFNLQLx86cEao3i/wv8bFPnq/h1w6QhPtp3nmz+jH2vwEJ8xHCmOJK7eF5dsmVUNHgoaa6ZdvtQQhmOtXnQSwrizl/tTk72xYiEQzSGG9aYVfAao92hC26gIqRwkUQajy3gQmxgEBL61yQZX8Mk1DGPC+1P84KcdWh4P6CLKjVpFmCfe9+Ml8pLAg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030f2481-de69-4900-f8db-08dbb9d2bf1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:11:40.6214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrdoIx2pxzNtBaalgztin1lHFb4JXvYpts9l/Tl3VJz9TWPWhdU+zatNFKEzhpFWIBZl5nn5bLI6oR0Q1Xc4qT5b/kmfEPHs+NKjGr3Fr14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200098
X-Proofpoint-GUID: J6phlTqWGXosrK-2Gfv5uftnmb9ZYnUQ
X-Proofpoint-ORIG-GUID: J6phlTqWGXosrK-2Gfv5uftnmb9ZYnUQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Thank you Zhijian for your feedback.

So I'll try to push this change today.

Cheers,
William.


On 9/20/23 12:04, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 15/09/2023 19:31, William Roche wrote:
>> On 9/15/23 05:13, Zhijian Li (Fujitsu) wrote:
>>>
>>>
>>> I'm okay with "RDMA isn't touched".
>>> BTW, could you share your reproducing program/hacking to poison the page, so that
>>> i am able to take a look the RDMA part later when i'm free.
>>>
>>> Not sure it's suitable to acknowledge a not touched part. Anyway
>>> Acked-by: Li Zhijian <lizhijian@fujitsu.com> # RDMA
>>>
>>
>> Thanks.
>> As you asked for a procedure to inject memory errors into a running VM,
>> I've attached to this email the source code (mce_process_react.c) of a
>> program that will help to target the error injection in the VM.
> 
> 
> I just tried you hwpoison program and do RDMA migration. Migration failed, but fortunately
> the source side is still alive :).
> 
> (qemu) Failed to register chunk!: Bad address
> Chunk details: block: 0 chunk index 671 start 139955096518656 end 139955097567232 host 139955096518656 local 139954392924160 registrations: 636
> qemu-system-x86_64: cannot get lkey
> qemu-system-x86_64: rdma migration: write error! -22
> qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -22
> qemu-system-x86_64: Early error. Sending error.
> 
> 
> Since current RDMA migration transfers guest memory in a chunk size(1M) by default, we may need to
> 
> option 1: reduce all chunk size to 1 page
> option 2: handle the hwpoison chunk specially
> 
> However, because there may be a chance to use another protocol, it's also possible to temporarily not fix the issue.
> 
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Thanks
> Zhijian

