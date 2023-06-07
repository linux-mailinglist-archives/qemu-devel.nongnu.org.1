Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C7726550
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vYv-0006Bx-NA; Wed, 07 Jun 2023 11:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6vYt-0006Ba-NT
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:59:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6vYr-0005FN-El
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:59:03 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EaDMk019401; Wed, 7 Jun 2023 15:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3+YmBfyZ2QV6EajgEPxFXCU+TdtHsj4Rxs4YxE3X/lo=;
 b=Wb+EBsDMSER8urFKHao6BiBgXmSBEYsz7iWgI/coRhqrEc9nM9GBkhEBix2qW2brsWc0
 VM4RycEwDDDiR5m2uGHF6Jp3R7I+rS0gu6AuCC6y1fxOIq2UJWm4cC2WavAFo7ILSwzf
 ijuXSO4X1hM5W7UMKVTMfLTLVfwypAgY+2PKXXM0+nGI6sJpbJRNjiwMkJ5whtOd1MrR
 LcEWI4/Xb9a2xfkbm6kY1VVwQHrmDAvQVh2GnTv+kIxNPP7mqw3Qj2zIvZZ9/XMTrbew
 53SX38zI39Xj+NzEQYWBE4HdJ6qcBouJKrM0oszs7JaN/XcAZKckfxQgIvOgB1iEfR2e hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sj61x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:58:59 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357EfAfT010438; Wed, 7 Jun 2023 15:58:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6qq81s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQbAoKjhY8m9T3hs+TD5USh/76ZXXoQb5KhQZ17fU89sp5upWygW3jFXEnKLHx9whz5y3wLAmqUxTwyxkkmdGUAT0KWQr0GwndlmiiXLGU038N4Ut+uA0upkyrVf0l2SdIF71Wwv8bm2GgjLn3mYc9v8SWExbva5povye5BwoI58+CJIHuRirJDBxIrVjU4GAWEzlwahp3cGFbxiJUzezorL3c7HenI6YKi/uM5/39UkbJcuSvcYvOpxHJNNOzPxQPQPF1rlUqYCQow0cCF/BYQWUNv2j243l5eal6tDeu5bOX4lDK4f6jzzWXWhp/4RGWShyPkDwc40HQvVUO6JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+YmBfyZ2QV6EajgEPxFXCU+TdtHsj4Rxs4YxE3X/lo=;
 b=ABtiRqLuDuwq0vXtwpInV7ht0VR0xftbNg4R3Q8dy8ypA1wTX4Ms/f3ZsPmWFe+2D6BssCqym+C63xLYXX/Ndd8ZPZKa2KDf/WOWroEDumN3n805TucRQv8XpHigheHpPV+Y9/MUXo0E7ZQFd0CiuQaAfHEGdLfzHVbSkpuIr38Z8h5TtDeWaGq3JAIxK9Bj473CO0Ta4SZ8r/2YcEfPwN1yPZL1cnYpAER4zkyUkFJIIGMt4Gomb9yZK7XPb4NGrVWkpPHkEsC8Km3oUWN+cC8Oga8HiyQv3BygmvN0U5hzWhkRgtCBFlhRkq0fSujMSwcc12rAyqsSFtMsCULFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+YmBfyZ2QV6EajgEPxFXCU+TdtHsj4Rxs4YxE3X/lo=;
 b=cNWXrjtHRk/ewhjg5vclYj8WPnFVcKTw+hhIy+LVYMajLqvkNF8EIItBL7wmIXGxKw5+qeSPhPzGL+1dOlheK5T6LZ7hOCA/WjVNrXvCGTN4pusIQqWu2BlI4ghdf1PXX1NsEeAJaBQ3iV7y85AINE+f35g8Db09/uSy5MscvbU=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 15:58:56 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:58:56 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, elena.ufimtseva@oracle.com, kanth.ghatraju@oracle.com, 
 karl.heubaum@oracle.com
Subject: [PATCH 1/1] maintainers: update maintainers list for vfio-user &
 multi-process QEMU
