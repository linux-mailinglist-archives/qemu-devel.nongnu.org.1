Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A5B74485F
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWg-0001bH-HE; Sat, 01 Jul 2023 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWe-0001aE-E2; Sat, 01 Jul 2023 06:08:20 -0400
Received: from mail-db5eur02on20710.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::710]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWc-00076b-Lq; Sat, 01 Jul 2023 06:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLw5MRkan4czi4GaFSLIb5wm6SVJqSBMxe+Cs3fGVnSf7SsHINyZtYzoxplYcx66Zh1R8mUevmXiiIF6a343sUjw5X4qveSF71HtDyK5PqOy9pgoorQVEkwJ1bccgrNJEJMoCVJnZKp3n/YYcuIxGBhxtPxk056u6lUzSWmZ6TU6JwWkPEjUAFy+Rkxwz1L5dPihQnQRTl4VvjPljJnpUw8asIiyk/WqQQhmWYwfRkyP9k/nVhruyN0V7p5tP0B7FWkg0lK/Ty1MzQdG9u42qSAFs/0riMlq/eQGfo/jnTHq/Ctou5qaOYWK3vH+sY1F45upyaFoVJbna1XFmE62MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAqaascQH9M/pNRP+aybKI2JegEv7iKFNQOBciZfauE=;
 b=ag5wL6NPauTmiHqG4fwx8fHrei8BB71ovR+pEQ5LlzGge9KPjd9dQMJrGkW2Js9J1AnfjoBOeKxY9oFQeRm8HsA60IUADGinh3vaOFGEjbdnbGb7v3qO4MeDrhMrMoP/s/XcdE2ANSue2HR9Hr3i1YPtFA+eLgbrlJQAivJju1dDsonHHfx7jvhZK8zipsFeKN3ZPt5NjW/OPyYgzvDZTOWPArc5PaIO3txEFIMvK5I52955L9N+mJGO21fBtdN6NtgFJTujV0wRNs69lIYemjZlSWkw28frPa9lByx8mjGpcK6QweXxVxEvQJ75lxx3PppXXk5rSlm9qsO3f4/TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAqaascQH9M/pNRP+aybKI2JegEv7iKFNQOBciZfauE=;
 b=dscgwGu31EeL+1YSqmsoLlSRo8A1Azj9qtButjIKv/wxzWq1L7c/AobI72OS6Z1zBMyMKGCijjIh8PhaxbxGNasFlVl8F+sSmstIu+a5ohWHreEWVLyz9K6SlvFjpmDJVMtYwqGUTxdrIbqdihcaBiOUl59Waf9rZA/ETjazgFxyJp2IXaYII8qqAjGtMKFaa8c/qNgpzLii3GTW8B88R19O5fyBMeHNsnjpgCFo8XSyhLZSz9g4zZlbTlLRbzPhWtZke8+RImG5r9IzLp1YkDDhQPZhE8z6G+J16HRZRZ0Oru0DWCCButkmaBAmZPY+tndd/cG3jqpe89jpOAb3Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:09 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:09 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 5/8] parallels: Add checking and repairing duplicate
 offsets in BAT
