Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B67CFA23
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScT-0005kL-P3; Thu, 19 Oct 2023 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScM-0005h8-Se; Thu, 19 Oct 2023 08:59:15 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScK-0002f3-Nl; Thu, 19 Oct 2023 08:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSRsccyEK+bLAnz9T7dpzxx+scjl0qkJgxwrMJbYH+0M4NszZwLlsQX+Z2ED4aP7uB40wBZM/xdgM/pTwLHhSAiWroKYMqS7PNsViZ9NOSqCrigimHq3cJLKUStrc4dUBmQjq6Z9F0F+5VP+m7XN8i5fCP/CDZHw6IOJQT9rCW3eiR5+M5aPld0BEHy4tN/gN+JDaOLvkOl3HyWBpkQ2X5VCMp2/FLrEUpV/6aK7cT67xKOdbNXVqiQruKCFMFaqvv05CwUCr3DlZW3OqXHZQuK6gCRWSdiU90gJRa/iHHICE7q8A+63yiEFkcHDOxBMr1aHQpgRTTmFOBD44iBBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJTjXlH9d+c1eWZwqQZdk1+aL299rT+DTPDqF+pBQzk=;
 b=FdSDk2waPSyu/49iIa+3TEvV4dE9myVyQXWdV7YwxUMsCNoW9Wtcb31l9nZO6mtjyMA9cGBx3MQBUqM95bWkMTcnlvkpoOH/Xxv4xxpUsOiRpiYvqlhoBLnZ+AEpMzhd96xzJWWY0e4Oc2DC7aiPATHJNgG6yv8jm7OJ0kika3hybvyrSfWVkB1O0tSWIFQ4M0M+oFc82kG528SUyyHoT8Ay7Q79LBIJcIsYQ8eBEiK9M6fox2UC5lvfK/iVRzn8CKH+SeGGz95idbz2GYhkGuGmFPnjZA2VHMW2yTQfvD4c/lRjo5QvfOCCpVde8NkzFxB9a9goxwOseTtt79kfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJTjXlH9d+c1eWZwqQZdk1+aL299rT+DTPDqF+pBQzk=;
 b=vv5x6ZQ0oUqns8IXEIM4/hJcQLu5IKgXkhS7SckOwtvli7erhHHsRy/FMhQP2LLdNT6Rx+01mmGbEdJui4vGOJdtqCTeiCa9R/JzamNkIU0UFyDoyCPBSsjn0nbD4253MFW+ToKifpxtGo46TdriCdCOvq0NtODwubaLOe+svqJhPwmNuhTilY1ikzZs3ZahngHABcghpNrn3OkvhNmqDG00AkShPCcJgnsgtAsQL6CLEPgyyoESAmO+ly5HlilFMshcwLBRxNqr1oOhhI1iflVtOPkF+E/5nsPdH5Wq2tzcoiKkpwhZr/kQH+D3HveHrgIL2z5nioXwM9wdviAg4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:06 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 04/20] parallels: Move host clusters allocation to a
 separate function
