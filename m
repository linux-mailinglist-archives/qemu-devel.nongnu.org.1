Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAEB87BC98
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 13:17:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkk1i-0000gP-5I; Thu, 14 Mar 2024 08:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkk0m-0000Yq-S8; Thu, 14 Mar 2024 08:16:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rkk0k-0007ig-2W; Thu, 14 Mar 2024 08:16:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EBMw4H015546; Thu, 14 Mar 2024 12:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=R/F3ycOGq4Vy6Z+Az8iUBsPrys7Suqw4hImFYUv6c+Y=;
 b=Xv5N3Tp8sh9FvRzJ+PmgnynYQb7k3YGRLe6IFK9JndWXdvXJnbSkoHpegkClmDOqGo/T
 BWQ+7hLjk+F4APRo0olJvHsoZtBHNqJv3AnYRfKJD/CZqCWmFQu+vOZdyzbg/NvLmJ1N
 Rs0mwn9M25Yqn1rGw8deaG5kB3pAB0MzSG7am1yAQJJSApIm8E2O4PNr03Q/yMhPU+FC
 zsjkuxzEFAX18nWjy588KXBSEuoj7pWauIBr7a/5Fy2U+YjxoHqkgXHrie0sOxlb6K7v
 AMp3t2UycsAQZnjaCWyUEP8+ie1BMPVesr/Wh9NXNEAty6HVl5mwQ3Ccs/eBnN4NBPUo eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0abr2sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 12:16:21 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42EBF2dd038057; Thu, 14 Mar 2024 12:16:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7aahs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 12:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbDCoXv1x+uz81Raf1V9wKeyFm8d2KHrk7zPxtUk1JVDenzDk/aMEMGrR64ZvlYTuS9n21Snn/2PbvQkb9OHg+XZnJf43aMYvqk/KZtyMCPVHkrcNFvL8LivJvdpXdM/+Fpbw3gCxJ5h0kvEuoXHqeRTgJQhgLWDCI+M6Fpk0WEysm6ZQMAO2yRRguaVfl/9ZI5SbQZPX4mm1DvAUnh9LOPrDZUyL26ULOnpHdmIKGQnQX26wJBG5A1EC+GS0id25zJaVjZR+95LIYI6KsKdEeJkbLnfHiY428ozAynBIrs1vLdUfFKKTPU26nsvcepSYMn97NKnBKySZyfX4Yh/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/F3ycOGq4Vy6Z+Az8iUBsPrys7Suqw4hImFYUv6c+Y=;
 b=obej8tbS304epHqmrSs7E8Rf4SVeoHb13a3uwuK/QzqPqtnxzb51puh2gehXEEPUq/hiG0wt+2N/MXhoiuSvHXAkfgqDW6nW5M3X8mifXywYPxs+FNX/rtG34+iWzdNGPPLZaf8KL5ZcVXiLDVnf0oucmoa+hwNqhOPHvlQMd7ttxYRGXf/xuHMSvhKV0iqVTdJhxWAR6IjIrdndpF/jDEeNq51Qa5hfSF8LClF5uFLnilvrzgmGlt10k4JDfuQbHvyLzWiSJrfitHQVeMIsJanK7snxeiFA+13zBAUcI37QejxZ6jovxQAkst6lZU2EvCe91n6Rs2zXMG1JI4zuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/F3ycOGq4Vy6Z+Az8iUBsPrys7Suqw4hImFYUv6c+Y=;
 b=l8HiYq4gIb0Cwb2NkWqz0ICH5IvbCtDpWKf5hxoaYA8GzOXEsiZp33CFrPGkHQia9xiEjQ87nCM/Ip0KLdTOmAN5puT+aKgPlG8juHVejln2A0uaGvzl3/EY4At2KzIMDPlgr6ApS9IF1GckENBZTWtIFu9evwi1st2HR4SFnN4=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 12:16:17 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::75a:a398:452a:90a9]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::75a:a398:452a:90a9%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 12:16:17 +0000
