Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E3A1FF8F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 22:18:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWUH-0007Nx-Vc; Mon, 27 Jan 2025 16:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tcWTb-00071E-Ib; Mon, 27 Jan 2025 16:17:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tcWTY-0001Yy-O2; Mon, 27 Jan 2025 16:16:58 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RKqNSt023093;
 Mon, 27 Jan 2025 21:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7+PAGKP8ToVY7F+Jjx5h2ZdbL2v6GSkBZd4mok0tWg4=; b=
 gUJqWvE9mq08koo9nOtvnBS/AEhD0h5Vt64xpqw/CYLo4+woa2dBAOVQ7A2r4x3d
 gxVbdyyXOjyIBcnKyAS/UqHNpjNKWVbJl0oyOR3414kgDU00d0CYhfVNNmtE40Bv
 PcEWChe/cPbHCEcNIjwPOWA17rSWFWDmlLhhNZS6+zKrM25Mv8lbNdepi3+pm7vg
 ZqqHxNE1OGipheqGh/6xm552uJJhBxu3bDTAjN1NAjgVsQiphqcnZa6giNYHZ0Db
 nzTs1JUMRJIhhRAfoXtuKr7D1O+8pr+HNkeS+l2YDXk4qvsIDzUEG29bAV1UVhOS
 X5k3MGCCchHa1NFlv/7gxg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ehj601cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 21:16:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50RKwSeW036385; Mon, 27 Jan 2025 21:16:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd7gf0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 21:16:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLekuZKKn4YOKx0QzDlw5Zx/x54Sdo5N1BnH/cUoB0G83lowkUZawDjF3tN6s63vrT+v1bTXgf8BooDkm999Jh+e/KdG/f3HT7oz03ry+Jm4otE1erjyTcXgAURmCWkJrysw3bRTDxsMV5KlRFWkCyBej0Dyf4RwMdHyLMziT+9wMiwGgfjf2eCZ8PPIsrbmn1UWQU1r0RdIxF4EvWpB+JIiu2PvTtRXaLqj2fmENPkQprOELQ5fursKy+20uekn5pAZ8SjtJjMtfD+4b/uzq0vutvW+FfbTkioTiI2/lB5XMZRNgocpSiCB8rSdqsr/MH9k8Ei1mG47tkj/BjojAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+PAGKP8ToVY7F+Jjx5h2ZdbL2v6GSkBZd4mok0tWg4=;
 b=Gzh/pY9NVUENWVzKpWOk/547CFQxwU5nVFh0pOa4PPY+V83TPA4P4QAUq/su0HBNLTAuo+XYvur+/5mtE8aLxCNi5KdPK17aQhrxpgSdpzLCCQAVSchOCFbM6jb7uZnxY4kTBWWADsSPBdTD8pjoSOxg8zStcxDxwZozy7/Y5HO2Vic0cOlh3MmWb+ATcQ3CDIygCsO8eLiWh6WYdIEzclz5x438JIe6yuuzJe7Pf+7xy3i+nIBxKMh0xGTegr06NB6anvs8LIvkDbSy7wtUQuP36h9IgrUzq8iEZRRRLRsCdPb4tNrwuk9Z2uHZgHWtNSFFw0HJU73CG0ag+VKyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+PAGKP8ToVY7F+Jjx5h2ZdbL2v6GSkBZd4mok0tWg4=;
 b=twqBAy3Mu59jTIjt7rX9K+WFmZtOODVV4vBVVsm6iCBuodDsnNW9Vu/9br1U8ytYvtpB+keeLboWZLZHRmzAXILABlxmc1Dw9Nmfc9PSNVdMmlXK8QFzKjnOCw0y6jknImlziFhEjn0r1Cnhb2VX5d3kQoTMnUqhCO68zEqfbEw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 21:16:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 21:16:28 +0000
