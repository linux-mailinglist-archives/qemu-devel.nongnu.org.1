Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03FA84E05
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 22:18:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2yLB-0002NQ-4w; Thu, 10 Apr 2025 16:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u2yKp-0002K4-BK; Thu, 10 Apr 2025 16:17:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u2yKm-0003Os-Po; Thu, 10 Apr 2025 16:17:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AJmv1f021239;
 Thu, 10 Apr 2025 20:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=z+PrqAdKoXJiQn4F1DO+YaXY33sNfpMpLEjidVOfoPY=; b=
 Jw5sUJ1bweS9nxMxXiWkn8bfp8CyogfFYlnSBBPGanbYlN5MMMmHwhqtin9GMO8m
 /DikTlwwO9lmP0OJeIpVmpIXJgSlehFfKMgq29iRsvRSPmkdAbtB//P+BPbl+HK8
 zxAC2Zx/69/r4QT+AUH2Adj8PpSzBc8Eh+rCDO+WMr1MScEXbmOd4/o8py6LG6qd
 HhkKMbKAOrhCjJPGhPLOnRcT+2Cj+BPJcl1u2HMBrZwzWRuEil/2D5tnufEGv19X
 JXKxnnnq+FNhKtPcvavXovPrxfbVW23txV+sgNCZMmHjSeSRIsb/U9/33UvThCbD
 p2LNg19n0cUby7M42N69GA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xmf3r2ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 20:16:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53AIjZsZ001330; Thu, 10 Apr 2025 20:16:23 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttycr6yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 20:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI90oceWYj3bLv17YmGNJprookkbOCnkQATkRDak5ZOck1nfhSD/tLKnYpf4vkNa8qNN+nVl1mg4ocuWb9XTptVADAfMGxPHBROCYELWmon5+cf7h6rqfYkeZR1JDqqvZm9lxXp8fn6SKLc2hO0Gl0HhYm68L0SKuLzLvBsw1GQHYhPyrmlJUayf8Ul0tu8dmuSLBjUAmrQry7JuOSgrW4ebu84zfVKpj6O2oes6L/tjGUchJwrV06eBFOLRjwZYEE/+bHWjJebqD7paKv/nKEGhgFyNKLXdSdwMMJsMko3wdi1YJHB+7aWfd3PxkJgkVi/XSpqqjNjxjKyI/3ns8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+PrqAdKoXJiQn4F1DO+YaXY33sNfpMpLEjidVOfoPY=;
 b=aCTlneC5m47Hzy36h+Q3Z8Sbr3Fp4g1JERKK/x9Z1yvjts8/VN4NYPFIzCOeyhLQ9j8zyHcmgh3ItjNAF2gntLN/Ml/nFrshcYBU031shGdiTz+7biDwK4SbRhCGgagCeGM0R7JJl/Y0FxwYorMdSGPXd7SjEKgvl2ExOTuG25OIl9AXZfGL7evWUIaxmeRUW4+Pjo+Pl2QzWMemsXZBcIOHgimoVP8Nx3uoseLiR5CThV6F3NBpFe6HytxTB4kg56/m1P4ArVjeaUo0VNHWYrZcpEAh6W2ZjzkzQICyiiaOft+imDVKq5wIgxdEqw3ejjxr+mA+k4a8HXWLHlkBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+PrqAdKoXJiQn4F1DO+YaXY33sNfpMpLEjidVOfoPY=;
 b=ZbnZOhyUbcrqilQJRIncsDueI4ma1TB9XXOcmvcyVGtcf7BHDlmrXefo1kzlEiXpp7xzOmIqOLTIPSWqBvEl10f9gTa03A7mjXeucgYkD6CWPSKMxOpEvOaSL49QzKRmrSzcZAghODbTCWBdbozXThT0nntEceTnzynSnqBjuuc=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 IA1PR10MB6685.namprd10.prod.outlook.com (2603:10b6:208:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 20:16:20 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 20:16:20 +0000
Message-ID: <9427cf24-cf16-427c-99a0-90f5fb9c09b2@oracle.com>
Date: Thu, 10 Apr 2025 13:16:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] target/i386/kvm: query kvm.enable_pmu parameter
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn, chenhuacai@kernel.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, npiggin@gmail.com, danielhb413@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, thuth@redhat.com,
 flavra@baylibre.com, ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, louisqi@zhaoxin.com, liamni@zhaoxin.com,
 frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-8-dongli.zhang@oracle.com> <Z/dRiyGTxb8JBE8v@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <Z/dRiyGTxb8JBE8v@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|IA1PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 173527ff-9aef-40fe-e343-08dd786c8e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmNoTVNLcS9renRINmEvNzVhR2swMTZwNVVlRllqV3JHaUVJVmtwT0FEQTQ3?=
 =?utf-8?B?NDlRejJmM1BlRWZTZ0lwYzZEazBUSkt2ZkhmK3gzQXJoVlAyNWQwaUJmM3Bu?=
 =?utf-8?B?V2cxNVRWVnE1Vlg4WEh3Sjh5SXk0TDB4WTFVMzZ0enlDMyt4T3FjaGVlT1VQ?=
 =?utf-8?B?M3dQcjdBN2lSZHFuTXpWWTN0T0RGMEl2b2RYdlVtVGJLdm1mRThMMHh3ejFR?=
 =?utf-8?B?ZHlXVE11MnpaYWdNNGY2U0hDcXZMWmFveUlMQUpqNnFUWU4zUnF0dGJYSEUr?=
 =?utf-8?B?bHY5Q1hBT0pMTTl6SW96SU5mQ1dQdEdLT3BQbHFKOW55dkdwM1YrUjF4TGpm?=
 =?utf-8?B?c2w5MWFHRnB4TDdXNUhNNTVHbE1tLyt5b2gwZ2JTZUJkemsvbUxIaGpYdmtD?=
 =?utf-8?B?Wk9QNjZuWmRaN0Z0UStYVWkvU05GbUZvZUc4TmNFdlZaZUgxSkk0MnIxM1h4?=
 =?utf-8?B?cFVMTEhlaHNxeGxTSk5rcEpZWFF6ZmlNOWQyVVlnRk1PTnZwUG1MNi9UNW52?=
 =?utf-8?B?Z1ltNURvVkh6SjlZTFFNdFh2YWpXQmZGbmxWUUdROFU4bHRKQzgxc1dLWEJ4?=
 =?utf-8?B?NmxTa2VwOWlqTXNJYmxhajRXdXZSbk5hd0JPcFVhbUZoRVdOSFRsVkVNKzNM?=
 =?utf-8?B?Tm5ST09CdGIzTmxMZkFiRTYwZTFCb1VzbDliV3hLbno1VGtVeU1FdUo2T3A0?=
 =?utf-8?B?akN1YkRHSUorZ0ovVnBraWNrb2NqSmV1SlYzb3pLRFFGc3ZKdGNHd1ZJRmRF?=
 =?utf-8?B?VVVjMXNCK0ZKa01mRVpLWUpmSVZiSzVjRWN3K0JrYkxtWkhYUWw1cWM3L3Nr?=
 =?utf-8?B?TWtybFJxZzd0T3N4UWVUR0h1eG5oei9LRXpFcjZYRkRzUWRxUVdwMExEekxC?=
 =?utf-8?B?eEdhMlJ4dm1XYW9WTXU2ZmJuaXRVMTFDSzc0YUFLa3JNRXAremlhTWs4YWVL?=
 =?utf-8?B?WU4rYkdjVDhCSGFBVUF0UW1YdEJnSWRGSUV6WXNhc3hxN1N2MnFBTFVVZW9H?=
 =?utf-8?B?YnhGK2xpMjNEeDFwSWJxKytyOVpXeWgrMlF6WDU3Skliajg1V2lyRFJiL2Jq?=
 =?utf-8?B?N1JXRGFjUHl5dmhqZWJJOUdvN1AwaDhHVmhtQU8rSkxnRWhHaDJQT0dXYzJM?=
 =?utf-8?B?U0hCSnFnNXAxb3NmVW5nSS96cWYveEx5RFB6Rk1hTVBvUHA5SWNHOEorUlpM?=
 =?utf-8?B?eHVRN1IrZ1dHc04xQUt1bmpxZWZxNGhNUlhha2hKWnNBMnJ3bGRnZ0NUTUlv?=
 =?utf-8?B?bDZ2VTlXQzRVK0tJb2plS0FiNmM4ZmJIWlhKQkpQT1J3MEZvcXNNTXlWZmt6?=
 =?utf-8?B?c056WmZ4RktRTmF4Yi8yYmQzYUc4UzBzRjBrZExrN1puNkszYm9hL2lCcUM5?=
 =?utf-8?B?c0RFbWNiODdabzV1S1JXaFYwRCtDMnhyUWcvSmRaNTVsTVJ5MUR3R3dkblcw?=
 =?utf-8?B?ZlpnanVMSFkzNW0xS2ZvTkU4VkZwYUdwN3Z1RFo5dWJOYi9lL2JjbFRzM0dJ?=
 =?utf-8?B?aG9qUjZVeURZcmJJNVZrK2RqeTBOVFhobG5NSVZBMm8yMEVQc0tyUml2aHND?=
 =?utf-8?B?VklkRlhPNXVaQ1pZc0dRVEh0TTdKTlMxNjdQVmMzbkZMMlExSWJvQ21XeDIw?=
 =?utf-8?B?c29ManJCZFI3YmhyelY3YVFERmZMM1hCZ2M3azNZL05KZ2hySlBKVEJxcFRW?=
 =?utf-8?B?TlRxOXdMS0RGbkxNQVQxeWpvNXBFZTc1bUlpVSsvVHVSL1FtQW41WnRURHQ4?=
 =?utf-8?B?NllFckdHT1o0QlY4bUR3dEtwWjZYTG1aNTNoZThjWnNPUlhTRDdTNVdoSUtQ?=
 =?utf-8?B?NFUvN2piK0UvZ1Noa3dMUmJtc0NXQ1JwYi9xL2czWGtlYTNTLzREV3F6STFW?=
 =?utf-8?B?cERkV3htbEN3L0ZFRloweGVSbzdBRitpS1hnS0N5b24yZ3lwOTA5WTV0SHhG?=
 =?utf-8?Q?60xh4dObrAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhtSlY1S1dyNEl0QmlQcjhWeVdzS0xpRlZwR3VmdDRkK3F4d1liWWdpREdm?=
 =?utf-8?B?SHNyY3BVRkFYQ1BPK2JmYWdXdzBkWG1Pa3gvYmdtUHlPS1hnQ3VweHpJZ3h6?=
 =?utf-8?B?emlJYlMxMkNPZkNmRVlzSFArVk9LVHZoVW9lTDZFSkx5b01CdlZ6dmtXUGlv?=
 =?utf-8?B?YTRWTDdKSlI5dVBNb1ZUNU9lc2ptc1ZqZjFmbWtrOFFaWUo1NUxRVno3TWdI?=
 =?utf-8?B?b3NjZ2dJM3UvclJUYkJRUk5OUVJQOWJZWThWSG84QmFwV1ZDMDVoZndqSUpB?=
 =?utf-8?B?SnEybzE2SFhyekxjTnhGYkZ5QlVhZXZTNHQyTi9pdE5CekFYRE5IQjZKSEtj?=
 =?utf-8?B?eVMxRGlOcXRaaGVpUlg3Wm1laW5HeThrcm1zQUtadnpUQXh2aVdyWTMyb2ZL?=
 =?utf-8?B?MWpvN01zVkdNMjR3UVNLV2Qwazk3SGZXUHVaNm4xTzBhR2x4L0xtM0VtdmlR?=
 =?utf-8?B?SGZNL2JCZ0xyRFF0RWhJZmdUZ0hITFI4eC9DUXUweFM0NzJlc2FCVm42Ty9F?=
 =?utf-8?B?RWdFaWJJaU5FYjNlL3QwU0pCRlNtbW1kcEJjQmlLdHZxaStuMk9ab3JjRUZq?=
 =?utf-8?B?UFZRNU5wVVJJZDJqdjVJZlNYZ1dMWXhkRlM0d08vcXpDVGZBSjNuVmpwWk9l?=
 =?utf-8?B?b1ZqM0FsN3Boa3ViVFlNZXZ3czd4MkRxMVlTQUJDRWhHT0h6NVpMOGhyZW1s?=
 =?utf-8?B?ck1zTUpMdUwwMkFLd3BwaCtrY0JFYURTS1l0L1FkYW41ZWR0RkU3Tm5xRVNk?=
 =?utf-8?B?dWdEMitQcFdsTEl0RHNIRXJINjIwcVMrK05sZVh6cUNBQm5KcExabkt3K1BL?=
 =?utf-8?B?QjFMbDF5YjBBaitPUnNscDNYYlpVbEdRQWg5SVUwaGZ2cW9aT2hVRnYvUEh1?=
 =?utf-8?B?ZFBKQjI1WVRMRDJ3T3hEcE9SMnI2UjIxZTVNaFJGcTNvQUcrcnl3eFpiNE1n?=
 =?utf-8?B?b25Ya1JWdE1IZ0FQUTYvcnBZa0lHdmVVL0wvV1NUREE5WVJrRFYrc3kwaEpY?=
 =?utf-8?B?VnpwMUNoM0QzaFJScFpXbzhZN0ZVemxoaVhvTFVJK2pRYk4wOS9rb0tUWnA0?=
 =?utf-8?B?aTVCNzdLTGxaODRuOFg0UVJmb0pGM09BYlVDcXV6QUZIM3VubmZOdzRBRUUv?=
 =?utf-8?B?a0YvTnR3eWZ3aVd0b0V5NVVWTUp1dHlOSTJoa0ZWaDVGV0dzT1VMbW5NTzZo?=
 =?utf-8?B?RzAzOXg3L1Y3TUpYdjdBREZKZlJXbElTbU5MUE11RnJDOGdwZEsxcEpBZC8y?=
 =?utf-8?B?M2Q2aHU3MDQ3bkFzY1IrbWhwdE1RdWl4WWw3QlBZT2EyNGIrazAzeUxqTzgx?=
 =?utf-8?B?QWgwTzZqNHZTOGQ2WTQ0cy93MjUzK0hCQXlSV25ldnJRVVZzczVQeHVIQ2Na?=
 =?utf-8?B?eGNQRG4wRkk4akdkWXBabkg5bHZlbkJaZGZ0clZ3a1ZDMkNZaGViTWtDaTYx?=
 =?utf-8?B?VkhyRWppSjJ1VXlRc21RMm9sUHVVN0pvSmthandTSEdqd0Y2U0taY0pBVkpx?=
 =?utf-8?B?NHc3U3BoVzRKVjB0OWh1TFVLLzV5REZJUnpUZ0o2andGWU1SU3IrL05MVUdz?=
 =?utf-8?B?cWEvMzdYV2VzaWlseW5NZzhSOWhNMGFNZzRpdDJxQ0xwbWIxSTBkcS96MVJq?=
 =?utf-8?B?UUhMZkdVckhiS1VYVW1NV2JITmx2dCtoQWhsVEFtYlcyaFFvbVdhSmpBWnNG?=
 =?utf-8?B?NHRYRW5zZWg0dlQ3bWxkZVkwMFhLelVaMHlSVjJmTm14VlJmeklQZ1pFcGFu?=
 =?utf-8?B?Mm9hcWtGVGtzOWVkOHh2UHBoclZUaTU5c1Z5MzNHeTAreDdqUXF2K0hEQUVY?=
 =?utf-8?B?bEdYRFlVSkdRMWZqcGxmSW16MDBWT2gyQ0tYZVJ6MFluNkRlYmQ3elNXcGI0?=
 =?utf-8?B?RVd5TVN3QURuczhtVnN5cGxCWHgrNXdaVmVKVVFZL0RWYlZRaCtMRVNSeWtH?=
 =?utf-8?B?VC9xTGU0T0RNY0VVeVlZdGx6UzhBVWlwYTZoaFhsck9sMWpJeFBsNmJMcUF0?=
 =?utf-8?B?bzBoUXlXeEhPTWVBQ2JRbTJlL1V4ZHhQczJ0Rkd0U0NnUkxVVWFPZk9Lc3NB?=
 =?utf-8?B?U21xWkNzVWFZYnRZQVhvSkVBRU5IWTFzVDFQeVFPYmFjcXcyQVorYTZaelRL?=
 =?utf-8?B?NWViMWhXRndFcEIxbWtIL0EwWmdRc2xJb2V5eWYvMkFkK0x2VnB6R2hBZzZj?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GPrY/JAUjHj5UFnhGR4jk9qlRHRi22exROwW4VsS6vOhB78C4p26VMlTiTG58f+MvmM58EbJiU8U2kj9ggh+VJTx1iqHxdn26t/Y/d8MBnuxGcZ67nu1BKOd6DoZPP45t5fzIoHXNQmIG/x9qca2IqrG5O6EQftZgXPbDNjA3c+PHymWKFI6plecTUG6aN0qhoM4jHT4noUojiaXZuA63wAmaEMwcl6GoLyG92DZ95YuYrOumsIuqSZ4+aBAWljIQH/XEiabRPBuNU7pxgKXbuRyjmqrElXU7miaAZJKsRFbRf1YDoij00P+izGaRt6dg6KQ0287oUWlZleKI6+fcBLpvDzIMUS7pLHHCFNY9xUCgavp1BsHiaInJXTKcrhFhLiFAzgIuqyQC68HRZHFY0Ux1/WaR8xLNjZhv6v9fWmYfTq7FuIAUQ0IYaE2fhX3dfNgsqelpt6rM+JUobKTiFM1L3nRkr9+1pnKR9XzjRFj1soe16/WsS0McF58Vno4XAkhJeXVUO7oOkjjPYhnSNM9mTKeldDHfEOCEiT9l26uJkt/hehSyR650cAhsDVUtQoG+5qW1BjirTBb7fKdQBPYhlsdoAJgBtoLeKpIA0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173527ff-9aef-40fe-e343-08dd786c8e5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:16:19.8899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYjf2LCg9msQF4IYkqzqMVtMFi6UPqmHpxnOs4kaGmKZMj1ciWmzPNpStWcAsn7MpK5Ncc+RRJT8ausXaeVVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100147
