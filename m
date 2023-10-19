Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A309F7CFA22
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:00:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScz-000639-SU; Thu, 19 Oct 2023 08:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtSca-0005qR-69; Thu, 19 Oct 2023 08:59:28 -0400
Received: from mail-db8eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::717]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScY-0002iq-AU; Thu, 19 Oct 2023 08:59:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Hskc1JU7Cej6UQx/9+9AHo/H/oaSUQWa7ViEDVfyBFWJjN1Kk/yLvoPsRAzb/K9yUe+/V0ulrkaZV8kS+6v7nzeImvjIm0stbmLb70CSyBAJ4T0GqN13mB/pPH/nQdbv7duwhWyJdvqY4GdsLBzphgMFXgi4Zc5UHr9DnJICHRT1GIeFLfl/Dzl7ZmtZWtcdX2jTqoBMviRDgVNExL97gIkHbY91wsM3qX6IRjbsyqKD2ZjvfGvb49aKSCrgxqHoNJ29JaPjM/uiiwiu6LTNYr5HjKNQtKo2Y+quxbAdRcX8R3+Vn2J1gcCieZKTcwtNhRmQD6wIIXzl61KHWT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/fIMh0t+n5/eHm7akgQHN0R6WD+Om74Hz3SAl1S1G4=;
 b=SVahIMeauDuqihxkP2JG1d3hl6wRwWVltWAIkS4D67UMNzLHuOW5PxOLHdWTrEb8nfTiNJeuUH32d56v0ofE32gwpP1LqjQqI3F9oeejZN0/oFbyri4dI/xvfgg5gHJTlb9dlrk2dtgJKtTIseqOnVDD9stb5vrzwXyXXtdrqsL7pSFq3/IzCnjvh5gu7cyG3ZboVxSs2zBQWfBI1vPveMPRIjryVLXd/dHuVP3xh3gLcWeUOc8V+3fPkt3oeYZJsZNBDbqv3wnILofSuuH+4bkEpGCziGfo10bWS+zkXRSwI7tmMJ85VhVozKK7LqyqlCxAhWLpsIkTbbhaVXjMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/fIMh0t+n5/eHm7akgQHN0R6WD+Om74Hz3SAl1S1G4=;
 b=0Y+YHNB8xUYiRXaNHWxTCnt2DxGbRd4GbLLkQApBqSATzBbDmK2tHqqopOPkYIHjA2Xqfmm+MzNsM8MlFqKtNYYahmTPREcg1n6DVyeq9a/KiIaAStZgchDG+deJYtuGUA/xThLom9pptNL9RUmCkZ5J7Zu1vfDwugAUcKHOy1SSF1xsrTir8Hee95Po7NcDsyfWRxs6uxnWIZIFV1mVogj1Jdj8IxZfVM37pYV5YUO+pBbs/wMDHXaVxBRYpiAOKiAc4zLMUSEalIXMXISDi/Bpb/mvLWh3w1BorMUZqsUaIVzhRm2wuejmwioY9z/OyQnPxyaMn8sgGdKK4mc6nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:16 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:16 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 16/20] parallels: Check unused clusters in
 parallels_check_leak()
