Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C59730AD
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 12:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxhp-00070F-Uy; Tue, 10 Sep 2024 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snxhl-0006mh-Uj; Tue, 10 Sep 2024 06:02:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1snxhk-0001mo-3w; Tue, 10 Sep 2024 06:02:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A9QV6t027615;
 Tue, 10 Sep 2024 10:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 corp-2023-11-20; bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=; b=
 iMZGZsiI7NapdkgKri/lyAeJnnhqZJKeDqUW7/xckH3XkYubnfMhnvsHIyowgvzJ
 Gyl8sMHb2AWR0XTlsJ+Pt0PArYStx9IWaXDBYMJ+tkzKbY5P4HmJbYfmkZ938QZi
 ilxwWZZrm6F7Z9oHxFGBeTPdMYPnvd+7UaV2D2a1OMgLC9UGruhN8TYort5Fr2nW
 UeEFFroodYXnJ4vA6BIiI9mstac2gsXh2KNMbjJZVmuchYskDWa6d8OAvDhxYAEH
 jOChk/+LE1Ro19docfHbq1glznanYXJLZW3IUoCvsnSFVc8N8YwGrT77KAc/F2fn
 0mEZjxac8t8/HvaVUCSzwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbumwkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 10:02:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48A8C1Hl033550; Tue, 10 Sep 2024 10:02:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd98bs0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2024 10:02:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnOC13hYghUl+f+BMW1CoqxSf3e0ndaAwCLnCF024+3nTznj465hLj71Siivcw6DJOHi6XhWVcZw8++Aq3c0J3S5Y09HgkNgjxoPp66j3tuooV4FSF1d8i69cYP7v4aUKvTe3X54wWvJ+ETrKg2yEKTRUBb/S6BFAa1JagxfuokKp8/C12lIdHxCh/Uf+3GwVKWxkKcikg9g9R8DPDdKUm5RgIy73eBgIPPPltD0DdOdEsjMUgRh6yZzlsXBlnLVgMOGyFo7hOiaQidwTdpuFsAIi1pi/+xzJYEgrPI7pXBxKGxbMdO5pLeYsxW54irMRqxDKavCJ0+sfa2w6ryJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=;
 b=ZMJB+zj+3mrfxRFqvHQzAL5UKopx8uTqzPAQ9gAsn1UzG6tlfgYEBaAksQv5MukTf+gX0qCHHUom9OsSrkLVRgM8B+zmhflt6gKuQmnb5UerE0a0IUXvlemZ4pGrKIn4wJoNS/6oCrMXc3t6IuEnRtdLH6RdUTXnWw8vG7DZ91x0Aal7TgzDWBv+9QqKD70iNkW9iXglZvZWZ4owKjcYUBwVPoZqcrhBsfpjR8KJo3WAl3itEJ88/Gnrt4mhX5VnMLZZPcmbASz9/hUTIKULlH55InsL+tMFsu27ErohvoKjzwTlD/AQa7ToI+IvtBocfcAxhfg80OdC9rQ6yrc5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0iQvauBKftLkn5wPQYkulRxXA4ngQtig5Bo3welgzw=;
 b=hSQ3n8OEysTratlYABDGG+y6SJ1sd+x0rQTPA4SYOgxfBphcq+koANfemhSEw8woZxbSI35JGAAp+F3iSd4MLoz/HLryOFtODvriCZ8QOFdfN9OGaHp1FIcgtEsD+5S85+Ko5DHiFDD9M7RFfPhVRxAvobhFkvNBDSM4UzePqIE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Tue, 10 Sep
 2024 10:02:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 10:02:30 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, william.roche@oracle.com,
 joao.m.martins@oracle.com
Subject: [RFC RESEND 5/6] system/hugetlb_ras: Handle madvise SIGBUS signal on
 listener
