Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFB737D3A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4w-0000Md-5x; Wed, 21 Jun 2023 04:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4r-0000Ie-Ji; Wed, 21 Jun 2023 04:20:33 -0400
Received: from mail-he1eur04on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::726]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4p-0007B8-K0; Wed, 21 Jun 2023 04:20:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAlVdGuxCyayUEfZjK7QFtWyUbHwZZdWwiFKT0koweJPxQii9tSYipvXecq3oUDlHZ41aoRaIqkKA/v4sRk/kkJA52618cifGXKKvw1bTl+eGI5a5FU4+ogtho6+NVvchJcb4DAFjmqjrzmWMiq+/GTZjfqZMrJ7uYx8ZbD5BNiKG4aqUQCmFVCjG6yEzceTNmmxAPz3vAfSZMAAYrmmW9lZVrzDx426Thgsv2Ka7Dp+j8Tckym50kERtY41CJHKM4dcyGKeke+dhZPiV5UT7LsQegCESTEYvkWRi9v7oh3RU9QGC97F2CM4WXsx+OSSjIkM/Aml8CRvKPOLx5LdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/swzjEA4VFYanQpi1FIIbtk1pnBMq7npMJFUtvSYk0g=;
 b=FMkqTShJxdx6NlBQCuPxg4Ed5U0st9Z6Os4gg0u8VjtsUp2FIhaFyIDC4Pf7iLu0P9n15xxuYx4VWnLYnYc1xdzH8fa0be/MSpdqGpPlfJxeT249VrDyPcrVFWj3qJPlPPORzKNyuSawNlZNTwrOR50GPKItHaw32VkzcNbySDUZYag/ZvYLloCE5ehwBXf7pDxORFgpyuB+3x2krJjmP0V/8u2rQt13EmJcAv4yTXjxvgN7jyd2ETF2+JySqtMQxxRhzjtTz8mfaFjmOmGZL1Pu7ekVwzGn3Y0TMQMIRH7sXf13GvywdvY6Id8pEM8/tKBUIUur2by0Y9Ph9Oj9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/swzjEA4VFYanQpi1FIIbtk1pnBMq7npMJFUtvSYk0g=;
 b=BUISDaLiXbgwO/Pepl2NYwIckdiXIgcUtSOUNT+sgctDZPsJv17z4RhoHRSojnnmAEDbbUhLixWlPGzsKii9kiqIi10Wd+LUZHaq4J8IFAEMR//is7Br8wcyLXfloomJaxfVHsfJ8LNMwVT0uJDygOwC58LinsAopsGi/4Tkz3WeXbMhpWCr4fVylueihXW4hlOAHN+A9qUZf3BwABImYpvtBVGYmKfaGBbfXzCtj3LlYCngFAMcST471IL2MKv8VQbuS+dcBCgbq6aEht8QMqlSarjUNUoGEKDe1GixcZj6UyKft24l52M7Z8GSUeodaLl/RktfndV5FNuB9eQbGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:20 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:20 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 4/5] parallels: Add checking and repairing duplicate
 offsets in BAT
