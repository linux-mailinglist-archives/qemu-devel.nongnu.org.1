Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DC9F1F2B
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Dec 2024 14:48:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSUt-0000BR-GJ; Sat, 14 Dec 2024 08:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTh-0007kd-Ef; Sat, 14 Dec 2024 08:46:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tMSTf-0002ot-Mx; Sat, 14 Dec 2024 08:46:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEDfrI6028739;
 Sat, 14 Dec 2024 13:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=uLhbKhI5RH66g6X1oJem2vCjv5om1/AgyTDM5B2oaik=; b=
 SfagUYh/eSK5LNJIlB7YwQX9wlelsvkNh7CULSsM4VJe95Rm96PL9UAfzjxEfaV4
 QQgSQCHLcGHdpfhU62NUOp2bCHMmZCyoAEEH9a1S4K+LfCzh4YWcQQH+1QzuM+J9
 brsFbs/GlH8cGPf3u0RTt3Zyz+hlFS9cpoF2HoAPEfjmGcTX+IDNXhytjm9B55pI
 1etXLBXxivUgGmwLtZ+Bch92m/N3M9qgDjdeqmqoVM/wLqORNbyw2KoFhdjOd+bv
 LhNo7noyC8Hs8YjiR2OVO5Uzi+zTfisakEAB1wywMqWquKj/TLUbOGk/1tXQ0UDI
 Yrf3oMgqpVKf+KaNQF5w1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec0guc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BEAHq7I032785; Sat, 14 Dec 2024 13:46:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fbu0px-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 13:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP6rj7xqKG8QIHsYCn6VvMDoyo5PIuqnlKZlCQyQgpRSJKayZc66J5EcH0Ffg2ziTWmyK5RT8vgWszTTIYcOOTGgIPVJDlfOw3gMeRhd9Ve7aENspB1THrFfh9B6mPU8Dtw9y85YwghqyBkGgDR3TBVvfa1IR9peTkVMZU3NgjCgMyjWrWNTTQw9Y0QPMkvcyWIbcFCp0MxCr2xaEbEK4msL5lihf87loOwwj3vB3T3VDEcSD1/Ab/PSJsdhRH0g60Prcyqto6JHIfa6epnVvVZhHitkucB8xr28iNsc69Gy7nPbmK6d4rWXWKdeRFdkPOnkF0Vy1CcyFKgTRx2yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLhbKhI5RH66g6X1oJem2vCjv5om1/AgyTDM5B2oaik=;
 b=Th2xft1ZwPf0sDyRcM/4M6n5+HCrxmnVp+/5KiZYcsK+LsEZ1LTZS1FTvAhDZTvCx4UNglbTmpaX3kN856QTtVXZO2VtfrsGN08i9p82d2Mrc37WyZPAKM6P6ELv7EcY/Q7WBScz5lTYPbuWyKh6pwLKqbiVsHEo8+IH7StH140PCa8k8GgubqqQdIu/iNJkZSG6WH0Et2DdAx/KFT8iGzOt64vdzaYaUEfDf2YdHEhf/su/mWz2Rfm3CBcVdP71do/8+kLh62eThRlKlFEk2LnPzVkf9pKQVGR3r4RbnuCDsKFs14D6ZVGWxBS4vLQO1FIDLmlGH7MrSau0B4++pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLhbKhI5RH66g6X1oJem2vCjv5om1/AgyTDM5B2oaik=;
 b=YgpxIid/B+qeUrKRjjzjnNQLca+cjecY6pZTqzdHTeO/vz2eXy1IUOHjhx78jgc4cqJ2iJER845XkWgCtaDVHHX6J/Acgn7gPwhDE6eP6CiJevXzFgdR4wTLT5ZisHc9CqQLee1xTlRmEubTDF6nvOgEtd/hMd8o8v7/5OdIEJk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 13:46:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 13:46:10 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 6/7] hostmem: Handle remapping of RAM
