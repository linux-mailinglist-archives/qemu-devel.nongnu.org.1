Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B809730AC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 12:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxhj-0006bI-HA; Tue, 10 Sep 2024 06:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snxhg-0006SO-OB; Tue, 10 Sep 2024 06:02:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snxhf-0001lS-2I; Tue, 10 Sep 2024 06:02:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A9QdQO026829;
 Tue, 10 Sep 2024 10:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=; b=
 Uu13LZMvKHtaK3nzsvEDgu0yPOV13cFrxkFFtSyqUDE820if5UdPew2eMf8IZ8LN
 ndUh0C5ndzTGkB8li3EF0X2KRJEcuLsCYaQ4d9mPX+sEIBGuxHfKExY4FXWK+xGW
 nkfysFm1xN/hg0c0mmVqAncbjprvQkTTpF4DmlcXsNU49PHJSLA3s3AGO59Ol0C0
 Cl1o6bPsLiNkbcXOpcfUhSBNLVVoW+wBYv6G50/U8d9UFF61H5B26HW7AKboudok
 /MS9sS7c9P7HXLRU/XXzo/X6+C+k+S8+Zxl3JVklfuT3x9gWzbmBigLTK+DxfnYb
 2kaXJz1/VYod9uQ4Ieb1Yg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8cw2sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 10:02:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A81g0Q004160; Tue, 10 Sep 2024 10:02:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd98baar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 10:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MetVgO9suJylxZ+gMPpG/8Cgdyv61L6YzWCJXPob+pI/CNTsSU8o4XmcOjt7qGC76ZOen+SMjVuzJhIdo3KG21jWsUmULqgAtt1KUTW7KziQACTdM3+pIyouUlW1ZgWLyDcqoghqA7dIr0/xSNkQFw5Ltpp87giFq5LiKMmSlWQOfHILcddjgjgGJaimqADQr8DieIU/f2iJSCPityaTHiwXMF+YZ5BzR9QLmigXz8Rd4gZ/b1IyUWK0y5ITDzUSCC7QjdmR10KLalMfPHYkRdEN3I6aIGuUFABa9N9QRMfLkFJAiGY2QWyN275UTmeWvsk3UWki3D8shn1LlGFnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=;
 b=SxK0OA+OGOF5dKmgYC/robj+K4FMtCfl75qgIOAYbgnbaGItLSP4APQgte0yt6RiROZyZFOUAzdZbmc36FNM3wWPJFuCUCzX9rJxQpJBIoQPSwOBko7qeqcIrq2Z/g/xWptECS53AqXAV3YD7QiVVsarVPbnQ05mX51mQrTvaVXyd2J8FdVSEDFwUEeIxqUbW1R9wvDTdIPxjQgg+GPqGdtl4xEotEygNZ/JAv+eEGrVZBM4foyU/+yVo9TXZafxQsvMVpJlcalwGUrbw6i8oHLzIygdaF7MALCWxrMPbJAMH3NPVCV9klU040cRkTupxtsf86hsv0la82kazVJ0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUpJfFkmzvcResM42CgeM3OXvVIAkS6DqN2a6mWjScg=;
 b=DClR3H3IfrAupamFBrGTF8+n42woFonEJaywJGbPDImF2RF1wULqETJpe3hF8IQ8YLg7fsXLQfr4OafFJuR/4ixxr2XOnTdWcgHtpbrsOkHQoDH3rcgeqrE3CGfNmaVyyD87DA8dQgBG9Qaw+qFspn4hkzgkay3QBow88yILgR0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Tue, 10 Sep
 2024 10:02:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 10:02:25 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, william.roche@oracle.com,
 joao.m.martins@oracle.com
Subject: [RFC RESEND 3/6] system/physmem: Remap memory pages on reset based on
 the page size