X-Proofpoint-ORIG-GUID: CEVgf8MnlrqL8PdkzIslkPiUVvNheA6u
X-Proofpoint-GUID: CEVgf8MnlrqL8PdkzIslkPiUVvNheA6u
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhao,

On 4/9/25 10:05 PM, Zhao Liu wrote:
> Hi Dongli,
> 
> The logic is fine for me :-) And thank you to take my previous
> suggestion. When I revisit here after these few weeks, I have some
> thoughts:
> 
>> +        if (pmu_cap) {
>> +            if ((pmu_cap & KVM_PMU_CAP_DISABLE) &&
>> +                !X86_CPU(cpu)->enable_pmu) {
>> +                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
>> +                                        KVM_PMU_CAP_DISABLE);
>> +                if (ret < 0) {
>> +                    error_setg_errno(errp, -ret,
>> +                                     "Failed to set KVM_PMU_CAP_DISABLE");
>> +                    return ret;
>> +                }
>> +            }
> 
> This case enhances vPMU disablement.
> 
>> +        } else {
>> +            /*
>> +             * KVM_CAP_PMU_CAPABILITY is introduced in Linux v5.18. For old
>> +             * linux, we have to check enable_pmu parameter for vPMU support.
>> +             */
>> +            g_autofree char *kvm_enable_pmu;
>> +
>> +            /*
>> +             * The kvm.enable_pmu's permission is 0444. It does not change until
>> +             * a reload of the KVM module.
>> +             */
>> +            if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
>> +                                    &kvm_enable_pmu, NULL, NULL)) {
>> +                if (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu) {
>> +                    error_setg(errp, "Failed to enable PMU since "
>> +                               "KVM's enable_pmu parameter is disabled");
>> +                    return -EPERM;
>> +                }
> 
> And this case checks if vPMU could enable.
> 
>>              }
>>          }
>>      }
> 
> So I feel it's not good enough to check based on pmu_cap, we can
> re-split it into these two cases: enable_pmu and !enable_pmu. Then we
> can make the code path more clear!
> 
> Just like:
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f68d5a057882..d728fb5eaec6 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2041,44 +2041,42 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      if (first) {
>          first = false;
> 
> -        /*
> -         * Since Linux v5.18, KVM provides a VM-level capability to easily
> -         * disable PMUs; however, QEMU has been providing PMU property per
> -         * CPU since v1.6. In order to accommodate both, have to configure
> -         * the VM-level capability here.
> -         *
> -         * KVM_PMU_CAP_DISABLE doesn't change the PMU
> -         * behavior on Intel platform because current "pmu" property works
> -         * as expected.
> -         */
> -        if (pmu_cap) {
> -            if ((pmu_cap & KVM_PMU_CAP_DISABLE) &&
> -                !X86_CPU(cpu)->enable_pmu) {
> -                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> -                                        KVM_PMU_CAP_DISABLE);
> -                if (ret < 0) {
> -                    error_setg_errno(errp, -ret,
> -                                     "Failed to set KVM_PMU_CAP_DISABLE");
> -                    return ret;
> -                }
> -            }
> -        } else {
> -            /*
> -             * KVM_CAP_PMU_CAPABILITY is introduced in Linux v5.18. For old
> -             * linux, we have to check enable_pmu parameter for vPMU support.
> -             */
> +        if (X86_CPU(cpu)->enable_pmu) {
>              g_autofree char *kvm_enable_pmu;
> 
>              /*
> -             * The kvm.enable_pmu's permission is 0444. It does not change until
> -             * a reload of the KVM module.
> +             * The enable_pmu parameter is introduced since Linux v5.17,
> +             * give a chance to provide more information about vPMU
> +             * enablement.
> +             *
> +             * The kvm.enable_pmu's permission is 0444. It does not change
> +             * until a reload of the KVM module.
>               */
>              if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
>                                      &kvm_enable_pmu, NULL, NULL)) {
> -                if (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu) {
> -                    error_setg(errp, "Failed to enable PMU since "
> +                if (*kvm_enable_pmu == 'N') {
> +                    warn_report("Failed to enable PMU since "
>                                 "KVM's enable_pmu parameter is disabled");
> -                    return -EPERM;
> +                }
> +            }
> +        } else {
> +            /*
> +             * Since Linux v5.18, KVM provides a VM-level capability to easily
> +             * disable PMUs; however, QEMU has been providing PMU property per
> +             * CPU since v1.6. In order to accommodate both, have to configure
> +             * the VM-level capability here.
> +             *
> +             * KVM_PMU_CAP_DISABLE doesn't change the PMU
> +             * behavior on Intel platform because current "pmu" property works
> +             * as expected.
> +             */
> +            if ((pmu_cap & KVM_PMU_CAP_DISABLE)) {
> +                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
> +                                        KVM_PMU_CAP_DISABLE);
> +                if (ret < 0) {
> +                    error_setg_errno(errp, -ret,
> +                                     "Failed to set KVM_PMU_CAP_DISABLE");
> +                    return ret;
>                  }
>              }
>          }
> 


Thank you very much! I will split based on (enable_pmu) and (!enable_pmu)
following your suggestion.

Dongli Zhang


