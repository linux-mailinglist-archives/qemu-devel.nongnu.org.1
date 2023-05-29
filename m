Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0F714CD0
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eay-0004Bu-QU; Mon, 29 May 2023 11:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eat-00049T-8Y; Mon, 29 May 2023 11:15:36 -0400
Received: from mail-am0eur02on20715.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::715]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eae-0003QL-QE; Mon, 29 May 2023 11:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD6Rk7vztDfJRpUTNwAOZjgVf7F3joXzxzTg+E7sVFl3hAX19p2W3k6JeF1aH4Pz+86rNEdvawQJlYntSaGREp0IfAITEp/fwATqIpT/djsO3DRqntfaXVGKfS4yj/RNu+bh/bkBqtHRVuvCCn6ZAYRUSb2bkbUUO/7j3EzkZr4l4Vo+pyNlAHzRkKR5A6AwiLzd1oDqalBV7be1yWzPCHCh9Fq9BuFKVSO2hLGBSHhq4XJo3ubjA18RXIi4/aed5TpsdO0pxc1mlE4RCfTYOQ5+dpW1IO9NRYNKhUZsmRFO3BSIBOrCsOzl/z2hGydHGKiX4Wt8tDLp8HQCZtmlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mnsL3AJogepgecIdnap40aW7/qrXTop9gwA2v10OUQ=;
 b=RxmNvkr/pfVSqQ6PL8VBtJo01f4quZl8M9i3Tkrpe0nE1IDwpFRYa9fSHnaCZymjEgO7khVQ0pvd6MoqpNm8cqQvu4KMa6Cr5Gv8/2LCc66aR92Qmg1Zn9LkShaby5xTDKuyXXQFFTp1aSQTvObxXcnsd0Cznj9NyGUtXnWGO0oID9b5MqHwnkK4UhWbaE8PA54v6jCHuuLG8nb3ORAfLBTopwaQbVnmLsAEPF/N/jspPHJ5Xb98nZ0qFxd4Z0vUbhrMvsO3jI4Zya7NEhnXjCDrqY2EEVDCTP+U+kVsVgesuiJFJR7++8RHdFr8glsc3gSr9k2Km8VOFYDNthv6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mnsL3AJogepgecIdnap40aW7/qrXTop9gwA2v10OUQ=;
 b=ey9lACOCaIMZloRupbVjyCTCpU+X9Ca+Lkl6i7hu6jbYF6v3/Frfn/EhmuLobowpDITFIT28reob6rFcH5yxptIyBdolAC+D7/v7YvpVzLFX8stZAFS6wjMb3i5AuNPhwkiMWWaXFXLBxhtUYTZzIJyFPHdKNf6qSkObixKgj8Mbbect5QWMgL3yqMZg63jXtO8GkV/jGU7W8X8/Mk6XxqUdEY7yDcQyBXgkxZ7ccHzJanJ9aNi4ZvRtnCKhnPgQWJxm8nyv+QpZcoNC2146cI6DR5DQoPdJOKY8dF3ihdRlKuuaojXmGim8S7lWKu/yQnIWbCXY6F6kpR0d1/uVxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 15:15:12 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 15:15:12 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 3/5] parallels: Add checking and repairing duplicate
 offsets in BAT
