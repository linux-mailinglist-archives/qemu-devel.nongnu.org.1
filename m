Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D86257262FE
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uJG-00021z-KK; Wed, 07 Jun 2023 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJ9-00021G-3S
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6uJ6-0006fF-LM
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EZcLX026183
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=97E1t7TdDviVui1UOy1HPxD5PtAqDrENIaR/jVhtYbs=;
 b=0NSy4ZmVWofCpt1lCFdRgLMPoVf7vl1kcaFw/4Vs9wjAn79r29wmvFsuNYUrnqYqq1Hm
 3fuEiVy3lHDb608UrEXLXg4ysx4t70CxoHrRe0Q5ILtvL6b+kndAg+vm6GhH/IOQJBZY
 r1NkgOBVJ0zT6ZR+Ii/0WdHI290D9ipYa960L8Q4VIgvabZ1XfzlkXZkWkTBQLUy1VJc
 XUN7hoATMaYKpNGKPt414abBgpe6alI7kU7CTbvO6A2IEJYt136DUyVYmsYg063KPie/
 Qwzva/hUYfO/ZWrc86IWpZ/m5JKjZL289GaL12u4s+oOLohmRWkPOf9LTVdhywWx0If4 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6r9xfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:39 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357Dcwv5003005
 for <qemu-devel@nongnu.org>; Wed, 7 Jun 2023 14:38:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6kbe8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TphNWRUYcib+fkHoFInCEfwc8TZBjyDKuOBxE5SiWqbsWSfQNd6zkF+lZ1wcpZdhNiPhhX/zVQ/slb1sDDyykGjq6xwxVIIOwUVrA1nyxiu4Zi0xE5d0Z5YjioQQIrVE/phuiz5JJVIipjdtQYFzh+IOaOAFyOY7xV/SwPlYbueOpFmxEeFt6UkEljOeXhFXIcv3bhoIuTepuFEAz4D8HdEe25bsXyx+rk07MWCFGC0RRDegfr5b549sfw388sobOkIaFjn5gHMihoKezSMf7qB5rZt9Hqv3wFMe3cn8Neyr2X5QwuBAOXpMMuCCdwKNMPvjpIKA3w9/Bez2vkICYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97E1t7TdDviVui1UOy1HPxD5PtAqDrENIaR/jVhtYbs=;
 b=ftuP95Ag8MYmoqXZ2SnYzHz5OgGgFJNWyjZBY5S1byznxgkkwpid4GQAQ4IhIds8Jlp1D6pXnqS15Cfs/6uz9P07jkW06KASJj5vKsLK7W9Dc+rwMVTKpaX0ClxwBL6vWUDq0/hYmQnii1KHbgG8Vpy7DrqZotEMX6dds8/L++FjdN0TFzowohMXJ6/R1xnjN05wsKjslZ/ZtpDhe0MRxL4dMqHeUBDiT8OLiV5nsd/0YgK2xbm6jWsv1chNRn+ysbkxg/2ObH9EmeG+uPdIYn3H7d6RV8kF6n4/oz0bs3Sn9itjIrRVWhbSoFlWTtrC8KkawYkxhmpXJthRZQCl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97E1t7TdDviVui1UOy1HPxD5PtAqDrENIaR/jVhtYbs=;
 b=GL4ilZ8BFndkqggKQZ6W/+sVMWqHl1w1Q0sFwyGwErfcCEKbmUWfSSq96FmvHmDd3g5fytROVhX5RtOhhWD/Ka0KDCSi0V2HtM1f5DBqZK2i/9DC5fjndh7CQ5RjiTw2592HVV+HaAkTbKNzUtQnDqd236SHWqMti6S83vuneBg=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:38:34 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:38:34 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] docs: fix multi-process QEMU documentation