Message-ID: <b0e4a124-cced-4cbc-9f89-b8967f5a0b2c@oracle.com>
Date: Thu, 14 Mar 2024 08:16:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] virtio/virtio-pci: Handle extra notification data
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, cohuck@redhat.com, pbonzini@redhat.com,
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, leiyang@redhat.com, schalla@marvell.com,
 vattunuru@marvell.com, jerinj@marvell.com, dtatulea@nvidia.com,
 virtio-fs@lists.linux.dev
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-2-jonah.palmer@oracle.com>
 <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b74377c-87f5-4e71-f570-08dc44208c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qfn3w6r2VAAvW2JToOzpym4Pxaufa+VFpryXWHcx4UF+zS1t7RdO3ya3MmP+xXJA70/it0emG3IOW+JcrmWI3peeK1ivFMlwZuE4/tBgKzy5oN8phaeakh2YcfycQwOfKTj/nfCUZau9zJT2B+Mmci7AF+wXYbVyDube6kmvlBjy3b7sWrIRqCIXzrdYTLd52zb4Zc1wN+m/Zp3btLUhYh6nUJyTUvhzfcl6W6mXrjpz4drhtlBW4pP54y2sLHQup2qeqSGm//pMJfuzr8kIwCO1DO1WczMqiliAwRKHcNQ2X7TKQu8ix4LBtIzKve8CGjT+fhIyguu7GEdWi4U6hMd+mttml7q/eo2rKcH/3zs/Qqk+0NVscaVuw6+rXQBaXDBbZegjvQEyMjHQgYFtm/XP7gnPdH6MMqNSdqLy+6qtgoevGjMUWMGQ6m7tRtsyvUHIwNWEvX8pktSYH3OKe4fSC5UUS46Q50bj4f2o6Z+T9HLdH0BIelz8dbTNG4XVpaPiAmPeXzdDGBgezg9Oi9tzrsK2Yj/dEZVr9r56QbnAHVB/vZfCgFfOkdtSAiphLQbyjZ9a6PMThJQHaAO4qlXPT73v2lnYpM4I42fbloAvOr7SO08e9DjU4PiqppIO/GsBXa6ZGa3ix6skdsSLaONT2/kvEB1VJgxM21IOWEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9kOHdxTHNaSDlqZ0tOOFBjUDVaZW1JaFVuUGtrZnh6c0hhZmxXVEpCbE84?=
 =?utf-8?B?NWU5eEUwcUc4OXI0N2JmK09vUyszQjVsc1ZGazY1Rm12N2NHMTlrRTJpRit3?=
 =?utf-8?B?eVduUDRUZmpuUVVXNVh6MFIra2ZhQ2tCTDlFOCtJQnM5VkswVFQwRW1ZTUZZ?=
 =?utf-8?B?THZUTkdQQkp5QkNOR0s3R3RFcG1yZWdjbnNKL2gxZCsrMm52NHI3SFFJVnNE?=
 =?utf-8?B?YkRxRlZrK005a3hEd3VRQmVwZjFnbTJld2wvY2E5OG9GdDFEdDVTTllmNXph?=
 =?utf-8?B?QXBPTW8vNi80UDlzWEJCblorMXlUZGxQalh6TXBXdGtRdlJtZXo4V1BxUEp0?=
 =?utf-8?B?ZytSN2ZwUGlCS29zTWxYYjI0R2xyWFp4SVM0ZXdyaFdtVFBuMW15UytJeG9G?=
 =?utf-8?B?QmNxbUNEZGtYSjJrT01sUFRrWk5mZ3VwdDYrQksyU0IxT2VyUTAra3pySTdz?=
 =?utf-8?B?MFlVMVFlVmZFbkVOaDhicmdIVnViYmpjc1JnNGFkaWlITzdSMlFZeU8ycXBT?=
 =?utf-8?B?WUVVNGQwNnpxci9qUWMvcGFDSzVGckV3TCtuMmE3Y3g4QXhsZlBnY0VFNmlx?=
 =?utf-8?B?QjR4T3pkK2VXamdzMXkydWx2eVBId3J2c0NSbjRLamJ3TStmVmdsd0xueUxB?=
 =?utf-8?B?cnYrdC82TXBtK2I1TjZjQnFvMkliRTFvNEt2aExMVGQrbFMyZFZ3UEZUK3ZR?=
 =?utf-8?B?NjE3RXhUdlprekFXOGN4SzBxeWx5YnhXYjNlL1ZJMmxUUEEzaEo5WXlWTE1R?=
 =?utf-8?B?MnVCaUNBejlsZTMyeTBFSm96a1UvSWlnVnJZOWVqZDcwUHE1VXhlU3licHJU?=
 =?utf-8?B?UEdvUE13YnQ2Z3psejZhYmpNRnBFeHZuOC9QeFBmN2FKcEtUZDFaeDZmYm9V?=
 =?utf-8?B?ZzdyNzluOHpxaDFNTnNmVmZQR3hvUG5GV0piU29Ocy9CbWhncWxFcytuODZv?=
 =?utf-8?B?OE5IRDVyL0c0R0NtSGRmYXBrRVlOV0l6RXd1b29LR0t5SjhvNkJTUjExS1VB?=
 =?utf-8?B?U2dhckJQMDUzL0F3ek9mSkM5b2dtNFVYZTk3bEdta2tUWi9xWlBjYlhkZXNs?=
 =?utf-8?B?bVhnWjVTMk1oa2F5ejNvQTZQSGx0cnNYTlJwbHRIWWRoRzhBL1lEdy84MC9Y?=
 =?utf-8?B?Zklpdmd1UG5iOXA0TnN2c3FsRjVTcVQyWm5JMGRrR0EwWTBkcHAwU2RrMkxR?=
 =?utf-8?B?cnBFT05TU1hVLzE0bUE3ZmhidkMwN1AwNS9pRXlGYkgxekV4ek1tbTRRWlRZ?=
 =?utf-8?B?MzBBZkMvdkd5R2VyczRsRk1UZzVGc3RWcnh0dmh5SFVDazdocmw5ZGFiNEph?=
 =?utf-8?B?bjd1YjBYMUNtU01Ga3NCNW5RbTI3OG9qNTVibERKalBsUXJHTnFMbG1QUWNQ?=
 =?utf-8?B?Z2RnOWwvNVNHNzFqT0tNK2Q2UnBuTEI4OWswZ0l5bkJjM2Rrdy93alYvUkox?=
 =?utf-8?B?Zkw4bFArcjFPck9CNG53c1NxQkVrNkxYSFdQbW1FbUluOWhtem9ZSEJYbXpQ?=
 =?utf-8?B?ejEwcXBCZlVMNlV4MHRqVVdRQ3phY2pzcm5zQkJPV1dHNjBLa2lMSWp2SmFr?=
 =?utf-8?B?MWF4OHNWTzQ0R1Z3RlZNUUR3c0YwcVhjYVVvUUh3dFVnWnJaUEhkQ0RvSTZJ?=
 =?utf-8?B?THhLZUJZdHBwWmw1ekE2c1J1K0pHRFRleS9STllvNGdxcnNnU1pQZWFlYkRz?=
 =?utf-8?B?L0FGL1d3N0NlUUhNbXB4NisvcEhOVkhydlJxSTl4Y1NaeUwweTJTeGZ3ZHM1?=
 =?utf-8?B?ajRQV21UUjlXKy82TVVqS2M5eVEwRSt6QzVqQUovOE4wd2xDWFZPWHRtWVNt?=
 =?utf-8?B?RFhadXNRa2pPbDQwL1IzTEl2aW95UmxRL2g5WWJrNVpWTnpoRk9oZGlhUDdt?=
 =?utf-8?B?aWVmcFFwRzJNaGtvSG9RZm9rMUlqNFNFSHFvSzlDUjNERGhOS0F6d2YzcWxU?=
 =?utf-8?B?YVlSbEtrbVd5RzBObmF5WGVWM2FzZzUrUkVpMEdtc0N1NG1yTWFUVjRibXRO?=
 =?utf-8?B?YWxSUXl5TFF2b2J3ZEtrK3RZclMrQmNYOEtpUnlxeGxIWGRxdnRkOVltSVV4?=
 =?utf-8?B?MWdtOFpjUjdDNW1SM1ljL1ovaXVCcS9rQitCeUtsMXphVHlTWCtRK0VxWUJF?=
 =?utf-8?B?dVBMWnlPVlRFRHZ4ZUV5TU5FekQxR0JXWVVzd2h0RDNZQkhZU29oTCt4SFc3?=
 =?utf-8?Q?5jDi1AQC4idRc6PmdVi6vXo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rD9KGTBCSCp186NSAbOSX26HT82PoL2iOjRmBs3iGlsMwUo8lhpvmEZUIQ8p7uCI9bEVc33HK3vxM4Db+uU2N9TqEPlzIBR0ATt6EZjWeCvYtAhXHVmsCX9xZ3Qk4L77xSkNJGXCarEW5OXWmRSV2jVZxhCaUjcvGrboL6X7xj31jI0VdfAwESShBiDnAao7tOhK6Jw6WaQPrKdXYibOpBUQ8egrpZS9OeR6bBcuDqeKou4WM4Y8X1aV2T5asouC50Eag9rUD5YzjIv6/IWCLMtJWrk/gg56yvTqSOAm1qMfjeRtYQAoFFOJIQDnlJmqb8ck890bTik7rxSHX9NxFrOEybvR88299H9SPSZARnrOfK3Q0DGmxFxr++Z0ZsDycf+Bl9j3v935CaJxaTk/sjt2A6HwP04de8zAffvd+SqIVW5iEyxpaRaIwoAGYD7My5U+uK8DICzkLjSAm8+kSa+AmCNjolVLhaYpWYrll9aVlCWzjZWE+Sh+4S0P7zqp0pYHKuLXDAUankTmBcJDzjouF254VNOv57qIY5kIEPQqY40t3LpcNjNenLl71eEu4CQke+QHQZGmoDNNPrs3gCASdx6+durX6FuHoT36FHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b74377c-87f5-4e71-f570-08dc44208c8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 12:16:16.9145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GysPvLbxt+ia+jRwUPWRdZS/OinW/tZe3qWdacPFbf39OlgqwRQev1vd6MV0TLJcYYkuEtktzfhBbbopqu2QcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_10,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140088
