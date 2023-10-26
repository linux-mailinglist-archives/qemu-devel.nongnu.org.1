Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50587D8672
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:08:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2so-0003n6-1O; Thu, 26 Oct 2023 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw2sl-0003mi-Jv
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:06:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw2sj-0007ck-8o
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:06:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QDi5v3007231; Thu, 26 Oct 2023 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cmZQaKqEuCyToRPsx1ozSuorz7UCza/BwUf0viQdR5I=;
 b=XNvtxYPzsZqb0tXfldz6ntDr44oON/1mcjPXI8EMz3sFLFX60kybnD2Zou11QcmahceP
 dU1SCSi4V268hgWwbSFxAz+GCZcqiweW2TzHWcyt6sGlKZ/vQxjB/9d2x6h6+7f5ZhEW
 ute/+JLSprhmmJ4n664hOjTgo1s2Zt+2F+cPxdFQWW9HkvhtlV3mZZdD1anmDPTdhVlo
 rUD8auODjA8Szvl9lfdR2s2SlZb13lwHbEI2Q80LowpM8SSA024XKk49/chFtWEYiLfJ
 npDY61n0CRWWlnHZTMdA7c4Hua9bvfWkZMi+y4sLVYWqE27NUntTXp3C0SM3hZS933fL CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e3bf2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 16:06:44 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QFu2jZ034526; Thu, 26 Oct 2023 16:06:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv538ckcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 16:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXmRwI22vuiJwmbc5np5kJ4N9pUfDxJrqvM91u4Yr1u+nMgLuWzhnVfjNcDuoLLhdoF4nRO2nVi24wGK9pYxhtC2GA6OvTJL5Qf0MsUXTrLt8vyePLI0gxLKHUIgYTopolKa+9Tv+u/Lh2s0NiMRJ7Y9ve+vLyB5JhFR8bjOHijHzPC0BThBamtMRdIzmzmKCpB86BqeNipblL/bAgP5iw8fuNOKWUPOeoUCrzh1QLLwHj932cGZKgHKhUh9xZdfCEnFbQEFBkFlYApbg5rqAbt5KrLWC7t++N2O0fhsy+ejUCqbPjB+GimkEuReQsZGAWXDMJ11XYCbdRWixEyNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmZQaKqEuCyToRPsx1ozSuorz7UCza/BwUf0viQdR5I=;
 b=T3nnYLXUSHtV72toQ74Hc9Xu8bzreKKq3jiGSkKUKs6Kxm3ArDjwQvYfsVuOMnASYcx9g3dvzGYGkP1aJ43gWf1RsecZdUG0VnM31O6OIC3BkRLKKt/wzzXKa6RnEz2q6LfeF5Rgi45Tizl58lZmm0vESxc/BNNrq3PCSCP3qf8Hw0hFle40plmks9c6+zbT2B5uXpDVBNE9KKugazK2lLMJjAxd1IM+B+RoVpqqrFM4dcnc1tyVplWDqW2lIPFqFaA0oeioZqbhGdu74tp0msHsMbxirTvVQk0GLqYcOyaL7FCiX8n3tRBQq2JXMRyNNqFCxJXiNhKx5kY6i+Ilfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmZQaKqEuCyToRPsx1ozSuorz7UCza/BwUf0viQdR5I=;
 b=y0RHAGsPU2Y6yu1ToSpDEbeEYcdOkiSYtHUXcNQyfs5qQ+N8Id4kZdOM2iEyIgw9uzMwkyrA5hEQBxhfGD0mQutQwXO0eUtLLOE7e/wXiwWAslEiIJuXb/ou+b/3dHAqRXJwEdZ0p/vUmgMIDZX8qzgFPNmpsU0ZeeSgm2cdb7Q=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB5199.namprd10.prod.outlook.com (2603:10b6:5:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 16:06:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 16:06:41 +0000
Message-ID: <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
Date: Thu, 26 Oct 2023 17:06:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231026155337.596281-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: d99cef65-af4e-4790-477a-08dbd63d8ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvN0f5eE3gs5bZiuzxYohV4hdaGmrFLXNFqoLiS3VHzZGhVQwBwOb0COoRyK1gM4tg32jtHS7S6LbhoyI1lJkgcsmEEvSMPpa6UMi/XjTyxO8kMpS830vatoppY7Is49uthNap7nheIEH+ZOvWsCBnimUMOdOexG7Dixo0//zzXerY9nPGESYnZgtx3BANY+RrRkupda158m2aMUtPk7/cmqjxWkVPsDff/v5lbMZN75UTDT5OuhLE8+ErVxBWrEwcgPsSGXBJQuYpYh1UrQ+wkk7HAVGBOjasppTQI1V3TuZSuXTiuuqLAnJExgQ5D8SrXIf/Fx1RRiSCvYAwWcEUCNy7UCiwtiI7HJCbrPzRuQiKvHFT2mLzbsGZ8wp02A/QbWEhIrvSFa8ug2RZ8HefjyNq5zSQzXm4En/DsLcl6nj9YbeoPY7yWAdegYvb8/m6KKMd2VNdhZ7X5NtGC1kj9dqykp5lRqmBt4qgZFBx0W9DnCDB5N5T6VaTDbI9UAAvyj82hOZP8Qh+ZEg9t81smjbeW7dsp7sCGkazZy8WCm3o/+HP10g9I9v2nRndDBqTbV16RzD3BUsk0AXm5txOhhtElEybsVk65ra0vYaCna1mu9QfCKVH2b63piko7aIXh71EmgQ0RcOSGeSeZ5QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(83380400001)(2906002)(36756003)(8676002)(4326008)(53546011)(2616005)(26005)(38100700002)(966005)(8936002)(54906003)(5660300002)(6506007)(6486002)(31696002)(316002)(6666004)(6512007)(41300700001)(66946007)(66476007)(86362001)(478600001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDJhSjhBZ1JiWlFaRVptWkNUTS93TkVvR1JzSUExSEp4ckV3MTU1MGlRck9O?=
 =?utf-8?B?a0QyVXB6RndLOElSTHpFR0thVVlHcEpXYnBMTUt4K2Z6V2lqZlQ0VnUzSXBE?=
 =?utf-8?B?TVZwakZtQjlLYXZ4Y1dZNkV5Y0lFaE5wRkJLTzNQSEc4a2xLWGJMeXUvRXd0?=
 =?utf-8?B?NkgvVDFBS3NBUnpJbnBKc0toTllHSEFuVmNoTjJCUzVrNDJIVVNaOHRib2s2?=
 =?utf-8?B?QjkwWG1ZNkIrL1IvdkM0VUg1WHVRZFlIWEF4bDB1eE5JZWxmZlE3TzZhNGhi?=
 =?utf-8?B?TFNNRzhFcXkxOWhEeSsyWjV0bUJyZTVHRlBiRmRpUzlFQ2hwc04wWHBYYWNG?=
 =?utf-8?B?dG9SZVJ2aDdjK09DZTVSdm5obE8yb09MWkFGalVHRHNpQlp4R0tlVkdvOElB?=
 =?utf-8?B?VTE0czJTQjRuV0hxQklmNSs3M3M3eFA3U2xEcHlIWnFkNjVkN0laSU1oSGx1?=
 =?utf-8?B?VEYxUnlERGEyYnRuVnlsZEY3VWk0dDQ5d2ZNNCtxT0cxWkt0dGhzalZNRnU1?=
 =?utf-8?B?dEhRWitNOXhyc1BJMnFxdEdad0swdTJHVnA2RktDZkFFNEIrWGtKZ1VUdUgv?=
 =?utf-8?B?MU4rL1NVZitoUFZKcjZaNUxtNGNEQ1NmVnRwMWJEN1hHN2ZnWmY1RnhUM1Ar?=
 =?utf-8?B?QklwWDRuOC9vY21CeHB3dGNtb2s0cjJWTnc4bzhmR0c5MSs0OU9seXBNSDd6?=
 =?utf-8?B?RHZyYWd1MWhTZGF3NjJTYlpLS0R5d0NUK2FLeGtQN0lwL3Nsb0pzMy84aUdy?=
 =?utf-8?B?QTd5cGJPSnkyd3Y2QUlJREpKS3liVGhyVCt0emJEWWlpaU5Uc2xTK3JvREw5?=
 =?utf-8?B?aHhXa0VEdzdzWUF6MzEzZzZEcG5VUU9xOWlFQnA0RDBTLzhkejNjUTRMMmxO?=
 =?utf-8?B?Nyt4eG00SDVXQVFYTW0rTmcwb0cwNlFmVGFtcTVxMUgvb1J0U2JYNGFienRO?=
 =?utf-8?B?b1BrcEtQcmZzTTVxNmFUWXkxdzV4aVFFN3NyQ2Mrc0poSW5Sa3RDRXpNQ0NI?=
 =?utf-8?B?UXRFMy9xOFZtTjVTblpIRWlOZ1cxUW4yeDVwNzZVOFk3L0xVdmRIQ3RiOGR4?=
 =?utf-8?B?UG1YWWRhU3g4NitlV2U0ZTcyNUpEdFFtNGxWV3cyaEF2Mk9vSUdOTnVmQnBy?=
 =?utf-8?B?aktTemZ1K290VW0vUlhLcHYyWWxhQUlFTWpNb3BNaUFheGZVZys3MGNFZnFS?=
 =?utf-8?B?N0FGekt5Tm9QRys2MVVoVnhGUlFGYUN2TkwremhNOXIrbmFQZXl5Y1FKTnZ2?=
 =?utf-8?B?Yllvdm9jSmlVRUZic09lbTNhZ0xib28yTjhxcWM5eDNtWEE4cmRVaUROSThJ?=
 =?utf-8?B?K25obHgvVXNYbkQ4T2k4eGkrUDlwZGlpdWgrY1c4bXdUZFFoT25iU0NoZS9E?=
 =?utf-8?B?NkZqOW4xWmt1N3ozbGpKeGFjSytJWlpHWC9KVDJTclJhcU95OFA5dTRtM1pF?=
 =?utf-8?B?U29LVU1aZ0dYV0JsV3ZmbUVZR0V5NTRTbHNzUUxjYzFSejFaS05BTUdqTldB?=
 =?utf-8?B?eG1Da1lQdFlXM25aOVJhOXF6d3daRkp4RTNDdEo3RnYyaDUxRTdaOG55aDl1?=
 =?utf-8?B?N2VRYnRuYTBHNmZZUU14TXF3MEw1YlpyQzZWZERwS2RGbjJQMU1XaHpiUXJV?=
 =?utf-8?B?bWl3M2daOThEcTRYTTVuWHAwME9SRVRRazFJR0p1ZGliTDZ2U21jUkp5N2Jl?=
 =?utf-8?B?VE8zK3BoYkoybnJFVVlkb1JtUEdpUWFERkY5WC90eDFjMjFkVXdxU0Z0T0pt?=
 =?utf-8?B?dlJqaUp5cElqdnZaSCtMa2puNHVTUGM0aHNVTnBvOWVEdHZtQTU2ZkoxRW5J?=
 =?utf-8?B?Yy8wMVZPbmI0aTFSQzAvb21VRkx4NFlqOUI3S2ZQQk5zMmFBQmhvdlNPbVZP?=
 =?utf-8?B?M2JJQ0ljZHdGVXdLeHVVSVdtNUthUUNLRkRvV2J1bW1GQTRxOS8rOFdQclVk?=
 =?utf-8?B?L3FnNk5abkFma3hwbTFJeWc2MENOcHRQYWR3Sk15MkxSTmdQN3pVOGdQaHRE?=
 =?utf-8?B?K2pXQVlIVklUeDZJVS9lN0xRUi9BTlFjaU5QcUh6dVFqSVVUWTVxRVJLekpY?=
 =?utf-8?B?WDA5cXBuVjRacDlacHBWNFFIa0kzZlJGNjJiajd1QWF3ZmxLVjR5LzlWZjYw?=
 =?utf-8?B?L2pscUlDbytPalNwbnlQdmJpSkxMVkxndFlUaXE2TUVRWGQ2T1d0SGxWTmNT?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t41KeRTU02+RySgRYwHzpNKtOjdHS8yAqzHhJ/+0c/BptV7OFXfjp0/2DqNdV1iKZ4Oe1D1+gjRqrCkP9zm/OenpzgLCvkRI7QR3uKULjwhMiOYEKPaXOsN1B4iiPvIFmODeqUW5K5j+xfpBQGonf9eN1OVn/MLVprJLO48hefNVrIWFwGlClY1Tl87G5InDI5L7IhGV3oqFaU3Hs4faNHNSi3Ulr0+3s75m+xq3CosHpd/QpTqh2oCP2qnoeGtdpzRbkoqsbQEa8gAUbmaesmkvsVFSEfY5/msZ5CQXwT15f+Jesm6pE/slsriYNV2VHzBz/n6GzX9GB3YNHs7s0bpp9tPefF2PJ9NJpVC49d90nlVmQG4CK4W5prjVRZ7RRCDMsq7AQD0r/vBgHyxuSPtVHPQQNXf0K6AVVDSsxbeqNZ5EgWPS0OZnpHQbM6DfWfi5NDzR9rR0HAQ7bjdawG2Ca8a9spvicVpaGuYk7+5Hzs85onHhEd3t+dNeu/MFC3qoaiUyyE5sqV/ylpx+WxrbA9AZmLDZVsjv7IZLBaZLYdHOVhHnqFUGghaW15pLfZKTEZPehVKz1ILg9hH4Hy0UfwFIAjz1DuA8cCkbKqDd+XhP9ehpltFRGCFFSRT9XLFSAOl3xsgoZ27VcQ4IvrK2hr2JazOhLKSOw7j1HBxBeh3INthJ+BsETQlCVgzbF5MYjsqvJ0i6HYFs/7IorfOF3FqwIuU4tt6+T/DD/LbUjLQXk6YKLyXBexlpCccLIQBbgeHfRo5wYlXp2IOrCVdpDO7zKNbWbYOhLZwDolM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99cef65-af4e-4790-477a-08dbd63d8ad0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 16:06:41.5001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKxTaXm6ZjwadnCBxKL/Kgr7ahTnJpNLyF1rnnwiEZEyCCMkb8cck3kw8VeJIZ8yNrFw7glSI8o8gkzd4sVTo6N+VzDTx1kDUOA//Fs4Tc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_14,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260139
X-Proofpoint-GUID: 0hhsbCsh9TKfZvySP5bUccvUpoFnvMNT
X-Proofpoint-ORIG-GUID: 0hhsbCsh9TKfZvySP5bUccvUpoFnvMNT
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



On 26/10/2023 16:53, Peter Xu wrote:
> This small series (actually only the last patch; first two are cleanups)
> wants to improve ability of QEMU downtime analysis similarly to what Joao
> used to propose here:
> 
>   https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com
> 
Thanks for following up on the idea; It's been hard to have enough bandwidth for
everything on the past set of weeks :(

> But with a few differences:
> 
>   - Nothing exported yet to qapi, all tracepoints so far
> 
>   - Instead of major checkpoints (stop, iterable, non-iterable, resume-rp),
>     finer granule by providing downtime measurements for each vmstate (I
>     made microsecond to be the unit to be accurate).  So far it seems
>     iterable / non-iterable is the core of the problem, and I want to nail
>     it to per-device.
> 
>   - Trace dest QEMU too
> 
> For the last bullet: consider the case where a device save() can be super
> fast, while load() can actually be super slow.  Both of them will
> contribute to the ultimate downtime, but not a simple summary: when src
> QEMU is save()ing on device1, dst QEMU can be load()ing on device2.  So
> they can run in parallel.  However the only way to figure all components of
> the downtime is to record both.
> 
> Please have a look, thanks.
>

I like your series, as it allows a user to pinpoint one particular bad device,
while covering the load side too. The checkpoints of migration on the other hand
were useful -- while also a bit ugly -- for the sort of big picture of how
downtime breaks down. Perhaps we could add that /also/ as tracepoitns without
specifically commiting to be exposed in QAPI.

More fundamentally, how can one capture the 'stop' part? There's also time spent
there like e.g. quiescing/stopping vhost-net workers, or suspending the VF
device. All likely as bad to those tracepoints pertaining device-state/ram
related stuff (iterable and non-iterable portions).


> Peter Xu (3):
>   migration: Set downtime_start even for postcopy
>   migration: Add migration_downtime_start|end() helpers
>   migration: Add per vmstate downtime tracepoints
> 
>  migration/migration.c  | 38 +++++++++++++++++++++-----------
>  migration/savevm.c     | 49 ++++++++++++++++++++++++++++++++++++++----
>  migration/trace-events |  2 ++
>  3 files changed, 72 insertions(+), 17 deletions(-)
> 