Date: Sat, 14 Dec 2024 13:45:54 +0000
Message-ID: <20241214134555.440097-7-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241214134555.440097-1-william.roche@oracle.com>
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f87c67-f638-466e-7837-08dd1c45ab1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HI4H8nxD+pEyd9PVQ+e9mwv/dHN99D2ju7TcemZwuJBHRXaZKcP+vf6dLkDy?=
 =?us-ascii?Q?HwCSfx1R+N8Ocf6haYLFrj/488B5hVGfRmT9m58Lq3ca8ZN6JkDa8rvuz5RW?=
 =?us-ascii?Q?4QmJ0sQOl6Cx2V+R+5PfJl1F4F1S4vB7Vg/b8mmqN93hVvZWv9/eEvj2Y2Lh?=
 =?us-ascii?Q?dtJhn6maxwPWBp7ixJLFVgjqY1NooJgqGd/lm+QyXrM5zReRkDlHJoGQy7np?=
 =?us-ascii?Q?8eFH1JlMUMDFCO28tWHEpOUPedfXHGHBkkA7Aj9qBIy7E25q15E9cqNNTQJj?=
 =?us-ascii?Q?WMsd3t5t1aob8nSjH/7yAByHBDCI3ZYwYzzdS7UuxOOHk9jbkoTtbd2YjuGJ?=
 =?us-ascii?Q?l6ifyn0QucWV6U7mF+drjPXdvRZj4OMCam/Yfkco811jGT4OVUrlgfApPe26?=
 =?us-ascii?Q?C7eaMMnSCMHHO2lIZSD3IDAeGRnQpKOBbIlHn1MhBjCWJZoUzU4npD5ITxj6?=
 =?us-ascii?Q?XQB2YJwIYkqw0yrqq7+uXOOvsOy9hZIt8AbaXUaVn89UhJr6EO7QnQ4WVbUj?=
 =?us-ascii?Q?eYEMVHzKORhjrKSGR0f6r6Ok8t28idOz1ykSLI0NX5FbYQqkI21ijLnZLKHk?=
 =?us-ascii?Q?+rR6qI/867z4jVGH8BLLklDDo2l9MJAkMW1cHDl+CvD27toR5jnJJ7WCDUb3?=
 =?us-ascii?Q?DYIoW+LVbg86SKhmVlPOqNs/hWB9ISSzwYshSdOJps5XupQQ1ev4k6qwyScK?=
 =?us-ascii?Q?m+FgJARI3hgl0hR2oBTFTqJM8voB/Yw3TS23KZKAth/VP4AaPM1hBE7prVUd?=
 =?us-ascii?Q?PXgCX8Ns8Hi3K50BSym+u08fS4tdXsJsXRxadoFvvjvcYvZWj6DlOHfZ3w6p?=
 =?us-ascii?Q?2z3ra5lV8JuePdMxWLKavYQWcUbo/5fHxFPgpcXXYDqxu0jfIzzWFxAPZLpa?=
 =?us-ascii?Q?+afQdQrsY9YnxKPen4q00aMJGiUrEaqJWHr1jvan3NTPDt3RdORkEIkkd/sP?=
 =?us-ascii?Q?bNVQbERS3c5GHyTTSvu9BLCaE+LmUyShz/hAIAb+ojibcthHiqKZKv9SdSMb?=
 =?us-ascii?Q?oGbZ9CAtGIhqKbdanynRg+PyI5fGWKfLCd/NlzG5dYqXXuQXS7cd61fYOvVX?=
 =?us-ascii?Q?bGnZiXKpeka2GxDcPjctZyhcW2XfmuZfuJZ5tfYlInC4d8kgupFzWUS0Y3c1?=
 =?us-ascii?Q?vGVaaVZlBs+/EDrp2jJ2iOGjfquNliEIYkaeqix3aZym71xdXUzjzo0BbSef?=
 =?us-ascii?Q?wNPiXcOF9JrNsTiB1oslxOjVS261QsFHnkwpHrRThotNWEcyFq4IhaLcMxxJ?=
 =?us-ascii?Q?OzBycitSwNpyUkDnfb7nqCqrkSBJjU8bE2PBAqvwaXb3hrBn8gAy00Nowums?=
 =?us-ascii?Q?Ywfb1Euf5Ube/SskGf1VO0MTxeYq6HMx3kTcp3OSq7R5SQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRFP41Du6QAr7Iezlzovj5UNHX3xz2nP1TTzbSqcVAONQbmKhxeCFQHcR8jD?=
 =?us-ascii?Q?tHgMk/gY/5ZM8l2+dDysTyrHwLF+Mk5TC+kub+LwWYWURf3o8EI7WnYQPcHU?=
 =?us-ascii?Q?W6guUnHczJIXdG0aP10MlPn+rwNd3psvFf0N34jPDrmVRqSm7STrChPjQ1gr?=
 =?us-ascii?Q?XqIKsjoqz1XWqEzYZr72Ma++JsO0RV0qHjF9CLXUl3vnbrmksnBltEHUDPhh?=
 =?us-ascii?Q?+1gBklubMF7Shd24PLzT5mqiO3e3qkOZ8HygVYPrkm0yvHA9an4RnoWwpcC2?=
 =?us-ascii?Q?puCldIAR6YbBBDQGCzBl6+9vpBonpPQ9Zx0bceBZqVjTmIyqCr67/wjBR9lE?=
 =?us-ascii?Q?v0Ahh1oSZ5a/ELhgDmQRw8N4aEzB9fPBkGXyzQpwQf5xlkF75WBvTCBtXLT4?=
 =?us-ascii?Q?OaayyJgS8Z6e+qVPnvKC3A3bhNg0d6NKRxCu33SXT54lDejHOFLxpWxMbXoc?=
 =?us-ascii?Q?LQCc5PnXBhkR3iB8nQvwJSkAwVVdRWBWT0thPJ7DkE6gLP29QPs51G/kea7+?=
 =?us-ascii?Q?XhJgj57JdVGVLb44/ycFucmXbn57JzF59CioMbw7+o2Fn8otnHY3Hla0OU/e?=
 =?us-ascii?Q?8xMySstVfOhAU71JUGVKFZyO32/OOoagyWJiqetqNlWUHzGrTP2QIBu//aIE?=
 =?us-ascii?Q?qvRJF/JyeksPNYpJbsv2MvEAe5nqg2E7cr2EEc/fiji4AThyJQCXy8VQxYcv?=
 =?us-ascii?Q?mlpXjQnGtnwXY/PY+hRmUILGUfUkBsEtRM4fMarn1uAmCRhs1tCNoarxIigQ?=
 =?us-ascii?Q?Um8HvoWSatGgEqpcgXB/KoVF7rPVlbnLk7W5X88Z3Y0X5RNrjGcldEwjUAsp?=
 =?us-ascii?Q?5we3xE7r9BDv5xxBFRuzHJiM/m7wfZa+qfXeTzOL8BPTe4Dz4yEks7f1SH7e?=
 =?us-ascii?Q?FqqFRnVQ+WaQGO59id4zvUVp6PmmlXOCAWDgeYtLFG3CSTLLcLeCSEMxICDL?=
 =?us-ascii?Q?WcO8U+eLIXG9J5+SSkXNJvRjTMwmUtyccP1T8MkKqK++z3u/bEkJXRX04GPP?=
 =?us-ascii?Q?vUGy3QPu/5sVfPAamK8a6V92/TfwOX8zmOGA55UDx4fKnTlKn5uTypeixMac?=
 =?us-ascii?Q?ifkBOzNUbZEeSb+laMMlrNkSke8dEtDVhsar17OBOWtOD1TS7JkUDXDyjptQ?=
 =?us-ascii?Q?gHWRCUpZaAuCdHKRyT717MbJGCgkjIdITCv9V6T2ctHj+6C7xB0mVmJdczgI?=
 =?us-ascii?Q?rI+CUVD0AqCuL1kpAZI32z4euNww2KPvlC/P9m4k+GZc5xqXHxeYI/CTXxIo?=
 =?us-ascii?Q?JKSAWCaynkoDqqhK8ULp20qZdxyx7XxDhxuDGSNpujb/pz4VkJuB25k14ax0?=
 =?us-ascii?Q?n5kz+Jh1j8kuWDKUDOD0sJvK36iHhpkpPNdXyvYV0y20TPGgjyjvCcWMDt4h?=
 =?us-ascii?Q?BsUHIto8VMqPcFAhLUZIsbl/keqT/ARd0VVTEY+HsFR6HxorxgrhHuGdipxk?=
 =?us-ascii?Q?d5Kl/eC3V/I40b44Fz0EGXPo45TUlVwaQnk1MGfUFzKKS2ejnZiYItaP/2U3?=
 =?us-ascii?Q?of4m+8QGNsoCPldvGssfaGSoJOJUz1xahm41Uh8ddCWhtkHAy9zItACjVzDf?=
 =?us-ascii?Q?IacVZz1arMxoZSSrG8OLRmp8E4TgU9zbUYlS26titinOaXUah9q6ROGHVa3Z?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VZ4lfr4MRzx7qzagiwdCVWMiD2IrK6vKEDZgTWM+rHLIVFHBsgPMUBS45T3cq4DzGr/OViZiAnFafAkNSAe5rmIPRsUgDgNtEHWcZCB7x18+T9OmUXLq/vZgpYPd8lJJeXylNexdOtxHiDk1oMpogL3dbyxJcL+ChdTCYeTnT4+X5Kaq+oQblUoSaSa6KIT12oAiW3vTu9YcyWf5NlM9WuoYWIuGZuvqMTIyaFGEBiEk7UudSBsH+TZ37rdOSzzFwEUNXUfRXNqqfmX8QNrZxr8c9LLPOksTxIsKKc8FxAfwgD8AapzOKBXb0vdzkCjqjGXNX3+DUnbizmO1ipKoFj+Pj2Ilu8hqwlelUnvAP9+qP0a0dXqliZYM8Hryjx/z3ViA/hOWA3LA9rIM7iW23xRAA4kHLaSA1Bqnd9y61RQhcweOAeNFKxUHryFj3HmLmbUM5ofZtLLFZ0sIQLTVsFiLj68k5ixCvT+WzPQKT655Ohr+mQgJK0AwIBT2UBq6DRDsHnTHYWQexj1pkmFIJOIu2aZjIPiJS3kMuI0XwLhpbTSAPTq/11hw6qMZPyvGJmfIbMIbYYFVBXbXMKDFtsIttc3ZqxLraQOIr4VwWSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f87c67-f638-466e-7837-08dd1c45ab1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 13:46:10.7303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxW8/U6B14Jjsn5y2lZwhY6ofRS/38NI0Z5jEnyyKZWoEHrwECwQz8AgZdfhoAVqiOLGGWOlvMcepVLRu1ESPkF6nb6fH3U69WisY6IgQdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_05,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140112