Date: Mon, 29 May 2023 17:15:01 +0200
Message-Id: <20230529151503.34006-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea7d1be-9fbb-4da8-9a36-08db60577fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg5TtakWK5YW3qQuN/82V2sJMU6d94TS7nQXmRP1Bx+l3+FF0doydk8707K3jAT51mtZ0ISodw33egVOYszwdQBM1wPU5BLw/JWGkZru9nnVC9OxhC7zDxEYyltnVp+7iUH3bvjeRC2J4T8h92Po9xB82vy/W+oH1zR8Deb/Es7km9Kl3tSXEA+//Wn03yUr4Zpykk1uHZYfnKKav4i8hIBWoMNMaG5VT+4v5UNSDkSE686HpG90saYhkAjMYEK8hwuAo4rZL5EHsd6f3+P891ftTJTKh2xd+Ssq608tmMJ2eN0vuw0Bn+27n3LByh4OhPHIvvPIjAVGn0hCPvJJvI/B6wpJipjvAI29yhM92fDTtfUKgyNfYOhYzCNwY3UiUz0VJmzGjev6TNEfBpJv51+EPsiMiki/I1hqUyAXEeOwugN/t6J6rPVz0PMih/CFchJHQ9SzQlaal37cgW/DdgyPcCyGF5h2Komz+Odz2R42UoejuLpEjA+7IAHUmaLUYEpgBQHsR/mqIq5DHo32Bkzkq73gdqV7WXuhXrYKlnT0ei73H7r3Is1/7JIGsLLq9fuc41pPe9yOllNU/XHKZMt0D9uHuUnu8Pltmb52Py68ZgEjpP0hxvS0VHk262kF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rn06hyWGhXfYJwozG35xMmqxvLAb5ov+5+ifEFjJmRYJBAXZullxc7GTi6xj?=
 =?us-ascii?Q?+rOkgeMOQhf8w82IbYrdqKUXjM6NCpgIbL+l59CBSqVnYTgbwedglOmFOYC5?=
 =?us-ascii?Q?xR20h12gsO1f0wB14fpB59UdVeioJviSUuxMtHFMctaI7y/rHWYj089wHUuK?=
 =?us-ascii?Q?JNWHmVoRgwoTTBv0wmSt237+Ivk9gu1i0fVCgbEPXlYpNiBleddgZSiUSXtu?=
 =?us-ascii?Q?Fk/MGr0zYkmruZhR72SU3yc0TaBfq+B/ZEUyiMLrBmIarf7SIaF4eMsArIZZ?=
 =?us-ascii?Q?KH0V2YrByB5RyWW4O/iQ4a8rW7OwK2bmjs33mRSZrfS1RVqSErPvc+QjzjFQ?=
 =?us-ascii?Q?gVG8Pcf38EgTk0WOteMQ+dqJtF4StY8/zwpGNt9gE8jD2cftawPNK2Rc7R5Y?=
 =?us-ascii?Q?7JCrwBKBO5mvBGdEhh4OXibZVnE5SEuk9vnOXreK+6B5LhOYlIOXOApbU+tS?=
 =?us-ascii?Q?//D9xjVRrb37yGCd9PfVJxYselqikhhExxSxK446ODbX7Zovf6WI8c5YSqo1?=
 =?us-ascii?Q?samkcQZOfx6qgyug5occoPm/NuUVYNopYsMfVzFiyo6DHGFrT+aviMyJxETU?=
 =?us-ascii?Q?Y3gWQCrm5Ev27slhYzhqxWCbOjAGFu05uCvSlsPFTu0lKIFx58lBngYovObL?=
 =?us-ascii?Q?3i7vrmwlCFBQxfbACWPYXiZjoAtK/REk2eA6Es9UTp2tuTzr+EZriubJiZ9Q?=
 =?us-ascii?Q?D+Yp6vmUrHy6mRXX7F1Ad3qLeo8gpaWPU/KWE1sPTPA/kA7DaWJsmQgy3Wc/?=
 =?us-ascii?Q?miOOguZ4+hiOnk/DT7XeiREp+luDGOFACJR7V/BRfqTil4jPdp4J0zPNnoze?=
 =?us-ascii?Q?YUihlS7tNeEdkmcfTlmEi7jnyW9gJ9gCyyTgOuXs4NKGFn9PTs5vOZgrvLIj?=
 =?us-ascii?Q?A3Jrg9+5XiGQ2Sqj0a/WULRz+xaVRZumqVgDVgoS8nrstUIUhrTGJiW69yr1?=
 =?us-ascii?Q?sI3LegPjYmD128ofS3jiJ60CaPqYktFDVspRCM6LF+shPaUU0eMGAhF8XYyT?=
 =?us-ascii?Q?JHlLTREChmp8xw61fAii90PJN1SMXVIUVavL0nmNRYWKDxF1bImDfXXGKWj9?=
 =?us-ascii?Q?lZ8VPCyPitJAYwrYlwOm7v5jV0dizOhP442DoUFdkox6jao3ve3ULN2xt/ug?=
 =?us-ascii?Q?nEvMZJ3f9gp5MPBkaNdH5qXyE8PyuKq7PjB7OEAJQ7MmdYvoIPl2yvccgQAQ?=
 =?us-ascii?Q?XuCiRBxToayPHin1bk0BH6CRWZA7Cl//zNcsHUrt31faF17jTvQFROp7gmrU?=
 =?us-ascii?Q?L5OnJJKxph7on148nw1GvMeJ5BHedFYiufC5baJ68lY3svi667sGb52T/4jl?=
 =?us-ascii?Q?Wy8xOVYt1v4fHJjOc74Jk/Q95qSIZ1PHaEH+Gzu5gXi3Mdkm7zd55UhkmO7N?=
 =?us-ascii?Q?q0HGnkbbPFkGZqvdK59mruT5Dbm6PWJkJ1dKyzrKROkbcKn824Q6wmn923QN?=
 =?us-ascii?Q?LJurDLHKQT0LaXuY5ItbAYFNOVUMcRPOPdiMoEn4Y6T4Q0ci2nt/vQieS1zk?=
 =?us-ascii?Q?7V5HTdWCQcwRYtCEtAdXt4MWsCnopIEVf0YqZw6lAQYjFBooSbkEikh6WWJF?=
 =?us-ascii?Q?4Z40oPzCMHRDw7bEQoAC3WiXqDv1fTBYg1QcJ6gPKQFHVZ2WfVFZyqj3R2JV?=
 =?us-ascii?Q?9i+oYo177HnqEmo6UwVFN7c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea7d1be-9fbb-4da8-9a36-08db60577fb3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:12.4932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TKIY5vtaPo7Vzh4rBMItO4wCKFklI9UV4SQ9UfCQ5X/CxzJ2OdU7+T+ccNtYdaWA3YmLb0N81fkBrAtbhAD3zdUq88YIXH2b+WftNJy/es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe13::715;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

