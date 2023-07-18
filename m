Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F7757974
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCS-00027V-0h; Tue, 18 Jul 2023 06:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCP-00024e-0B; Tue, 18 Jul 2023 06:44:57 -0400
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCN-0001yi-7A; Tue, 18 Jul 2023 06:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLkGJ/z9iK27iD+naSN7oRzQ0s6NV1h4DMvxjGpwjwLGsw4vMkp4XsvYVhrZeCZJ2vDcibRs5gktu6dA+r9z3BuPyF3y5Zp+KZfMmhVKTrkQV82EasbztbQ7v3TBkIbS5h+6bZCPDpfcjmL2j+VMscFRmWVWbml444vMaddijsuEnzA6Rh0jBaJvcfF5n+8tyJEzMUvWmhL9RNZkFPwFTuWHH99v+Fixvo65BD3+wITlInNxQy84MkHW2GksypSP2Q0jn+ZMwmhwA+PZQLBL6EGMCfDDrrhrl/bqE36IhM15ImPVQcSMVE1lxEExvwvcvd5O00vSYU4OVVxqtVZTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6No7S2mIfoq2E9I5xoANEy9Ibx7QcjrMD+ZbvM66tQ=;
 b=gDH43rXqv+yhiMn1ASK9JERqv0kiTVa03lK158w3VTi7GVcR0illd7xGm2aDONnbaBNE7n9ktLlf0tqfCCYLDGfihgBW5t37LZhj996rYfCLBGWocTlFQIxnyOvwAS/XiHT/499KkQe7npDyK/X4WN/DL6M07vnJgmWjawepyyDy5DKSgV/yA67SDsmxTVirHRglFdbBDOavPHkSb0K5jwZjajo6+BPTN/jIFayVi+ks3odfV4blT9aRHzWE7Gc2gg8gfha36NeDEx9lRUsgq9yplN7TVN61+J2BvsiCIbsas9/TJG7swkddOBMAhB4iAUS3wMQyAcDH6v/IPCku4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6No7S2mIfoq2E9I5xoANEy9Ibx7QcjrMD+ZbvM66tQ=;
 b=hSN/7CiClfoPJvysYmkgOi/HNAx/Whf2Zw0x1lUD87AsDP/GIbEy9WuW6+mNJ4LZ8C/P7oRePAru3wxoboui63i0dO9ZEZYV4dnusq4Ufj5qujqtxefqIvA8LB+OYfxzhODCXMiNNo5FRA5GvjYvr5LPd7CjmalwskNtQFtGz1UE+1F9f1vdyVGsZ5UjcJUPewRneyyGKgB342TNSVA4prWQKSpP3D1liKxTZKMSp3V73sjuNMEEr+SuMMfChrAi7zSyqV6KSwkybq4Z4h6E26SvwBEbpGyBY4jgEwet05vSwTDhcRmybdKOlqymPtDFZzGvbcsGZ3AiiTcRlDTffw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 10:44:42 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:42 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 06/10] parallels: Add checking and repairing duplicate
 offsets in BAT