Date: Wed, 21 Jun 2023 10:20:09 +0200
Message-Id: <20230621082010.139195-5-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 907c4392-64ac-43a8-8ec4-08db72305a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeoHUlPvsRDA8BwNtMdYwLMMPbnbi+M9CGWo5NseGRNxryU0jD6EDHnymgjHy2zOhTJBEiRnGPCU5poKpZeD7TbD5CMXW5p76Agu84q0ogVrYloLvw76Yyep/9Ilykh893rvmjKT/wJp9ZqBUXJnCuHudikOckYE9N/EMksKEw33UBVoBe7YTvAj8cWidQmy3XrzmeAfVDsrG/V1UAwYRfxL6BO3lTIlfLwOpgr9T7IODQ6VdOcs/rXQDgYlKv7SYDU0AXEZbbEoOdb6eao23+gKIQk4hjbM+3xqyp1OEjkCen3s5fOdEYFlJuzbehrT5L3FwfqVImmvcUDyxcC0OLV/mot9FWqrPKVvrbWkCpUP4hXRmkaMpdwEShBBpjb3vwSbD69wgFZbR+dYPB96HmSop9IJuIm53nMxONeKcN2qzrmXm0YnrQ7AHNIdC0+q8irbCIebEy0hPje+qZ4Xmrv0dEHb2q2Z5KYInkXTTYKcyvc+M2Dd6PUJPYhdiZnpMx0elke5/mutXDSVPobaR/Q7L62SdSgRakVh4dlKti+k2eEoayUTukVZLpKLYAyih+7LPk1KLwv8jMu9EYG1pU2DhnKzddCKNNudAIx3FErDX9NdQcD7BNL0nfJR/OIb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0hNcgLe3zONUFqOxbjxcvuRF047wqJK7GIx7P6x/QvfxH5rCTlWFMpTuOon?=
 =?us-ascii?Q?1KujG30yHvMsL4x/bx7LWqWv6bihiIvrGY7JLk4MLua1pGhwSQD4P33K3N5y?=
 =?us-ascii?Q?pWW0OROLy78vCqkRjuEfZ7dACizDY3InkoRvqXBk1Nc2x5T0n7ooajBn0j/5?=
 =?us-ascii?Q?/uYNjl4VqjTsrQ/rdO57BlQbgQcRQiplTPmrPucZCIOTCQic7/VFc9ar0xbr?=
 =?us-ascii?Q?Z8WvpXU/LPG4rYuN9QQPej/xaG4SFx8+S5fMAib44F1KhqIYJ/+5XGsZ5hWC?=
 =?us-ascii?Q?1x7dobfyDACOXULSb6l24OMXAqhgRqpHBTNvJxR0DkXD//1n9O89JB9Y/HZX?=
 =?us-ascii?Q?vFLjqSlWy0/ZYA+rp+rc7dBPiDo3qm3gqF8oljgkQdRzr7NWuidozvGs7LRk?=
 =?us-ascii?Q?nUioUV598yJZ4OKU0lhzUYdByu82Yq19DzyVTPvRIHPvmB6LoM+MwtcFImMU?=
 =?us-ascii?Q?DYVU5cIVDdllHEOG7KPQDILACjuIPb4EQHOHIf2uFl+SdbljCwV7EpDnW+ue?=
 =?us-ascii?Q?4M5YO0jq+oX+G0dPl9I9fMBRmXNB9h34gFYNBThWSC0EUSXpt6cQf/ms6MXV?=
 =?us-ascii?Q?JJ2iyujlHUySNoXGuWQbfayBmLM+WOPbbPRFQIB4xDVheoSGTV0ApQ/tCrEB?=
 =?us-ascii?Q?mjFM6U0AvCAJvATUbAeZYAYjfmlDUQhGG1nHoeD9pa6vxuF5gMUHr/b4VkA4?=
 =?us-ascii?Q?NS2jRXvMNmyB3cmv1aeFeouNBahV9Qtm4UiMWNc++Uzfuu+6vLorKBDVysas?=
 =?us-ascii?Q?Ow1YRl+XCxQY60pGksezlCxzRH5igCq5ueRUQlBUsg814W3CCJAnGEV+uoge?=
 =?us-ascii?Q?BMHn7NTLcoocyjMaG7723xXNH8ZbwUuC7WVv6zG8M0rueGm2fOZ3TveuwJTl?=
 =?us-ascii?Q?KacspQfGGrRq6GJntONf9+hbnklKK/NDPa1wSQqN7z2kSm3TEGjIUSisyTf5?=
 =?us-ascii?Q?DYeFTtR+eWPyfN2fA5vgpc+OplVJyEqFpnns7cwRqtwkTK+8j+ceF84dbZjA?=
 =?us-ascii?Q?xk1mH89kbNSca3omJ7/wHeKGlqd8OR1HbsQMscjUPRnuX7W4MnNDmpQn54XX?=
 =?us-ascii?Q?2xIC2eIb9fgUjG6gVUG/xdPmSxG3e1B6ryOvl9/JG9atpwgfaQVtuzc7dSUy?=
 =?us-ascii?Q?Nq14hrMmtd1P6QXTMbnUyJBo/NtNhzF5gYAhDcdvV8sa6pEBpEgV9OKCxRIk?=
 =?us-ascii?Q?ZrFZ0NBeHVvXL/SAfBJjmJU94+B5V2+ZeyaPpJt3xWypJKnTHEuLloyClAFo?=
 =?us-ascii?Q?aDW8TbY83fIH+1fI0IPJl2nakYLpTWaJSDhakAk6xxEwtCUl6FfrCxyOwqmS?=
 =?us-ascii?Q?pcOw+/pyDdiPqT7GS3TUbeyLJc6l+JXUpvkkAZ91iqmPCmkantoG43Nkqvlk?=
 =?us-ascii?Q?s4zlAjd21sQhgqlnc2mEkB6TNf56V1ldxUoTpgw+ql7JCjWFwZ2LwxLKmDE/?=
 =?us-ascii?Q?gpsdfl2a4x991ytqkRFFgNTlO/tiJn9YzIm4X+CpymDEBkW5Cb4Fr9uMLsP+?=
 =?us-ascii?Q?vRHSlzmaKKD+44KDS1ypbj+C4eBSYPh/d3AL5p49nO4o6RypJFuCP53KhJQU?=
 =?us-ascii?Q?mCwCQijju6p6D22XK3ueSzNAoFL8Z+eHnRe1py/iMTHdPD0UhDRbs02FjELE?=
 =?us-ascii?Q?mMRwXXJ355PYWJhexipwFr0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907c4392-64ac-43a8-8ec4-08db72305a8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:20.7142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEGczx5B+D//F7IgAIkJbldKE53M/0MlstIOFl3kVtnPEojgUZBDRGHpGCCX3H3KnqdsGD8vsfkHp6Fky2IiGEFZNOEOaHk8/pjHv2cDY4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::726;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

Cluster offsets must be unique among all the BAT entries. Find duplicate
offsets in the BAT and fix it by copying the content of the relevant
cluster to a newly allocated cluster and set the new cluster offset to the
duplicated entry.