Move parallels_fix_leak() call to parallels_co_check() to fix both types
of leak: real corruption and a leak produced by allocate_clusters()
during deduplication.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 5 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 64850b9655..9fa1f93973 100644
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
@@ -533,7 +539,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t count, leak_size;
-    int ret;
 
     leak_size = parallels_get_leak_size(bs, res);
     if (leak_size < 0) {
@@ -550,16 +555,127 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
             fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
 
     if (fix & BDRV_FIX_LEAKS) {
-        ret = parallels_fix_leak(bs, res);
-        if (ret < 0) {
-            return ret;
-        }
         res->leaks_fixed += count;
     }
 
     return 0;
 }
 
+static int parallels_check_duplicate(BlockDriverState *bs,
+                                     BdrvCheckResult *res,
+                                     BdrvCheckMode *fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    QEMUIOVector qiov;
+    int64_t off, sector;
+    unsigned long *bitmap;
+    uint32_t i, bitmap_size, cluster_index;
+    int n, ret = 0;
+    uint64_t *buf = NULL;
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
+    buf = qemu_memalign(4096, s->cluster_size);
+    qemu_iovec_init(&qiov, 0);
+    qemu_iovec_add(&qiov, buf, s->cluster_size);
+
+    for (i = 0; i < s->bat_size; i++) {
+        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
+        if (off == 0) {
+            continue;
+        }
+
+        cluster_index = host_cluster_index(s, off);
+        if (test_bit(cluster_index, bitmap)) {
+            /* this cluster duplicates another one */
+            fprintf(stderr,
+                    "%s duplicate offset in BAT entry %u\n",
+                    *fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
+
+            res->corruptions++;
+
+            if (*fix & BDRV_FIX_ERRORS) {
+                /*
+                 * Reset the entry and allocate a new cluster
+                 * for the relevant guest offset. In this way we let
+                 * the lower layer to place the new cluster properly.
+                 * Copy the original cluster to the allocated one.
+                 */
+                parallels_set_bat_entry(s, i, 0);
+
+                ret = bdrv_co_pread(bs->file, off, s->cluster_size, buf, 0);
+                if (ret < 0) {
+                    res->check_errors++;
+                    goto out;
+                }
+
+                sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;
+                sector = allocate_clusters(bs, sector, s->tracks, &n);
+                if (sector < 0) {
+                    res->check_errors++;
+                    ret = sector;
+                    goto out;
+                }
+                off = sector << BDRV_SECTOR_BITS;
+
+                ret = bdrv_co_pwritev(bs->file, off, s->cluster_size, &qiov, 0);
+                if (ret < 0) {
+                    res->check_errors++;
+                    goto out;
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
+                /*
+                 * When new clusters are allocated, file size increases by
+                 * 128 Mb blocks. We need to truncate the file to the right
+                 * size. Let the leak fix code make its job.
+                 */
+                *fix |= BDRV_FIX_LEAKS;
+                res->corruptions_fixed++;
+            }
+        } else {
+            bitmap_set(bitmap, cluster_index, 1);
+        }
+    }
+
+out:
+    qemu_iovec_destroy(&qiov);
+    g_free(buf);
+    g_free(bitmap);
+    return ret;
+}
+
 static void parallels_collect_statistics(BlockDriverState *bs,
                                          BdrvCheckResult *res,
                                          BdrvCheckMode fix)
@@ -611,7 +727,19 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
+        ret = parallels_check_duplicate(bs, res, &fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         parallels_collect_statistics(bs, res, fix);
+
+        if (fix & BDRV_FIX_LEAKS) {
+            ret = parallels_fix_leak(bs, res);
+            if (ret < 0) {
+                return ret;
+            }
+        }
     }
 
     ret = bdrv_co_flush(bs);
-- 
2.34.1


