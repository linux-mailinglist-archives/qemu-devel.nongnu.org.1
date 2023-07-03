Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD0C745FC6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLPg-0004OI-NO; Mon, 03 Jul 2023 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qGLPe-0004Np-2Q
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:24:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qGLPb-0001kH-Og
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:24:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363EnilS030221; Mon, 3 Jul 2023 15:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EP3hqujmTiAaabQN/d2jwZHE2Wy3aagxRraw6lARyb8=;
 b=VJLyUdglxYaGlTOIjhGY/E3AVYYB2UIqO9sUB3IqDhaqAcSf8osBp4vn49MbJFmYu21M
 WvZXp6OxiveSAQeIFafrFV4fIs3Qtj0omz9u2DLvmT1NXvDj8coBPkXiIx42L9r671A0
 6IWyhBsjNha/e8r8KHXtKDIOGpXExTSM4gOM7bARs++jQ7mODmpV91bUkyl2zbA5/CCX
 bX6V9l7H45f9FWmhboUMf7TjG8quutlsFEBGb4kvT7BvVQrxD0hpypSnL7CYEgtu9iax
 8cM1HtYRrKYX9R223fh8PDocDjqA35dxSRwlqM3s7KGMefp9KdVbb1rXGyi5siovtTXS HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjb2bjxtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 15:24:17 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 363FHlbr010763; Mon, 3 Jul 2023 15:24:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak3fqcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 15:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc8RiiAAiUW/VzpOnIZ5wmyZFX99N/d+vxPGcX0V9JDYb/FitM2AdfwF3LrRiLFNh6a8HgzzL0jcsN+TyZNJCEneCVbI3zhK8q5iXeBHbGqLoGBC2EuCpcCbHPH9rYsQ+B5+yhlsRrm/e0swQFNaiF3ub8PlaYgro4iPTCh+fGG/wRLPzNCAES2rViHCwLzv/SMo2RREhL4KdofErHxfLCJGpIa2I0sXakpr/6nMMh1XO9MgLxhQiSMjQsgFxavPL/7z+OOgTQMWmLksXkM/z0sRe5tr3So22oDbFt5UJ07tG2AX+lvs9IzTy6Gq9ku/7uLM+AqBEqqRLh5pnDb0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP3hqujmTiAaabQN/d2jwZHE2Wy3aagxRraw6lARyb8=;
 b=Odd6yz+xjRZl6OgKvFNTnRmr5G+2pjMbCNjl6vZIip+KBoV1DRbceMst6JaQMePl5k+tUK5gmmUtKOOsgTW8G+elJfSCl0wZKs48alsOY46N32AgJReLjALb2Lz5rmG/vFdHOgHLs1JKhkWW7UHijIjj1eNdKwuWPpBD+em4OaRK7wUb7lhn60Qd5E0n+rj8tJpQwxYbEzFocgFcZBAV6viWzLfT6WULv7J3Y1zuPwJGitlEbvBLIWcZ9y/2XGGlFT1nwQoJAfKP5sV+xOelh6XdonOnP1SAaNPTn+PmKmwWN8tpd0OhbzmO5hhN9fddNw4Gi114qqv9LdHCHktmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP3hqujmTiAaabQN/d2jwZHE2Wy3aagxRraw6lARyb8=;
 b=I3QMmXqOXdn9BG1N7z+duuOfU9BF+qY2tqxvvfK0QB07UJ56ZHjIKRYnn9+zu8Hqi9EDsKPbPcn8Jg1ynFMollPi/jdNZYfAtWm0zMBOR1jOPgu/7S2PXrpkEC4QWq9tezPEDpH4U4KyK81XI9EWqTiM+pL6L7G4Nm63TyICA18=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA1PR10MB7710.namprd10.prod.outlook.com (2603:10b6:806:3a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:24:03 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:24:03 +0000
Message-ID: <58957ed1-e2e7-05f6-90bf-9170189b11f8@oracle.com>
Date: Mon, 3 Jul 2023 16:23:58 +0100
Subject: Re: [PATCH v6 5/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-4-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230703071510.160712-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA1PR10MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb2e6a5-8188-4ce1-a17b-08db7bd988a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9C29C21MD7CJxLg0S+qFdhFEHz+cdlQ+otV0C+amMCk/L6Nm3rvZv2XLWRgh6o/Tv8Ct/0AffOa/DNPvn8NMBdfb34sioEV4ci/JONyDbIS6nxoFHDnlumwf5IeXbtOLysUsUj2QPS9S313WcE8eIc3+rvdBYwPqDtzs+DgCMcKl9CbwQALb9ddVOvn/YmAKOz0Hb1ka8GTqvPsbJdPNmQbkY6RIuKv+dXkgCqOfQmYpnihMkVCYYyqswwUSnQvXdTP9xFIIAhfeRqavKZhwZ3jRTm190Mt7Uz6+jZsWTIh9PNhFdGauQe8WtbbMtK2N0SKCwxpb7RHFmFgBL0Wm1bscQk8PaU9s5ZihIL3T9B6ZS+oq62ziXVNicqOC59h51uYdeK8jPIAbiZGcBYEBwBeVt6BCcNB3dYmWN7lOl5QJgzcu/MT0dSyJn6Fw0I0h3iA9F56oTeFKKqccA0JPOXJcdwK1KBYlXnBnNZVK9yZKa56kPM8eM5KmUK9TPX7wmlHQwiGRtRrPAQkzKRpXbO1D1pJfQnNNYkxyn2LjAWvxV9A9bEMfIRzjYjrOgLDJCeiUKjJYd8OZ2CL2a02ZDUf/PZJvK767VlIk9OZZ/2cfZkNITgCmTydxa4ZygWiL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(41300700001)(6486002)(38100700002)(6666004)(2616005)(83380400001)(6506007)(26005)(186003)(53546011)(6512007)(31696002)(86362001)(478600001)(316002)(36756003)(2906002)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXF3azB3TzRsZ3p5bDhsdURhRE9ZTGZHajltY3pDZ3cwdHhmdERlNjdaUklh?=
 =?utf-8?B?aTArSnp1a2FDZlRWdmZHZDNkeGtCVHkwaDlta0ZrMjZjelg2M0FLdkkydUt5?=
 =?utf-8?B?WWNURFFGOW9tNXY0MlZpVllRUmcvUkgwRWZzdVVjeWNpRjVHZXZPSXdHM3Vk?=
 =?utf-8?B?ZnoyQ1dhN2FiQnpaeWk1cStxYkdXUU5TblJVVG52MW5OQ3J0Rm8vM3pmWG1j?=
 =?utf-8?B?N2MwVXh5dG1SaGxnNjQrc1FycHl0MjhPUVlVQmZmVVRkZlB0WWtiT3o2RmRv?=
 =?utf-8?B?b1RZU1dwbVV0UVo4dHV5ODREVU5zd1lwMWpOUHBUMkZpbDNJSHNHOU95NmRZ?=
 =?utf-8?B?R1hyV0ZhTzJabVZSMzUrclE1dmxZMHJYTkxWRWI0MElhQlgzQjU0VWlWMDVw?=
 =?utf-8?B?NWgvd1RXN3hkNjZzcVQ4aGJ1eDZZTHlmTmhTWWg2T3cwbTlLb1E4MlU1NWor?=
 =?utf-8?B?SWJNUGMxZFpCT3BhOVB2Yk10Ri9HdktlTSt3ZnVDYjNuZnpyQWxxSTRoL2VX?=
 =?utf-8?B?bXVFUXVFQmFqVFNmNVV3dlJKNXRDYlRwTG1jS2laR01YWlVxYVMxQTlaS3ZO?=
 =?utf-8?B?NVVBcmVCNzltQ2VxbFZoUjhtTkliV3V3VnBwcmNKMzlPd0NlNE1CcytqbnVp?=
 =?utf-8?B?OXl0Kys4SjE1cUFmNXowRUM1NHd1MUdpWkhSUU1oanJpRjdEUTJ6SW1nNmdo?=
 =?utf-8?B?RGdSeFVhS1Erek5WdmxNaUFkS05NUEZPaER3NzBWT1VlTmQ5OWFqVVFtVkgr?=
 =?utf-8?B?QktyY2VvQWlvUXROZks2NUkwRWZpYlVBU1JYS1FsVnUyMmkwQWthRkIzZXJI?=
 =?utf-8?B?WnpmRzdYMlpLTkV2ektHMDRYdG9CdmZyc1I0aFBjcFB6NDVxWHB6Z1F6aFFD?=
 =?utf-8?B?MFZRZ3pLU1dZeEJXbXRtdS9Zc1lnQlNWY2duM005bFhCUFRGNi9tL0R0NFFO?=
 =?utf-8?B?clAydnI1a21zNHAvM2xTWnZTOWdQWjk5RGVqR0ZLZTVvV3dPVmxkQW90VTVw?=
 =?utf-8?B?SFNYWHd4dldYemJuNm1PVXI1bmxMQTJOTHo3bXRtRWdHMkVQNkwxZllmVjNP?=
 =?utf-8?B?V2s3SUQ4UGE0WVU4RTBaekNUK2o2QXFGRWxKbU9EaldYRUdIakFiZCsvY2M3?=
 =?utf-8?B?WTZmYjNLWFdFSHBKdXJBalMyUDFVOGZYUThCUytpamJ3a1JOWWkvYytpd1ov?=
 =?utf-8?B?QlMwbGt3Vi8vZFRQVmZEcXR5RHExMVJQeTdwL0gzMUhzakNaeG0rYzdZR3U1?=
 =?utf-8?B?d2VFSTFyQklWazllMXkzZGF6ZG1JVUZPUTJPSU5EcE9hVGhlQjNoamVHS2Vx?=
 =?utf-8?B?K3RKOTU0YThETFBaV0xjeUIwL1hLU2F2RC9pOFpMZExOb2JGbE9VaFRuRmoy?=
 =?utf-8?B?VFF4anVyR01kSkc1RGo2bnNNeXJnUHY2eWFzR081V0NNUEphc2JnZlFpOVE5?=
 =?utf-8?B?d05IYURKK0dkdkJFMTk5ajYwbWtvQWFVbWREY0plaEF5Ums5dEVFRk5EVnIy?=
 =?utf-8?B?QVdHV0ZsUThVSCtHWis4MGZ2NFA4QzZCYlJ4K2c0dngwRE1FdjhKZ1RPZWMx?=
 =?utf-8?B?S3NORlRPcW81dXR2NzZpSk4yWUJnekZPSnc0WHJPZGRydXpINkViTGdZMmlX?=
 =?utf-8?B?SktKNmR2NElGYmU5WlNkekhWWGxFSTg0MWUzS01TSThHb2MyMWNsTUJTdC9r?=
 =?utf-8?B?RFdJdlZ5VGFUNjFNZ1VFYVljamtSL2llYnBOWHZqVDNqRG01QWs0WFdDdWsy?=
 =?utf-8?B?NkVZT2ZiV0FIYXJtby96TkZIV3JRSUtSaFZPTndGcnFDYVJ5WXpPWmV3UGhp?=
 =?utf-8?B?eFBFM1BjVkdLeUNLY0lQOFducERBbTRFT1U4cEVPNG4ySlJNR0ZjQ2J1aXhG?=
 =?utf-8?B?cHRodGlKbGZCWHJIWS9uVDI0QkdOV3hsSnU5cGZMdGtvZ2t2VGM4aXRZczVH?=
 =?utf-8?B?TDREZDZWNUU3NE0ydEh1RHRUS2l5eTgyTk8xcUJkVzlUYytybEhwNVIwd0FE?=
 =?utf-8?B?V0FDRVQrQ1VVbzNjaVF6ZmJyVm56alFBRUEySGoveTZVaXoxcEVwREVGamd2?=
 =?utf-8?B?cmU5VGZKQUYwczl4dkVJUGhPQUZHeHpWcm5aS2VaYVYzeEM4dXJDaEJaaFJJ?=
 =?utf-8?B?ZDVrL1pZWTlCdkdmYlF6VjJiK01ZV0VGbVJCV1N0NmxlT205TURTd0c1akpQ?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 133uQhbRVdDjC3NtbVEgzoekdA23QKjJmKoeT9jhNhT0JApDn1xcFvku5FS6Jk4F2jVzJXdjyFiKsriOxFx2Wk9SetFoJGWOpnrPZsKZA2n5jzdNc+i7pDu5gofoDVG5R5oSLu/8xpsjFnr4JaZowkLc/2RoltIbJmsD6/VvH4QxWwDbkgBQpnBeUn82Aq/Aws2fn9E8+qAcxSDY4ITLzgExXpJgMLsgpm6d13uC785+RZ7BVskT26FL2BOQz7dxLFrATOiI6wlwvxUJD0Ec9o6pj5301s1KRpYRVE9tFeF/1h62ResvpEu5uBArmUCe34IZtCZ7VJS5v38icTOZGv6EcVj25P7mzgTMwn2Hc8WVSb9dYtARaym8VxHKmvNQZ4gI4SySknNfLAJ8ezag52WeHl6eibhlhE6uXXXVSvfWza1UNvRuBLg1M9EBzMr8yOkyWiqL8QI9d1iZy83UZihg6E0/AMNfQbz3mkmgxs9NN2EhEeAZZRSz4s6H8Y51gjLnp1Fjkzc+AgsdPkZwNuP1VFa+Z0bFenUFTrGQlWO28aadQTudhZ23PCaT4kwD3H7fP9wGPeB5E8wxxCX/4I6Uy8gu1s8MAFn6p/2vDLH8odjzdN/ksHyEwfxEnNLvXIYhTzndAFnJrydn+y7NtQriWOApWdH16Vbkx/EBFaO63I5RaiLLCcNhXjd0wlEQOo/PYeNkzbJNR6F4bmiMoztEGPlsI6DazMTbA42eNLN3PS19FeUvRugtYv/ia61M+8rMkMSDobpA94122sFPEItRrzaFID5tqBn5k7G/Q9f5qNfOtGv55NWPBpc+F3FRXljoz/aHSK8my23Ye0xqaA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb2e6a5-8188-4ce1-a17b-08db7bd988a6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:24:03.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itkKU2kvdHrpGeR1fyyrv9L0RAmOMg41uRrnyIJCk+HQaGD5WGWnjEu2KDcTM2lCxTeORY+E89lJlTtM/jfe/QUQ/iiO++wfAvAPQuya8FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=806
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030139
X-Proofpoint-ORIG-GUID: 1ZUjqZ5pCc_5tjdKgPVXsq8NMfl7HcZA
X-Proofpoint-GUID: 1ZUjqZ5pCc_5tjdKgPVXsq8NMfl7HcZA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 03/07/2023 08:15, Zhenzhong Duan wrote:
> When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
> to free resources allocated in vfio_realize(); when vfio_realize()
> fails, vfio_exitfn() is never called and we need to free resources
> in vfio_realize().
> 
> In the case that vfio_migration_realize() fails,
> e.g: with -only-migratable & enable-migration=off, we see below:
> 
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> 0000:81:11.1: Migration disabled
> Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device
> 
> If we hotplug again we should see same log as above, but we see:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> Error: vfio 0000:81:11.1: device is already attached
> 
> That's because some references to VFIO device isn't released.
> For resources allocated in vfio_migration_realize(), free them by
> jumping to out_deinit path with calling a new function
> vfio_migration_deinit(). For resources allocated in vfio_realize(),
> free them by jumping to de-register path in vfio_realize().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/migration.c | 33 +++++++++++++++++++++++----------
>  hw/vfio/pci.c       |  1 +
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e6e5e85f7580..e3954570c853 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -802,6 +802,17 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>      return 0;
>  }
>  
> +static void vfio_migration_deinit(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    remove_migration_state_change_notifier(&migration->migration_state);
> +    qemu_del_vm_change_state_handler(migration->vm_state);
> +    unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
> +    vfio_migration_free(vbasedev);
> +    vfio_unblock_multiple_devices_migration();
> +}
> +
>  static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>  {
>      int ret;
> @@ -866,7 +877,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>              error_setg(&err,
>                         "%s: VFIO device doesn't support device dirty tracking",
>                         vbasedev->name);
> -            return vfio_block_migration(vbasedev, err, errp);
> +            goto add_blocker;
>          }
>  
>          warn_report("%s: VFIO device doesn't support device dirty tracking",
> @@ -875,29 +886,31 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>  
>      ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>      if (ret) {
> -        return ret;
> +        goto out_deinit;
>      }
>  
>      if (vfio_viommu_preset(vbasedev)) {
>          error_setg(&err, "%s: Migration is currently not supported "
>                     "with vIOMMU enabled", vbasedev->name);
> -        return vfio_block_migration(vbasedev, err, errp);
> +        goto add_blocker;
>      }
>  
>      trace_vfio_migration_realize(vbasedev->name);
>      return 0;
> +
> +add_blocker:
> +    ret = vfio_block_migration(vbasedev, err, errp);
> +out_deinit:
> +    if (ret) {
> +        vfio_migration_deinit(vbasedev);
> +    }
> +    return ret;
>  }
>  
>  void vfio_migration_exit(VFIODevice *vbasedev)
>  {
>      if (vbasedev->migration) {
> -        VFIOMigration *migration = vbasedev->migration;
> -
> -        remove_migration_state_change_notifier(&migration->migration_state);
> -        qemu_del_vm_change_state_handler(migration->vm_state);
> -        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
> -        vfio_migration_free(vbasedev);
> -        vfio_unblock_multiple_devices_migration();
> +        vfio_migration_deinit(vbasedev);
>      }
>  
>      if (vbasedev->migration_blocker) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c2cf7454ece6..9154dd929d07 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (ret) {
>              error_report("%s: Migration disabled", vbasedev->name);
> +            goto out_deregister;
>          }
>      }
>  