Date: Tue, 18 Jul 2023 12:44:28 +0200
Message-Id: <20230718104432.1130469-7-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GVXPR08MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4159e0ce-42e0-474f-4a2a-08db877bfe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfgOkMSHHvKNq/En5KZKJR7Z9vKU1Kqmlzd5y8M3uevFj2g8HexcFHvoOAD5XSPNV5IqlWJs+Gh3dFN24Ff7FKhbOs/sfPcs3kwJpU8C78wkxVGMl62DWH1rKFscsqfTuv25xDUyevHKJbwUJIIfwaviOJhjlHEUMkisukSICDsBFReCSM32wFNwrBdxdsf2dEGyqwceBoeNCAjXrE6XsRtQErYBXPBUNZ+4CkWyrUeis5BOW2Vwz/81G5h8107tq3pXM4vhagxoZrWZ5L6Y+UwXqlDEbiK4UT5ZCP90T/3omvkLJ4Vr0qSIVSPg3kAEkFNN8tCyqvT/GLA27SHEQ6EhtErPki0QJxtqL3Ft04vk2heUodstLyvce9OiqmcgVwwP+ksmC/6Slx+ZQGsxqhh3w6gYR1jTKeWfePQ6hw6Stz+cnx71JOyfhJxLk6Bui+pnCYLnjmm6nS73qreQPZbZhu9eB28lKU2+bitFRIyLEN9eT4+cyF8wEutFhF0rJAxnXcAeBomcO0rfqjiHKl/0hXxY2+Z4wsmggIt8LF+9UzMKfuRhqJb8zo19Vm50T+rDUjhtKV7iXl4WSGJdRtZTPuGuOWK6WTYCxBpJNtzcnBQvj/yoDlmFXON9tLE/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(1076003)(38100700002)(6486002)(52116002)(6666004)(38350700002)(66556008)(5660300002)(6916009)(478600001)(316002)(66476007)(66946007)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cakIBGMOesYwJo9EugazoNCYM6dV+zuaVnyfAnaSmzlFGLt51bdbNqhNQvBt?=
 =?us-ascii?Q?5/jIpGuId5llhXdYanx8o456IM5c4uqjpxhG5uWI+larJ/Z46/i+GxJF+xwD?=
 =?us-ascii?Q?DT7b3Eu93ELrYUEbl8ABRb30dsV3dZD5X9ElFSYo2AB3SEvLD/bU+HnwPuy9?=
 =?us-ascii?Q?1dGDAlfFkvQi8oMdwnYeycrwOmr1oOWMt7ylypIA4pMkrsHnLmGxJ1FhWB9f?=
 =?us-ascii?Q?vgWQrkXSZHQT14N9fh8OMOztBQijvOk+v9mwicREZfIk3kH/6ikaeBsy4lM/?=
 =?us-ascii?Q?HfAoVDS2rnvtW6EZ22svOa1Vubv+GEZvGYwtbuSHzLcpGA+NgfR6/I+iUZEc?=
 =?us-ascii?Q?Hg32WVWGyMk231AaoyxstcNHAdwCKrieYP9aSlUwbB7dvCkdUL4VjIj1dye0?=
 =?us-ascii?Q?48xey1ROG42CZWtFhP7HJZ5aAq8Yh6lnVLydv4rjAp2h8n/Ad0CnW0TtyYGr?=
 =?us-ascii?Q?CmaJNmJaYQ7z3c7zN6VG/LOJSmBWBhngY2vCkvs1kDl21BfjpGVHVncKuNDG?=
 =?us-ascii?Q?F8VPBohDpY8ADausOJyT4giniQh6XR+UuwXjgSlJbtEADBLcfhzdzOwIxyu4?=
 =?us-ascii?Q?xDm/KsW7bbk0nmU8ZqvlwoerXjpjriYk6qNowQAVt9IW66Jr9Q/bCCsklN/l?=
 =?us-ascii?Q?0O+DV2D0W0hV8W/3BuiCKm0hOat3pzVnujRXalGHczR6Y9u/OzPUC0tqUo8R?=
 =?us-ascii?Q?0DaExg31QC8YmiukvfcjIfXGGt9qQKmMip/gfvr27SDPETHrZLkRnCOQkNS8?=
 =?us-ascii?Q?rbiX2O+OMFbRmzbxPX5oG9UVKeCqaMfyta0S/YpuEpHbv7g5Q9v9I3O4Z0Rx?=
 =?us-ascii?Q?eKq3r7r/hZu7gkFwZVZ/Oha7UabNxBeCVGE0uLYS7xfwMzkjBtf4CzpU7k9c?=
 =?us-ascii?Q?b3hr4Tr2nDwOxwwrAV8MGc7BPpAtgu3ZWvW+8FEnCOve/Bb0COuFVj3V8Xl7?=
 =?us-ascii?Q?MgN3I4XoFhZAnIKAN22g8ZAplP9gd4UOEBqtU4avlh6JUi40YiZBx0P0WqW1?=
 =?us-ascii?Q?6n4e1fKEd/GLzkzIR7DjzVvT3WBiyFdSrORq+Ul7WqSC+rOiMpLtQpYl4JsQ?=
 =?us-ascii?Q?KR8eoUMrnm7WR32nV8YuDkfmQxDt/92lnAykTKAxz1gb0jeJ4TT25bEclRV6?=
 =?us-ascii?Q?utmZ+pwq6ZbxHXWTdM5WV2ljYeRsJdesnqj/J09RWPh6oxQDwKhK7MXGsOgY?=
 =?us-ascii?Q?4MFJWPzXjfXd7d2mVV1QklrMhrhUfoPMz+g6ka8OMnR5zck7B5FkvkRl7iI5?=
 =?us-ascii?Q?h9tEzRuaF15xHXr4bYKdszZf54l4cVnx8t+DHjY68sknbf2fLvpLvk0vePKW?=
 =?us-ascii?Q?d2fXLthKzZc1ZK0eDTR8wVyNDEKpIw6SC4t1lMGcN+uISQkMtkAC7nW2V4od?=
 =?us-ascii?Q?pW9vb4dNR1PXz4Wu79ul2gs8N5bi6G4O95axQMWleshB296dp1aeoirEOjpZ?=
 =?us-ascii?Q?YJE5HWe4NIeFT3plSeMuhpNB3xVfkc4uPFBKker0OGoUW4EIF36pFNXwbiMC?=
 =?us-ascii?Q?OO4br40KGumcl1H/z8NDbnvTfw9eQR6r7rU18XOOmKkkeVqpDovZUtMJ9WlB?=
 =?us-ascii?Q?bsgWlAU/++sdZwHtFlnyLMYpqTJ9NVor8JuIlyU8RUQvqGQYseOcFRlw3+cp?=
 =?us-ascii?Q?oZZMIcbcNoWr6hHqKLVxThk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4159e0ce-42e0-474f-4a2a-08db877bfe96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:42.6077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Svh/OrvJTH69pzWmLMiITnLOU9JqQn1f4Ny0/Bb6cWg3zGt7wppQqtFA5B5hnotT7mwzdkI92n0BgMQrQDEP/4bPeYHCD5z3cF8KKZWPNmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7894
Received-SPF: pass client-ip=2a01:111:f400:fe0c::704;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index f7b44cb433..a78238eadd 100644
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
@@ -533,6 +539,139 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
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
+            goto out_repair_bat;
+        }
+
+        guest_sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;
+        host_sector = allocate_clusters(bs, guest_sector, s->tracks, &n);
+        if (host_sector < 0) {
+            res->check_errors++;
+            goto out_repair_bat;
+        }
+        host_off = host_sector << BDRV_SECTOR_BITS;
+
+        ret = bdrv_co_pwrite(bs->file, host_off, s->cluster_size, buf, 0);
+        if (ret < 0) {
+            res->check_errors++;
+            goto out_repair_bat;
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
+out_repair_bat:
+    s->bat_bitmap[i] = bat_entry;
+    goto out_free;
+}
+
 static void parallels_collect_statistics(BlockDriverState *bs,
                                          BdrvCheckResult *res,
                                          BdrvCheckMode fix)
@@ -584,6 +723,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
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