X-Proofpoint-GUID: 1Oqh_ytNV5pxRKI1eBZ1fujzkbwU7Xyw
X-Proofpoint-ORIG-GUID: 1Oqh_ytNV5pxRKI1eBZ1fujzkbwU7Xyw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's register a RAM block notifier and react on remap notifications.
Simply re-apply the settings. Exit if something goes wrong.

Note: qemu_ram_remap() will not remap when RAM_PREALLOC is set. Could be
that hostmem is still missing to update that flag ...

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: William Roche <william.roche@oracle.com>
---
 backends/hostmem.c       | 34 ++++++++++++++++++++++++++++++++++
 include/sysemu/hostmem.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index bf85d716e5..863f6da11d 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -361,11 +361,37 @@ static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
     backend->prealloc_threads = value;
 }
 
+static void host_memory_backend_ram_remapped(RAMBlockNotifier *n, void *host,
+                                             size_t offset, size_t size)
+{
+    HostMemoryBackend *backend = container_of(n, HostMemoryBackend,
+                                              ram_notifier);
+    Error *err = NULL;
+
+    if (!host_memory_backend_mr_inited(backend) ||
+        memory_region_get_ram_ptr(&backend->mr) != host) {
+        return;
+    }
+
+    host_memory_backend_apply_settings(backend, host + offset, size, &err);
+    if (err) {
+        /*
+         * If memory settings can't be successfully applied on remap,
+         * don't take the risk to continue without them.
+         */
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 static void host_memory_backend_init(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     MachineState *machine = MACHINE(qdev_get_machine());
 
+    backend->ram_notifier.ram_block_remapped = host_memory_backend_ram_remapped;
+    ram_block_notifier_add(&backend->ram_notifier);
+
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
@@ -379,6 +405,13 @@ static void host_memory_backend_post_init(Object *obj)
     object_apply_compat_props(obj);
 }
 
+static void host_memory_backend_finalize(Object *obj)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    ram_block_notifier_remove(&backend->ram_notifier);
+}
+
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
 {
     /*
@@ -595,6 +628,7 @@ static const TypeInfo host_memory_backend_info = {
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
     .instance_post_init = host_memory_backend_post_init,
+    .instance_finalize = host_memory_backend_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 67f45abe39..98309a9457 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -83,6 +83,7 @@ struct HostMemoryBackend {
     HostMemPolicy policy;
 
     MemoryRegion mr;
+    RAMBlockNotifier ram_notifier;
 };
 
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
-- 
2.43.5


