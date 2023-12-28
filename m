Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F125981F678
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:46:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuK-0008I5-Cx; Thu, 28 Dec 2023 04:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu9-0008CG-D6; Thu, 28 Dec 2023 04:42:17 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu6-0008Jv-Ql; Thu, 28 Dec 2023 04:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2IfrwM996OhOpIsc1uWj1D12+oEU9J4gpil5/kVUrSeyoNrMIAPpK/uUAgZ8yZ0UY9sRmPfWGqUt+npqOYTnt4yrKvle18ZmEfJjlafsJNiFYr6vNacwiQkXN9ldjh8MRMm0UD+o/WeHo0gtEIayyae2n3yW5tBpwpIQKEeYANtg+kzAHr0G3NpEXL+dexO1j00cy/MmUw8m6SxzVH2S+/jtVYk/wLK5Bx0Xe4NBw9rxdtJgPNI6GaAepTgQOZUEd7XxmtEIXxLO9lxdGMK//oXFaYgbfDd7Eb5IfHAPLOnbdPCO9Y7e4Asg6v41QcrLDTM4U7f0FVWk/ooyQsW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3dDAqfScSQKpORpASGRpyoVYYLjILjPhIDAhREH9GE=;
 b=l8QBWtqtVqmNjrEv+3zLHy1eci8slMrz6t1e2oigpODtA8BDTEHonIDjOtw46rKG2Aoz0WOinJSuZju5XqBpXqFl+/I85mGfhf3zxW1bBpEP/UinyczcjBgb1LKoBNlCUmO4kH3PrYp8H/zrmiDxBxRYjstAr6Pb/NukyRX3T9Wbp1ERuVPweGECE1+dCiTlj6oScCcA4CLhbYtRLpgDQRNup2EKAOVP3+UF9dgOJWaPtRjPqOT2xOFxHEBZFMqLo5ZsF5HAc4Mqu4fRGAjD+TczMOVrb4JKc5+XWBN0/aPBZyDHo7AAgcWAHnaJPZU20zSidYYKyLgTr4NjWLv88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3dDAqfScSQKpORpASGRpyoVYYLjILjPhIDAhREH9GE=;
 b=i9B4H3Y9aYT6E5KrnMdZqgKn8T3RlaTWLJw88PVCblSkCNL79F7BwtPVUYTGlUesLqrROe+swU7kFMETdDJ8tIAEOW8K0isdJHDn0o64MfQywM/4SMntvyt/coY0c/8HvM2Pg8yBXSI4X0bxjgF+H8mEgsxCWFcW+RB/WAiSFwil38kKFCTZWpnq/1fdYSqeHJeMljk0qc5V804v/IXdxIO+6Pt7vWcjyv2Lv19qbCXrNfQw9KTk9M6Tw4SkpzgfbkM3yKi5r339Eyz4ZtxGFt8OiF91oRDFmTgRMi+7yBVwsZ1hAVdR0YBBMSqnqD/7yLD5tdXVeeaxf98JNcdHLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:03 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:03 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 08/21] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Thu, 28 Dec 2023 10:41:40 +0100
