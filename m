Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE675D7BB
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 01:00:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMz5Q-00054c-3S; Fri, 21 Jul 2023 18:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMz5N-00054F-3o
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 18:58:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMz5K-0008Oa-Ic
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 18:58:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LMP1ql030808; Fri, 21 Jul 2023 22:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a8kmUF86tINxJ516RCe0SMhfylup8+G3QuPuJVxALW0=;
 b=PPUPVynU1lnnFGj51PLh5uNSBQ9X0CeG7SUAh7P/TPpmuXxTJubDZ5VPV8xIPHIAnbdR
 rBUBv3UInxG9vhtNIX6Necyvq8B3stUMfpHnIvMPzOPliPfLbMWowaWLRhhaq6Cw5I90
 mfU/UBuZ6ZrcUebK5Oc4b6wLpVtkRfViZyNyeV4GVHDMO7qmJiA7N27KQGC2n6HAc8oq
 SjT1aAkZmoqX3OhA0hAKpaFQ5pU+nSVm0fY7vDXS0D3pzMLlnXmbfopef8+Uw1sXvDq1
 TvnxsS+IzIwNx32Rm8MSVsI/jNbxOBL46mqjtiPOfVMORI/kWdNVl2PLP+enCbjheeBg 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8acxpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 22:58:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36LLpnSb007789; Fri, 21 Jul 2023 22:58:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhwabnn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 22:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLda929PSbyQGqFZUR8gHt6TMwA1XjOweaY9K0vHoS2BEiDVDLEtlMDXWbhtZ/8OHC2x2vnVQ4MjqLwTorAj8d2qzXw55nfEVlnwwvN0XKeyWQhhF5dj1nKiFh2jhZo2S4Q7U+KfKMRxOyNAYZm/+S95agkj84C2C5al1+mHW6FqlcX65Xt5QssAIV2lizom1XahNfCrHRoo5eyzFztqTYGxHtjblHcSyiP6/clecsoyA2S+uLuLIACC324YBXZUdtFymIIk7Z6Yy9GeI3Qloirlg4lNnN9Js1QFy+PwhgDaJTmB8roiTF0KF7dcTGfiX4kIRtmgYqHX+Rt9xlSQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8kmUF86tINxJ516RCe0SMhfylup8+G3QuPuJVxALW0=;
 b=afF8W5boaDj2VdMFmTR6WObQloPYJzCExkwtLhCZhbtlqLlOgfvuStvFECdznm6yxmdJaT0EUkV6l8SLBcxCQj6HqS3jkcOrVIOe68rA6tCcU+H3TjZr6DRLERaT9h72G51LTRSOHCNSu4vefovQUyB2fE5NezW+f6+QdzLqHzMjxRuEFXkkHXxmLsuVvMAkf3MMIR4LEtQXnL392H31OgEm2+g9YOiQnmCZ2B+CJKJ5QWgcme7R1myBQUCUhC4plg39YKi+L2OATTbnBSQOAADwjHGsyXo4v94MwQZpBHWGCyahO1hdJA/NcPkHB3PT1zIaDZBA6Q3CUKf7iWfCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8kmUF86tINxJ516RCe0SMhfylup8+G3QuPuJVxALW0=;
 b=ydOjQ/UcLaRCd/HbiUc65TClpkMUsQpY6ZZAj6rBo5LNqa7H/zOpk1zT8mcSLrF2/t7qWRtbjrsWh8wsVotOZSHHCylOOoxBrRXYzyojppN2MM9xX3Tj35PmXVi0gfvrxVGJPwOqUMJXXbnQ0V9SV2FLRGMCFzaC+0hLJdGuwAw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 22:58:48 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 22:58:48 +0000
