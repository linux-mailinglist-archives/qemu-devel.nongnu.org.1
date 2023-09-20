Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B727A8DBE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3hX-0002Vx-Da; Wed, 20 Sep 2023 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qj3hV-0002U8-4R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:21:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qj3hM-0007Am-2v
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:21:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38KKJdEr009257; Wed, 20 Sep 2023 20:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sVH6fafeeNH+fPHlHwXxQJT6Wu/+Lc3bfp6PRm+zAWc=;
 b=c5dzIoyOBTvdpdkOmOLS1KCT1QywrbuJvobSymeb14c1/SChnnDRPtu+WjEs3x9FLA9I
 87Ux3vOyZmKo7ApE3Tu09vopWniMxEMXMN1Yxl1nitezhwDpLzL2QG1g+N2HsjL5vpul
 2MaNJQBSs7usBxprkll1N5PZjezFmMWKJEM7wTR3zQHdFuPcp3D2ismT8InCab7fSF6i
 8gNfjXIBaWikCC4MwJ26/pgw1lOske0VkK81Sh969G+euuzqrebeQezu0jFAeJMeeKub
 EMtBsOvDtHf+/Po11Vj7GvtJMqOaZ3DLlDDnfoOsdKCfy9ReXVgtsQP7Xljpl/6/lgvR AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y20bs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 20:21:20 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KJovZo030112; Wed, 20 Sep 2023 20:21:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t7krur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 20:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0lv7vyHPtx+hZ2b+1dKRaXQeAXeBXuVfuUzRwablJoaGUWjFZf4YSQJvKqW0FjI/Gzmg2sbT6kRTW50Li/uDLGGViP6o3rmShk510b7vrM2xvTNv7SZPOFLerJeJTsdVQH8gUEBPvZjryKJFJJZzgXeYKY2GXDYWk53jhTqgn5rbc0UPpONfNknyJ6+/WP6jpUml8tVUO27HW72Pwte93uFje4fdBTzaZZSqaQs0eLVYLfVFTaEyDEHzGdo+87iohn+0TQdvLsSbOuCyFNUGCaHvm64NKyxGwcu8iBeE4Vqw0Uv1YczRtlC6IYhqZxvHt4YIWY2ksqi0FEPFLJ74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVH6fafeeNH+fPHlHwXxQJT6Wu/+Lc3bfp6PRm+zAWc=;
 b=OqRQQGbzi9bB78hOmKkzYRBMZh0GLOkPL+KtDMTZBe8bSYMcbZYg/ZjUxGOI4k8LE3cA1zPOzMdiaj31J66l0ysodzReVjhEQTZ7akU74RgymLlMFeFkpXzcK5J/M1SAV3Iu1qvIV+hbW65MLpDr70hN5xGPzGzIGbRvbzU18xffDo2kg12SrEeH0NChw6Sor1butWh8+DzgnmlQyJmOjD7mjJXWvTjy+7oLOHq9TTonpIW38OOqxGoYO9qSYWUAPzr9amV0a5zl8uVBvKMNLk3OgXxWQdjYwL32F/nwXvTkcgzPZeEv5YvaWu64WwthAr1FYhMBlhgrIMeZNE8nQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVH6fafeeNH+fPHlHwXxQJT6Wu/+Lc3bfp6PRm+zAWc=;
 b=ztbl30HrNWDVak3aueZfMMC3lgLqiz/RRsuJWA5viLre6J06xg8Stm6iyxeMgEbTatmUo10ss0Ud3ggwDMzR0K+3R6hs0jHJcRp4LgTmSY8tncrTpOECL8e1aLL2xBKy8JDwBzDPEMFEV0LZolPK1jMgJC0OYDaYMPv3U1Dj+/A=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 20:21:13 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:21:13 +0000
