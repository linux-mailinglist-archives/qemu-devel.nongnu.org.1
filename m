Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A0D73FB14
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6nl-0007MH-Me; Tue, 27 Jun 2023 07:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qE6ni-0007Lo-D3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:24:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qE6nd-0006sE-9f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:24:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RAs4Rr011495; Tue, 27 Jun 2023 11:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=EnDgjMUFEGBhKUFExQK99BBx7pnMhBaQDqKa+p8n/38=;
 b=jAa/Cig1FUZcWroh5wOhbdOOMttwlo7HO9N95XjmvCb5Z5SgU1jCm5yX4K+oYON6I5I6
 8AxdOPbcwDSARO6+LHDiBypKsoQvVFgidBH0UVhY73mbCd5X3HG7/P022SLTyZoSDYuQ
 DR0r3FBY4lXqxcCj0etsKX8RWAlxw3St1t6SxhWZFzYIhHZ1G5ogMGoNamCT8JzRsZO2
 Q5y9BVjE+8VVtYkmDXV3L/m5ZvK6V/8F+dPJgZcIvvHFvo78LKQd6PRv5sJS7BdfB2o4
 euMQdgiLAtz9mwtmMp23BnLR3S2SvEuXrF5nSsEsjuatuZ7XE+a4CYgf+81uuCIUdciT HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq934pt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 11:23:54 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35R9fGxE038223; Tue, 27 Jun 2023 11:23:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxauswn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 11:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knybrh4p/JA346RzgzXKgKZ4yqYCma/WvivrypJ4EHTqQ9fEVEbEFGel+BiJqfcyuDJjNvLFWRhdlaFZs+4zw8Gl3GMTkIYyrs/lJnD6enMX0mGZ/Z4gJSgPz6xRGrmIB+CPMA7+aXPRcB0E1mi2g+bW+OPWpE9MzKfGTNyLFKgUuKQ96DHDlNvdN8IfWMCy2a9KT7gWwjW+YD8qmQ9kIF69Ip5sLpdUYV7ZmE1WeLtoNtfMk1ig6GHkNLtKxhhEkFkRpwoCXBaFeZNnsVgWVrEMJ3Qt+Mfvna7qQnmRgXvJr4GbvO0qr1nIAMiYgEFJ6w+qcB1oeG5rPR6dVXamzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnDgjMUFEGBhKUFExQK99BBx7pnMhBaQDqKa+p8n/38=;
 b=e30Tdf3dIH4VggG3EeESdGp4yMumXbddCmrWELm2GwaUKkNEaELPUQ2R3DJ1GnOoodYgYDRyGp1ZMucUJ/jOBpYbSWWXj8Ho1QRBv+09kPhiHyhtECvBYHUzBOqaNt2IUL7ltzU6nJOyoraNt8G8OGefLYT61Wp/ENLLsGrZudX6FfoufdvIm0EgFUC14D4PM+W/S7dmF4iZTjYDjNDy+FdXx6WIQrvESh4PqCwBFOfYwRBwlvF+YwqDLFKYbuF4BH6Cu0/8cxbbBaBwq4XzaJL0J06EqjgwYpSm2xWr6meeWMiYEE+Hu8wlYLZ55nh4mKwkn0AC1cTs0AiZyeEzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnDgjMUFEGBhKUFExQK99BBx7pnMhBaQDqKa+p8n/38=;
 b=xZ5aTmKNygWc6uJ7uN9gVKR/JQxbQodxbuZCjEH8d9ev3dWc4tTPRK+NXWdeW6LNEvHZrXDfIGmgIiFxUUwhczoFi+HSXb+dvDvWPH0lv6fktgQQFM2vtExP5l2IoKoTxCvdh+LkHUqVbCkyppUJ+pP34p7Lvahr4c2BHwfFmRo=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 11:23:50 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef%2]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 11:23:50 +0000
Content-Type: multipart/alternative;
 boundary="------------FJHamD35e3ucqy7AcL0QBnWC"