Date: Wed,  7 Jun 2023 14:38:27 +0000
Message-Id: <20230607143827.1435488-3-jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230607143827.1435488-1-jag.raman@oracle.com>
References: <20230607143827.1435488-1-jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0020.prod.exchangelabs.com (2603:10b6:805:b6::33)
 To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c25734-1b79-491b-e5a2-08db6764df43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9YqV7n3fMM/VmCkKLFVO/9AdeUymUiOUOuSjt0pA8UPBtiUddEQ9TG4XElTrxHO6bIigrtx+gcxBhveTlCiKBY6/AvN07d2TF8revrib0MSuh4SQvE5LdSw9OsxHKywFjcuAt+OGHy+OQpWCZ9ntOKZ0kBj3EZUH8RhmSslUih9la9mX3dXCjbY61lw73I6NCWa3up9GAM7+CNwx9BW3epMPyyrlpdGUgAgZTnbiDxVeIGJAVgFQL/0+IlPErwOru23BaNO1TNO7fYbUfm6GuY3UkfVC0VgsFM7/j0zY8oi/2Wbu0b9SmMfC/S1k8eAnh6MZSegkTxCiUCC8wAr8ix6H4xeHYfs0jq7M1vGPaWMRjpXgkqoeYRxFn3jkVtq9POOyQ4IXecyHbDxus6qmLb457bdjMi0gwtJZKB0l24BOpl1DCeqn52ASiV1DBvZCNH8dvSnCw9h1+FzOaEgfF3oMWnbP4NQlyXYJwuZQu21vB2z9fx3/3WnzFlJNrme0Gx1pOAAwCqRXo9DQOmKcfSo8gCjO8ad6dMK5uVSODsua7Gt3fvErGwEEUg0XwjH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(4744005)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgkruFKjoTuIFc6QWAZ/Dmpr3UBU1xGu6CFLQ/NfvWkq5HeHwaI/TcvdDvNy?=
 =?us-ascii?Q?U5KbCB313MZ7bwdcfs8WTdS0QmR2l4Tst5J6PTq744wiR/FZUpC3wjsTszM0?=
 =?us-ascii?Q?SxH0ogsFaXCuPfpIfev870V7ZfrxoSpDy1pUhFv6tRq122wXJ67bD7mBlCSw?=
 =?us-ascii?Q?GIx+i6N4m3WBng/RXoYsoBhr4PB2IFmDlIQdrMca1Egz7TU6nYAU7ZIviVi2?=
 =?us-ascii?Q?m/iy0dFUd00vNu6Fo/r7kxUzRDCKYRLZ57R4dpF3wlg237UMZsxnegL+RSx5?=
 =?us-ascii?Q?nEbGzhose34MxuqvNqVTGdfjLcTfotsDUNv+9Pm1HW9sUrwgcpVBgKTOiGCe?=
 =?us-ascii?Q?fj/jHCQD5gFi7yKqjLWOXaHWaVNOuE/+SYY0GYxTRwj6GDb8g1eXpyf/s9VX?=
 =?us-ascii?Q?39+K51/fQrexGXbNXTamc9xBzbHLHd0HL56QBLE+UtH27WquCnqcvabpFqCy?=
 =?us-ascii?Q?FXMAbrziBR+C0DO7ieTKri3x9IxPz7+lTEm+tdgOTZP5Xaxri7wMwIju0gMd?=
 =?us-ascii?Q?NEE1kno9Pr0JRFc0DEcJiFvJT2Af8sTkE0pEuanx/IQPKVQl5C8A6FcZ6qnq?=
 =?us-ascii?Q?s73BdJ2iK2JtwPsLe1I0OJ9T0dW5qor2Gv6vp7M8n33jiWr1lB2pKYP1m73W?=
 =?us-ascii?Q?kGrRJQpGkeszYfBk7FcvTzEuZx7RMq5w8tJ/cS3pCgXWcWxDWhBGIaYdFltU?=
 =?us-ascii?Q?huxddcw9RcBT6LH4aYqIMBoNLn96aR8POgBwd6PTxYpjewg2NZyTYDFyO2Ij?=
 =?us-ascii?Q?6miGe65xemTW1wikCkjJkyqgKGBTeowMuEHxCzEBsJyJ+pMBcxyyGer/1vYf?=
 =?us-ascii?Q?SVa+PCbPHUpLpGXsioFvP2AUCSfUm/h+jcYYq5AUD6kIFLb1yk/Ma8Y09G0s?=
 =?us-ascii?Q?veSOrfLxlrpZ54f4s6YWY56JCIBv7CLbZQfQ3US6V+Yb6VFIcgzOYT88De2g?=
 =?us-ascii?Q?+0bYAQi9zgERvuj1hpEi2UBU+KbDXRXnOzWC0+LOEOBTbTSmlTmWOJl5B0LF?=
 =?us-ascii?Q?1Z4f1TngN3yefq7Z66dNhOZqnOrLSTknhxvRLCDkQXuerXhI6l8czbk+xZjm?=
 =?us-ascii?Q?+Ck4wLmAiDPGfH9GSSOKq08Nd5oSVong7Qiqi0haY78LZW1g+gh9jmSbc0Jo?=
 =?us-ascii?Q?RR4kZOSTp3cJIFBiLQCfMWgcBEudKkjd0k368Bdjl0FqVYLGKqhritMokVVu?=
 =?us-ascii?Q?AOYgx3U85xSiH8+aYJVPQVoOBZIOvWKTw2qEuDt8vzyzci+gbBSWHYPhxba4?=
 =?us-ascii?Q?FHfQe/rsqVY0OgiVgg6lC8BbO26leOt7uJxL1zMvfCaoA6N2llweoYYjAj5s?=
 =?us-ascii?Q?k2VkBO2CRRLVYi2/I9AI+Zro8LIXxWZhN3RSIpux6mBaUCBRU5QiP9psMQED?=
 =?us-ascii?Q?TFnCWE1tIB8Pju5YPKs7hjzrpwLPaBLJ15zO40k40Tc0uX6NDglbqzfhD1QN?=
 =?us-ascii?Q?nechaTwYNs74Kg2d9d1HNpZ+0MESIhZG98iv7Ye1JoyF6dBJ75RRCa5nAz6u?=
 =?us-ascii?Q?yxcdGAE+Z/PawI2aLLmfUpoek9q4QiY29EVz2ue8oQdEq4UUOp4TiCt3kpqf?=
 =?us-ascii?Q?Rarqv3eUwplMguf/xGmmSvUo9bsKxhecaAeZFxgs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1udbtv6TqM5JwC5aHpQVWAYd4jIqyVskFr3W0Io3JPf/HLZY5faToP20Og25t+UFqM2cnG1JzeKiMmB5is9qrN2cVdkcjrymWYFa4CJvN7efSpg5O79AAj2tt1bvKUVTNYoM2mXGwAsFmKiVruihESMxsx8aHFK6oXNrdHJS0pcfZHD84za7yqyL4j7+0z53AgfVCgAYTtHI7Sh6QaRT1akl+gAwlkzsvZMj37OrmeMJN+npPO9DEpJ3mAmXFPAsD/yIcFYmEnpSE+fJ3L0m6/gm3P1m5JR/Z5nwnJOST+AkqG8gaF2vPhT2gGFULElX6Z+lHBPrV9XZTNaW+4wPOgRWJ4Cj8S2WKLIJ+PFpOirWBMdKekKQZgrXqMaU+hvdRkcc90np84PSOY43iG1KTZQ6OTSoNdN1LXlxq+RajcFIXeeo+ALrQ4mbUeBBtTQ3m1ueD8xvNtiBifeMPZR0AoVmNAUr9Hg5y+CoOo7BVgDqFXRd95DJK2hfQWXTcvkS5iFw5EhD+rOLeynDSPrcsG/0W0gbuWWll78THcASf+lLw4KG87lBRZQ8W8Wwa8Ecg0s55wktM66TwEkFifeDHiBEzJbMfHkFS6veoeCACza+h+2V4gfZHLVw0sS/kqRdHUhdVnFhIQykdURzhdQlc9r6QPudFP7w7dCL4+h6SLiTYldiDfzvdIcvp5ROCGxL9jdb6PKM1Q909yye0CkuQ47Yzkr/tVdZGyKvC2cdmoHs0vPeQv1k1GxelvJscP9J
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c25734-1b79-491b-e5a2-08db6764df43
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:38:34.4186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwqN/9eHXmRsNd/Sj30a+Qr4jYjIF1VjKhyXXbMij3EvNH2kZmSL0HGn9d/F/mJZ3khvtbK3mHiGrvjMNwiMew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070124
X-Proofpoint-ORIG-GUID: Ha-xZEVjn6B0gLddyX90bFIEnI2Yzggu
X-Proofpoint-GUID: Ha-xZEVjn6B0gLddyX90bFIEnI2Yzggu
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Fix a typo in the system documentation for multi-process QEMU.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/multi-process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/multi-process.rst b/docs/system/multi-process.rst
index 16f0352416bc..2008a6780953 100644
--- a/docs/system/multi-process.rst
+++ b/docs/system/multi-process.rst
@@ -4,7 +4,7 @@ Multi-process QEMU
 ==================
 
 This document describes how to configure and use multi-process qemu.
-For the design document refer to docs/devel/qemu-multiprocess.
+For the design document refer to docs/devel/multi-process.rst.
 
 1) Configuration
 ----------------
-- 
2.20.1