Date: Tue, 10 Sep 2024 10:02:13 +0000
Message-ID: <20240910100216.2744078-4-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100216.2744078-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0681714c-bd8d-4489-2358-08dcd17fabfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Eok5j0TODBnwoIMXf9qhAuTqtVbQLy/E3CC4pjf/PtHAymu/CfV2hsCNYZ5q?=
 =?us-ascii?Q?SBygs0mfl03C/aQFfZGFr22+YHh80D1FoqCnxUO8zuHE56EBSO3fE6UvJrYF?=
 =?us-ascii?Q?zHHSyVfEXaKuVNQ635aK+U9WxjmnuogTRXWuKTbylQ+P2+cEUnzY90yCrudu?=
 =?us-ascii?Q?E39qC8D6ycLe11fIwueRBt3cbs/hzV96tBfSZ3MHYm6c/2pl61gCXW+ZyUuS?=
 =?us-ascii?Q?ap7XxnWGds3GQkXzeAFr8o5w28YwkT1f2wpPZ3vE+cXWlhSek8AJfoyV7WmM?=
 =?us-ascii?Q?sfsmVn1Fdckk0wynmY/hW/AC4iMubPyssO4cLRNQfqvQKks389QwJSWJQuks?=
 =?us-ascii?Q?h9Tj9C96DVABNc0+9OMg2z8IjbpopLhOB6dKAhsbx3vlGgc6VtTNEGUNZ/BL?=
 =?us-ascii?Q?2M4zApPecQhvfZrAAsJBubAu3VhUPdrh1q1sY9gNjEFjyr8IuVPPvFWJBvIh?=
 =?us-ascii?Q?/u7uauerxSQ7Ce0d8FPWZJiNmOYt1lCZvZdV6WdFoUPBp1naqzPCAykv23bo?=
 =?us-ascii?Q?67J3iCEq264xgT+ZA/Jwn4jbvClo4vyRNYmWKRfz9TBjIujfcgun7hMxSZNj?=
 =?us-ascii?Q?lxN91849qHv86hpFU71OY2wmb2v4neakQygWYVV/UQ3qtcWFfS7bCnOg8JIY?=
 =?us-ascii?Q?FGo9Mr3IM0ahxlpdskma2q3noy8glzYOwLYM+oP+gNWztH1NY94EbxXr8s2s?=
 =?us-ascii?Q?zuX1A7GHtAdu1eaiHkvQLUg3oERmhh5hfw+CmADPqwYQb/VtfYxhXfXsVV05?=
 =?us-ascii?Q?pMI0QelyLy4M2VvsOhfmIxkyzs1u+FxVhigFMKYoU0Rf6H6zoevakX/gmMld?=
 =?us-ascii?Q?xsYBso169QYcXxo6PfTM1GW5j5K+AO85igqy/PfczUxYPB5cpjUcxW5MAwPn?=
 =?us-ascii?Q?se6eTUYFtZvhYkfyGn4tmYkau6ojfuy6ebeGCfHaieFdLScGD6YW/Ue/RhkJ?=
 =?us-ascii?Q?+JD+2B1kidANWAPX4pQnJUi4jyH5QGFVQJqNoeeVRTwFIce2TY6uhtRs/CLz?=
 =?us-ascii?Q?VJOjNzcr8qy06HhykNE9mGRkfGrTEptP+7t7UxpGMY5g8MHySCgtCiCvUO9H?=
 =?us-ascii?Q?T2ixL7sNixlxotm67Qzzmwa2GC//L/WdGpDkTFnNsk7spyO5ezzQlOIGs2GR?=
 =?us-ascii?Q?w5BbokYCIlBIfwQQWhLx8fKyLcACvsmZWNDAoOTlk/UeUOfeaC2/bpujmpMG?=
 =?us-ascii?Q?SVkouSl8+gEZsVtkc3lwOxvqR8BZuSaWtdrvHEferq5d+hS3uYiisUDxYyC1?=
 =?us-ascii?Q?HcADBDGTPwBRcAFcZA8yyGfGXUjTu/ikMagjfXvT0gC6xcTCivpSczd8PpwQ?=
 =?us-ascii?Q?5EI5GhitM6GsdEiDg4Ba9X43TEJo2EZH4KWvDcf8ic8KEqCEcMzsM2wFXdLW?=
 =?us-ascii?Q?9odxx23InQLqoqQ6kgnqsmF89Ca6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ahHWp/WiwzMSBSTMzHoV4XMooKu9wal1N6uXBZp6KMhCbkBDujwM/KKhJGA?=
 =?us-ascii?Q?HHR/hV4nn5JO99iOVouNy4xWI87RcTqV25srLLCS16NQlWtEhkgnlAqyHU6W?=
 =?us-ascii?Q?Dh1IULeWnRsziYpdQCQqQ+V2GHNuCFee5/XRxeP+i/2yxm6JyGeg/JQwioEO?=
 =?us-ascii?Q?iNCKetsi8Ot2l8u56sgUbIrVLavy8/I8qGEhzJXhoG79SAzzUxWqjkMCRRjk?=
 =?us-ascii?Q?f9mF8z7NircPxPUVkz3K9j0MyjtwgpIOmW8hvQEJTEcW9/RvNzKzJEBqu8gP?=
 =?us-ascii?Q?c+wEkEnJKgkHspGbTdZL4xAma0f5AgGAKYw/08bjS+E/RgUSLQ2OCtASVvCe?=
 =?us-ascii?Q?CJL41jsbCXSjuOnC3Atm7NA3S5408lUI3w/vUpK0PoHc0+DZoRaWY3YYrAhP?=
 =?us-ascii?Q?nR4XIpHqMfL8ijVKoT4zjiWbyYVkG51TFhiUni9xI9MWsuc3AVwARLvSTehk?=
 =?us-ascii?Q?15+BqTqjW3zSuxNto5qMcky5BPISVGOIH/dSH/H5jMt50Lxh+2okiR467/Y1?=
 =?us-ascii?Q?LKiz5pOeDoWgwwl8UOFVV3TESxsyfy7CJf6Zsl58IeaJUjqk6NQU11Ms4OnC?=
 =?us-ascii?Q?NUr980vQI0YnZFbYsXh0uyeJPmhmEZwgdGybZLixANGgl4S2UIz3FPZK+Vld?=
 =?us-ascii?Q?7f5FA0ft4RJcJ6pV22/XqLZjkvvG8xeSpT+mVKzFigA/tJtR5lrZsC2r8gAn?=
 =?us-ascii?Q?WOILRRpTbHnkaApOKfDqMQ2sfcpDFNfiYsnh7aaRv+0d3wR263gIHaCZgZsv?=
 =?us-ascii?Q?JH67fhJIHong5b10gwFOMPpksyFk3i5uGJgrbKTSZJ6WmjWXIszGu/uCed2Z?=
 =?us-ascii?Q?MdR2QWNFbxV7qLs60z4gFaP5RKnWUzLqyknK1uLq3lALZm8YZW/6qiNQXhl7?=
 =?us-ascii?Q?RHfmpiO+XMOz9Ol0QRkvOTsLxsQJGiUVEIQJJN5pvDlu1fcUsrAvOXvIFh++?=
 =?us-ascii?Q?9d47Vg6LmD/mhBPU7kHzcT9QTw9NrXqS8cXjjgfdV8wA6q5Yhr+doMuDHGMc?=
 =?us-ascii?Q?Z2hIocVRD4qvmOlIRr3J5AbIl03aCxgO1co5WAWW+9PYUDzodBdAft3CM78s?=
 =?us-ascii?Q?MZJoYZx0avsFQW2+xCqRplBs3Qm81Hl8EEjyTgo35YJe1U6+a7Qzh/O98Rnb?=
 =?us-ascii?Q?/AAKoDr/jSceJLQ0kGoUvhyNVud9wWL0tKucuaSOlImExlFNQCOrDMB1br2A?=
 =?us-ascii?Q?QCR/MZUM0GIqcPUtrjbKsZez1atp1Xwpu9d3BbOpf6bhRddDtkgllnhQrpaA?=
 =?us-ascii?Q?d0uBG8sc9ZxBvEnvGWBnSmg2oD8cqdgncsA5KLaKOxa38sNYWal3XLW6LGJv?=
 =?us-ascii?Q?UTgDmkKwgQGCbXCCgV1lbZQaqtpvgByKLC7LRkL82Tn1cL7Q6n8vCIw4T5FR?=
 =?us-ascii?Q?WnlSR7MwZi93LmfPu1kL+yD2GYkgmsMV7AG8LzxGq0LKMZK5M9G0pe2/iMYk?=
 =?us-ascii?Q?bBDDffmGg1YAeLz9mW4VlvF/5nHVVk1FDh0E36peJ+EaJYpiS/mhHnlZCVwP?=
 =?us-ascii?Q?8oruLGN1xGfGEJpbe1DJ6XL7KPM4VThxysoKiGq05ZhUs3o04bFrvYHuWb9/?=
 =?us-ascii?Q?38P7WocmWyBcdIUBSur9o14vOgjK3Em2yTlzMMK+vBmKno/326FQ5NSwyOq4?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xa8bd83GwAEdQLAyoEt4bd2WrzMtDzjIDnzXBZRyuWa7p1BD25oj3bNiF6df+3bXiBNjHH8rEjyJ4I4EWsBRAY42mJQjWrx7qE+q4xEe7Z/ysi7xVDDLo2qz1SvIzf3ZgyPdzkoK+H5CAFTdefNliYk8jrLpwwPsLFOLDRpSy+4heHxZUPQcKiIIXlCBawYwmAsBuVVejnErGYFapxk8PLyB1etkukvqpNGh/Lsr8EFkuLu8gvtOajdmCLxiolqDigNZnq8R7hSzT00NMdZY5gx9fsphYPEh+UnAFEmt8i6Rm+AUSSUPaCREdqwRPq5+nGUc07754IV4otr6MGoeMXNn70piV9r7+zSz0F4BX/ruFp6m0avQRYsqYN4WQ9XjUBbpcsGHKIpfe2WkqscytWlh9o8OTHv5ZMi1fSh3mOOHM2Mw3G4G1B5RAhtlJGYqEnhSIO68sTPKgAgNXmekrjQwP0M4+YBYhqYd70Xui/TwrrJPsvoWXmn59hV9hM4HgZv2Ziepy6mVlIfKvT3ryJ9FrmfBaRnFOs+VTwV/fVJYRfc9i/qob58/yeoPDfz9mtqV/9OY8oMQwCMSC0dWXqBi+91B85yuH7+eCMdncVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0681714c-bd8d-4489-2358-08dcd17fabfe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 10:02:25.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc1FS/YsiEZzQqsWZur8GveaszjgeC3LebMAzQfkCcmKywG28g5aW4Zkfp8GDrW6hhUDxc6TbGLGMTwVFH9OwxUzeoP9TiDW8+KJAnZa8Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100075