Message-ID: <006e8923-d73b-b6be-fccc-a26b3e98e811@oracle.com>
Date: Tue, 27 Jun 2023 07:23:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
 <20230623014315-mutt-send-email-mst@kernel.org>
 <49f01bcc-eefa-d277-93fe-e3bcbc2ccd42@oracle.com>
 <20230626081522-mutt-send-email-mst@kernel.org>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20230626081522-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: MN2PR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:208:19b::31) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0d5ee-23b7-455b-be97-08db7700fb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icfp3jQgCLBtlGuCJWP+2E6hS26+0z4otEQ9I9LNE8slvSl4UarxHxCacahn60A2jKj5nQj8HIllBUZBlrzaQbSzWli5fYPIegIaN7KwnH4XrwUwlT0GHLCDRfd4E2mLvwfm6i9Ti2Ty6stO128nEhOqVnKBa5OCV2UfUsuRiBZwaCWboFoPpExW9v3LKQPV4Xr+73toLHJPhLzDWGMJqxRnlb7HNHcxAUHLUKoaL3q2HvJzqk8VZzOrr1JIM8kbeUAOsGbIj8VFfiUyZZ5sQ4oSlMdM0yRzb2NzHn+UFqYFHMgMdj43leCyKEcKxDZus9aBjnUUztpsINGemJA55mMMmbfz8ic329aLedi1NhCRvveS+2Qg0QMZgkXFgVdUTSa514fGDJTH0am7utDH4Ym01uqpD20qRZmgV/J+bDogzYZsIqwxsJrZQPg6Nhs550sZ22V36XoasvRTdlJuJcSvpmmqANCa2wAKJaSlWQK5JUTk1SgmK6H5nn7v/ES9KTZ7JlqedvDZ3nZoboqJgnlk+Wmj8Qdf9QJXlu15mUrCa4TTCZqLExt2nQFfsTHvttfW0ikcTIuO8zJmBGaKlgkCosQ6jlXOibSDOpK/rF2gPWzr/k3DAX6tQFO2u8TtKpQYTO4tgi0bq0qP125/vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(2906002)(86362001)(6666004)(6486002)(33964004)(38100700002)(53546011)(83380400001)(2616005)(6512007)(26005)(30864003)(186003)(41300700001)(31696002)(36756003)(478600001)(66556008)(66476007)(4326008)(66946007)(316002)(6916009)(31686004)(6506007)(7416002)(5660300002)(44832011)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZ5ZUVHWHpMRmJOL09GeHAvdFFKdUhZRGNUYUI4TkQwTG4wc1V1SXVJd2Vx?=
 =?utf-8?B?eDFnbHZtZmwrTjdCZDllZ1NLV04xaWZYRm0yZWgvVVJ4eXYxY0ppYWlKaFcw?=
 =?utf-8?B?OEk4dnZhY1JDSGd0M211UDZLMnRkSG9CRkxqNnZDUDJNMEVWRTMyR1d1SXRa?=
 =?utf-8?B?UFU0MTZLb0ZrblhXR1BIdXpuNXFod1VRK1YyU2FQSHIveHIrT2ovQzByL0Nx?=
 =?utf-8?B?SG5CUUxDZmZjd0RzdTR0QUxrUzdCYW1rdVRHcGxaZVdyRi9HczJFSjNaNWpF?=
 =?utf-8?B?UXF0NEY3ek1yM0c3eEFjOWJYWTI1ZkJjQ1RyblJJdFBTSnZaR0ZKZUphZnRk?=
 =?utf-8?B?Q1pXNWZEU0RXL2RWbEhhRkhpVXJPQ25wQjY3UXdjNzNUWWE4WVhYRXFTMkdT?=
 =?utf-8?B?cGNkSDJpdUxpRmg4T0F2Q290dmVoeUZmQ1NablNoMTQyR3JiNDZlR0hZNkNP?=
 =?utf-8?B?LzNkbUNhL2JFVmVSSTM1TzdVMVd4Nzg3Qjkrd0NZRExBZXVJQnFZclB5WTFQ?=
 =?utf-8?B?Z2dMNjd0Vm5ZWFlMVGI5VHdZeDhCZ3AzQ3hZMldReERPRGFyR0VWQmwyNU5R?=
 =?utf-8?B?NWJMT2xUVG5Id0wvbTVBdXgxdk9QY1ZsckRFOHlQVFZyaGQxZy9xMUpMUTRD?=
 =?utf-8?B?dm1mY244MG83RUpSdnBPaVRjSlljN2VQTXNXbmNnQXhva09NSnVBa3ZkMkE1?=
 =?utf-8?B?RmlnZE12RGtGZXpnZkFzUVpoVGxteXR0T3MzQ3JHamtCOXNKVUhrUTJndjZN?=
 =?utf-8?B?TjhQVHc4bjVCVGlFOVVKcFluQzhMRllmTUVwZnFKUVQxQ0pVSHV4bWN4RXFF?=
 =?utf-8?B?dnJSRktmeGsxRW1qN1R2UkJxYmw2MkFLV0hYRSthSGV2ZWVJS0ZOSzkvVzZi?=
 =?utf-8?B?NUt5Yy9yZVR5cGJFNVM0WkFnV0tReTZmalJNMU5HMHRETld0QTZLQ0hlL1Bm?=
 =?utf-8?B?eXVRc2tzQTBBQnA4UXJPL1FRd3p2S0o3ZUdGN0pwNW1jRTM3NDVnbkFCMk10?=
 =?utf-8?B?dGNMbTBuT3pDejkxVUxSSmUxYmZzZDQzKzZTcWRydStMVWlTcnJQN2Jua1BM?=
 =?utf-8?B?VHo2UjFvQnorWDEwdDByQTc5eXpHdEErVWJMWUQ4YUovY3FlWGhZcWZiSzZS?=
 =?utf-8?B?V3dST2NNVDMyMm02ZGZISHNaV0N1VnZlK3M2RHE1YTViV1ZPYXhIYWllcnB2?=
 =?utf-8?B?ckE5T0NaQ3hRRWlsMUZEdC8zOHJqMWhxZWV1SFh2U01iNEJDemM1QkhsVkU3?=
 =?utf-8?B?R1hsalo0VUdTUnVaWm1FdFNraGZzMVdkYWxhR0hPR0gzTTVCYU96cytxcEx3?=
 =?utf-8?B?MENaNWhPUG5nWlNQNnB4c29qTHR5clp5aDluRW5YTlNIT0Z5cVUxK1o1MnNq?=
 =?utf-8?B?QzhmQUt2SnlDd09CWkdXWVlhQW5qUVdtcnJvMGJ6WGw2WDlqYW5vd2YwOFJ1?=
 =?utf-8?B?a3hQYm40NXl2ams5WjFGaXBuRnJIRTR2ZGhEK0dsb1Y3SmU3anl3NWM5aFlG?=
 =?utf-8?B?aHRKY2J1NWxRWlpjTVJqNGlOaDdVcjFLVzVkcFBiUENiajZWL1J6ZzJiV2dw?=
 =?utf-8?B?MXBGRDdCdWJRdTRGbHRLQ0huTkZYWFZ0TXVWb3pLT3pLaUNCZ2J0ZXF2OU1p?=
 =?utf-8?B?ZDgwSVpCS2lVdllsTVpaT0xETVNTeEsyM2hzYmdLYXliMkZQNEJ5RWhzWEhi?=
 =?utf-8?B?bjdzVEhHK1lXUTdtYWgzVll3N0xxOGdBUU1VQmc4bnRFeVFCRjRHSkVtN3FU?=
 =?utf-8?B?eWNrR1BER0Q2NStmUVVXZ0k0VWkxY205YUNXellqNWRZSzN5OGtkMlhGVG5j?=
 =?utf-8?B?em01MS8xNFgyL1k5b3FlUW5MNGd3Sm9JQzd2OHZRRjhnS1dEcFFqbStsQkZu?=
 =?utf-8?B?U3lFTXhzdVFjK1IxR0dpY2l5SmNEU0F6UGhtSEppeEVGUTk1U2gwTWViMjZr?=
 =?utf-8?B?a0JKMVdvOGpTY05uU2FrTHl5bWh3L0tvQjk5MytNR3puQW1Qbk9yNkdCekMv?=
 =?utf-8?B?Q1JNdXQxaHJkQkJUcTFPaXNzV0NiZ0pTTm1KeUNNKzc5MlpudDVDRVh1UC9D?=
 =?utf-8?B?eEpXRXp6dlZQNDl5RkJCQ3ZiRCtBRTBQZjN4WFVNTHY4dE5QQ2NiYklzQlph?=
 =?utf-8?Q?tcrlwMeDl93mGbBm18rECeAKR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: exqls8EOamxciNuv9m764mmmRmK1wXDKI6xHUagXpdMGmK7lO/C0kiRLAPxfl1mCeuGi3RxZ7895NOk7XI7nbciLmdQLlQwSwfIM+TYroVInSY8XnYxeZgXtDQ/QKysvmR3pmtNBknvigw1RBQjD47wtm4+VlYcLtYzPj3NyNFMikaVY+M0mkI0BSFF0h4z0FOF2aPUUk1n9wqkDkxUATJQjvEZCYALfEKMe1QqRSTVQaQflXLTgy4vqJS+sDQ45t0uPTzYjvMYBJb8xtW8lPuUrLgbVUvG71KEcJUVNXNLXck2VruYmVMS78Zl9jXiYcg352+aU7q3I3iFUCjN71c0L/E5GRYV30hu6GrdX4Hq05q00Zrukf0KBnt2bM96vXbwSIT8tGXAAbadlRznRbIeZ+Am+xwFcdxKjBl5P9C40/Zdmi70z1yrCA69CiKtNkdDJGZL8+3DEeyNAR9cuq0n9rMqBXVoljiO9j0rOkd+FI3FDuhUH3q/glwOfo7RpNPWUiwoBXYtytD58Ml0rx40lhhgo9Sg+A0iehelsd7r4DXH5aOxq5Sw/DESSP5r0oFJzpgJaQ7vqBeNaeAcvB0XqXJ22cRTGYpYKYv52jhK22lWYDfoBD3N7Em4Rhi9uTI37a1fKDIePULMmLDzx1+w1AfkSEVuYSWoixaPEBtvDrhH0m3OYAfFbCOKajGhH5bDeCSXJb7nohjOYFFRCr8okox3XtiscHZCnerNTsTWTHX11XtI0SB3TwbG79Xi3btEuh3lMxDRdEk6UYPWgjzXvhYxcrYuUK4xeAO2SqjaOA+L+yA08NQtpLL6zEmjeVZjczWevFN2s3MspOjJUzXP+CfUuMt9lhKQKzPrmJqCEgR36J5Zt2kAPy1EeQP1/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0d5ee-23b7-455b-be97-08db7700fb69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 11:23:50.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhYVVVfq/4BaRqgJYphQ9j8uyIoKeQAidjbDXwOk61qJq0AFGQfjvnhBzYVMQ0GtrL+EaqXV87ZW1515EIrqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_07,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270105