Message-ID: <95fda9f7-285b-4ff2-f1fa-03f5bc804429@oracle.com>
Date: Fri, 21 Jul 2023 15:58:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 11/12] vdpa: use SVQ to stall dataplane while NIC
 state is being restored
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-12-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230720181459.607008-12-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 499db36d-5f6d-42fa-1e4b-08db8a3e0b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gs8Rd431mmHBkY657p8GlckLDZ1K5LWeXDh6tAtyzqunJMe2l3zdvuBLUy/pHzelGBWQOBHLXCnNvvAJEz27f4Fwogf0qQOpyZMkTFKOJ7jzOy7EgesWGvAku4QSSGTJWJSuf5fkWaZreLyCCPZMK+oBK0P3CumSEMzRs3U9EpMLXO9iIp4Sa64XU5KC8Zw6XjyNnD7r3/CTFYxpQpIbsglHUZ6hNvz7HPMT/4orjpfGMsomhREqhwUU7aVrnbJRPDpKrPXZ0yVtt7llcettUzVt4WWL39fy0kFrjszY0wuNAAjxoc9sYGeIfE2nGcPVY74h+cXoceQmb5/JecGWxmzzwE3ZqDiQaPu0ZlCiv8qygZ9zYU7GQR07VIhtgVVEZ46hFApANoBnqtzUVzod+iW5hjIbuDaQPQWDPh/0yIC4TOOySPl8B+ctNxhkONE0rpSCn72UI0Lq7K+S8M2F/S3H9a25eB3IEcalrtDofftVcXA+rjYs6WKefuTq4JVY0m+7S5Ohcbh8Hly+j1Q6KoDf5/gFjc0qqBxwdHt8P+ysiPxDO+Rp+sEvwtGtQN1ZysSXkECzDDd8uGgAmH/4ybvPyLaSfzV7HepX3nQM3arpxSlvGYMvQhZBBCxs0ICUyOpCW5yLUDn1JaFSXi2VQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(86362001)(6512007)(966005)(6486002)(38100700002)(36916002)(31696002)(2906002)(2616005)(31686004)(83380400001)(66574015)(26005)(66899021)(53546011)(6506007)(186003)(478600001)(8936002)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(36756003)(316002)(4326008)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9WK2s2VTFVeVlhR29Vd2NVQzFYeGIwRkZEQW84WXdXWmZKWHdMTG4xZHVm?=
 =?utf-8?B?RlBUdmdTMmZRb3JOaFhZc2wyY3R0V08zRXd5VXZWSUw0cDJURFhHT2Q2NkNY?=
 =?utf-8?B?MnQxbmF0UzJMekNXbGtMeHdQZWYzZStFUHh6d1R3SzBPSWkxMXNDcnZ4VmVY?=
 =?utf-8?B?SEc1UXhhRTVzZjNrK3JxR3h5c25NOEJxZFpydFMrUXhvQ1k0TllOT0Q0YUlI?=
 =?utf-8?B?cjdzc0o0VUcxUUU4UEw5NHFTQUM0a1BLUVE5Z2JXeTNkdUVYRXpvdjRldE85?=
 =?utf-8?B?eVVqK3o0R25YbmdMeG84WS84cWpGVjVZdUlyV2tuTjk1WWRIVkJFYlk3cEl2?=
 =?utf-8?B?ZUJUOGllWElya0crdzRudVA3S2pOc2lsT3oyamxJR1ZiNXVQVUZObjdVNjJ0?=
 =?utf-8?B?SXlPM2d1WVRQQ3g2Y1BhOUFyOGl4d1ExTU94NWVFWVBrSVZtbzhwd0tEb05k?=
 =?utf-8?B?aHorQ055QUcxWUF0MG5EejJialpwcUUrL05PaS84LytSYmovU2ZSSzZJa0ls?=
 =?utf-8?B?cndTUkhCZHhvOVF0WXlXb01RVmtleFB2ZFZtU0gwK1lKUDJva1kzcjVHWnVN?=
 =?utf-8?B?Y1NUYTFqd2EvQTZGNmo1NXRjckVFV0JkbUdSOTVOQmY5Qm5tQlh4MUhRb2Rj?=
 =?utf-8?B?NHF3ZGFhWXdObTZ1WnA5K1l4cTNBL0ova3poMk5YbW5oZVZtYnlQQ050SzZj?=
 =?utf-8?B?NEJHd1pPMVphaUtJcHFoQmNlZk5jNGkrSUtiVlB0VDRaUkgyM0psZ0MrcFRy?=
 =?utf-8?B?M09vUUhWUUF3cmRFUUhoMXF1WURqczhzVUtmTi9MbXdGNHBiZC9hTEVieU5J?=
 =?utf-8?B?VlNrWjlaVkROVWhmN21VSU5zTlNnWFBDRUFhM3J5QWlWY2JmTjBDUG1IWGQ3?=
 =?utf-8?B?YVIrT2hrem02d3F1VVlBQUlMVGg1RlVRVGFBc3VrTUozOG10YnUwcWF1L2Q2?=
 =?utf-8?B?Z0VDK3VUaHZKbE5zOGh2VDU5RGNtYUtjY2RhUFpPUTJQdS9yR2hqblRkQUNw?=
 =?utf-8?B?c21ueEp5RXgwV0NYZ2tqd1FOU05LYm5LTFdrWmhYT2krOFdvVGt6eFpweVdS?=
 =?utf-8?B?N2dWMmtJSHFvZEFnNmpoY3JKL01rTEVQWmRlbGRkMzBSZnpYRGI3YVZ3Yjhh?=
 =?utf-8?B?Ri9ZWmlwUng1dVVvOStOVjlaeklNclNpSTFEZ2ZiM04wb2tkdmJBZ3oxMWRN?=
 =?utf-8?B?VWEzZmx5ODE0YnE1bUJ1dGg5dk9OQzVORnd3TXhvckhWeWttUms1VHU5bTZZ?=
 =?utf-8?B?SXNBajV1MzBUek4yUk8zYlhST0h2STNXQWNTRzRsYVl5YmFUUENtdnJGSXh0?=
 =?utf-8?B?WmNoTXBickZVUCtvL21LUnVBSmtrWmU2MktLVjNpOHlMOVdXdnRDU0NyQy9X?=
 =?utf-8?B?K3NmZHdBRW92Q09sUllySzVpTDVnQUlOOXJxVENMMEZOaUFHM0t5bHcvd3o1?=
 =?utf-8?B?cVdzbGsxSzFWZ0huNmNNS2p0OWVoQ0JiZ2grV2M0RVdoaHFUbUx6c3lKNjQx?=
 =?utf-8?B?aEVHdHp3UVlBUkkrYi9UV0RUQnhUa243L1hXSGVqd0lmbzRVWDB2UG1iVmxR?=
 =?utf-8?B?R0JZWmpLNnBIZ0VkczFsR1FqY05aZWsrSktmd1BYRG5PN2JWVXYxWjhOM0Fj?=
 =?utf-8?B?TFZnZ05RbE1sOFBROGJDUmFWeTJNSzNFTDQ1QnF4c0x6ZUpqd2c3bmY1Y3or?=
 =?utf-8?B?aCtaRGh3NjYydWJQbUJ3TGppT2oxN1dWNlp1QURVMVRFN2NXYUh2d094VTRJ?=
 =?utf-8?B?K0RVTGIrSTlHY2YzeXMrZ3RzR2FDNkdmN2hGM2JzRmhWK08xRlJmQVZNNlZR?=
 =?utf-8?B?dS9YMDc5MEtkWUMwM0ZVNlI4emF2dXMrVVBqdnU5TFk5QmZuY0tFc2FVRWxm?=
 =?utf-8?B?MlM1c1Z5Ui9XRXNjSFFIMWMxb3ZXMnQ3NDg5VFRCRjU2QzhWZGRWcUE4SVlH?=
 =?utf-8?B?MzNvaVZGZ09sS01aWitpU293QTVHb1gyYkZQOStBMUdmWEt2R3VPcXB2dzBr?=
 =?utf-8?B?a2c3QTFBZU8rWllWb210SXNRTnUzeWRuZEk2OE1LSTR2MDJ2cHBaNENMV1I5?=
 =?utf-8?B?YmhYVXNaOTlpUWluZkhEeXBuVWpxS29wSnhQeFUzUXdkNE02azdUN2lPRkg4?=
 =?utf-8?Q?P+dWw0mCG/Rf8qqS0TP+x881M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +R6hkzJwKt1ep9CdmvljBLDy/B7PpY4pYjcCG4Ycq7pA1igqbLtqsV9+t0o7Vny7T3cDk85+WqS8eOJPPwUbfRLOpQ8RGhBgvsdmXkf+sYM/i+exVxRfT3INQPu7WeSvmj80nxNQe9h029krbvXrOI26W5m6ENPUFZKRGceIjobkzJvfom4dhJ5Rn2jXzd6to3ddOtpHz4ryoWJHDm7aBY7ATYk9qppsY1aegSWppmiQYgWwooVucKggGPdeUPxLJoyG/R5HlJEySAh21RMpg19FaDGLxvNrJzNqRXtfzbnIFyzonL0o4inhM558Oo+/7haQwkng2FjxNzNs6RU3kDDHFpLhCOfZapvUdLz2JP0tybcOoQ/g8/8sG8LojpwcZe8J0g6Z5AIOUlk1CvEvvDlCERzLqfEcI2ZVEHYc+HaU+dXQHAg4sSRAO517VYca5PJJINVEaOMx78ILXQOT1j9oZ2YSDS/6vsH2uhTb3HeXAr2+I1aofwrVGUUu7cYB2l0/G6sYgciGM8VmPPe2HnvJAZg23mlpOk8HjB3ffe2WPdCVTkJryvDcWiNVv7xRcl8u8tKwe7qVgoIk/K9yxMhooJEiqsE5GNfW0OhTGOcLbH4KSo8FUkVGPYNJVJaRWjnHarUA6NMTdek4DCpKFi0JZoaTsnb6+CcnhabCjv2nlv+c/aFHdQUojZGnrrrvzzXwSOC78oOhdHzrieARvuMr+it9Atr64R8llZkoX0xlEyASUYzRyKjcusN0AzsIfjmTAXq+rxkHHl0CkEIH7dGgVfEhUXVI/ubQ/wtJrmkKaHaRXZVDELcJbhnnWCES07DjihL7vdiaGLj17CLGXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499db36d-5f6d-42fa-1e4b-08db8a3e0b09
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 22:58:48.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9bFh6wG7+60O636hCCAY3xAFDsdS4QBirxapUH91PKxRcjUkcKnAfVT/ETgc6zCSJ+HpiFZWUW7pXmiGU8MRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210204
X-Proofpoint-GUID: -bVSJrrAIE7igZx5D0xXElDozqokpNkm
X-Proofpoint-ORIG-GUID: -bVSJrrAIE7igZx5D0xXElDozqokpNkm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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