Date: Thu, 19 Oct 2023 14:58:50 +0200
Message-Id: <20231019125854.390385-17-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: dad8b8bd-19aa-402a-bc65-08dbd0a3339a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dt9DiIMmYLPVofM9PI0q8luTF/62VIjzX5w44ImHcTvIezx6tkkOQ2TmnfDivT1L9Ud7vQlfhT1f3XBPoM3fpcENZcwSTO3Ufwytc07LyBxZCgJw0QmQ06jtbubzIYMXwjpWb4qNBtraTpXYLRIN+QavCbhFp2F6HlqAAANGDD02iEgHqDZ3VCd6s5P9WkwoMHhD1lax6ingXBPs5lM6/2df93psJTIbMuDlARh9KlPVS2cRwNWkiTAJZCUt/f6t5/CUx73Timvfj085A0AYzAp3eTkyFHbRUugyVY93K46OzbdBc+n8O+gWqDu1Bx2fFP6fBcNt2VsefdfnfMW7AhaDR8ROpp1/kFxyTi93VC82briRrgoNImNIyQ9A1DRHN1b+KgpPFdtUU6OqhetQK1f1lFCCsoTQVRfrmcLOGlEEB3NuI97TkRyZ9MZFXpOklXRBYgA2GjFugoT2i9A8Ua2YI3heTXcxY95VWs2JImDjlffEwA0YjdC85vliTrOP7YR6MGFeNUxY7uUhPwqOngTOmRx1Lrd2qF9HnWZxd3Cz5bFGYre6h2EcywHWnvMQTWyfLNKn7ReDfJHQbbI1W0ozj6XYYJXBJKsDuxVCfdH+wtUhd2GEVU6oK9aNOR4A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YQYRF0VMET4+Kl9MeSIxiFz9wjl8yGmvh1Y/UEi7M/JZ+r8eZiqPMXkAvQ8?=
 =?us-ascii?Q?ka02nFNyapBxbUTRP20BnqSnZc119QA47sl3MuW539mfl1vPpTmVh2RVoML1?=
 =?us-ascii?Q?Ly+O59gviAph15wqSFTiuBhffBMxNDyRpdSEbrh85aGvXSpssr92nTdU3wd4?=
 =?us-ascii?Q?rpjhf6jrqlryFt0+U7Pw/VFvYVOdyjWcZ/cXrnX5QupLnIRMKHY962irtRNg?=
 =?us-ascii?Q?cd1FiU8MjZeeehooY9t6yj7MAwIEdFIvaqzSDLJIsa0W9YWEIMh9NK/Q9Pf8?=
 =?us-ascii?Q?1EFSEepA52oktbPoZwPubGoqWn9PCZFvBDwoGYQ0w8ANRyqhKiRs8VZwP3wX?=
 =?us-ascii?Q?YjoO/O61GEyIH3vRUsEXQstDi0Ws4JRPC5gJfBQ6RWB0d963clBf4Y4p80Nm?=
 =?us-ascii?Q?LsNdoa2Vp56DBeMxt3oKqX7C6qyC3X4co6OujWuv5UI3fTlceot9rUbEVzUP?=
 =?us-ascii?Q?H0o5Qha4Jxo2CbsxL8ForsLWZ6bFYk9NCQLpyDhFQgLosZHSIEi0SVKj0Cw1?=
 =?us-ascii?Q?ZZ1RRHUnYRUv2nmKj4LZcNNbzNEjAorvKx76AyErW8rynWOk8g58nD3ATUA+?=
 =?us-ascii?Q?217yiQL2QMmZRd43S8aUw2Rl7Ake+HEAU7cfpCz9FzvPX1rGnvxoPopUfH8W?=
 =?us-ascii?Q?a4qQFfnOJ7GP6M1WhcDLk692DEf8yHtKw5ZJCe+yVGuRX4DKaNYkW7NL0gs9?=
 =?us-ascii?Q?Kvx6SCDY3RZlexK6tDSHbB6Ni+srZB6XFFw5b3mHUv+gBq6hD5KPD42cOu4v?=
 =?us-ascii?Q?Xc0aKskWOzTXXHKhcxcc5JVu0+yED0ekR4qjrPFp1lq+/DbM+WoL8tSVa70s?=
 =?us-ascii?Q?vAmxnNJ763ADY/hWAAThq0tGGrb8N7f2UQbXnzWaYN4QFo3x8Q7V4kqGLC0k?=
 =?us-ascii?Q?XAVmMmaV6N0jjRBZHfAijH5bcj79/QT5G0MfH5ojHPRsfk4GJKzNDbuNe9LM?=
 =?us-ascii?Q?OST7fB3nkdE5Q3F/ucyT8ISt7FAE3VCOL1vylVe08x0Y24UXaWmvfOgyRpFx?=
 =?us-ascii?Q?Zv5gY1LgqNsVSj/DyXNdGF09nXaFAeb+lPJR+nnox6XHGn8BI6+9P8IfiJTd?=
 =?us-ascii?Q?vuWYYIgHU3SyZyWNpBxZvzjXRHnj8bsaxE7OTiRyrCNoKMdS0BLKc/z+Lura?=
 =?us-ascii?Q?GiNac0Qnjvv3jBNeA2jdrB90AIQT19sNC7yBdISXZZENAELUglnlz114i8Uz?=
 =?us-ascii?Q?nXDi/XD4sRAHIm95G7WuNvYdAF7zPQe4KzNQPuUAHTgOtE3uyYDRSrRCwapv?=
 =?us-ascii?Q?A4V3WshKFdfb12FillvbPMHQnDjKG79LLEo3nbzA8+TtGaNx4W4pAuIlKsMn?=
 =?us-ascii?Q?BCnZ3+XdFG791jNnnwF8QzHHPNyWBmDyq6Tl7Gw9A4UrSr8720dScyB67Cz4?=
 =?us-ascii?Q?6+ksM3XDRkswU5gRaB/0PD6weEvfU1dsgvoWz4SqHxYzvqsi2JBpqRBe5qMJ?=
 =?us-ascii?Q?DFFCJDwevUbyvcyhUaD5r7we+02w8ZZpBDQU1qul27SIyojSCcAJVjiMkzr9?=
 =?us-ascii?Q?/Qkey1pNWKX0D50i0rQs3yiGFwTldcE0wjTr+WWLZtVM30Hw/nw0QtQBbkn5?=
 =?us-ascii?Q?46cHGLeHi76GmZikMupf8tNt8DXsxkbw2lJv3wfmC6MEtOpekoR8gGIsgGgk?=
 =?us-ascii?Q?aehTWhaJ+GIJSWvn24HFuAM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8b8bd-19aa-402a-bc65-08dbd0a3339a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:16.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0WfzL4hHYIMnQH2kipcg5K6MX0dlCpTpCN5xjZhEmRZIvD9hqyJwYfW1a/00NeAwMyexX6QdmBvwJOQilILtvf8XiS3uaXb9CP3D9JEq88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::717;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Since we have used bitmap, leak check is useless. Transform