Date: Sat,  1 Jul 2023 12:07:56 +0200
Message-Id: <20230701100759.261007-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eea9a5a-8a36-49fc-f404-08db7a1b124a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZOHxD/89VI16LR2Cb3lQ156ibzK6QIa80glk4AT34dSBLtGfqPdWZ1vJIH+tfjYaRtihUpniuvUbD4bcD4b7fYeAKA1YRN0itQTtRPqg/r4wt/SzJftmroMKAnAXEFSVPp7IJnF4VVovSHwWuNuPrxVqwWig9PL2EoEZc4mWO19iSkM2lUDNU7Z2L4NFnHr2apvTzSNmWhey/NWEIIV72zY5f8DXA1XuWRAtqelsLjYSxeuSEIcEzrA1055oH/Ptnf0OyI8wadl0elMYKn41+WO4kdjqxVXz0SCvp3x7wnvV3CWdmQHtn5XF/lOzuaFdnyFCnxcdJOK/2AsZc0cCQdUK2R2gU3ZB1IzXkwMojoVcYYvJzgBp30o7LKuRfNsjovbsSf16HVmeGIdw3KwsSTx7fL/ybLorwDs4ovposj6wfz7XqOqjDOD2U5GqcxZH+vLq8Q7RqxFItyycdDjdYSVZztsWjAL4pNwsvE2KlSbxIZ/Ylq6DNwxYp15309rs7Oe/f8RdGif4+guMYZEsjX/iJz6KVWcm8TyZS0xHpAzBucV4FflS3v8ltSGw54miNwHPnJs33SQJqTbWOwNMQCh0bFs4iloY14qWnvuAEGD7wyfY+4rdW1u6SNQk5pq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1TAR/bgYVtm4UySH71RxEp6QpKhuRu4ulzySN8mGOPQ4dzTtBYBOUovhpU81?=
 =?us-ascii?Q?myvM+9ETSKTm0SsPhnOn4yrEk7B6ZsREXOiE9W6sEYli5gPoyoB2WWOlbixN?=
 =?us-ascii?Q?LB9+T+Q3uxMEe6D+ILcGHNSbo8T9ISg91eG4gDzeSUFSdhmUg7dAEK7QHR3h?=
 =?us-ascii?Q?CAdglmX7grwu+F2lgo+xupJmwHaFCkMjneSCAMUoQ6DOzkhMLWwoFznNKb4y?=
 =?us-ascii?Q?C/n4QS2WY5BV7MfQ+6twW6ylBOz/5yq8+YfvYvKPxTooSOkZOPajFZMn3IAS?=
 =?us-ascii?Q?K7L1Om9/ch5NehzwKq3OfV+qPkJ/yBbtThXWjBqPvV+Js7lekjXqK28lk03p?=
 =?us-ascii?Q?zPVx+OHyFWCfAgxUZzkMBlRYD/cRWMsFQCDprmOhjMmpTyQuXi6f9yPniSPv?=
 =?us-ascii?Q?xZvQwLiJKcuF2eYXc/dozxAtqZDnq87ROZHt5NoGPD6ALnjOpxh3hNnKqqTw?=
 =?us-ascii?Q?/VmuDqJJ8BdaXbss/6Rzuhnu4xmvKDA7x63BwPPOxmLvGSEmFLZG8121PhtG?=
 =?us-ascii?Q?Xl9ArWIBtgLxW8TlL5ULikPAfxIhcNKjxJiXZSRGGr7NZOs0qgEs9dQtx2bt?=
 =?us-ascii?Q?pbbBGV5SG85Rn49Y/xRo55g4JCX2m1iNR7jDaDducX5b+lupJ6DYJPUbJjMH?=
 =?us-ascii?Q?F7jSy1ebCwubAxCIhBvfipLcGdnnAOmIhJfPtvfhVs+ErHJ/vC+62MSthTO/?=
 =?us-ascii?Q?HkR33CayLhdJPI1OqsKOdnQcnSrzzZzo9TYnFQn084LKDHoq0GDVJUQilzTL?=
 =?us-ascii?Q?zpXNjeaGuX9tYnnb0vb4P2QubbWT2xRGNDxT6hkvvNZ2F83V//PBEXqkfogU?=
 =?us-ascii?Q?GPGDEggnYEvQcH3F//eNXPhyRDuwX+tmk9PaKBxq5fUU9pZVzgWqUZFIeV+C?=
 =?us-ascii?Q?C6gfm4coWX1+9ZLchHKf/zuPY0DykLH/GU8cRZxRwDSHVn/4ZClHW59lnVOw?=
 =?us-ascii?Q?wVhN4iGXrr8Vq5x0x2K60rw+89Z9MJ0kfS4oZ4XsydUKKakmv4wAsHc6oSPU?=
 =?us-ascii?Q?OcKoAnAM+/Brp4++b9SJfIW0ys4rqYQWlRd1CAvD8JLulNYPAtHyctOqNy8Z?=
 =?us-ascii?Q?y/lM6zmA4WzY054ri+d3DDjH5wlZlckaotcJFJK3b7ra4BPH9ySQnLOQMDaY?=
 =?us-ascii?Q?osicbmYWCc0zQMTaiKsODt5zLVtOPu+rbYfn2v5J0lXZVc5TcaSAzkcp+jIR?=
 =?us-ascii?Q?ea70qb4eDma1++GwxZDFEX8QYIBVZK6wqkvZPEc09DkBemQk2jciJe3aOb90?=
 =?us-ascii?Q?arRgyvERMiflasqtRUinDZlVJ9x3Gg1Em3CBAUcx4hYeEgJI7A7UmsFjcVFy?=
 =?us-ascii?Q?IWdQZIkX0gIrHpw3N45fXeor/brT8yZmAeHK0wvmffLvj+8o9ACVi8PPYth5?=
 =?us-ascii?Q?N9eBwXJvBUx4IMY/vPlVDHmDuQ/JbzsYaZjN2OiULMlEHGXXEj1h6MxlI9GY?=
 =?us-ascii?Q?d8dzfPIUJmD48n/C+7eSSNJOMvd2sFV+o0bLSSsZfDMMFzROZFNzxG+0Dv/J?=
 =?us-ascii?Q?tsGeV7Na/vFaoUQxEVk+Y8DsjMOn+WABJjrjSu8yHP3mAHLyX2iMauMzvi4D?=
 =?us-ascii?Q?++n0KJrPATWlJ2GaAtO7EOTThxDZ8btu9BsMKGKUHmOAOgHmDYS9oe3+I4km?=
 =?us-ascii?Q?TrbWokBxEu9NSWAHN83a1Bs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eea9a5a-8a36-49fc-f404-08db7a1b124a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:09.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSp8Es8N3iqekwNhBq0vJJXcuYAKfEoLk7kv1ztxBRYAL4TRafRKY7lou6V8lORK4nDASGJpLznXJKgnLk8mowZuo7Jv8T6hEqBrmxiN0hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::710;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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
 block/parallels.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 374c9d17eb..0f207c4b32 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
     return MIN(nb_sectors, ret);
 }
 
