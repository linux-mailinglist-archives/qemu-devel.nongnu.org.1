Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492D7FBB85
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:27:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7y6X-0007MT-Sr; Tue, 28 Nov 2023 08:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r7y6W-0007MK-AJ
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:26:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r7y6T-0005IG-Mm
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:26:19 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASDO8mr007978; Tue, 28 Nov 2023 13:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lUCiPiwXPwBjrTL6MOzw0S9gZibkAM4G6gjVAwf67Zo=;
 b=lTAq7zWk2oCy01Tx75vtaM8bD8mWo80TNVNCXiiwuNcg0oT5/uEeWD3yh8bEQHGtXNgn
 0cN2XtJrC4A+su+p9kAqeh5VqopRwB50jRfkRZ2kAoYwSvEJBF7B8wQWQ/OyKfhgM/Pt
 TYssGRbT2DrDlIBseCunLeJdiibP3AlHYkpnOg11dIjRQ0Niim+RKLQC/Ek2FpBAl3fW
 5Bblc53ekGbGZe9HMRIt99TUjEqCdl03wZ2pSdkm+F1jzoY9W4ujwbgBJ9Whh29xqL4S
 Vp25KnObQjQyoFJfG/n/BpmwF3c5hI5ADIxIeHPnTIvTTaGYCa22Xe779aam90rrCJ7B pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7q45tf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 13:26:14 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ASC2Kgh027013; Tue, 28 Nov 2023 13:26:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cd3qmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 13:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXNgqnUTX3ehAqXqocHTpnvflYN2Exg/nWD2pfNci5k3ArCjm6wAMDRxS7gIe/Dz9g3i22tycqNhlvbF4sCx9C3MCjFqN7UNkZY30h7qmhYbWNzLvUfU/ISXHGd7OQCx1YBrHPM4GJ8wXFX0wD2hXQudLYZ07MFeOfXbu/350YIseoOl2gRCcuPt0rnrqzkYVm3Mo8Es0LbRDpZB+fpWo5oFCzcLzfTweIY0H2RCeXFR88KFINGQC3edOPrRRTR/l3lx68diTwtqcis+yUIY3UK3+R8/v8zUWVyah8rQmfqdppSDoNH6pyx3TgSKx0NKfp9eYh5QmGrO7jz7icX7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUCiPiwXPwBjrTL6MOzw0S9gZibkAM4G6gjVAwf67Zo=;
 b=K0eBtlvhhPsWpvtXdFmK1SMruIUQllJoVFzlsnnQnoJQ+czEXycM+Q6iT9X/y1jLrl/+RmLnI210Yorikg4/ug2jTGLoI7tk6OolEDQPij0xgl8kszxewUgE0x+BZXUNFHYVbZVsV29Y3i5e8LIwMP3TcfmgfYZ7HTw2jceiTOdC5EpHRUZwhmarcruBCh2NM1V3RVHs4Z4jIOuPgvRZXHVSvH5b53QxuqY0ttnI7AOZBBgPIwywi47/OHWl9rlxP0zmE+yDQkas0hN08ztWz2HMGapDF1FToQKE3KNRU+s1pHk6i2woJ7Wa2/UBbv++nEnu5uaYIMeH0SZg6ZENKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUCiPiwXPwBjrTL6MOzw0S9gZibkAM4G6gjVAwf67Zo=;
 b=FldbJ0gJbaEzohTtSPydPRms7RROEBiDjUF/XW/lU1GHcuzssSPdre3Ur4mnnvCuV7a6xMvi1Y2e3bfd2wrIXNXXZ2m+TUADPzKPPyi1xXjL8XdHPRZSrNwM/UPE/3MBANxPvWKdKuyHDmDRE9I/e9QuAj0qNpME4tGnTMqwUfE=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 28 Nov
 2023 13:26:12 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87%7]) with mapi id 15.20.7025.021; Tue, 28 Nov 2023
 13:26:11 +0000