Message-ID: <df085742-3a10-4a84-8828-15a4d3f97405@oracle.com>
Date: Mon, 27 Jan 2025 22:16:25 +0100
User-Agent: Mozilla Thunderbird
From: William Roche <william.roche@oracle.com>
Subject: Re: [PATCH v5 3/6] accel/kvm: Report the loss of a large memory page
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
 <20250110211405.2284121-4-william.roche@oracle.com>
 <39b26b64-deaa-4c52-8656-b334e992c28c@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <39b26b64-deaa-4c52-8656-b334e992c28c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf85916-ef3b-423d-8660-08dd3f17dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVoyVGZqaVh3MERDSkh0Q3NQU1lTUURyR3pVLzhFd09vdGRsM2FmZHJNWmJW?=
 =?utf-8?B?ZkZwbC9Xb0JWR0xobndjWEVXaDR0Y1ZhZ3BveWJKb1h6V3F4VHAzcy94MEFx?=
 =?utf-8?B?SGNaUjc4Nko4VlRjZWFNVTN3cnFWZ2VFRHg2Rnh3WEZOYmNKblpiODMvTXpB?=
 =?utf-8?B?RkM0L290ZTd0eUpReXgzV2RXSmkrUnFlV0kyb2lUYXk0MzJzQnI2dlVSVVJp?=
 =?utf-8?B?dU9OcHlMTDI5L2ZIR3NaYlkxLzFlUFgrQjVmQU96emM2emJ3MUxkMUJlMGxY?=
 =?utf-8?B?UmNSVmx2QTV6aitubFFWa2FjM0R6ak5QOG8vRmk2elNEdlE4QytUNFdBVTZk?=
 =?utf-8?B?M2RlUjFlMXJUQThrbGpxeTNtdlAydFZOdVJnU2VOUFN2dDBoMk9RMVErMUlu?=
 =?utf-8?B?MmFXdVcvdVh5THlrSzNoRnBWa1pZdFREMjZkYXNzcXcybjhZQWNmTzRSVWov?=
 =?utf-8?B?cldsU1Fzc0JnVVg1SDVHclNMMFF2ZXpOM1dDdmhEb0lnaW5RdzA3blBpcDhP?=
 =?utf-8?B?MzNKdDlwYlU4cmlmbjZOMnBtR2l4aDRSSEdNbm1icUk3MmQ2M1hwUjVYWUdV?=
 =?utf-8?B?TmUxYmxKaEFIV2ltWlJQNmZGNnd1eUJUTmw0ZnBkekdTS1hnOW9oOHZjbTRu?=
 =?utf-8?B?NldmQUFNUVBKNHB3RUI1c0tjeDY5VVk4SEVBc3JXdld1djdaTVBrVnAycitF?=
 =?utf-8?B?S0ZHOFpBaXVjQUJHN1NhQTZuSXplbU1IZTJ0TlRzVGt3KzVETmpNL3BQQ1pi?=
 =?utf-8?B?Q0lWc2dGQzlISTM3WXhaUnFObDNwOCt1UDMrbFlXUTRQeVpUdFVsR2dkQWNx?=
 =?utf-8?B?eUlPb3RBdTdxSUV4NkxMbEw1THdNTDQyTm5PK1k0aVFqN0NwZXVUOXZkTVpo?=
 =?utf-8?B?cXFleE1lWFRUY3RzT3BCMUNrSmNqU2p1OVpTV1lhOTVCampPYVppUlVpL01B?=
 =?utf-8?B?QWxZR0loU3pVK0FTeUNGYkdKZERpTkN0dFUrVmFCUzNUaExqZTBjdVdndnFj?=
 =?utf-8?B?Sk9zZTgrc1hWc2tTUnZCRTV0RHVEdnJPdzZzUjhNTnZ6TGFxcy9DRG9zSElq?=
 =?utf-8?B?dzNEV25wVXgvdEdRSnZRblBielZHVkFSLzJ4aXl2NVRtclkxZGd0cERNZ1pu?=
 =?utf-8?B?Q2JwYXdNaDU3dUk4eWw4VlFtc1dWM0E0VjdpdFdrKzV5dWVWNDZzZnFqMjhh?=
 =?utf-8?B?NWRlNmZHcVZUcVNhK0w1akkzbEtNaEVhWExydHZEQTdCOFZyOEFPd2QvSC8v?=
 =?utf-8?B?T2JiUHcwMWNuY0phcEx3anc4RmFodk96Qlh2M1lsekxRYnpLenk0SER3Z2Zx?=
 =?utf-8?B?aEVTbXlGZGRiMGNsdFV2ZHBGamc4NnNjZGpzRFdSaDgxY2FpYjByVkE5KzdS?=
 =?utf-8?B?bFBveEZqZnVFQkxwUkZsMUdndFgrUEZ4TkJKbDhZQXRMS1AyYzU5QWJublZr?=
 =?utf-8?B?QmkwdC9ERktyYml0NjdaQnVabUdZRFhEdjNvRHgyMktnRjFZb0JtaVZ2YjBz?=
 =?utf-8?B?b2dyWkUwbHJiNnphT3VBcFdrbzQyZjhnQU5ZWU5kdGdXQlVSazIyTlUvc3lY?=
 =?utf-8?B?K2Q2T1RZSEpIZTFmQmpXTThRUDhBQ0pybytCeUxuSHBMVEV2aXNqOHErVnNh?=
 =?utf-8?B?V0RCR1FPNWxwOGM5aHozYVdPeEc3N0t6YllSWVp2cTZOOTB0dlEwSnB0Zkk1?=
 =?utf-8?B?VkxXQmxLYk1zdkJWQ211SWNQR0hFVEFFS0JLZFhDMStpcU9BSlRSVWRlZFo3?=
 =?utf-8?B?YjJSK1drSXpOT21hekFJbFhjZ1BQSzhpMEhyRW1aeUl2VmNHYTN3bzhyK3FS?=
 =?utf-8?B?azlWM090NnFJSFB3NHNXK1c0UWRsbTZJZmdGV1NXdXI0cmRDSmRJLy9za0Jt?=
 =?utf-8?Q?g8OL6F8Re7x2w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzF2c2kzMHVQNFYyWWQrVitUb2l3d1lVS05uQW1EVzgvNkVjU25zZW5IY0Jx?=
 =?utf-8?B?T0Qya2gveXlKb2lZRVd2ZWw2OEdudkZQWjVWVEF1UHRPaXBraVU0S2xHYmFD?=
 =?utf-8?B?VHM4UE5YNVA0VTVocEIyYVZZL3pja3IwM1l5ZHdvNE9lckE2Vk9Ja2tpWVB1?=
 =?utf-8?B?MEljTUZYbzlXNGdITEQ2L3dSRW5FTlBieTE5ZUZndEJyRisxaTlZTko5cWtJ?=
 =?utf-8?B?cVRkYWZTWHdGY01vMHdjdmJ0d055SXQ4SmxzcDRmNHpNaHllc2g3eUJmUkha?=
 =?utf-8?B?OExLRnNWekljR01xdVM4aDl4WDlDcUc1RWNEVlNmYmlRZFA5aWx2ZUN3cXhi?=
 =?utf-8?B?dldhQlZVa29qZnVkTk9jK3oxK2RqalBJZXR3RDlFMmw1OUpCODg4WlAxUlVM?=
 =?utf-8?B?bVlyT1ZpclRnNkErRy9NSk4xVGRnUERHRFE1c2EwMnBBMTRlNDhNNVJabTdh?=
 =?utf-8?B?WmpWYTlYd3hVaUtEL0RpWjFramRTTnh1NFp1RlZkQXA2WDVpUTlDMmlJV3Q4?=
 =?utf-8?B?c01QY3BuZDlIeHRHa25Pb21obnpRdWNuSE5EK3hWeThMRDExQ2RNTjVpT0M2?=
 =?utf-8?B?WHd0WU80NzRjMHNTVkRwdkg0LzJhK2xqOG0zaGgzVGFXUVR4Q1M4YUxQcml4?=
 =?utf-8?B?YUFEUUhVcUZFNHlVZi9DSU5DbUFTT1J6UHhHMVBrV0JFeng1dUxjcXp3Y2cr?=
 =?utf-8?B?LzNjSHFHTFpZUThUMTNxbU5ScnNoRmNoM003V1FxeXFlVGZYRTlyNmFoaUhE?=
 =?utf-8?B?VFpDbkh1ekl2NXFXenk0VWRIdHJJODBwWFdmRHM0SERQcG9mdkpCQy81K0M1?=
 =?utf-8?B?SVg0MzBwL3JNVFJjZDBoSkxHbG10clUwODlBQWFJdk81Z2tBZG1lL1I3UGIw?=
 =?utf-8?B?cjZpZmlOQnNjZElUWW5NcTYxV2dTNjVRaUN0bnJXZzNwL3pOalVRdlJ5OTV1?=
 =?utf-8?B?MWtYL29MbUJiSldBSTFiOFpuVFMweXMyRWpUR0swdDJmNzVPMTVQMGxhbm9D?=
 =?utf-8?B?R05XcUFId1RWWFJpSXltWHFvcFlRTFk4NlA1N2ZxNVdkb0grRW83MS82cTNJ?=
 =?utf-8?B?S2w2RFFnUEhTTldQcTNwV0x1TkR1Tkk2RlpnbkhnZkxYUHN1TUJQVDJNbjQv?=
 =?utf-8?B?NFVJKy9BVXNNNlZFUFpubkpCN1FBakQyK0I3Q1BPSkRzYXZGdWRERmYyZjB5?=
 =?utf-8?B?L0lNSXNLTnpBK0EvM2wzRndxNFFabTlQWENJSWpQc29qRGJpUHNEWlBEcjVC?=
 =?utf-8?B?OVg5bHYyeUptNGRuZ1gweGNGUEZwcDlEbWtKTEVLams4T1RHZWNMdG5Mb1VY?=
 =?utf-8?B?aXRDS1J4SVNNS2VlNUI5UlB0aFo4aGtlWGtWWHJaL2QrMjg1ajNZWk1wTkdq?=
 =?utf-8?B?cGZiaHZzUmVKQUEvV05SZE1MZ3dLekkrUkh6QTdubWtBbDR0K3RnNDNlVUhh?=
 =?utf-8?B?M3FIMFBsS0t3VDdjellIYVBmYzN6TGh6dVFMcU44K0ZCdTB3bDd0VVhWUHpt?=
 =?utf-8?B?UmpJdzhFWWNoTC9rMHJPRnZsUVNZZzN2MFAzbkl0RHBVbGh6cnR3ZDl0anJv?=
 =?utf-8?B?dGR6K29QTHVZZkZpcVMyY2dWc0JDWXl1S210TVdscHBCTXZ2aWM1VGZmUXlt?=
 =?utf-8?B?a2FLaFliTXRWWXgzbEEzOWV6ek93MVRrcHk0QkhMM1RuN2w5OFo2bU1nZFlP?=
 =?utf-8?B?ZGxWRGZWQlNQUm5DZ2w3NGg1Tk44MW1Famx3OUpWazRtbzFicUVxZUpuWXNJ?=
 =?utf-8?B?UG40NGN6ejF2Um5nT1NIdVE1clJ0aG15alJFWDZZRmxJbmV0b2RnaVhZLzFZ?=
 =?utf-8?B?TXdVNkZFbkRwemtBZTd0WnJxL0ZWNXhNSElqdkthM2NIb0t3V2lZbmpIR3pI?=
 =?utf-8?B?SkY1YTZnNkIwQ1RJaXUyMjFjV2Q4TWVjcXlxdmV6clV5d0RJNlNvZjBpTVBF?=
 =?utf-8?B?VkFiWFlPRi96OCs0QkJaa3ZvdTFUdHExeVFXM1Y5cXJSTkltN2F1TXoxUjlY?=
 =?utf-8?B?Qmt4cGxndzZzdlgzYmh0U1VyUVgwQWNPdGkzV1pNWkRLNjhpUjcvaldrWFRy?=
 =?utf-8?B?d3dyUnRZalE5ZFpXZWg1amNQd3dpNWhBTUYwNkVUUmt0YXlKUmdLbFFqbERu?=
 =?utf-8?B?S0JKNkJhVzJzNlF1MTlveHZwa2FWR1VqK2hrUVJkN0hwTXRXNWpJVFRGaTNk?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZkP+M4bMwoinh6Ce24P99vWpW3IFvp9ZC+EqMV14rrFVYWbqRqTkRCdxICqRszoYlRvcwgWBv3K2uBicvb7ENZwQ00S9w6wMwJBpDXcbQp32CsqY15mikfsHdDRy6XsBjQlWj+MEhYSS6irVV3fBWiZ8uQwRJA9qwrcG6NpA5H6OW3pRHykSy0UJKkTHEwvSSo6NZlcLkddMpsmgqzuByimyyz6xxZhiEpjIDW0U7Sk1YRWkSZG+mOU88AoyFve6GMXZkHDvgFerZwFwDXyk3EnfyJ9l3ThkSDVmHWeVPRQadcqrex+To6r0w401R9efoBOwKDdTtDwvZqAlv3pukGohyZgIfyo2zbk04kVPZEJSO4tTI8pIYm7GyosvL+E+EyUPHr1NwUzGgEF5OSe2SWYEXAI8f90cl3UorRL8Khs2GBRQqcdRWGS3nCMDizD8D7F7IcqqNUnv9H9DjIgqzYRbQaxs/k9xUyXc2/jSqQic4LyRBtXJX+ahDX2E8+fuQWBqnSkUq9O9LSVo5IZGuitL82qkPhCnIOylQmplR09ihMuH8HpfuSzhQOXRPro3rmY18KTCBjsUATN8ZMP8sPV69zZ00AUyyx4xvfw3aQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf85916-ef3b-423d-8660-08dd3f17dcfc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 21:16:28.3185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2voFkqa8KY0A+os1sDfjFbGxpJ0H9MzY3XmrB6I6789iRsQTERhU56e3gcGBnXXixKYPlvWD7w6CTbVz9tGcNcT9k7WPkUBESKI7d9ezEks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_10,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270167