Date: Tue, 10 Sep 2024 10:02:15 +0000
Message-ID: <20240910100216.2744078-6-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100216.2744078-1-william.roche@oracle.com>
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f31a53-56f5-4e4d-b37b-08dcd17faea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8svcxqUkpXhwhPSdttr7t3dwEYmR+0qCE73OUXB8Uo14aQzukfWzoKABvwZ?=
 =?us-ascii?Q?lVu6yVajuk5Wwwu1XO3sOBKd8rX/FHjS/8z8b0Ai7cdbxhLUXjvlVCs2WDhu?=
 =?us-ascii?Q?pFAxGZAKGtuwvsTxo/6iZ7+LEZV+fd+aP6QWwy6dNa9ZAYvhPyk2jzxkaTIX?=
 =?us-ascii?Q?13n4i0sm2go6hTIskiUUO7ZueWfTRuj1C2eX90zKJ32RGbghqzmtVaMDBF0S?=
 =?us-ascii?Q?guutaw+8LicQfg3CJMVUg7Q+rBubKNzB/rIP9MPFpKRC7Q/OP2XfAzHT0jOT?=
 =?us-ascii?Q?kdIQaCgRlrboggHj7JOewTTTqFKiJM3IqUxyiN3znMsayn458xaZ97O4cGKy?=
 =?us-ascii?Q?RBGpvIvS0wyNc5xvGma2i9+ElnUhB+bnxIIxCt/sRirnS4RLMBZ/aACNSuoS?=
 =?us-ascii?Q?3Q5mSD7ZfLwA7RxxJY+8drDfxWe4eZZXtpIMxWumilUaazoqCKRx88VfWrr6?=
 =?us-ascii?Q?k4WIaXHB65Wf+XCqyRCd1U2zuDrKsvX1uMZLiIfqr9FblW9dGwKK1XmIGsuc?=
 =?us-ascii?Q?W3f2aSlzVToiaC/IrG0OVDphdbzA17Yp1CO+hyg/wFEdD7bslbQb1G0WftM2?=
 =?us-ascii?Q?pfZRAx6xxdURnN9yQWtlk2rjvJYF3b5II6/BPteJQgu6+GnDJn+anWadmmiJ?=
 =?us-ascii?Q?xA++6GoZSlD5jvsAj1btX0MQzndvqXdHZqHkdoTqnTPNRjQfgs4CPf0FMsM0?=
 =?us-ascii?Q?OTVVfeBMjsjW1MZaaYLDLoqf9rURTveFSA5+wNHPksEwB/UXgnPeYfRGDb0H?=
 =?us-ascii?Q?0da5QagusqFlNwQ6JDlGTy+qk6Frv3Y0jpzS2Zw4dHfdwLPA4D+JBcuSxvoY?=
 =?us-ascii?Q?YjyHVBEaub8pg4Jlxl+eVCZ7Oy/AqwtKD+YkErIW1NMfwokxyoSXo4efoHc6?=
 =?us-ascii?Q?gc8CpNI/kHW0xkxMN45Z5LMJhVSaqhjb0DCF4I0n6FrBb0QxjY95YHz7cSPk?=
 =?us-ascii?Q?O3Z1YMOqHqIMb3E9mP+nj17MerercBoC7KlJAyP/my8WdU98pee9EqUtjQL6?=
 =?us-ascii?Q?BnaF6MOQVSErnnDre46+R10ydO+ouBpfMUrhAwEo89/RlEAk+6B1cqzh4FW0?=
 =?us-ascii?Q?Fx4Gts7i3jlX0PqM9y09Q3k9PacO5c9bYO/FBCm3Q34cAzZ5BJWgaSagVK60?=
 =?us-ascii?Q?2FebTygveOLz6So/WVikfGpfPjRckdU109G9NRv9O3Y9dBCek1PPpFgWCUXv?=
 =?us-ascii?Q?xMk/u9FK+4F8R6muouTCKA3bcj8O0yxDKhVqvCCQ2ZdllbnfLfyyR/WURNB+?=
 =?us-ascii?Q?2pG63fCBvMc5qdOrXK8DjJFIngf0SOYWnkYg7Du5xK3h9EsSAqBnD9sWxryv?=
 =?us-ascii?Q?1EoMxR11/DobFM3gRtb9ka0WhZeW6+Y4BR6EtTIrYcwsiVzn+otpekhl54Ei?=
 =?us-ascii?Q?j1lsqB2RV0hxR/w9ImXFB/yNq0aM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqTei94JI2EucWBZwbTW49Ghm/i1wAAxWj3gqODofQFbCma1tEKPxVWJxyIc?=
 =?us-ascii?Q?x6qEhaeV/YvXRJQzSkcjHV0YEwQth4Eoht/Ajqcfk25LTVbjXwZKta56FgrD?=
 =?us-ascii?Q?eCPX2mSmQRYS1BkW8k12urW4OTiitMdSk/7g+cJ8Dc2ohpZ1cU/WkCHKtdmJ?=
 =?us-ascii?Q?9mAXVoa0PPt/ibKO1DChW16OgyO6Fj0duI0lGMaV1sMQdjLOAiko/OZqYPw8?=
 =?us-ascii?Q?xloD0T5gtkYG4qQSiErT+Tk4CLDvdPFlSTLawFiOf1WYA8Q+vPfmFQzatVA7?=
 =?us-ascii?Q?3vRGkMIgTSyfn7RHRBHlLWr5Z73HGuDrEhHMgD5eLQSws0JFB20SfkLaDX/q?=
 =?us-ascii?Q?/06mDTp89R8DF5839k2uPlmaX0u1MmY7jrlRQeAhWJeSel6kfwNDxkm+eZEO?=
 =?us-ascii?Q?pdG3KIHe4N+I95jmmcVxrNnxTm3N0iqgdej5s+XqrQjVZlDMttP/aeWJoB50?=
 =?us-ascii?Q?mhC/zgqtO2kmobTeLnt+96i1U0absd9gTgb5f9uVtBJeUX51SBl3jkGFT9lt?=
 =?us-ascii?Q?Sw7x+kJxid8VJqwTLtQ0LM3E35g8PwNIYYjlKWqgomE5Q0YnI8t4U+OJiPlq?=
 =?us-ascii?Q?69T0zjdcf5dJOePajXg1ogTLkvhmTd2HqUmEVLd7yjQbE+ZHEEbtHdh1dtVH?=
 =?us-ascii?Q?rOVmceVuNsCBycBtU/64ZqmgedgVF2OBufpwpDFGfCXRtVBMJB6F+g5/tfSp?=
 =?us-ascii?Q?VH7HVwLqTAfuI6Rs1xkhVPcePB9lru4b7LjCwRHv/MjmNyRfW2AGIXAeftPU?=
 =?us-ascii?Q?qicPH9tRbHdAG8Fi7ay4rwsUgEmKowfss7ki8aGTJL4doGxGGY17gdX/E7zG?=
 =?us-ascii?Q?bqEQaLWK9L5lEtSS7mzYNzdkJtBKAmYhXT/6R1Vg7Hf2H2xcxnQqb4s6TsvP?=
 =?us-ascii?Q?gxBEYx7Vb95zAmLOTPbrw6Hg6fQfO+KHa2nDbG+2VijH6SagSwLBrh+gT4XF?=
 =?us-ascii?Q?WwqQYCFlMbPZk1/Uyf2WuqHihT4UuZFZwFVlYMDxT61aMnq2TGGzivnsH70F?=
 =?us-ascii?Q?46XGAo1BdYehu7CvkgAHZsTxDddLijajbmilZn1HeFedIL2yi3XflplLxVU5?=
 =?us-ascii?Q?Psrrc6ipa2j51Jutqm67PWLZW+EO/T45tH/9oEayOLSjKlaDAu+fawqtwvVs?=
 =?us-ascii?Q?7xEbDJ9BcfADrLHFMpoKmndzAz471/mQ9j4wKR4X9ox86MJIOPmvcP4C0ja/?=
 =?us-ascii?Q?rM0NyOLRD0ADaZRz/7G6IB0wk6GgGfrTq/dO5tur97u3kHZJsHXExYaNiYJQ?=
 =?us-ascii?Q?n0/X7OiPZ8ysEGZVrVFdizSMd7aQR8itUGZ72+ql/2rerB32KoisaGCeUsa/?=
 =?us-ascii?Q?KaRnkXjRHCYLxrQ+rNDZFozbrh7Ri49qnDwtV01LdxmvyvInny1fgquivtb1?=
 =?us-ascii?Q?8EEqcLaBQG3xQwBq384Pj0GOvXs+vHJ9IpRPoM2orerO3xIqBoKWkLwHXQJl?=
 =?us-ascii?Q?MyP1wOKee/Hs9rrmIdUfp1kKrWBBMp7xok8isT6EMSZAOj1X1NSA9nR/eYvS?=
 =?us-ascii?Q?tuGBLEq+xdstitIvw4r1+YHlaWrLA+ns9enRgxRdBG0aolTiEns+HAxKhy0v?=
 =?us-ascii?Q?wNv4y5ECE5MCMzhJA2mG5oikh6LxpA8dkUbVufJfNWpa4Wazd37txoVn9e6h?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8W1niBl+CmOVxW2ZVUvoR+AlEU4bgyqzttw4W7HoVXZMlz4xd40DVo71dGhWesxUs9gDtHt/UaZIhGz2Ubsxp7c3tRCjQn/XoExxSKL2a7Uo9oovPEKtYCr6CMAOx9mevBfTAEtXCxzc2CmfxtmQYJAy/EKFELCPQLcRjJRQ9IgZLkg6hhJgEugBnbyHLpph2D6MooUs6qk0Uf5THeu4QjwMBSsd1EICpjQF5cEXU6kP7JWY8UaotH0w5HKKuygeu82luME2HuN26sHhzuHoDekd7Qkmvh+7rTcxlMsVtJKMFWGw4KGH2etAKfOCOocUMvvISnBHXLn2whR/eTXlwM+e8s4YM63v6IgzqFAHKOaokhsEVZ2OxcctI0/GnwyCG+ArLsGtI5cWE7rY1DsOVWWjA4Q6tvcAUKq2LJy7iNxBO6rzZ86X7Gh098M2oSsBH1o0N3ok67/oMeFZIfvlwsRyD982URtKSiaCEIYawo3C/DQaMBcfNyjISHxRDAgOdh21gl4y6AAhcj9/CeIxgn2tQLYjyOhPdu06WfnCa7Lfdu5vFufW8Z6uMoVKNn9QRVs03ipg7RImWXG8CKkOFJyW2m9DW1iwhC1hzWBfpYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f31a53-56f5-4e4d-b37b-08dcd17faea4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 10:02:30.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkJ0cV1j/2jousaO/Tgm2VY4y1m9n3jhdDK9PuAkTSducDfnjhS0b2fIkfOe5EHrp2Hy3eM9oxspu4XkfONAKF/lWUKGKSV/4hkwegnavyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100075