X-Proofpoint-ORIG-GUID: ohKAdu8Xws_9u2cnoPSBDn3cYzVZKgqn
X-Proofpoint-GUID: ohKAdu8Xws_9u2cnoPSBDn3cYzVZKgqn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------FJHamD35e3ucqy7AcL0QBnWC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/26/23 08:16, Michael S. Tsirkin wrote:

> On Mon, Jun 26, 2023 at 08:08:28AM -0400, Jonah Palmer wrote:
>> On 6/23/23 01:47, Michael S. Tsirkin wrote:
>>
>>      On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
>>
>>          The virtio_list duplicates information about virtio devices that already
>>          exist in the QOM composition tree. Instead of creating this list of
>>          realized virtio devices, search the QOM composition tree instead.
>>
>>          This patch modifies the QMP command qmp_x_query_virtio to instead search
>>          the partial paths of '/machine/peripheral/' &
>>          '/machine/peripheral-anon/' in the QOM composition tree for virtio
>>          devices.
>>
>>          A device is found to be a valid virtio device if (1) its canonical path
>>          is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
>>
>>          [Jonah: In the previous commit I had written that a device is found to
>>           be a valid virtio device if (1) it has a canonical path ending with
>>           'virtio-backend'.
>>
>>           The code now determines if it's a virtio device by appending
>>           'virtio-backend' (if needed) to a given canonical path and then
>>           checking that path to see if the device is of type
>>          'TYPE_VIRTIO_DEVICE'.
>>
>>           The patch also instead now checks to make sure it's a virtio device
>>           before attempting to check whether the device is realized or not.]
>>
>>          Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>>
>>
>>      Could one of QMP maintainers comment on this please?
>>
>>
>>          ---
>>           hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>>           hw/virtio/virtio-qmp.h |   8 +--
>>           hw/virtio/virtio.c     |   6 --
>>           3 files changed, 82 insertions(+), 60 deletions(-)
>>
>>          diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>>          index b5e1835299..e936cc8ce5 100644
>>          --- a/hw/virtio/virtio-qmp.c
>>          +++ b/hw/virtio/virtio-qmp.c
>>          @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>           VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>           {
>>               VirtioInfoList *list = NULL;
>>          -    VirtioInfo *node;
>>          -    VirtIODevice *vdev;
>>
>>          -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>          -        DeviceState *dev = DEVICE(vdev);
>>          -        Error *err = NULL;
>>          -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>          -
>>          -        if (err == NULL) {
>>          -            GString *is_realized = qobject_to_json_pretty(obj, true);
>>          -            /* virtio device is NOT realized, remove it from list */
>>          -            if (!strncmp(is_realized->str, "false", 4)) {
>>          -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>>          -            } else {
>>          -                node = g_new(VirtioInfo, 1);
>>          -                node->path = g_strdup(dev->canonical_path);
>>          -                node->name = g_strdup(vdev->name);
>>          -                QAPI_LIST_PREPEND(list, node);
>>          +    /* Query the QOM composition tree for virtio devices */
>>          +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
>>          +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
>>
>>      How sure are we these will forever be the only two places where virtio
>>      can live?
>>
>> A virtio device will always be considered a peripheral device, right?
>> Since peripheral devices are input and/or output devices by definition.
>>
>>          +    if (list == NULL) {
>>          +        error_setg(errp, "No virtio devices found");
>>          +        return NULL;
>>          +    }
>>          +    return list;
>>          +}
>>          +
>>          +/* qmp_set_virtio_device_list:
>>          + * @ppath: An incomplete peripheral path to search from.
>>          + * @list: A list of realized virtio devices.
>>          + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
>>          + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
>>          + * to a given list of virtio devices.
>>          + */
>>          +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
>>          +{
>>          +    ObjectPropertyInfoList *plist;
>>          +    VirtioInfoList *node;
>>          +    Error *err = NULL;
>>          +
>>          +    /* Search an incomplete path for virtio devices */
>>          +    plist = qmp_qom_list(ppath, &err);
>>          +    if (err == NULL) {
>>          +        ObjectPropertyInfoList *start = plist;
>>          +        while (plist != NULL) {
>>          +            ObjectPropertyInfo *value = plist->value;
>>          +            GString *path = g_string_new(ppath);
>>          +            g_string_append(path, value->name);
>>          +            g_string_append(path, "/virtio-backend");
>>          +
>>          +            /* Determine if full path is a realized virtio device */
>>          +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
>>          +            if (vdev != NULL) {
>>          +                node = g_new0(VirtioInfoList, 1);
>>          +                node->value = g_new(VirtioInfo, 1);
>>          +                node->value->path = g_strdup(path->str);
>>          +                node->value->name = g_strdup(vdev->name);
>>          +                QAPI_LIST_PREPEND(*list, node->value);
>>                       }
>>          -           g_string_free(is_realized, true);
>>          +            g_string_free(path, true);
>>          +            plist = plist->next;
>>                   }
>>          -        qobject_unref(obj);
>>          +        qapi_free_ObjectPropertyInfoList(start);
>>               }
>>          -
>>          -    return list;
>>           }
>>
>>           VirtIODevice *qmp_find_virtio_device(const char *path)
>>           {
>>          -    VirtIODevice *vdev;
>>          -
>>          -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>>          -        DeviceState *dev = DEVICE(vdev);
>>          -
>>          -        if (strcmp(dev->canonical_path, path) != 0) {
>>          -            continue;
>>          +    Error *err = NULL;
>>          +    char *basename;
>>          +
>>          +    /* Append 'virtio-backend' to path if needed */
>>          +    basename = g_path_get_basename(path);
>>          +    if (strcmp(basename, "virtio-backend")) {
>>          +        GString *temp = g_string_new(path);
>>          +        char *last = strrchr(path, '/');
>>          +        if (g_strcmp0(last, "/")) {
>>          +            g_string_append(temp, "/virtio-backend");
>>          +        } else {
>>          +            g_string_append(temp, "virtio-backend");
>>                   }
>>          +        path = g_strdup(temp->str);
>>          +        g_string_free(temp, true);
>>          +    }
>>
>>      I don't much like the string operations. We should be able to
>>      check object types instead.
>>
>>
>> I don't either but in order for us to check if the object is a
>> virtio device type, we need to use the device's path ending
>> with '/virtio-backend'.
>>
>> If there's a better method to checking this though, or perhaps
>> checking a different type, that doesn't involve string
>> manipulation, then I'm all for it.
> TYPE_VIRTIO_DEVICE ?
>
>
Please excuse my ignorance, as I'm probably missing something here,
but how can I verify a device is of TYPE_VIRTIO_DEVICE without using
a canonical path ending with "/virtio-backend"?

Initially, when the query begins, I use 'qmp_qom_list' to generate a
list of devices under "/machine/peripheral-anon/" and
"/machine/peripheral/", e.g:

	- "/machine/peripheral-anon/device[0]" (virtio-serial)
	- "/machine/peripheral-anon/device[1]" (virtio-scsi)

Without appending "/virtio-backend" to those paths, which are virtio
devices, checking if the path is a device of TYPE_VIRTIO_DEVICE would
throw an error and fail via. the following:

	Object *obj = object_resolve_path(path, NULL);
	object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE);

With these path (without "/virtio-backend"), we could check if it's
of TYPE_VIRTIO_PCI, but not all virtio devices are PCI devices
(e.g. virtio-mmio).

This can also be seen when qom-get'ing the types of each path:
--------------------------------------------------------------
{"execute": "qom-get",
  "arguments": {"path":"/machine/peripheral-anon/device[0]/",
                "property":"type"}}
{
     "return": "virtio-serial-pci"
}

{"execute": "qom-get",
  "arguments": {"path":"/machine/peripheral-anon/device[0]/virtio-backend",
                "property":"type"}}
{
     "return": "virtio-serial-device"
}

So, in short, I'm not sure how I can check if a canonical path is to a
device of TYPE_VIRTIO_DEVICE without its path ending with "/virtio-backend".

>>          -        Error *err = NULL;
>>          -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>>          -        if (err == NULL) {
>>          -            GString *is_realized = qobject_to_json_pretty(obj, true);
>>          -            /* virtio device is NOT realized, remove it from list */
>>          -            if (!strncmp(is_realized->str, "false", 4)) {
>>          -                g_string_free(is_realized, true);
>>          -                qobject_unref(obj);
>>          -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>>          -                return NULL;
>>          -            }
>>          +    /* Verify the canonical path is a virtio device */
>>          +    Object *obj = object_resolve_path(path, NULL);
>>          +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
>>          +        object_unref(obj);
>>          +        return NULL;
>>          +    }
>>          +
>>          +    /* Verify the virtio device is realized */
>>          +    QObject *qobj = qmp_qom_get(path, "realized", &err);
>>          +    if (err == NULL) {
>>          +        GString *is_realized = qobject_to_json_pretty(qobj, true);
>>          +        if (!strncmp(is_realized->str, "false", 4)) {
>>                       g_string_free(is_realized, true);
>>          -        } else {
>>          -            /* virtio device doesn't exist in QOM tree */
>>          -            QTAILQ_REMOVE(&virtio_list, vdev, next);
>>          -            qobject_unref(obj);
>>          +            qobject_unref(qobj);
>>                       return NULL;
>>                   }
>>          -        /* device exists in QOM tree & is realized */
>>          -        qobject_unref(obj);
>>          -        return vdev;
>>          +        g_string_free(is_realized, true);
>>          +    } else {
>>          +        qobject_unref(qobj);
>>          +        return NULL;
>>               }
>>          -    return NULL;
>>          +    qobject_unref(qobj);
>>          +
>>          +    /* Get VirtIODevice object */
>>          +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>>          +    return vdev;
>>           }
>>
>>           VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>          diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>>          index 8af5f5e65a..4b2b7875b4 100644
>>          --- a/hw/virtio/virtio-qmp.h
>>          +++ b/hw/virtio/virtio-qmp.h
>>          @@ -15,13 +15,7 @@
>>           #include "hw/virtio/virtio.h"
>>           #include "hw/virtio/vhost.h"
>>
>>          -#include "qemu/queue.h"
>>          -
>>          -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
>>          -
>>          -/* QAPI list of realized VirtIODevices */
>>          -extern QmpVirtIODeviceList virtio_list;
>>          -
>>          +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>>           VirtIODevice *qmp_find_virtio_device(const char *path);
>>           VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>           VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>>          diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>          index 295a603e58..83c5db3d26 100644
>>          --- a/hw/virtio/virtio.c
>>          +++ b/hw/virtio/virtio.c
>>          @@ -45,8 +45,6 @@
>>           #include "standard-headers/linux/virtio_mem.h"
>>           #include "standard-headers/linux/virtio_vsock.h"
>>
>>          -QmpVirtIODeviceList virtio_list;
>>          -
>>           /*
>>            * Maximum size of virtio device config space
>>            */
>>          @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>>               vdev->listener.commit = virtio_memory_listener_commit;
>>               vdev->listener.name = "virtio";
>>               memory_listener_register(&vdev->listener, vdev->dma_as);
>>          -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>>           }
>>
>>           static void virtio_device_unrealize(DeviceState *dev)
>>          @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>>                   vdc->unrealize(dev);
>>               }
>>
>>          -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>>               g_free(vdev->bus_name);
>>               vdev->bus_name = NULL;
>>           }
>>          @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>>               vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>>
>>               vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>>          -
>>          -    QTAILQ_INIT(&virtio_list);
>>           }
>>
>>           bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>>          --
>>          2.39.3
>>
--------------FJHamD35e3ucqy7AcL0QBnWC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">
      <pre>On 6/26/23 08:16, Michael S. Tsirkin wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20230626081522-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Mon, Jun 26, 2023 at 08:08:28AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 6/23/23 01:47, Michael S. Tsirkin wrote:

    On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:

        The virtio_list duplicates information about virtio devices that already
        exist in the QOM composition tree. Instead of creating this list of
        realized virtio devices, search the QOM composition tree instead.

        This patch modifies the QMP command qmp_x_query_virtio to instead search
        the partial paths of '/machine/peripheral/' &amp;
        '/machine/peripheral-anon/' in the QOM composition tree for virtio
        devices.

        A device is found to be a valid virtio device if (1) its canonical path
        is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.

        [Jonah: In the previous commit I had written that a device is found to
         be a valid virtio device if (1) it has a canonical path ending with
         'virtio-backend'.

         The code now determines if it's a virtio device by appending
         'virtio-backend' (if needed) to a given canonical path and then
         checking that path to see if the device is of type
        'TYPE_VIRTIO_DEVICE'.

         The patch also instead now checks to make sure it's a virtio device
         before attempting to check whether the device is realized or not.]

        Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a>


    Could one of QMP maintainers comment on this please?


        ---
         hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
         hw/virtio/virtio-qmp.h |   8 +--
         hw/virtio/virtio.c     |   6 --
         3 files changed, 82 insertions(+), 60 deletions(-)

        diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
        index b5e1835299..e936cc8ce5 100644
        --- a/hw/virtio/virtio-qmp.c
        +++ b/hw/virtio/virtio-qmp.c
        @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         VirtioInfoList *qmp_x_query_virtio(Error **errp)
         {
             VirtioInfoList *list = NULL;
        -    VirtioInfo *node;
        -    VirtIODevice *vdev;

        -    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
        -        DeviceState *dev = DEVICE(vdev);
        -        Error *err = NULL;
        -        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
        -
        -        if (err == NULL) {
        -            GString *is_realized = qobject_to_json_pretty(obj, true);
        -            /* virtio device is NOT realized, remove it from list */
        -            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
        -                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -            } else {
        -                node = g_new(VirtioInfo, 1);
        -                node-&gt;path = g_strdup(dev-&gt;canonical_path);
        -                node-&gt;name = g_strdup(vdev-&gt;name);
        -                QAPI_LIST_PREPEND(list, node);
        +    /* Query the QOM composition tree for virtio devices */
        +    qmp_set_virtio_device_list(&quot;/machine/peripheral/&quot;, &amp;list);
        +    qmp_set_virtio_device_list(&quot;/machine/peripheral-anon/&quot;, &amp;list);

    How sure are we these will forever be the only two places where virtio
    can live?

A virtio device will always be considered a peripheral device, right?
Since peripheral devices are input and/or output devices by definition.

        +    if (list == NULL) {
        +        error_setg(errp, &quot;No virtio devices found&quot;);
        +        return NULL;
        +    }
        +    return list;
        +}
        +
        +/* qmp_set_virtio_device_list:
        + * @ppath: An incomplete peripheral path to search from.
        + * @list: A list of realized virtio devices.
        + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
        + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
        + * to a given list of virtio devices.
        + */
        +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
        +{
        +    ObjectPropertyInfoList *plist;
        +    VirtioInfoList *node;
        +    Error *err = NULL;
        +
        +    /* Search an incomplete path for virtio devices */
        +    plist = qmp_qom_list(ppath, &amp;err);
        +    if (err == NULL) {
        +        ObjectPropertyInfoList *start = plist;
        +        while (plist != NULL) {
        +            ObjectPropertyInfo *value = plist-&gt;value;
        +            GString *path = g_string_new(ppath);
        +            g_string_append(path, value-&gt;name);
        +            g_string_append(path, &quot;/virtio-backend&quot;);
        +
        +            /* Determine if full path is a realized virtio device */
        +            VirtIODevice *vdev = qmp_find_virtio_device(path-&gt;str);
        +            if (vdev != NULL) {
        +                node = g_new0(VirtioInfoList, 1);
        +                node-&gt;value = g_new(VirtioInfo, 1);
        +                node-&gt;value-&gt;path = g_strdup(path-&gt;str);
        +                node-&gt;value-&gt;name = g_strdup(vdev-&gt;name);
        +                QAPI_LIST_PREPEND(*list, node-&gt;value);
                     }
        -           g_string_free(is_realized, true);
        +            g_string_free(path, true);
        +            plist = plist-&gt;next;
                 }
        -        qobject_unref(obj);
        +        qapi_free_ObjectPropertyInfoList(start);
             }
        -
        -    return list;
         }

         VirtIODevice *qmp_find_virtio_device(const char *path)
         {
        -    VirtIODevice *vdev;
        -
        -    QTAILQ_FOREACH(vdev, &amp;virtio_list, next) {
        -        DeviceState *dev = DEVICE(vdev);
        -
        -        if (strcmp(dev-&gt;canonical_path, path) != 0) {
        -            continue;
        +    Error *err = NULL;
        +    char *basename;
        +
        +    /* Append 'virtio-backend' to path if needed */
        +    basename = g_path_get_basename(path);
        +    if (strcmp(basename, &quot;virtio-backend&quot;)) {
        +        GString *temp = g_string_new(path);
        +        char *last = strrchr(path, '/');
        +        if (g_strcmp0(last, &quot;/&quot;)) {
        +            g_string_append(temp, &quot;/virtio-backend&quot;);
        +        } else {
        +            g_string_append(temp, &quot;virtio-backend&quot;);
                 }
        +        path = g_strdup(temp-&gt;str);
        +        g_string_free(temp, true);
        +    }

    I don't much like the string operations. We should be able to
    check object types instead.


I don't either but in order for us to check if the object is a
virtio device type, we need to use the device's path ending
with '/virtio-backend'.

If there's a better method to checking this though, or perhaps
checking a different type, that doesn't involve string
manipulation, then I'm all for it.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
TYPE_VIRTIO_DEVICE ?


</pre>
    </blockquote>
    <pre>Please excuse my ignorance, as I'm probably missing something here,
but how can I verify a device is of TYPE_VIRTIO_DEVICE without using
a canonical path ending with &quot;/virtio-backend&quot;?

Initially, when the query begins, I use 'qmp_qom_list' to generate a
list of devices under &quot;/machine/peripheral-anon/&quot; and
&quot;/machine/peripheral/&quot;, e.g:

	- &quot;/machine/peripheral-anon/device[0]&quot; (virtio-serial)
	- &quot;/machine/peripheral-anon/device[1]&quot; (virtio-scsi)

Without appending &quot;/virtio-backend&quot; to those paths, which are virtio
devices, checking if the path is a device of TYPE_VIRTIO_DEVICE would
throw an error and fail via. the following:

	Object *obj = object_resolve_path(path, NULL);
	object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE);

With these path (without &quot;/virtio-backend&quot;), we could check if it's
of TYPE_VIRTIO_PCI, but not all virtio devices are PCI devices
(e.g. virtio-mmio).

This can also be seen when qom-get'ing the types of each path:
--------------------------------------------------------------
{&quot;execute&quot;: &quot;qom-get&quot;,
 &quot;arguments&quot;: {&quot;path&quot;:&quot;/machine/peripheral-anon/device[0]/&quot;,
               &quot;property&quot;:&quot;type&quot;}}
{
    &quot;return&quot;: &quot;virtio-serial-pci&quot;
}

{&quot;execute&quot;: &quot;qom-get&quot;,
 &quot;arguments&quot;: {&quot;path&quot;:&quot;/machine/peripheral-anon/device[0]/virtio-backend&quot;,
               &quot;property&quot;:&quot;type&quot;}}
{
    &quot;return&quot;: &quot;virtio-serial-device&quot;
}

So, in short, I'm not sure how I can check if a canonical path is to a
device of TYPE_VIRTIO_DEVICE without its path ending with &quot;/virtio-backend&quot;.

</pre>
    <blockquote type="cite" cite="mid:20230626081522-mutt-send-email-mst@kernel.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">        -        Error *err = NULL;
        -        QObject *obj = qmp_qom_get(dev-&gt;canonical_path, &quot;realized&quot;, &amp;err);
        -        if (err == NULL) {
        -            GString *is_realized = qobject_to_json_pretty(obj, true);
        -            /* virtio device is NOT realized, remove it from list */
        -            if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
        -                g_string_free(is_realized, true);
        -                qobject_unref(obj);
        -                QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -                return NULL;
        -            }
        +    /* Verify the canonical path is a virtio device */
        +    Object *obj = object_resolve_path(path, NULL);
        +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
        +        object_unref(obj);
        +        return NULL;
        +    }
        +
        +    /* Verify the virtio device is realized */
        +    QObject *qobj = qmp_qom_get(path, &quot;realized&quot;, &amp;err);
        +    if (err == NULL) {
        +        GString *is_realized = qobject_to_json_pretty(qobj, true);
        +        if (!strncmp(is_realized-&gt;str, &quot;false&quot;, 4)) {
                     g_string_free(is_realized, true);
        -        } else {
        -            /* virtio device doesn't exist in QOM tree */
        -            QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
        -            qobject_unref(obj);
        +            qobject_unref(qobj);
                     return NULL;
                 }
        -        /* device exists in QOM tree &amp; is realized */
        -        qobject_unref(obj);
        -        return vdev;
        +        g_string_free(is_realized, true);
        +    } else {
        +        qobject_unref(qobj);
        +        return NULL;
             }
        -    return NULL;
        +    qobject_unref(qobj);
        +
        +    /* Get VirtIODevice object */
        +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
        +    return vdev;
         }

         VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
        diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
        index 8af5f5e65a..4b2b7875b4 100644
        --- a/hw/virtio/virtio-qmp.h
        +++ b/hw/virtio/virtio-qmp.h
        @@ -15,13 +15,7 @@
         #include &quot;hw/virtio/virtio.h&quot;
         #include &quot;hw/virtio/vhost.h&quot;

        -#include &quot;qemu/queue.h&quot;
        -
        -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
        -
        -/* QAPI list of realized VirtIODevices */
        -extern QmpVirtIODeviceList virtio_list;
        -
        +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
         VirtIODevice *qmp_find_virtio_device(const char *path);
         VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
         VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
        diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
        index 295a603e58..83c5db3d26 100644
        --- a/hw/virtio/virtio.c
        +++ b/hw/virtio/virtio.c
        @@ -45,8 +45,6 @@
         #include &quot;standard-headers/linux/virtio_mem.h&quot;
         #include &quot;standard-headers/linux/virtio_vsock.h&quot;

        -QmpVirtIODeviceList virtio_list;
        -
         /*
          * Maximum size of virtio device config space
          */
        @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
             vdev-&gt;listener.commit = virtio_memory_listener_commit;
             vdev-&gt;listener.name = &quot;virtio&quot;;
             memory_listener_register(&amp;vdev-&gt;listener, vdev-&gt;dma_as);
        -    QTAILQ_INSERT_TAIL(&amp;virtio_list, vdev, next);
         }

         static void virtio_device_unrealize(DeviceState *dev)
        @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
                 vdc-&gt;unrealize(dev);
             }

        -    QTAILQ_REMOVE(&amp;virtio_list, vdev, next);
             g_free(vdev-&gt;bus_name);
             vdev-&gt;bus_name = NULL;
         }
        @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
             vdc-&gt;stop_ioeventfd = virtio_device_stop_ioeventfd_impl;

             vdc-&gt;legacy_features |= VIRTIO_LEGACY_FEATURES;
        -
        -    QTAILQ_INIT(&amp;virtio_list);
         }

         bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
        --
        2.39.3

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------FJHamD35e3ucqy7AcL0QBnWC--