Message-ID: <4699f005-0b3c-45de-8967-0ef90b79f228@oracle.com>
Date: Tue, 28 Nov 2023 08:26:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n> <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
 <ZVvTUuNYzGgFcg4m@x1n> <ZV3L_ihDoQOAsT44@redhat.com> <ZV4qlqxp8QVagcjG@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZV4qlqxp8QVagcjG@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:510:325::6) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: d15e99c6-e216-43f0-2a6d-08dbf01596c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNZuJdqmAWKNKNPGTcKDDkKyW8QFAN2wF0/nYU4NLDHHIeRMF8ay/i3e8Y8Sj82vGDu82d+qLlUq3KbVsZB1cQ//9pnySRbVogtIt0ZfYZMH2RaYNsJ6d8DvtRaVOsS4nFmkHcE1yL7gt060HWZmq6QiLsH1/LOLbJHqhd+mObBQ/8HsgZdfbRdyyWDR7e8KpchqKxvtoyIEedvkKZhJUyO1yhi53jr+lUXcs2D4Ip2mukM9Ycs1Kus0Hu2wjrkbdVIeKrDTXcwYYnnSU3HkomdNXjcMj6AgZV7HB9PU/v5+auGkNAGM94aqUBTQNITktzCRYl3U4nwOSboTAfiOf9yzKHRpZfrkSkkQxz9BHtvqVfv1wXqPX1DctWNt/8xybh8IbHZ8iAwmUBa+M6Xh/44yq7p/wMXllQgrTeK2wzRzJ1VrafPJ+xGQQmwdnrDkPfHk/PerXbj916BYpUnjMDgelIX+UIlKCNyy1o8iesN1Hpfbci9kvGvcj63f57Gqs8rz2jnEx5tBlNep0NqH4NyPieRZdxn1kVRZ1vu+e7XUljXCxxWlK9Vc/RkIU5wMPHo1eFfykVst6F4BpeUUNf5C4/10/Lai5E1QEl4DOM7VLIm8JLu9aJdpW2Fp9F6CL+Twlw87Lyqr9zLEAU3NZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(2906002)(44832011)(8676002)(15650500001)(8936002)(41300700001)(4326008)(31686004)(110136005)(316002)(54906003)(36756003)(66476007)(66556008)(66899024)(86362001)(26005)(6486002)(66946007)(6512007)(6666004)(2616005)(478600001)(53546011)(31696002)(6506007)(83380400001)(36916002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGF1cDJ6c2p6eldHbnBKUWZqOXlyNUhCRVNmT2RZc291bk9tSzREYjdVcVBO?=
 =?utf-8?B?UVJvM2l0UGhWa2NETVdpTldLOVBHQXhuYVVJNExia2lIbW8yMFZWU2VkUGMx?=
 =?utf-8?B?Zm5wSUNZdnY4S1R6bFQ4NTFaamRIa0ViWVhzY3JoVk9VeVRxOEV4TEhuN0pG?=
 =?utf-8?B?QWRtb1pMV0NUWWMrY0JYZm5TOERPVDhKdFJqOUdrbFpxRGdVY2Jlak9EOEVx?=
 =?utf-8?B?Ky8vNHM4RUpoY0VFRkpwV1NBU0J6SGlZWThrR0VXcDRVbVpuZFR6WURnOTBw?=
 =?utf-8?B?K0NiRjVubWRhbTM2TXR2UnhhN0JidjIyR1BNK3RWY0hFY25UUWJCbzZCWEtR?=
 =?utf-8?B?cXpXY1UyRWNMTW1zY2lhczBDMXVTRHVaM1ZGNFRxNkdqdFRRVkEwajZYc2lo?=
 =?utf-8?B?SmkvWlltU2VkS0lCRmJOVkFuYi9ER0RZdTdNa2QxZnpUMkE0M05WQmF4QmhS?=
 =?utf-8?B?cnBtK1lINnVQamt5b3hIM2lUeWZLSGQwVCt5bm9QK21JMlVPbThrNGVzVjAv?=
 =?utf-8?B?ZTBkdmZPNU1GeHRnYjhGWDdJb291SEM1QmFJNnl1V2t6dXJVWFV4Y0VZam03?=
 =?utf-8?B?UUtNV3RnZUFoWWUyVkFlNEdQblRjZkE5VkVZT282RzFtOHpoRnlXMnl5Mk5B?=
 =?utf-8?B?aytTTXlrems2RUx3cjdHcmRDcWNlVG5VdXBVQTM0bU0zSUd4Y0cxM054cjlx?=
 =?utf-8?B?aEE5TWk1d0l6Z1plWkE5dmxhcnc4UjRKTmQ0MktRYzVPc01xWCtYZExiZTRD?=
 =?utf-8?B?NTBJZkc4QVR4YS9sT1hVMGNhZjNkTFZlbVJneWRldDVXVW1yeUl6bk4rc1Ro?=
 =?utf-8?B?Tmo4Q3l3bXFvNjVSenZxRGdLcldad0VxSXpyQ0tNNVBYbDVDTWpzWnJJTTZy?=
 =?utf-8?B?T1owTGp0L3hnbXM5UnBuSHdxV0lGczljN1RMU2J0QmNjSWVGN1lSRDhoc1Ur?=
 =?utf-8?B?RWU4WVFyZ1Y1bGpLeWsrSWlaR0RtTHQ3aUZDNEFYU2huNTdMck5zMmNocXhV?=
 =?utf-8?B?dTJ1MHhEb05jdTNkWDZ5aHNXVUFaR2NuWUxjRWFXWExyK2dXVzlVSU95QVlS?=
 =?utf-8?B?dFVtelM0OUJ3Sm1xUE4zeFM2VGxvMS90NGJtZUpUb3RQQkg2YTBtaHRLY2lm?=
 =?utf-8?B?QnczN2NOeEdXTFd1Vjd1QUF4c0VKZzBuejJXLzFWbUVlS21sd1BSVGRadlky?=
 =?utf-8?B?SkplSHZEVE01K2pXbkVDMEZpUUsyNGppdFZ1cnR5Q2ZxUVkvZENROXJzNlVG?=
 =?utf-8?B?WnEzR1hFczFURld6czdQMnk5WHdST1F1dlFEZDRPK1QxSEMrTnMzSzkvck05?=
 =?utf-8?B?bytnMDhnVDcvS3BIMGZYNUFJNHdMcVhFaDJrMVRXWHhEeU9sem15YzQrOUti?=
 =?utf-8?B?ZG9QNXZkMEpWbXlNUWM5bG9xeVRHSHlibUdMbU1USjNaMi9UM2syclE0d3Vl?=
 =?utf-8?B?K0tYSHFjRGZ3QkdCM09NRm9qQnlmdGlzUlVVUU9pdlFXenhRb1lCNGRrMC9V?=
 =?utf-8?B?U3Vzc0dhNDRLemdzMFlnYzJ3c0w5YXo1K3N2dlJvaE81aUZhSmJnemtxMllX?=
 =?utf-8?B?ZHZxT0dQaGhSOUpDTnhITTV5U3I3eVJMd3Y2QkNLM3pXWEVWankwbVFUSDB0?=
 =?utf-8?B?SW5WQ2NRVmFidkN0MVlEeTgxRlNnWHpweUQ0cjhoczBybnZVa0RMSHJ5dnBP?=
 =?utf-8?B?S1RaNUUwcS9KdHF4L25mdjB0OFhqN3FPTXFYdWRuOEM1azRvTE9nTG8wZWF1?=
 =?utf-8?B?eXFTQmg1cmpEVnQ4N0VRakdiT2MyeklybWdjaTZCMzBKQ0JBQk4wTkZRK1Ft?=
 =?utf-8?B?QjFzK2VWNWlyRG1QQVlNRElXUXE1K2Nxdm1ienpCTWlNTlM2MVlPV0trWkZX?=
 =?utf-8?B?WCtFYTl6Ny9ZemhkUk55bUh1SW5ROUJXWCtSRkgyT3BjMm5PSDZYRXNlU1NO?=
 =?utf-8?B?T3RUQ25qT05ueUtkVlhQZzU2N3JvMFkrMDNPYUxZb2V0dXhoVE52UHZ2RGVt?=
 =?utf-8?B?SGZudnN6bkhqVEkvbWFQc2VwZ1FYZXJkTUdnYktUdTMyNm9qWWxvb0c4WEgv?=
 =?utf-8?B?TzVOK0FNajZGcVNadncyQ24wandoYTYyemNzT3hURXRiWEsxcitkQkkyNm90?=
 =?utf-8?B?Tk9PaWtqMy9CUEx2ZXFEMnArWTNEWmNzVm5iQzVmSExtbXVNRGZkOFM1VnFF?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OPaDLybZijPban2NNiP312254S51+UprQ4GBMai/g7PwyOf4K2TlHLLW+lfKDNxYx74vpWtttEV2+x5nHlmDg/iLSWcHOCo3hSJiF9La0SAVTkk8ZHi65ziUUIt15lvSNu7kAPNf849OcK3KGBJcb8uldIjjcejantHsHlikuPdFy5pg6XEAeJDLutEqO9/DzKxqC2H7jFpWLIL/mngc+6/ofIFPngtfod/3a+xwUpLdZWfQQ6BBQs1lSZiU1mTbmFzwODTWD4eqXGIY7l5VRKfsaqFR+j2CyeWIfF3P6lYk0FF0B7DdwBCpbonKB20B3QP7lw/kAW5D/Y//B2sfoknm8JdlZY+/xfy2gd/KzsyHCPyZ8UoTGahkdqpt9HGyg7TFBq/8yX+6tBwXJmwGk+8OBFt0QD+Qxiooi1wp3A61wYJFK8pFuDcBqm2yLhIH2B050pSzxG28QEFPVWl7Q0+hF4vftJfIOd35HE2+lNae9n5Aemg/JucTcfXxAxruUy81/4A5OV5tEaBXYyPIaNXouONonbttoWOcViSzj3yVXrC5qrtQa8uSnoIlHh8dOuK9AGlcOdEXYfRuPtg9RuFPJFnLs5YieH1nnLX9dhAQLmaMNi/rPMKlNyY71QP6rht81d9Cw2V0imPFy1p4LCdb+NylyX60K8vXD4EfL9rBjVJXMCc5Bz47Kr7eVSIoXBD+5v2VPtJcOHi3Bevs6belKnKEnMzdTznVm3Owf6p2nxFoUt5fElIxror4Jq2bebCHsdBV0qqy+6DbWapJnhQR8QcquWtevYn5gKoTATs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15e99c6-e216-43f0-2a6d-08dbf01596c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 13:26:11.8901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tjz2VexsM0J3MqeA6buUtiCnnbRZ0CYarrTL/La2Ti4b6hVDGxWzB3bDupSXjWDiEYtueCVOUNhn5u9pVzN/kApEMpgXnughq6kQ6d0Pyjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280107