Date: Wed,  7 Jun 2023 15:58:51 +0000
Message-Id: <03122dc6dc27f93a674991ef64874170fe8d1a4b.1686153256.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1686153256.git.jag.raman@oracle.com>
References: <cover.1686153256.git.jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::26) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: ca985a5f-bcef-4957-a608-08db6770193d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRMpSokKC2HKgJufKMWIDeXoF4PuuBexS2Cj1B23FmL28ontKP3gIpZETuyR0rAdd9ZUkzj4yXBWcz5fSKeyzUI1a8/9rWaxl81456M2BTWf+qVPaPPUV7z14ep0vT+QMUboBkFsd5XbeUIwTrpH7HNM6a35GbHhGfp29uRDO0R1tDyqiWSDtBtQGD78s18QlAAOeN7XST/fFcyyRoaP9XrH6hbL9nC07ldxfR1pozhdVBsxwpgjcIdKYCyekDqhSumHVQSsqdNReBbBDNGVv5iwGDjo3VoqbE/BU5rwSiNS4vw0QbI4DgiMQg/97ysOxCDx40dti3xFhcY7pgJb+Lz2RU8pKjHoUUD8WwRrFQDncs+9szxEgFeajYd0mEeqtv8po0ij0tY5YqseLly++1bLv47k41HuzCWiNo+q94c5RfLqd5iR56DanLIVzq/E/7jSGGg0E4awXMvVt4u6UK6tDmSkohbK7Jux98YqDAGpU2qPuNH7mHgaZmKNtWzqzI+immETRbhUa8XGbNfD81xR9B/sGl70pEAjUNtT1H5qP4VwKnrGXUMWXoZMjGvx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(2906002)(4744005)(36756003)(38100700002)(86362001)(5660300002)(186003)(66556008)(478600001)(6666004)(6486002)(8936002)(6916009)(66476007)(316002)(66946007)(41300700001)(4326008)(8676002)(83380400001)(2616005)(6506007)(107886003)(26005)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75CQhYp8I0e/EGZ2w3g1cyl8CqGhnQZ/XRq8Z8wX7rFUhpb/xR8g+m6OR3q1?=
 =?us-ascii?Q?HO+e2n6rbc2EVOzquVufOwjagFxyY/7Q7kXUDROEyrNrynZF+zfXR/m9QKXg?=
 =?us-ascii?Q?oYNGwizgJZ5BBQgolSFcFZ6apZ2pFf7TGBh3X8cduqTsUti9v3gwJQBHgOjw?=
 =?us-ascii?Q?Fd72DgeV1WYUXek0xI+OxSJXEXXiZhCaMOcYaYier9lb99SDhqnarcLO6yuD?=
 =?us-ascii?Q?oG1rIdXdY6ygIajDYwJTeOrCeZ1o3Duokz6OM2jouT40MHXMSBzqFKaJTAGM?=
 =?us-ascii?Q?IVjVzfJhI7vpDKc6h8tsxx0S/HuotAJJhjpDGDAyoQ3ozkEsEtYLXsDGdn+r?=
 =?us-ascii?Q?A9I/eBlxdlc0xgPb6TdMMn9IDnsz6cR5x8gYpwz7b7RpvTefd/HdMj9XXMBo?=
 =?us-ascii?Q?Cu6Hh3Z633i8Cs27HT5/BNSc+IzUsHjVYX2Fxv1BeFJrHtlQrELYeV5FHTZb?=
 =?us-ascii?Q?axtpxERLHrkKiCdFbrQnVs1mVfXjpwUdcjFS5oN4N4DGqUH4EHmTxoN1M5wy?=
 =?us-ascii?Q?YH+6ioRNAnGoFC7IjuWbPHUcT+CHdonaqH+xZqScU+0W9BiUr5I7eKaqXRJU?=
 =?us-ascii?Q?T+LOMrv7r/dykbxKehdd0Yy4gQuseISyPkDSd7KLhSEqsolnlf/T6zX0fRcW?=
 =?us-ascii?Q?ZK8H92nrNCKNd8mrNhxcNqIpgZYwrWDAz9j0kj2GHxUjt32AdfwiCzmwO9Uj?=
 =?us-ascii?Q?MqRcuESqDIZd4gQaGGXMycxRBfXZJY+IYVGvsQf1hE5lqCPcvgzNkl0tS6kZ?=
 =?us-ascii?Q?XG6KWQ6v27Ip+TxqyI7BuAg8JBj0uQE8zWc9Uy+OczEvIL2xYhHgjwXT7ffY?=
 =?us-ascii?Q?kHGYGNPv0RsFeWgo4LvlkjZ6mRyY1OpKRLsUyMFt73Sp6TqIaAWPunlV6Ozb?=
 =?us-ascii?Q?pqRUKsLzQnZP1r4zwQy9AAFI1yCeLmMjE6FXXuBYNSVKSEJ7vUqmTsLoIgf9?=
 =?us-ascii?Q?PXyQOLojNbFFjytAqcpfHGUFaHWt8XUcjifoPVVFZbOoPPHW3KYkZILq0wZo?=
 =?us-ascii?Q?ZVMh1bscUYwf4Dmnisx60gIVaNtYrmosYz5Z63X7nIGwr+FAo/sUNScokhw3?=
 =?us-ascii?Q?jKN/L6tcK9KsuvcptkzgTxSOnp7y+8p51aK4vsA6InTt0AtsGOzZXdn4TO3h?=
 =?us-ascii?Q?xERwww8+2OJRoy5wIHkRc0w8b4uf/80CYZ4epBtRLm/orHgYzP5Z+o23uSVE?=
 =?us-ascii?Q?j/IQJYhVZ+RkPYczOyuXkJMq7MB0IMhPxB2SvjSLqCzLTxMg0yPR0BkyRrHf?=
 =?us-ascii?Q?ehxtk/afrivLO+hrpO5Zn2xb8ITz5JRHpCPthD44+5Sx2Z7AxqWYlGI+TkdO?=
 =?us-ascii?Q?+FLqVJzZPdqSha8HI1WXoo/IU4SM+UmQ/CDyVtyIqYSH4nJWpKwO5spX3EvU?=
 =?us-ascii?Q?gwcLEuK5Fd3geTsCrCckekbifLTxv8FyY+j7EZqkARABmkSOatF4nv0KUoKv?=
 =?us-ascii?Q?ZdVNDMlAd00aBVZWx0RWSHfG7wHmxp1GMJBIzDc+gmkimvRMElsTPgwOGDTo?=
 =?us-ascii?Q?xkXDizNB1KdMGX6TTtsdGJ2krN+g85O/T0yfQDJuohCWqaKyF2F+U5fPmIi/?=
 =?us-ascii?Q?ypNvKXtz3Tb80t9JVoC7LHHD8th/QzUN6ITpkY3K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lidyRV9S9LN6ZVACEtgHDqduZviL5RYbrKA4sXxSOU2b1oDm1DTlzYT1QhaG7vCB0PxVbfncXA5DIU151qWr8ecw/vYkL+tQaLs/2zvRWqyQXNES9l5Z74LZVDpqmqbdYVXJNa7ce/zPVc21HifndHycMhU4ma+GrwFRTgfHVbrw00jYZHwCsSdBE5hynvA9ACgCrCYtlEdZN4NLbOdxU08+Wf3Bg/Vs4+QhFLHf6yB8Qpe0q3naCN2Ovb31tJZ3E/2mEywR35GonJsH5KtkWtV2E9JHpy8o4Egg8cA1ZQywuMhE4nR4SP4SKXjwF2tXXb2NV5zd2/tQjq5MV20z/ZiohmPKPfDf8cBYdnu2l0d+UfK+ugHZkfBCL63kz3WDpXOarCgDdLaLPnvASEKZLUmHgM4HJRqxyRP6HSlkHTldmzfhAAt/RYgso+soQ0/bZDLc1ohfDFwpe3nSwfo1zoFLC69FeFZITyZq8y4wRR15QD6mmOaBldYNDgEmUkkS3AlbpHF84ACopnBrq//I0irI1pvfO1tl06EAiHK0C0vTuMeR168k2sQ+WR1Z8jqzkqHJHXk4jJz08TK4Ht1CGe2nG8LC2vrc7OKsSffWCzzSsKgf1QJK/WSXeSet11qvH84OVW7lm9IuOlohBchTn62k9RRbeNVQipPJxK9JjHe6YH7UsicmgsEmm07Aop66uQS2O0tMKtaH5xgJFNiivJrF+HEfDZ3c3ud39ZVmhO/pSK4kBpOxwTax5glGOASANHjY9uCJqK8cWRUOoq9ioA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca985a5f-bcef-4957-a608-08db6770193d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:58:56.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIzUKdDCALyuBCnjzM6vx5I69MtlTMZJZ4tpEYETTY+84ojbjw38Na6rw3vV1TJTNODJnyZnQDsWWKST9FUWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070136
X-Proofpoint-GUID: UQHNRuAUGCGUlzUtT4bjD7SU01Uq40qD
X-Proofpoint-ORIG-GUID: UQHNRuAUGCGUlzUtT4bjD7SU01Uq40qD
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 436b3f0afefd..4a80a385118d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3786,7 +3786,6 @@ F: tests/tcg/aarch64/system/semiheap.c
 Multi-process QEMU
 M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
 M: Jagannathan Raman <jag.raman@oracle.com>
-M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: docs/devel/multi-process.rst
 F: docs/system/multi-process.rst
-- 
2.20.1