On 7/20/2023 11:14 AM, Eugenio Pérez wrote:
> Some dynamic state of a virtio-net vDPA devices is restored from CVQ in
> the event of a live migration.  However, dataplane needs to be disabled
> so the NIC does not receive buffers in the invalid ring.
>
> As a default method to achieve it, let's offer a shadow vring with 0
> avail idx.  As a fallback method, we will enable dataplane vqs later, as
> proposed previously.
Let's not jump to conclusion too early what will be the default v.s. 
fallback [1] - as this is on a latency sensitive path, I'm not fully 
convinced ring reset could perform better than or equally same as the 
deferred dataplane enablement approach on hardware. At this stage I 
think ring_reset has no adoption on vendors device, while it's 
definitely easier with lower hardware overhead for vendor to implement 
deferred dataplane enabling. If at some point vendor's device has to 
support RING_RESET for other use cases (MTU change propagation for ex., 
a prerequisite for GRO HW) than live migration, defaulting to RING_RESET 
on this SVQ path has no real benefit but adds complications needlessly 
to vendor's device.

[1] 
https://lore.kernel.org/virtualization/bf2164a9-1dfd-14d9-be2a-8bb7620a0619@oracle.com/T/#m15caca6fbb00ca9c00e2b33391297a2d8282ff89