Message-ID: <8aa97e51-e59d-4ee2-9838-f565730a3cb9@oracle.com>
Date: Wed, 20 Sep 2023 21:21:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] vfio/common: Add an option to relax vIOMMU migration
 blocker
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
References: <20230908120521.50903-1-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230908120521.50903-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0025.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::13)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: b82998f3-8588-4536-a9a4-08dbba172272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUUI6CywqV2ipNxI8D0LA8ieN/+iuxTFTF8RDCRZZFB31tSRZPIgsfpr6IugufCf2jPnNjb+W8KztJtQep9OKvjmNwwg+jPBroGaUaz72iIIHQ6Nq+JPOJsX28EV1IGbLQPUowfLnrrbpnTv+w0wCjAqbaCGJ7vlBcBP/Zfi+HkqovB/7QwPLs1IqjR/SNDg82vh7VZ2glQqbu77GU5NFHIeNfv76ONt+I1aQqgOX/IoFmUlolA0Oo/gk4QO0f+8uBkZrK8s0hN8vJZGNguLU4UUZaMqb7qlXaAKs2EEug57OE0G5cdkkljBOCkJfN9pWq7iwPSz88y9gjCiwLYd6bfwWKDupmx56aeVnmU9kTL8L0B+xUzrkI79FhRYbQ7O8CBEEiXgDv1ddqNGTvhp5MO9j67LPkklAGqE5l0J7sASQUJ0g4QyjDn5OTcMKUZJVk+gLqV0HEu+pWyJYvSMRpxCtlJ5K9SzPcP6XPkEBkzgm+40GOm4uxznoEdNfwnMjhtO80ujQBq4f87mV+EMA8KdFkPVuicFv/AKoqtMuPW2OBjF8xrPWAnTJbmQFUi93nNmzjhh3iGFewh5+UBkxYfRf8fwSIN4mN9bv9vBcqGLyky+e2T7xEKaAlq4hv30NFl24ZAbdEzbxb9m1wYxcNYlea27qtsDE9c+jl0z4eoM4iDGFLuIynuAFImSGiR4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(6506007)(6666004)(6486002)(53546011)(6512007)(8676002)(26005)(2906002)(54906003)(316002)(66476007)(66946007)(110136005)(4326008)(5660300002)(8936002)(41300700001)(966005)(66556008)(2616005)(86362001)(31696002)(38100700002)(36756003)(83380400001)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGIzMkNGN1RJY3M0ZEk2bzhlWTgvSkNvcm5Ja0FQTmxLcjRaelN1OUlaZ3Nm?=
 =?utf-8?B?QVhjYTdLb2kyODdqWVhqKzA2YnBEdjU4UTVTNXRCTitpeGNtbE9INnJIcTd5?=
 =?utf-8?B?bTFSYkJCWVpQY0VNTTdESys2cVllSXhUOXM0dGZSem5BQzN6bFRaRFBwRTJr?=
 =?utf-8?B?enJKNDNhS1lmK2hhVHd5bTlTWldCQXU0Yy8rZGozVENkNHF3b0gvbjBiUTE2?=
 =?utf-8?B?cEF1TWNuL3FwME5GcjVzZFo3b3ZXcFpoZFdkOGw0MzJMeDY0M2NNbmJiakI5?=
 =?utf-8?B?TlV4M0NBZldDaFNZMEE4bGZZazd3eEEyWVhONE1pT0pEcm9PbTdFQ05NQXV2?=
 =?utf-8?B?ellnbFRSamNjWG0wUE9kSXh0M2xhRmN3NnNORi94L3FUNmgycytuZDVubDlH?=
 =?utf-8?B?ck1Wc2pCckJnQ2tPRDU0cjVBUkUxRkhSY0wwRDhGUjM0cXVsRmZLa2NUMGcz?=
 =?utf-8?B?eVlqTkRVWS9DaVROM1hiamp1UERjdHJnakd1L0lGZlU4VC9CQmdFaXA4L3kx?=
 =?utf-8?B?SHJHd1ZMbkEvYTI1bHd4MFc1UzVRcVpZcGRDUFg5RGVsMW1OVlRVVWZTMm1s?=
 =?utf-8?B?MjJIdVRSV3VyNHh5cnhSMitaK3RYUEQvUi9xT2diZWU5MEN0UEhFNW5JRDlB?=
 =?utf-8?B?bVI5YjhNMmxENDNKTHIwOHo3VWNrb2lObjV3Tk51K3VGNElDNlFXSUd6VGJC?=
 =?utf-8?B?eXR2cVhBWHo2allVNzdiTFFCSnhmalk2V203V2hxSnJVbzBnL0lNSW9BcGlK?=
 =?utf-8?B?RmhvM3FEWDRnSTY2TitLT1VSUVR2NnMvVkd5UkUzNVBTbFRxN2k1SHByZmFE?=
 =?utf-8?B?ODhUVWNTbjZRNVg2SnUrR3dNQ0ZCVUhXd1VVM1MvRWxVRDIzZTd1VDZwY3JN?=
 =?utf-8?B?RElva0hMMTZISHI4N3ZCazIzdDEyQ0VZem1uYnlybCtxNHVMRUh6Y3B1K0NZ?=
 =?utf-8?B?ZDR6YSt0TUJmUXFucVpDZzdKV1l1VlpLb2I1MDJvNFRKSlptVSttRUpVbk5y?=
 =?utf-8?B?MlBHVmJGa2NTTUlKNWxLTzdreWtZVk1nTmFHQWMzTEQrRnRBdjhlanZBenhT?=
 =?utf-8?B?WmdvMEFjSCszbkVlVDNZS0FMY1ZBbFo4TC92ZE5GRFhyYjFnWWh1Y3BsR0sx?=
 =?utf-8?B?ODl3dlRObzZPOUhGN3JOZ09zYm5mRE5VeTYveUY2Z0NvNmI2Ui96RXh1dGZr?=
 =?utf-8?B?SmpqZnlLV2oxYlpmZk5DR01PVWpIU2tqMWxhVmxZSkhyazBoQWlBT2xMUTd3?=
 =?utf-8?B?ZUk1eHpJc29VeEU2NVA2VzZ5ZWZibnpvM1JibHJ5R3VPMmI2TENtVHEyN1pt?=
 =?utf-8?B?T0wxbHdDNkJPc3dQK2hNY210MFpaMHFubmF5NFpMNHRJYjRFWmJYOGJTZkky?=
 =?utf-8?B?cDdyOXZXaUJuSFVpMTlYTDlPQTF2RThadlBmY1owMjhlWTlOVXNwME5qTGsv?=
 =?utf-8?B?dVMrY29aT24rSS9GZ1FmQjVJNzJRVHFyTHdhMWdHTTVpK3RzNFNwQWtLRGpD?=
 =?utf-8?B?bGh0ako1SDhrOWtBUjBremg5UXd6Q1pKMVNZazBQN05BUlIzNVdMSGxyT3pv?=
 =?utf-8?B?WmczckUwOEpwVXlhQ3hZaUF4eXZHOGtGWW9NWHROR3VWUHpGamUrMVIzTGZj?=
 =?utf-8?B?eDhLNTZlU3dkU3FxdVhoUEdFV05uNmhxUGZzaHo5czdNdUJaYVJiUjdEYWxr?=
 =?utf-8?B?S3UwdjQwVHMrQ1NnZHNwRmNCbGFPeHpta1MwTkl2R21ycWtveWRUc3JGbFFR?=
 =?utf-8?B?S2ZRQkxDM0ZJKzBjaks3aU1iTnBsSUdxa1RFN2lMZ1F3RXJSZ25XMXZ1bWlR?=
 =?utf-8?B?anFvRHUyQlBiTDJpVlJRaFh5Znd6WW03ZWQ0cElMY3A1YmRpK1VGdUhHUWpD?=
 =?utf-8?B?enRxWHhndTV0Z2pUSmJqWEk0ZGZDOFRJKzJYeHRVUnFQa1d4OVozRGZSVlJU?=
 =?utf-8?B?WnBEODdRZFlzWjEyWS9HOEpLR25VelQvYzdPdmk3eWlPejNzckk2dHAzSi9R?=
 =?utf-8?B?VTNkZjhrZktNYmY4R2VDa3RlLzNOeTcrUjVhTmxnVDF1Y0NycjRpRzhNVHQz?=
 =?utf-8?B?d01zaStHNGlFTHRZaVZjcEdCWFdhT0RxSXIxaFJ1bXFvQ3ZnWWpLUzR2SHE1?=
 =?utf-8?B?a0lrUlROeHY0SERkTll5YWhWR00vdUhMOTQvNXRIY1hzeUFiL1UzbUloMHI5?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TIH2FJ4luJF0sm3A0ZETdzKKU8GLZ9UUE0jYCeayTQHq0IQVXZVM1fyiWQpiOz2LD7ZyeKXvameSQAG9zxse6FkOziBSn4HTP+vkzhjvCvqQ0J5ItHO4Dkh5zCxZYPEICB1sbmjyOi72t477AWU4h3QxO0BL0jiKlfBzTZpVfpaEycV957HFUjQ5KFORWWxk7ASs4jCrvIejLGzNHhsfDX3e1JTd3oEiUjiKX5TFaLlLi1BR02mkRaivYhCF3UGL/l4yCdCsiv9ZJ4zPMfgH5ajx3Q+KZh92g/FF4Hvvh6/xkoIHGZwkRdo5TZWmsQA2FLo2CIgkSdKIDRYsXiyx8T7vrdcSsnC09RBQuUec8pO9Ms9MtWZxi6US9L074M7Yd/pb2IlUOhL79fUQq3r9F7mQZqrTo4Xu/hfqu01H4+riukYibLbz7N09HiHPQlV3UH7fcfO+YwmcJ6t0fK2su7GK3ROV5/i2V6aw98VV0a+nXarqJm8Qa6Ns4HuY7jyA/Uy+Jkue5F6k9tBC5872nTQWL2IAkvyKVZ4pn+ZHblbffH2/r2kK75fHbGj9VFGifTbdO297SGTKeMG1YWeJ23TJcewzuOYhm5sXlMMGhCeRpnYBmpAxIwAvaHlJseFCg/nemyyLOdP3ytez/OZyrdvyShrne80PCLGIqw2yYhgDoYoXJo1ar3jBCyRo+YERqPt6Lpu3Chk0q/nKGWChwmAC0TbCMZJlFucsXUFniQeXLgjd7q39nCdie0H6lgeDrnrrQ0NbFJugQoyIH+vS0nu9zT25aj7faSu7BrTGgG5+yRt7mAAejArF0o67X7Ot
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82998f3-8588-4536-a9a4-08dbba172272
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:21:12.9852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+E4hlnkwoiYKaEyOu+1VR6tVld8rCXXaJoVEX4SarBf+yg2aCJtpmk70jITeGhuCnkxlnRgJiaosSd2okiY2eNTc6k5TZdIbVjjQaXOzX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200170
X-Proofpoint-GUID: f1dxRvZQy2XIdLGrqIDEiXYK0zEhIDPy
X-Proofpoint-ORIG-GUID: f1dxRvZQy2XIdLGrqIDEiXYK0zEhIDPy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 08/09/2023 13:05, Joao Martins wrote:
> Add an option 'x-migration-iommu-pt' to VFIO that allows it to relax
> whether the vIOMMU usage blocks the migration. The current behaviour
> is kept and we block migration in the following conditions:
> 
> * By default if the guest does try to use vIOMMU migration is blocked
> when migration is attempted, just like having the migration blocker in
> the first place [Current behaviour]
> 
> * Migration starts with no vIOMMU mappings, but guest kexec's itself
> with IOMMU on ('iommu=on intel_iommu=on') and ends up using the vIOMMU.
> here we cancel the migration with an error message [Added behaviour]
> 
> This is meant to be used for older VMs (5.10) cases where we can relax
> the usage and that IOMMU is passed for the sole need of interrupt
> remapping while the guest is old enough to not check for DMA translation
> services while probe its IOMMU devices[0]. The option is useful for
> managed VMs where you *steer* some of the guest behaviour and you know
> you won't use it for more than interrupt remapping.
> 
> [0] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> 
> Default is 'disabled' for this option given the second bullet point
> above depends on guest behaviour (thus undeterministic). But let the
> user enable it if it can tolerate migration failures.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> Followup from discussion here:
> https://lore.kernel.org/qemu-devel/d5d30f58-31f0-1103-6956-377de34a790c@redhat.com/
> 
> This is a smaller (and simpler) take than [0], but is likely the only
> option thinking in old guests, or managed guests that only want to use
> vIOMMU for interrupt remapping. The work in [0] has stronger 'migration
> will work' guarantees (of course except for the usual no convergence 
> or network failuresi that are agnostic to vIOMMU), and a bit better in
> limiting what guest can do. But it also depends in slightly recent
> guests. I think both are useful.
> 
> About the patch itself:
> 
> * cancelling migration was done via vfio_migration_set_error() but
> I can always use migrate_cancel() if migration is active, or add
> a migration blocker when it's not active.
> 
Are folks in against/favor the idea presented here before I go and make this
small improvement?