Add host_cluster_index() helper to deduplicate the code.

When new clusters are allocated, the file size increases by 128 Mb. Call
parallels_check_leak() to fix this leak.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 78a34bd667..d507fe7d90 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
     return MIN(nb_sectors, ret);
 }
 
+static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
+{
+    off -= le32_to_cpu(s->header->data_off) << BDRV_SECTOR_BITS;
+    return off / s->cluster_size;
+}
+
 static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
                             int nb_sectors, int *pnum)
 {
@@ -528,6 +534,137 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int parallels_check_duplicate(BlockDriverState *bs,
+                                     BdrvCheckResult *res,
+                                     BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t off, sector;
+    unsigned long *bitmap;
+    uint32_t i, bitmap_size, cluster_index, old_offset;
+    int n, ret = 0;
+    uint64_t *buf = NULL;
+    bool fixed = false;
+
+    /*
+     * Create a bitmap of used clusters.
+     * If a bit is set, there is a BAT entry pointing to this cluster.
+     * Loop through the BAT entries, check bits relevant to an entry offset.
+     * If bit is set, this entry is duplicated. Otherwise set the bit.
+     *
+     * We shouldn't worry about newly allocated clusters outside the image
+     * because they are created higher then any existing cluster pointed by
+     * a BAT entry.
+     */
+    bitmap_size = host_cluster_index(s, res->image_end_offset);
+    if (bitmap_size == 0) {
+        return 0;
+    }
+
+    bitmap = bitmap_new(bitmap_size);
+
+    buf = qemu_blockalign(bs, s->cluster_size);
+
+    for (i = 0; i < s->bat_size; i++) {
+        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
+        if (off == 0) {
+            continue;
+        }
+
+        cluster_index = host_cluster_index(s, off);
+        assert(cluster_index < bitmap_size);
+        if (test_bit(cluster_index, bitmap)) {
+            /* this cluster duplicates another one */
+            fprintf(stderr,
+                    "%s duplicate offset in BAT entry %u\n",
+                    fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+
+            res->corruptions++;
+
+            if (fix & BDRV_FIX_ERRORS) {
+                /*
+                 * Reset the entry and allocate a new cluster
+                 * for the relevant guest offset. In this way we let
+                 * the lower layer to place the new cluster properly.
+                 * Copy the original cluster to the allocated one.
+                 * But before save the old offset value for repairing
+                 * if we have an error.
+                 */
+                old_offset = le32_to_cpu(s->bat_bitmap[i]);
+                parallels_set_bat_entry(s, i, 0);
+
+                ret = bdrv_co_pread(bs->file, off, s->cluster_size, buf, 0);
+                if (ret < 0) {
+                    res->check_errors++;
+                    goto out_repare_bat;
+                }
+
+                sector = i * (int64_t)s->tracks;
+                sector = allocate_clusters(bs, sector, s->tracks, &n);
+                if (sector < 0) {
+                    res->check_errors++;
+                    ret = sector;
+                    goto out_repare_bat;
+                }
+                off = sector << BDRV_SECTOR_BITS;
+
+                ret = bdrv_co_pwrite(bs->file, off, s->cluster_size, buf, 0);
+                if (ret < 0) {
+                    res->check_errors++;
+                    goto out_repare_bat;
+                }
+
+                if (off + s->cluster_size > res->image_end_offset) {
+                    res->image_end_offset = off + s->cluster_size;
+                }
+
+                /*
+                 * In the future allocate_cluster() will reuse holed offsets
+                 * inside the image. Keep the used clusters bitmap content
+                 * consistent for the new allocated clusters too.
+                 *
+                 * Note, clusters allocated outside the current image are not
+                 * considered, and the bitmap size doesn't change.
+                 */
+                cluster_index = host_cluster_index(s, off);
+                if (cluster_index < bitmap_size) {
+                    bitmap_set(bitmap, cluster_index, 1);
+                }
+
+                fixed = true;
+                res->corruptions_fixed++;
+            }
+        } else {
+            bitmap_set(bitmap, cluster_index, 1);
+        }
+    }
+
+    if (fixed) {
+        /*
+         * When new clusters are allocated, the file size increases by
+         * 128 Mb. We need to truncate the file to the right size. Let
+         * the leak fix code make its job without res changing.
+         */
+        ret = parallels_check_leak(bs, res, fix, false);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+    goto out;
+
+/*
+ * We can get here only from places where index and old_offset have
+ * meaningful values.
+ */
+out_repare_bat:
+    s->bat_bitmap[i] = cpu_to_le32(old_offset);
+
+out:
+    g_free(buf);
+    g_free(bitmap);
+    return ret;
+}
+
 static void parallels_collect_statistics(BlockDriverState *bs,
                                          BdrvCheckResult *res,
                                          BdrvCheckMode fix)
@@ -579,6 +716,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
+        ret = parallels_check_duplicate(bs, res, fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         parallels_collect_statistics(bs, res, fix);
     }
 
-- 
2.34.1