Message-Id: <20231228094153.370291-8-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aede8ba-c28a-403b-412f-08dc07893ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ommW8YQSY8huPSWwqyP3UW3Rb9afeuoPQdcRg3X16WRr/zMBfHGLjqvfJNs6K+3HOHQIdUl0lOcjtpvUYtOQWLydoJdCJ3IgXjCbnCo19hNSV5JUSStWPdUBlVFUk7kfiQRbu3qKUCeZVwDxrcZ0rH2PAhNnGL3wQoxtaPtkHS8ev7M3UWM5tIcf+/eph/bgPELCYoAwV3aYCFcKQqWnRQWogPee+PQUiB2aGfLzpom+NppypnDEByMJlYjXKYcemCmXzsTRTWoSN+JF0pDycu8ZebkW+IG3ATxFQ63w41LHM6NYeKvTk8Y0YbkFvNvtIYZC+b5XSAqDfV/B5D/3eXLH9mbb/g2/MYWWQVzux83xqOpF72mgvHmWViCt+KD912ZQZp5pqepCORYt5VSXIvn2h924m2l547LYpgXv/oF6Oa8psvWUpWjko9Z/T49AWxvq1s5b9S0w4k4NvmBJsyf/S21kt6CZzVAszCAkFe9goo/PkKlvuWymZVlofeASGac2CBI9sRLvFF3Sj4hKi+1Ba8A2APhxsdutwf59XHeucFna3DGp97foEmbbw9PcWSwhUTfv3AUJHjGrbvJyZdtFvN26tnTp/Ep9QROEfQQ/P0ObuP95LRH81RgLl15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(4744005)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMc9xdb9f4u7hTjaA6ABSD3VQikjpt5TXPurkmEqXnfrGqpiKI+nfgE0+a7N?=
 =?us-ascii?Q?Tsio+iDP7Q+vUPoEjZ+Yg69a76lnsK4MCA7IJu/3gvuOHCLy7M2S6EQNEezj?=
 =?us-ascii?Q?lBLWV8zJhs/ttgkWmUV5BloVy2GqrRPza92tSljJQEpqNGxJXhV+xesI33oV?=
 =?us-ascii?Q?ddC5a+5CQHCC4AiC+djYSlRlNj/BVrwKcjmsPWkCqHIojcETvEptKdOrveqf?=
 =?us-ascii?Q?GkJy8VRAn6Gl7qJE8d+wF7dz4yuJDcdXdOqUvh+qTgmGrJ9NesTJrsAm+FZ2?=
 =?us-ascii?Q?JJhtMRk9ra33VOKMCVD14S9f4U2x6GVsPlXKc8nllM/qP1wJLaHz85TodMVn?=
 =?us-ascii?Q?GwP0CZr7QqVRf9dzW+3MFRs4Xdhnv/NxrTxTslS4XguLDhZIvYTTwnAiwuhp?=
 =?us-ascii?Q?tZHiypqNd1TkPjIkpiIRieOHBIbChm9C/E/J9v+oz9b0/Vsb/hFhlhA3K4+0?=
 =?us-ascii?Q?T0DKBwmyFYI39rNwzLdn8ti+smfqFFlp8q3aTsrQmUEcruXNltXtvsOz4gL4?=
 =?us-ascii?Q?qVFrNucd0L9hnMPtzTSc/UxayyR+h6Gu1kvIjT4K8yXEbYUZoAqluYpMlrYt?=
 =?us-ascii?Q?gKfLakRaxOtEE3ji5dvtDv4p6lESoRRvEahueYOgIl3Iv751G5EpNo5EH/9V?=
 =?us-ascii?Q?celRhtcLGy2O+VLQSq3c2MWT3kk2+wQA+XR+YFd4Jmp2adJ5WVz+aTt15GHT?=
 =?us-ascii?Q?gruCLSXmVJ5T810d+n80GBafVAcjS3kylGbmfKSHSIisBwIW10DTeVqxMpUf?=
 =?us-ascii?Q?43ySb2F6b1NOkaC6uo4zm/h0fbG3q+BAtr6dtCHUHCnHaRN4V2NXgH5CbEtm?=
 =?us-ascii?Q?5oZha+LkG4hgcmM8oUFEO3vTj8XEXeU55DFt7A6HyXcIiaTs2Ikt4/DpzJ+6?=
 =?us-ascii?Q?Df56I0nBHdzkZeguiFTWMAMUx8I9uCt61AM4C7q0jBwH/HOXNg8nhv7/QHJy?=
 =?us-ascii?Q?ShdM8abjeEctF8wZVh0kJrv2Dwe+D6mqq2w25YXEcOPX51W/SUvvO+f9DMze?=
 =?us-ascii?Q?fIgnjuitqgVL3JocZrhVz/7G2jwc4kWua+l8ubCe1s+khnsDXK1awmgSS2+T?=
 =?us-ascii?Q?puXG/vlf4u+oJpqpnDTt9Qb7ya5i4/rkcj+abU8T4lNNWLfJJHx7aOOnwkuD?=
 =?us-ascii?Q?giw8GOeqZWxyZExY8T551DN+pMJF9zsLYn6OS3WTYPt8aWnZHdX2Quhu4wnK?=
 =?us-ascii?Q?PV7nFWONFak4qOE3orIK+xUsavpuRh1uv3DJjdn807QK7JFhY6oyLaYNPU02?=
 =?us-ascii?Q?3ia0LkA0twAAPhDTHE2YNoO25UZhaz7trM7MJvo4pZp+wcN+vac0qAzHA9QJ?=
 =?us-ascii?Q?GSq4OfhRcFJnGjLlWr1b8eC/USUay9ngbLp50Egrm6mq3dENCRgM0P4y0Ie7?=
 =?us-ascii?Q?KkpIXq8tJTUtRCrZWIwJ2XSVqvagT+MBTjGXPtT3EHb9BVik4HJN39N8dTPh?=
 =?us-ascii?Q?w2R6wRhLqhhaqqbnhr3otVsu8mZza6PnfLYkTPSDyv6vhTJPnsydnvcvuqev?=
 =?us-ascii?Q?R7+QmsVl4AyHB5OaT4u4NCvCY7S3pA4eIjN0vHiOqFdHcu4TcAU812r6ruxJ?=
 =?us-ascii?Q?c4AxRMU2wKEMJeeJ4gJWPtGmpntrEN1zoYwJfnnkpBoNLu+c0IK/6vn10LSz?=
 =?us-ascii?Q?rCPvKFtbPfAun0n6g2Nb3dI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aede8ba-c28a-403b-412f-08dc07893ee4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:02.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpWg7gcb+w3HwRTRKDNIBFPtG40KPksfKEPBia1JB2XR1tzUO3lBBaetrHHwoQOYBxnRcDISzTcdoqDDMwpBg6rtw5JZCGVshCYbn4/TRKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 8a6e2ba7ee..04c114f696 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -807,6 +807,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