+static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
+{
+    off -= s->data_start << BDRV_SECTOR_BITS;
+    return off / s->cluster_size;
+}
+
 static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
                             int nb_sectors, int *pnum)
 {
@@ -529,6 +535,139 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
+                          BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t host_off, host_sector, guest_sector;
+    unsigned long *bitmap;
+    uint32_t i, bitmap_size, cluster_index, bat_entry;
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
+    if (res->image_end_offset % s->cluster_size) {
+        /* A not aligned image end leads to a bitmap shorter by 1 */
+        bitmap_size++;
+    }
+
+    bitmap = bitmap_new(bitmap_size);
+
+    buf = qemu_blockalign(bs, s->cluster_size);
+
+    for (i = 0; i < s->bat_size; i++) {
+        host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
+        if (host_off == 0) {
+            continue;
+        }
+
+        cluster_index = host_cluster_index(s, host_off);
+        assert(cluster_index < bitmap_size);
+        if (!test_bit(cluster_index, bitmap)) {
+            bitmap_set(bitmap, cluster_index, 1);
+            continue;
+        }
+
+        /* this cluster duplicates another one */
+        fprintf(stderr, "%s duplicate offset in BAT entry %u\n",
+                fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+
+        res->corruptions++;
+
+        if (!(fix & BDRV_FIX_ERRORS)) {
+            continue;
+        }
+
+        /*
+         * Reset the entry and allocate a new cluster
+         * for the relevant guest offset. In this way we let
+         * the lower layer to place the new cluster properly.
+         * Copy the original cluster to the allocated one.
+         * But before save the old offset value for repairing
+         * if we have an error.
+         */
+        bat_entry = s->bat_bitmap[i];
+        parallels_set_bat_entry(s, i, 0);
+
+        ret = bdrv_co_pread(bs->file, host_off, s->cluster_size, buf, 0);
+        if (ret < 0) {
+            res->check_errors++;
+            goto out_repare_bat;
+        }
+
+        guest_sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;
+        host_sector = allocate_clusters(bs, guest_sector, s->tracks, &n);
+        if (host_sector < 0) {
+            res->check_errors++;
+            goto out_repare_bat;
+        }
+        host_off = host_sector << BDRV_SECTOR_BITS;
+
+        ret = bdrv_co_pwrite(bs->file, host_off, s->cluster_size, buf, 0);
+        if (ret < 0) {
+            res->check_errors++;
+            goto out_repare_bat;
+        }
+
+        if (host_off + s->cluster_size > res->image_end_offset) {
+            res->image_end_offset = host_off + s->cluster_size;
+        }
+
+        /*
+         * In the future allocate_cluster() will reuse holed offsets
+         * inside the image. Keep the used clusters bitmap content
+         * consistent for the new allocated clusters too.
+         *
+         * Note, clusters allocated outside the current image are not
+         * considered, and the bitmap size doesn't change.
+         */
+        cluster_index = host_cluster_index(s, host_off);
+        if (cluster_index < bitmap_size) {
+            bitmap_set(bitmap, cluster_index, 1);
+        }
+
+        fixed = true;
+        res->corruptions_fixed++;
+
+    }
+
+    if (fixed) {
+        /*
+         * When new clusters are allocated, the file size increases by
+         * 128 Mb. We need to truncate the file to the right size. Let
+         * the leak fix code make its job without res changing.
+         */
+        ret = parallels_check_leak(bs, res, fix, false);
+    }
+
+out_free:
+    g_free(buf);
+    g_free(bitmap);
+    return ret;
+/*
+ * We can get here only from places where index and old_offset have
+ * meaningful values.
+ */
+out_repare_bat:
+    s->bat_bitmap[i] = bat_entry;
+    goto out_free;
+}
+
 static void parallels_collect_statistics(BlockDriverState *bs,
                                          BdrvCheckResult *res,
                                          BdrvCheckMode fix)
@@ -580,6 +719,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
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