Date: Thu, 19 Oct 2023 14:58:38 +0200
Message-Id: <20231019125854.390385-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9243103-d002-4835-d176-08dbd0a32d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryNJ5rBRqkd6NxQc6JEdYfDeizFUB+zVtOXPQU1qiGJ6OzdZ4TfKSLBVcvzOUN5WZBiQ+S+zGqz4Ujmmr/VM5saVURzSiym3e9+jl65tvUGYK/DXe1Wm+e04G5+hOL5vsRvZ9jEJMb8WXh4SMY5q4rlcXUD78P2ZV9QUJwYHWT5+YaHrRy23U/+Pt7hk4SOAsjTHwX+cRYVDRDBTZg9xD6uUMQNhaM2lPXcKXHszN3RaKvnq9CMdrilD3WRfqOgc1SDn+RBRCdgtiAeZh2BkaHyn4QnGQnUE06Xv6az4ALh1F1T9wm/62wGUogBbirLdTmKEbRWJ9U/0F2FjE9fREi/wSkknYVHCJ7FKfR0oxuhpA3j2EnIXfwzqzRDY2a/WNm6HIrCWSWb5VETUN9M1U1xFnMOCYoQdTVKkRu8gjYQEXN2suVCicKDFzh5IcuZ1bx/FRzssOZpqmT8Sebku/bwkb/Az7M5arXPC3oIFmLC17eGwXyxKxfF9cbgZ2Gp+KwxaUrLk7hb5eBw2h6V82NwaIKyMmbnUE4qVhYD7x5kn8+Y7Sz/4KJ/XutgYTT39Ioj2wVlxCrPzyrBCKrIa7jNSMepPjjvgRnHpl0UnOgqvTwTydQWFwpqyZt5L53Nb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8ihcfnZKM8+sAy+Xnfz/wk/pgW0Z2aF4+arql5mW7+61l2+FMdXszSH+9UG?=
 =?us-ascii?Q?v5cGbOAeLzKZ75t4pr2M8FGhFKjz/iBjGTwvbUgbrtLRgApjftCn1Tr+hnWl?=
 =?us-ascii?Q?98rn+U1E1jZc/PHAdK2LNKVrS4eJJQugp80uQAWiITdTE8QqVc53blNuhuUW?=
 =?us-ascii?Q?H1C3/C0W6Z/ApXfOmTFnXKUHymRpxekRHeVNqA5yCF8GER5vVDJEEWBuarnV?=
 =?us-ascii?Q?Q4O+6B8iiyVgBt+vPzE7H6ktoor6QKnzOci0mwy4YgLsykWe36ExH2Z1KMb8?=
 =?us-ascii?Q?gml99RzTuu3AtxdWK2IMnH9IWbl3BSLSUqtBkD52Oe+cG4py9GvLgbmDrQYR?=
 =?us-ascii?Q?UxLnIcOjinK4DkWJhRyz3C5vMmkd4dzgs1RCCdSMDeWEI1sgwEyw03p33KFO?=
 =?us-ascii?Q?HL9GbAoct6+GvOC/HEjLaydtsO1lWiYdLnqcCvuxZrEVin9sxlut7bTceK2A?=
 =?us-ascii?Q?XNKurg9pPj7RTnmu3dZDS8I3HrLpgoCI09yD5IFaMrGWe3+YpWbm0Rb2JRbY?=
 =?us-ascii?Q?FNxtLncGuCX6gCtAhWCJfJBITZUDXjEBGTDNomd5AbwWzRmeMMIQv4RRNqbX?=
 =?us-ascii?Q?9Sox+Sb9urnltjMYb6BFhC4lUWR38tJ4aqukHGa+pgzJIzkiXXdUNVGHtkp7?=
 =?us-ascii?Q?MIN36kL6I1roDuKOhHvHYLdxRWRP0V9hQUa/JHCrCRwiz/n7vF/pI3EkgGST?=
 =?us-ascii?Q?K88RRf6d71/hrIPSy+eIEnzBXI/D8lSfqmZ+IBZwTCDb+aykZ9e0LrD+eHDq?=
 =?us-ascii?Q?R3PnE3JoY8VUIHV7VscfqdARMr2jUG2MxHvUyoRFIB1+FtjJKX3hiYlh5bBe?=
 =?us-ascii?Q?cVJOBAK8mxGQQWTWT4Npt3pWiJIfpAVSq3WQJ+DqWw+rUasEabdP1cMKYrtV?=
 =?us-ascii?Q?KliVSUQb5w9/A+Y87Z1dM2MuAqV5BXWLYvaCKsIuqEom42t1H40js7EQ1nH/?=
 =?us-ascii?Q?SQDENKT2TyM1+YI8JtDJZf1wxlfc4XNVejjquQOrDBMGrUis4HtaGTgPjHRz?=
 =?us-ascii?Q?tssB6wY+gAU4PWObqsGe59cwzUmsVEIdgRVCL+QC+lTCwOyTissKYBuejeyJ?=
 =?us-ascii?Q?ZOLNOQ/+2WrWZoAqsWzXa+fA4EvI1eg0we/cJgwxzoIXQuADeriIKOdJho6G?=
 =?us-ascii?Q?TsLyocKxnHOuO8Q5ObWVn3HI3CGqtZMcDw2SAjbfPg/JwboQ/blQYqSjgb/M?=
 =?us-ascii?Q?K4w+JFDglmwbT8g23GcnBF2O1XMEkIafB6Ca8RszBoAr0T+JugyepGAxbCCn?=
 =?us-ascii?Q?o/r1WT8oCfF+yJQ13XxfFWwgGsJw5s/BsgiDVv3FL79sLF53WjS9WfmOdOGy?=
 =?us-ascii?Q?VdY/uLc56Kmg1Wrue2hjUvo8HZGDMXJ+FmFcIkb87JgsGoOJu7/uUif+h5C9?=
 =?us-ascii?Q?dn8pnBXPLb1B8DhuoS65Kg6RiNWQUGWgBpVX4Br0wzOALe0QGwkgdEzpv9ze?=
 =?us-ascii?Q?YJS1hLiD+zsVsuG6FRPn+D/7JoM2EoxaM9pteUiHgpFG3AtoEALlON+Y+kkY?=
 =?us-ascii?Q?z4mncemSYnWD/7coCEmWNrDMzSvRO3Qzi/VxyibxPusDVIPOrD5c4bKFnkbe?=
 =?us-ascii?Q?PcGCc/n/70T4DA5fHCJH/QZ+RCBEWUIxUVPyjdLubMRou2cJBxSCuCd58bSJ?=
 =?us-ascii?Q?JByUelSltvHhEgLITbBmLhk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9243103-d002-4835-d176-08dbd0a32d7e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:06.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbqfURzAQmEpTU5YpsFIbjXkyj6EGumWCFhIWNjzacshzmiTc7IHjJCaXgW18KRCJxY1xMUOCO/TNjGySQNLNDuJXFW9H9r+1UYOvGg9ZIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