X-Proofpoint-ORIG-GUID: rnmyGKondh9D7gNtCMS5PnbJJkCmYxPM
X-Proofpoint-GUID: rnmyGKondh9D7gNtCMS5PnbJJkCmYxPM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

From: William Roche <william.roche@oracle.com>

When the VM reboots, a memory reset is performed calling
qemu_ram_remap() on all hwpoisoned pages.
We take into account the recorded page size to adjust the
size and location of the memory hole.
In case of a largepage used, we also need to punch a hole
in the backend file to regenerate a usable memory, cleaning
the HW poisoned section.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 94600a33ec..5c176146c0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2195,6 +2195,11 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
     RAMBLOCK_FOREACH(block) {
         offset = addr - block->offset;
         if (offset < block->max_length) {
+            /* addr could be a subpage of a former large page */
+            if (length < block->page_size) {
+                offset = ROUND_DOWN(offset, block->page_size);
+                length = block->page_size;
+            }
             vaddr = ramblock_ptr(block, offset);
             if (block->flags & RAM_PREALLOC) {
                 ;
@@ -2208,6 +2213,14 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 prot = PROT_READ;
                 prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
                 if (block->fd >= 0) {
+                    if (length > TARGET_PAGE_SIZE && fallocate(block->fd,
+                        FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+                        offset + block->fd_offset, length) != 0) {
+                        error_report("Could not recreate the file hole for "
+                                     "addr: " RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
+                                     length, addr);
+                        exit(1);
+                    }
                     area = mmap(vaddr, length, prot, flags, block->fd,
                                 offset + block->fd_offset);
                 } else {
-- 
2.43.5