X-Proofpoint-ORIG-GUID: DiATesm-6ZueryIa3OCHeJaqwPpMEvk-
X-Proofpoint-GUID: DiATesm-6ZueryIa3OCHeJaqwPpMEvk-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 3/13/24 11:01 PM, Jason Wang wrote:
> On Wed, Mar 13, 2024 at 7:55 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Add support to virtio-pci devices for handling the extra data sent
>> from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
>> transport feature has been negotiated.
>>
>> The extra data that's passed to the virtio-pci device when this
>> feature is enabled varies depending on the device's virtqueue
>> layout.
>>
>> In a split virtqueue layout, this data includes:
>>   - upper 16 bits: shadow_avail_idx
>>   - lower 16 bits: virtqueue index
>>
>> In a packed virtqueue layout, this data includes:
>>   - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
>>   - lower 16 bits: virtqueue index
>>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/virtio-pci.c     | 10 +++++++---
>>   hw/virtio/virtio.c         | 18 ++++++++++++++++++
>>   include/hw/virtio/virtio.h |  1 +
>>   3 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index cb6940fc0e..0f5c3c3b2f 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>>   {
>>       VirtIOPCIProxy *proxy = opaque;
>>       VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>> -    uint16_t vector;
>> +    uint16_t vector, vq_idx;
>>       hwaddr pa;
>>
>>       switch (addr) {
>> @@ -408,8 +408,12 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>>               vdev->queue_sel = val;
>>           break;
>>       case VIRTIO_PCI_QUEUE_NOTIFY:
>> -        if (val < VIRTIO_QUEUE_MAX) {
>> -            virtio_queue_notify(vdev, val);
>> +        vq_idx = val;
>> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
>> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
>> +                virtio_queue_set_shadow_avail_data(vdev, val);
>> +            }
>> +            virtio_queue_notify(vdev, vq_idx);
>>           }
>>           break;
>>       case VIRTIO_PCI_STATUS:
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index d229755eae..bcb9e09df0 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
>>       }
>>   }
>>
>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t data)
>> +{
>> +    /* Lower 16 bits is the virtqueue index */
>> +    uint16_t i = data;
>> +    VirtQueue *vq = &vdev->vq[i];
>> +
>> +    if (!vq->vring.desc) {
>> +        return;
>> +    }
>> +
>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>> +        vq->shadow_avail_wrap_counter = (data >> 31) & 0x1;
>> +        vq->shadow_avail_idx = (data >> 16) & 0x7FFF;
>> +    } else {
>> +        vq->shadow_avail_idx = (data >> 16);
> 
> Do we need to do a sanity check for this value?
> 
> Thanks
> 

It can't hurt, right? What kind of check did you have in mind?

if (vq->shadow_avail_idx >= vq->vring.num)

Or something else?

>> +    }
>> +}
>> +
>>   static void virtio_queue_notify_vq(VirtQueue *vq)
>>   {
>>       if (vq->vring.desc && vq->handle_output) {
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index c8f72850bc..53915947a7 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -335,6 +335,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n);
>>   void virtio_init_region_cache(VirtIODevice *vdev, int n);
>>   void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
>>   void virtio_queue_notify(VirtIODevice *vdev, int n);
>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t data);
>>   uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
>>   void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
>>   int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
>> --
>> 2.39.3
>>
> 