X-Proofpoint-GUID: gsE44U6I7-Iqo4XMil3OPa1l_RjgpF29
X-Proofpoint-ORIG-GUID: gsE44U6I7-Iqo4XMil3OPa1l_RjgpF29
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: William Roche <william.roche@oracle.com>

madvise MADV_HWPOISON can generate a SIGBUS when called, so the listener
thread (the caller) needs to deal with this signal.
The signal handler recognizes a thread specific variable allowing it to
directly exit when generated from this thread.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/cpus.c          |  9 +++++++++
 system/hugetlbfs_ras.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 system/hugetlbfs_ras.h |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 12e630f760..642055f729 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -47,6 +47,10 @@
 #include "hw/hw.h"
 #include "trace.h"
 
+#ifdef CONFIG_HUGETLBFS_RAS
+#include "system/hugetlbfs_ras.h"
+#endif
+
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -374,6 +378,11 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
         sigbus_reraise();
     }
 
+#ifdef CONFIG_HUGETLBFS_RAS
+    /* skip error on the listener thread - does not return in this case */
+    hugetlbfs_ras_signal_from_listener();
+#endif
+
     if (current_cpu) {
         /* Called asynchronously in VCPU thread.  */
         if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
diff --git a/system/hugetlbfs_ras.c b/system/hugetlbfs_ras.c
index 2f7e550f56..90e399bbad 100644
--- a/system/hugetlbfs_ras.c
+++ b/system/hugetlbfs_ras.c
@@ -70,6 +70,8 @@ static QemuCond large_hwpoison_vm_running;
 static QemuMutex large_hwpoison_mtx;
 static QemuThread thread;
 static void *hugetlbfs_ras_listener(void *arg);
+static pthread_key_t id_key;
+static sigjmp_buf listener_jmp_buf;
 static int vm_running;
 static bool hugetlbfs_ras_initialized;
 static int _PAGE_SIZE = 4096;
@@ -105,6 +107,10 @@ hugetlbfs_ras_init(void)
     qemu_cond_init(&large_hwpoison_vm_running);
     qemu_mutex_init(&large_hwpoison_mtx);
 
+    if (pthread_key_create(&id_key, NULL) != 0) {
+        warn_report("No support for hugetlbfs largepage errors - no id_key");
+        return -EIO;
+    }
     qemu_thread_create(&thread, "hugetlbfs_error", hugetlbfs_ras_listener,
                        NULL, QEMU_THREAD_DETACHED);
 
@@ -288,6 +294,19 @@ hugetlbfs_ras_correct(void **paddr, size_t *psz, int code)
     return (*paddr == NULL ? false : true);
 }
 