X-Proofpoint-GUID: qKb8032AIWUVw34WMcfT_enNgw8WW695
X-Proofpoint-ORIG-GUID: qKb8032AIWUVw34WMcfT_enNgw8WW695
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/14/25 15:09, David Hildenbrand wrote:
> On 10.01.25 22:14, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>>
>> In case of a large page impacted by a memory error, enhance
>> the existing Qemu error message which indicates that the error
>> is injected in the VM, adding "on lost large page SIZE@ADDR".
>>
>> Include also a similar message to the ARM platform.
>>
>> [...]
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index a9444a2c7a..323ce0045d 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2366,6 +2366,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>   {
>>       ram_addr_t ram_addr;
>>       hwaddr paddr;
>> +    size_t page_size;
>> +    char lp_msg[54];
>>       assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>> @@ -2373,6 +2375,14 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>           ram_addr = qemu_ram_addr_from_host(addr);
>>           if (ram_addr != RAM_ADDR_INVALID &&
>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> +            page_size = qemu_ram_pagesize_from_addr(ram_addr);
>> +            if (page_size > TARGET_PAGE_SIZE) {
>> +                ram_addr = ROUND_DOWN(ram_addr, page_size);
>> +                snprintf(lp_msg, sizeof(lp_msg), " on lost large page "
>> +                    RAM_ADDR_FMT "@" RAM_ADDR_FMT "", page_size, ram_addr);
>> +            } else {
>> +                lp_msg[0] = '\0';
>> +            }
>>               kvm_hwpoison_page_add(ram_addr);
>>               /*
>>                * If this is a BUS_MCEERR_AR, we know we have been called
>> @@ -2389,6 +2399,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                   kvm_cpu_synchronize_state(c);
>>                   if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
>>                       kvm_inject_arm_sea(c);
>> +                    error_report("Guest Memory Error at QEMU addr %p and "
>> +                        "GUEST addr 0x%" HWADDR_PRIx "%s of type %s injected",
>> +                        addr, paddr, lp_msg, "BUS_MCEERR_AR");
>>                   } else {
>>                       error_report("failed to record the error");
>>                       abort();
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 2f66e63b88..7715cab7cf 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -741,6 +741,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int 
>> code, void *addr)
>>       CPUX86State *env = &cpu->env;
>>       ram_addr_t ram_addr;
>>       hwaddr paddr;
>> +    size_t page_size;
>> +    char lp_msg[54];
>>       /* If we get an action required MCE, it has been injected by KVM
>>        * while the VM was running.  An action optional MCE instead should
>> @@ -753,6 +755,14 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>           ram_addr = qemu_ram_addr_from_host(addr);
>>           if (ram_addr != RAM_ADDR_INVALID &&
>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, 
>> &paddr)) {
>> +            page_size = qemu_ram_pagesize_from_addr(ram_addr);
>> +            if (page_size > TARGET_PAGE_SIZE) {
>> +                ram_addr = ROUND_DOWN(ram_addr, page_size);
> 
> As raised, aligning ram_addr_t addresses to page_size is wrong.
> 
> Maybe we really want to print block->idstr, offset, size like I proposed 
> at the other place, here as well?


Yes, we can collect the information from the block associated to this 
ram_addr. But instead of duplicating the necessary code into both i386 
and ARM, I came back to adding the change into the 
kvm_hwpoison_page_add() function called from both i386 and ARM specific 
code.

I also needed a new possibility to retrieve the information while we are 
dealing with the SIGBUS signal, and created a new function to gather the 
information from the RAMBlock:
qemu_ram_block_location_info_from_addr(ram_addr_t ram_addr,
                                        struct RAMBlockInfo *b_info)
with the associated struct.

So that we can use the RCU_READ_LOCK_GUARD() and retrieve all the data.


Note about ARM failing on large pages:
----------=====----------------------
I could test that ARM VMs impacted by memory errors on a large 
underlying memory page, can end up looping on reporting the error:
The VM encountering an error has a high probability to crash and can try 
to save a vmcore with a kdump phase.

This fix introduces qemu messages reporting errors when they are relayed 
to the VM.
A large page being poisoned by an error on ARM can make a VM loop on the 
vmcore collection phase and the console would show messages like that 
appearing every 10 seconds (before the change):

  vvv
          Starting Kdump Vmcore Save Service...
[    3.095399] kdump[445]: Kdump is using the default log level(3).
[    3.173998] kdump[481]: saving to 
/sysroot/var/crash/127.0.0.1-2025-01-27-20:17:40/
[    3.189683] kdump[486]: saving vmcore-dmesg.txt to 
/sysroot/var/crash/127.0.0.1-2025-01-27-20:17:40/
[    3.213584] kdump[492]: saving vmcore-dmesg.txt complete
[    3.220295] kdump[494]: saving vmcore
[   10.029515] EDAC MC0: 1 UE unknown on unknown memory ( page:0x116c60 
offset:0x0 grain:1 - APEI location: )
[   10.033647] [Firmware Warn]: GHES: Invalid address in generic error 
data: 0x116c60000
[   10.036974] {2}[Hardware Error]: Hardware error from APEI Generic 
Hardware Error Source: 0
[   10.040514] {2}[Hardware Error]: event severity: recoverable
[   10.042911] {2}[Hardware Error]:  Error 0, type: recoverable
[   10.045310] {2}[Hardware Error]:   section_type: memory error
[   10.047666] {2}[Hardware Error]:   physical_address: 0x0000000116c60000
[   10.050486] {2}[Hardware Error]:   error_type: 0, unknown
[   20.053205] EDAC MC0: 1 UE unknown on unknown memory ( page:0x116c60 
offset:0x0 grain:1 - APEI location: )
[   20.057416] [Firmware Warn]: GHES: Invalid address in generic error 
data: 0x116c60000
[   20.060781] {3}[Hardware Error]: Hardware error from APEI Generic 
Hardware Error Source: 0
[   20.065472] {3}[Hardware Error]: event severity: recoverable
[   20.067878] {3}[Hardware Error]:  Error 0, type: recoverable
[   20.070273] {3}[Hardware Error]:   section_type: memory error
[   20.072686] {3}[Hardware Error]:   physical_address: 0x0000000116c60000
[   20.075590] {3}[Hardware Error]:   error_type: 0, unknown
  ^^^

with the fix, we now have a flood of messages like:

  vvv
qemu-system-aarch64: Memory Error on large page from 
ram-node1:d5e00000+0 +200000
qemu-system-aarch64: Guest Memory Error at QEMU addr 0xffff35c79000 and 
GUEST addr 0x115e79000 of type BUS_MCEERR_AR injected
qemu-system-aarch64: Memory Error on large page from 
ram-node1:d5e00000+0 +200000
qemu-system-aarch64: Guest Memory Error at QEMU addr 0xffff35c79000 and 
GUEST addr 0x115e79000 of type BUS_MCEERR_AR injected
qemu-system-aarch64: Memory Error on large page from 
ram-node1:d5e00000+0 +200000
qemu-system-aarch64: Guest Memory Error at QEMU addr 0xffff35c79000 and 
GUEST addr 0x115e79000 of type BUS_MCEERR_AR injected
  ^^^


In both cases, this situation loops indefinitely !

I'm just informing of a change of behavior, fixing this issue would most 
probably require VM kernel modifications  or a work-around in qemu when 
errors are reported too often, but is out of the scope of this current 
qemu fix.