For parallels images extensions we need to allocate host clusters
without any connection to BAT. Move host clusters allocation code to
allocate_host_clusters().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 126 ++++++++++++++++++++++++----------------------
 block/parallels.h |   4 ++
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6a4e3945c6..ce97387e3e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -265,58 +265,31 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     g_free(s->used_bmap);
 }
 
-static int64_t coroutine_fn GRAPH_RDLOCK
-allocate_clusters(BlockDriverState *bs, int64_t sector_num,
-                  int nb_sectors, int *pnum)
+int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
+                                         int64_t *clusters)
 {
-    int ret = 0;
     BDRVParallelsState *s = bs->opaque;
-    int64_t i, pos, idx, to_allocate, first_free, host_off;
-
-    pos = block_status(s, sector_num, nb_sectors, pnum);
-    if (pos > 0) {
-        return pos;
-    }
-
-    idx = sector_num / s->tracks;
-    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
-
-    /*
-     * This function is called only by parallels_co_writev(), which will never
-     * pass a sector_num at or beyond the end of the image (because the block
-     * layer never passes such a sector_num to that function). Therefore, idx
-     * is always below s->bat_size.
-     * block_status() will limit *pnum so that sector_num + *pnum will not
-     * exceed the image end. Therefore, idx + to_allocate cannot exceed
-     * s->bat_size.
-     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t.
-     */
-    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+    int64_t first_free, next_used, host_off, prealloc_clusters;
+    int64_t bytes, prealloc_bytes;
+    uint32_t new_usedsize;
+    int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        uint32_t new_usedsize;
-        int64_t bytes = to_allocate * s->cluster_size;
-        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
-
         host_off = s->data_end * BDRV_SECTOR_SIZE;
+        prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
+        bytes = *clusters * s->cluster_size;
+        prealloc_bytes = prealloc_clusters * s->cluster_size;
 
-        /*
-         * We require the expanded size to read back as zero. If the
-         * user permitted truncation, we try that; but if it fails, we
-         * force the safer-but-slower fallocate.
-         */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file, host_off + bytes,
-                                   false, PREALLOC_MODE_OFF,
-                                   BDRV_REQ_ZERO_WRITE, NULL);
+            ret = bdrv_truncate(bs->file, host_off + prealloc_bytes, false,
+                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
                 s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, prealloc_bytes, 0);
         }
         if (ret < 0) {
             return ret;
@@ -326,15 +299,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
+        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
+            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
+        }
     } else {
-        int64_t next_used;
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
         /* Not enough continuous clusters in the middle, adjust the size */
-        if (next_used - first_free < to_allocate) {
-            to_allocate = next_used - first_free;
-            *pnum = (idx + to_allocate) * s->tracks - sector_num;
-        }
+        *clusters = MIN(*clusters, next_used - first_free);
+        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
@@ -346,14 +319,58 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
                 host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
-                                        s->cluster_size * to_allocate, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
             }
         }
     }
 