It is the only way I can think of for old guests using vIOMMU (for intremap
case). At the same time, it is still blocking/interrupting migration with vIOMMU
except that it's only really blocked of migration when it actually tries to
setup a mapping. Hence why I was thinking to enable it by default, but
optionally on (as is) is great too. The naming could probably be better, but
couldn't figure a better name

> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/common.c              | 66 +++++++++++++++++++++++++++++++++++
>  hw/vfio/migration.c           |  7 +++-
>  hw/vfio/pci.c                 |  2 ++
>  4 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e9b895459534..95ef386af45f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -140,6 +140,7 @@ typedef struct VFIODevice {
>      bool no_mmap;
>      bool ram_block_discard_allowed;
>      OnOffAuto enable_migration;
> +    bool iommu_passthrough;
>      VFIODeviceOps *ops;
>      unsigned int num_irqs;
>      unsigned int num_regions;
> @@ -227,6 +228,7 @@ extern VFIOGroupList vfio_group_list;
>  bool vfio_mig_active(void);
>  int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>  void vfio_unblock_multiple_devices_migration(void);
> +bool vfio_devices_all_iommu_passthrough(void);
>  bool vfio_viommu_preset(VFIODevice *vbasedev);
>  int64_t vfio_mig_bytes_transferred(void);
>  void vfio_reset_bytes_transferred(void);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 134649226d43..4adf9fec08f1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -433,6 +433,22 @@ void vfio_unblock_multiple_devices_migration(void)
>      multiple_devices_migration_blocker = NULL;
>  }
>  
> +bool vfio_devices_all_iommu_passthrough(void)
> +{
> +    VFIODevice *vbasedev;
> +    VFIOGroup *group;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (!vbasedev->iommu_passthrough) {
> +                return false;
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
>      return vbasedev->group->container->space->as != &address_space_memory;
> @@ -1194,6 +1210,18 @@ static void vfio_listener_region_add(MemoryListener *listener,
>              goto fail;
>          }
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> +
> +        /*
> +         * Any attempts to use make vIOMMU mappings will fail the live migration
> +         */
> +        if (vfio_devices_all_iommu_passthrough()) {
> +            MigrationState *ms = migrate_get_current();
> +
> +            if (migration_is_setup_or_active(ms->state)) {
> +                vfio_set_migration_error(-EOPNOTSUPP);
> +            }
> +        }
> +
>          memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>  
>          return;
> @@ -1628,6 +1656,44 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>      VFIOGroup *group;
>      int ret = 0;
>  
> +    /*
> +     * vIOMMU models traditionally define the maximum address space width, which
> +     * is a superset of the effective IOVA addresses being used e.g.
> +     * intel-iommu defines 39-bit and 48-bit, and similarly AMD hardware.  The
> +     * problem is that these limits are really big, for device dirty trackers
> +     * when the iommu gets passed for the sole usage of interrupt remapping i.e.
> +     * >=256 vCPUs while IOMMU is kept in passthrough mode.
> +     *
> +     * With x-migration-iommu-pt assume that a guest being migrated won't use
> +     * the vIOMMU in a non passthrough manner (throughout migration). In that
> +     * case, try to use the boot memory layout that VFIO DMA maps to minimize
> +     * having to stress high dirty tracking limits, and fail on any new gIOMMU
> +     * mappings which may:
> +     *
> +     * 1) Prevent the migration from starting i.e. gIOMMU mappings done
> +     * migration which would be no different than having the migration blocker.
> +     * So this behaviour is obviously kept.
> +     *
> +     * 2) Cancelling an active migration i.e. new gIOMMU mappings mid migration
> +     * From a Linux guest perspective this means for example the guest kexec's
> +     * with 'iommu=on intel_iommu=on amd_iommu=on' or etc and at boot it will
> +     * establish some vIOMMU mappings.
> +     *
> +     * This option should be specially relevant for old guests (<5.10) which
> +     * don't probe for DMA translation services being off when initializing
> +     * IOMMU devices, thus ending up in crashes when dma-translation=off is
> +     * passed.
> +     *
> +     */
> +    if (vfio_devices_all_iommu_passthrough() &&
> +        !QLIST_EMPTY(&container->giommu_list)) {
> +        ret = EOPNOTSUPP;
> +        error_report("vIOMMU mappings active "
> +                     "cannot start dirty tracking, err %d (%s)",
> +                     -ret, strerror(ret));
> +        return -ret;
> +    }
> +
>      vfio_dirty_tracking_init(container, &ranges);
>      feature = vfio_device_feature_dma_logging_start_create(container,
>                                                             &ranges);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index da43dcd2fe07..21304c8a90bc 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -970,10 +970,15 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          goto out_deinit;
>      }
>  
> -    if (vfio_viommu_preset(vbasedev)) {
> +    if (vfio_viommu_preset(vbasedev) &&
> +        !vfio_devices_all_iommu_passthrough()) {
>          error_setg(&err, "%s: Migration is currently not supported "
>                     "with vIOMMU enabled", vbasedev->name);
>          goto add_blocker;
> +    } else if (vfio_devices_all_iommu_passthrough()) {
> +        warn_report("%s: Migration maybe blocked or cancelled"
> +                    "if vIOMMU is used beyond interrupt remapping",
> +                    vbasedev->name);
>      }
>  
>      trace_vfio_migration_realize(vbasedev->name);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3c37d036e727..5276a49fca12 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3507,6 +3507,8 @@ static Property vfio_pci_dev_properties[] = {
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>      DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                              vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_BOOL("x-migration-iommu-pt", VFIOPCIDevice,
> +                     vbasedev.iommu_passthrough, false),
>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>      DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                       vbasedev.ram_block_discard_allowed, false),