X-Proofpoint-ORIG-GUID: 83xjvlTn_mm5NPrrCaplN_90a6du-IgK
X-Proofpoint-GUID: 83xjvlTn_mm5NPrrCaplN_90a6du-IgK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/22/2023 11:21 AM, Peter Xu wrote:
> On Wed, Nov 22, 2023 at 09:38:06AM +0000, Daniel P. Berrangé wrote:
>> On Mon, Nov 20, 2023 at 04:44:50PM -0500, Peter Xu wrote:
>>> On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
>>>> If we drop force, then all calls to vm_stop will completely stop the
>>>> suspended state, eg an hmp "stop" command. This causes two problems.
>>>> First, that is a change in user-visible behavior for something that
>>>> currently works,
>>>
>>> IMHO it depends on what should be the correct behavior.  IOW, when VM is in
>>> SUSPENDED state and then the user sends "stop" QMP command, what should we
>>> expect?
>>
>> I would say that from a mgmtm app POV "stop" is initiating a state
>> transition, from RUN_STATE_RUNNING to RUN_STATE_PAUSED and "cont"
>> is doing the reverse from PAUSED to RUNNING.
>>
>> It is a little more complicated than that as there are some other
>> states like INMIGRATE that are conceptually equiv to RUNNING,
>> and states where the transition simply doesn't make sense.
> 
> In the qemu impl, INMIGRATE is, imho, more equiv of PAUSED - do_vm_stop()
> mostly ignores every state except RUNNING (putting bdrv operations aside).
> IOW, anything besides "running" is treated as "not running".
> 
> But then Paolo fixed that in 1e9981465f ("qmp: handle stop/cont in
> INMIGRATE state"), wiring that to autostart.
> 
> Now we seem to find that "suspended" should actually fall within (where
> "vm" is running, but "vcpu" is not), and it seems we should treat "vm" and
> "vcpu" differently.
> 
>>
>> So my question is if we're in "SUSPENDED" and someone issues "stop",
>> what state do we go into, and perhaps more importantly what state
>> do we go to in a subsequent "cont".
> 
> I think we must stop the "vm", not only the "vcpu".  I discussed this bit
> in the other thread more or less: it's because qemu_system_wakeup_request()
> can be called in many places, e.g. acpi_pm_tmr_timer().
> 
> It means even after the VM is "stop"ped by the admin QMP (where qmp_stop()
> ignores SUSPENDED, keep the "vm" running), it can silently got waken up
> without admin even noticing it.  I'm not sure what Libvirt will behave if
> it suddenly receives a QAPI_EVENT_WAKEUP randomly after a "stop".
> 
>>
>> If you say SUSPENDED ---(stop)---> PAUSED ---(cont)---> SUSPENDED
>> then we create a problem, because the decision for the transition
>> out of PAUSED needs memory of the previous state.
> 
> Right, that's why I think we at least need one more boolean to remember the
> suspended state, then when we switch from any STOP states into any RUN
> states, we know where to go.  Here STOP states I meant anything except
> RUNNING and SUSPENDED, while RUN -> RUNNING or SUSPENDED.
> 
>>
>>> My understanding is we should expect to fully stop the VM, including the
>>> ticks, for example.  Keeping the ticks running even after QMP "stop"
>>> doesn't sound right, isn't it?
>>
>> The "stop" QMP command is documented as
>>
>>     "Stop all guest VCPU execution"
>>
>> the devil is in the detail though, and we've not documented any detail.
>>
>> Whether or not timers keep running across stop/cont I think can be
>> argued to be an impl detail, as long as the headline goal "vcpus
>> don't execute" is satisfied.
> 
> "stop" was since qemu v0.14, so I guess we can't blame the missing of
> details or any form of inaccuracy..  Obviously we do more than "stop vCPU
> executions" in the current implementation.
> 
> But after we reach a consensus on how we should fix the current suspended
> problem, we may want to update the documentation to start containing more
> information.
> 
>>
>>>> vs the migration code where we are fixing brokenness.
>>>
>>> This is not a migration-only bug if above holds, IMO.
>>>
>>>> Second, it does not quite work, because the state becomes
>>>> RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
>>>> will try to set the running state.  I could fix that by introducing a new
>>>> state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
>>>> in existing behavior.  (I even implemented that while developing, then I
>>>> realized it was not needed to fix the migration bugs.)
>>>
>>> Good point.
>>
>> We have added new guest states periodically. It is a user visible
>> change, but you could argue that it is implementing a new feature
>> ie the ability to "stop" a "suspended" guest, and so is justified.
>>
>> S3 is so little used in virt, so I'm not surprised we're finding
>> long standing edge cases that have never been thought about before.
>>
>>> Now with above comments, what's your thoughts on whether we should change
>>> the user behavior?  My answer is still a yes.
>>>
>>> Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
>>> behavior, while something like QMP "stop" is not guest visible.  Maybe we
>>> should remember it separately?
>>
>> Yes, every time I look at this area I come away thinking that
>> the RunState enum is a mess, overloading too many different
>> concepts onto the same single field.
>>
>> Specifically "SUSPENDED" vs "RUNNING" is a reflection of guest
>> state (ie whether or not the VM is in S3), but pretty much all
>> the others are a reflection of QEMU host state. I kind of feel
>> that SUSPENDED (S3) probably shouldn't have been a RunState at
>> all. I'd probably put guest-panicked into a separate thing too.
>>
>> But we're stuck with what we have.
> 
> IMO compatibility is only necessary if at least the existing code is
> running well.  But now I see it a major flaw in suspended state and I can't
> see how it can go right if with current code base..  My concern is instead
> that after suspended will be used more (e.g., assuming CPR will rely on it)
> we can have more chance to confuse/oops a mgmt app like Libvirt, like I
> described above.
> 
> In summary, I think a current solution to me is only to fix at least
> suspended state for good, by:
> 
>   - adding vm_suspended boolean to remember machine RUNNING / SUSPENDED
>     state.  When "cont" we need to switch to either RUNNING / SUSPENDED
>     depending on the boolean.
> 
>   - keeping SUSPENDED state as RunState (for compatibility, otherwise we'll
>     need another interface to fetch that boolean anyway), even though not
>     query-able during any !RUNNING && !SUSPENDED state.. hopefully not a
>     big deal
> 
>   - enrich ducumentation of qmp_stop/qmp_cont to describe what they really do
> 
>   - (with suspended working all right...) fix migration of SUSPENDED state
> 
> I don't expect a lot of code changes is needed, maybe even less than the
> current series (because we don't need special knob to differenciate
> migration or non-migration callers of do_vm_stop()). IMHO this series is
> already doing some of that but just decided to ignore outside-migration
> states for suspeneded.
> 
> We may want to add some test cases though to verify the suspended state
> transitions (maybe easier to put into migration-test with the new ACPI
> guest code), but optional.

FYI, here is a brief update before today's meeting.  I have implemented this and
I am testing libvirt and its various save + restore commands, when the guest is
suspended running (RUN_STATE_SUSPENDED), and suspended stopped (RUN_STATE_PAUSED
with vm_was_suspended = true). There are a few failures, and I am still investigating 
to see whether they can be fixed in qemu, or need a fix in libvirt.

I will send more details later.

- Steve