parallels_truncate_unused_clusters() to parallels_check_unused_clusters()
helper and use it in leak check.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 121 +++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index c7db2a9562..b1100dc65c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -770,57 +770,87 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t parallels_check_unused_clusters(BlockDriverState *bs,
+                                               bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    leak = file_size - end_off;
+    if (leak < 0) {
+        return -EINVAL;
+    }
+    if (!truncate || leak == 0) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, count;
-    int ret;
+    int64_t leak, count, size;
+
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
-    if (size <= res->image_end_offset) {
+    res->image_end_offset = size;
+
+    if (!explicit) {
         return 0;
     }
 
-    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-    if (explicit) {
-        fprintf(stderr,
-                "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-    }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
     if (fix & BDRV_FIX_LEAKS) {
-        Error *local_err = NULL;
-
-        /*
-         * In order to really repair the image, we must shrink it.
-         * That means we have to pass exact=true.
-         */
-        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                               PREALLOC_MODE_OFF, 0, &local_err);
-        if (ret < 0) {
-            error_report_err(local_err);
-            res->check_errors++;
-            return ret;
-        }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-        parallels_free_used_bitmap(bs);
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            res->check_errors++;
-            return ret;
-        }
-
-        if (explicit) {
-            res->leaks_fixed += count;
-        }
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -1458,23 +1488,6 @@ fail:
     return ret;
 }
 
-static int parallels_truncate_unused_clusters(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    uint64_t end_off = 0;
-    if (s->used_bmap_size > 0) {
-        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
-        if (end_off == s->used_bmap_size) {
-            end_off = 0;
-        } else {
-            end_off = (end_off + 1) * s->cluster_size;
-        }
-    }
-    end_off += s->data_start * BDRV_SECTOR_SIZE;
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
-}
-
 static int parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1492,7 +1505,7 @@ static int parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = parallels_truncate_unused_clusters(bs);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.34.1