Thanks,
-Siwei

>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 49 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index af83de92f8..e14ae48f23 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -338,10 +338,25 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
>   {
>       VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
>       struct vhost_vdpa *v = &s->vhost_vdpa;
> +    bool has_cvq = v->dev->vq_index_end % 2;
>   
>       assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>   
> -    if (s->always_svq ||
> +    if (has_cvq && (v->dev->features & VIRTIO_F_RING_RESET)) {
> +        /*
> +         * Offer a fake vring to the device while the state is restored
> +         * through CVQ.  That way, the guest will not see packets in unexpected
> +         * queues.
> +         *
> +         * This will be undone after loading all state through CVQ, at
> +         * vhost_vdpa_net_load.
> +         *
> +         * TODO: Future optimizations may skip some SVQ setup and teardown,
> +         * like set the right kick and call fd or doorbell maps directly, and
> +         * the iova tree.
> +         */
> +        v->shadow_vqs_enabled = true;
> +    } else if (s->always_svq ||
>           migration_is_setup_or_active(migrate_get_current()->state)) {
>           v->shadow_vqs_enabled = true;
>           v->shadow_data = true;
> @@ -738,10 +753,34 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>           return r;
>       }
>   
> -    for (int i = 0; i < v->dev->vq_index; ++i) {
> -        r = vhost_vdpa_set_vring_ready(v, i);
> -        if (unlikely(r)) {
> -            return r;
> +    if (v->dev->features & VIRTIO_F_RING_RESET && !s->always_svq &&
> +        !migration_is_setup_or_active(migrate_get_current()->state)) {
> +        NICState *nic = qemu_get_nic(s->nc.peer);
> +        int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
> +
> +        for (int i = 0; i < queue_pairs; ++i) {
> +            NetClientState *ncs = qemu_get_peer(nic->ncs, i);
> +            VhostVDPAState *s_i = DO_UPCAST(VhostVDPAState, nc, ncs);
> +
> +            for (int j = 0; j < 2; ++j) {
> +                vhost_net_virtqueue_reset(v->dev->vdev, ncs->peer, j);
> +            }
> +
> +            s_i->vhost_vdpa.shadow_vqs_enabled = false;
> +
> +            for (int j = 0; j < 2; ++j) {
> +                r = vhost_net_virtqueue_restart(v->dev->vdev, ncs->peer, j);
> +                if (unlikely(r < 0)) {
> +                    return r;
> +                }
> +            }
> +        }
> +    } else {
> +        for (int i = 0; i < v->dev->vq_index; ++i) {
> +            r = vhost_vdpa_set_vring_ready(v, i);
> +            if (unlikely(r)) {
> +                return r;
> +            }
>           }
>       }
>   