+    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, *clusters);
+    if (ret < 0) {
+        /* Image consistency is broken. Alarm! */
+        return ret;
+    }
+
+    return host_off;
+}
+
+static int64_t coroutine_fn GRAPH_RDLOCK
+allocate_clusters(BlockDriverState *bs, int64_t sector_num,
+                  int nb_sectors, int *pnum)
+{
+    int ret = 0;
+    BDRVParallelsState *s = bs->opaque;
+    int64_t i, pos, idx, to_allocate, host_off;
+
+    pos = block_status(s, sector_num, nb_sectors, pnum);
+    if (pos > 0) {
+        return pos;
+    }
+
+    idx = sector_num / s->tracks;
+    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
+
+    /*
+     * This function is called only by parallels_co_writev(), which will never
+     * pass a sector_num at or beyond the end of the image (because the block
+     * layer never passes such a sector_num to that function). Therefore, idx
+     * is always below s->bat_size.
+     * block_status() will limit *pnum so that sector_num + *pnum will not
+     * exceed the image end. Therefore, idx + to_allocate cannot exceed
+     * s->bat_size.
+     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
+     * will always fit into a uint32_t.
+     */
+    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+
+    host_off = parallels_allocate_host_clusters(bs, &to_allocate);
+    if (host_off < 0) {
+        return host_off;
+    }
+
+    *pnum = MIN(*pnum, (idx + to_allocate) * s->tracks - sector_num);
+
     /*
      * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
@@ -370,32 +387,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
                             nb_cow_bytes, buf, 0);
-        if (ret < 0) {
-            qemu_vfree(buf);
-            return ret;
+        if (ret == 0) {
+            ret = bdrv_co_pwrite(bs->file, host_off, nb_cow_bytes, buf, 0);
         }
 
-        ret = bdrv_co_pwrite(bs->file, s->data_end * BDRV_SECTOR_SIZE,
-                             nb_cow_bytes, buf, 0);
         qemu_vfree(buf);
         if (ret < 0) {
+            mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                        host_off, to_allocate);
             return ret;
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
-    if (ret < 0) {
-        /* Image consistency is broken. Alarm! */
-        return ret;
-    }
     for (i = 0; i < to_allocate; i++) {
         parallels_set_bat_entry(s, idx + i,
                 host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
         host_off += s->cluster_size;
     }
-    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = host_off / BDRV_SECTOR_SIZE;
-    }
 
     return bat2sect(s, idx) + sector_num % s->tracks;
 }
diff --git a/block/parallels.h b/block/parallels.h
index 6b199443cf..3e4f397502 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,7 +90,11 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
+                                         int64_t *clusters);
+
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
 
+
 #endif
-- 
2.34.1