+/* this madvise can generate a SIGBUS, use the jump buffer to deal with it */
+static bool poison_location(void *addr, int size)
+{
+    if (sigsetjmp(listener_jmp_buf, 1) == 0) {
+        if (madvise(addr, size, MADV_HWPOISON)) {
+            DPRINTF("poison injection failed: %s (addr:%p sz:%d)\n",
+                    strerror(errno), addr, size);
+            return false;
+        }
+    }
+    return true;
+}
+
 /*
  * Sequentially read the valid data from the failed large page (shared) backend
  * file and copy that into our set of standard sized pages.
@@ -321,7 +340,7 @@ static int take_valid_data_lpg(LargeHWPoisonPage *page, const char **err)
     slot_num = page->page_size / ps;
 
     if (!qemu_ram_is_shared(rb)) { /* we can't use the backend file */
-        if (madvise(page->page_addr, page->page_size, MADV_HWPOISON) == 0) {
+        if (poison_location(page->page_addr, page->page_size)) {
             page->first_poison = page->page_addr;
             warn_report("Large memory error, unrecoverable section "
                 "(unshared hugetlbfs): start:%p length: %ld",
@@ -350,7 +369,7 @@ static int take_valid_data_lpg(LargeHWPoisonPage *page, const char **err)
             retrieved += count;
         }
         if (retrieved < ps) { /* consider this page as poisoned */
-            if (madvise(page->page_addr + i * ps, ps, MADV_HWPOISON)) {
+            if (!poison_location(page->page_addr + i * ps, ps)) {
                 if (err) {
                     *err = "poison injection failed";
                 }
@@ -402,6 +421,19 @@ void hugetlbfs_ras_empty(void)
     qemu_mutex_unlock(&large_hwpoison_mtx);
 }
 
+/*
+ * Check if the signal is taken from the listener thread,
+ * in this thread we don't return as we jump after the madvise call.
+ */
+void
+hugetlbfs_ras_signal_from_listener(void)
+{
+    /* check if we take the SIGBUS in the listener */
+    if (pthread_getspecific(id_key) != NULL) {
+        siglongjmp(listener_jmp_buf, 1);
+    }
+}
+
 /*
  * Deal with the given page, initializing its data.
  */
@@ -498,6 +530,13 @@ hugetlbfs_ras_listener(void *arg)
     LargeHWPoisonPage *page;
     int new;
     const char *err;
+    sigset_t set;
+
+    pthread_setspecific(id_key, (void *)1);
+    /* unblock SIGBUS */
+    sigemptyset(&set);
+    sigaddset(&set, SIGBUS);
+    pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 
     /* monitor any newly submitted element in the list */
     qemu_mutex_lock(&large_hwpoison_mtx);
diff --git a/system/hugetlbfs_ras.h b/system/hugetlbfs_ras.h
index 324228bda3..9c2a6e49a1 100644
--- a/system/hugetlbfs_ras.h
+++ b/system/hugetlbfs_ras.h
@@ -1,3 +1,4 @@
 bool hugetlbfs_ras_use(void);
 bool hugetlbfs_ras_correct(void **paddr, size_t *psz, int code);
 void hugetlbfs_ras_empty(void);
+void hugetlbfs_ras_signal_from_listener(void);
-- 
2.43.5


