Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDB97D9056
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZK-0007kJ-T6; Fri, 27 Oct 2023 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYe-0007B0-A8; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYb-0003ya-NL; Fri, 27 Oct 2023 03:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ1PgXCD1/mQpDgNJOfcb5rwcbYZ5edWxyZ1kzy0RxdiauVCzMX80qsdcUNpDdZJ1HMzu/ssHxAdnxybw57KWk0OPSfXKe72M2FjVjDUAeB8Z9tRu27Rp+wGnaFUcrYLiJB6EOF4eBY/iuORF004GRAc/lAg4pxmdOtZJzl7yv+rTtKbVFuCSiFA5L2jpxuYhFpq9TrIhUiugm22/0s6gVpnP1jRh3sXc+GmdEKlMXE2LtbJEmiwwh0ybaQMrV+7pIRY+Vq9hMzau6Os7YDKPq1J8U8JnWKlw86EGHhbDoZ2gIgdm5f/4tpDKXHxLF1PazFKCQxVZGwVEOxoaXik4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aseExujQTqvVy9E/a2V5FLxERrAg7pyhaSBNO7pbNo=;
 b=jYJGtBk3El2q+RxwCC/rhKaXeep1zgPEkfwhHulwb/PiIvXyTXc6Ekxd/Olb7xiG/uBgGBLP5RyJ2Red6x1qje50HHiOOQxDWn3Zn2mwqREcS0KnS+NwA2ZbChUK0gW8ZWQjyR1cuvX2//vRIRjkeoluJblxldTxF6h/ltFALJm0emA6NdypmM53m2H9lIxF7i103wssyg7AFyzswWeQkaU3vIEoXFZ3pqayhdEHB54qVk0mU/i/cPsr+20hvjkwVHwc/cmS7GzkPCDlVlAw8h5PlLawFdkb5564J/f7rB9XRlRvV2pVbhtpNewxglyyDRy+NZvF0vejS6YOach1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aseExujQTqvVy9E/a2V5FLxERrAg7pyhaSBNO7pbNo=;
 b=nVsXCF+DogpbR3Vz2viPTR4C9F13sQDx0E7fgio2VrpzD+AmxJFCUvqOBXXq8FB6iMVmofgh833JXfB7ZxEtPr/WoqVRl44VyYnNacD/3HW47YrR6u2sRk/sT69QIQaZK/lKcjZT9UtZovn33hYtYn18xyKKD8ilI85Juzcaosfe+vp2+nyJ053HfYiU1J/E7f9SuHvm0JaIn+F2AnO5+P72lk3wG0cC/OiKy/73Bj4mCBdUyFWfiSSXvwfjUnf6tLILwP62K9m/fp47XCoM+GC8D9n0F0UAsnnrzCkqiYjjGiG4yQGNTT8stB2TDYAr2H9bEFQz9pCliHBKNHV+6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:46 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:45 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 05/21] parallels: Move host clusters allocation to a
 separate function
Date: Fri, 27 Oct 2023 09:46:20 +0200
Message-Id: <20231027074636.430139-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e339f58-bf0b-4772-ea51-08dbd6c0ddea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVCG1A1vNRBgT0pNz/fffYpwITFw/tGaMNJyc2gCG2cuVqc+fH+N/5OiGNT8UwmV9pQgd68nmUpJJZj+012qTgRKDXvrY8h9dWPfBmYnJSDKIJTiHOr2V3DX8Dfx9z/h2nH2qlULKf+iqNv3aa8NIlKrzJxoYYjH2/dThuQ8wz1FqzM4eiUDwAA0xC+IPVHB+JMbUnOQ4iEf6BU9fqcMzoeq3BFS4UZcm9MrfWF5qbr1GoWlnSbv9UYil/c5GRl2KkIk9fb6DImwZLhAeV4ag/4hTWCJ3zf3xSCKcRKl7ozCbZW7Gxn9jfRUV598NlQRAMPT9BIpZewnXH0mHQvFQExJOlipHfaiSCQFjsLuubWGRYtMwF+fjaS32pO7HmZPOjmpi1Q3EC+dCHgVvFzddbCBB4u0s8kbObRBHzg6UIgii5vkQnQXfKIMwFwSaooyvqLuSYQaitF+lqDDTU3OLjbFj7aE9LovVIJ4ABKI/h/UlnqAxLm0y29OweeJg+t0+FV4EE+zpxBjSQ//U43Z1fiQ4tdoWea6YqcPguNPsG3aSXtBJACTslAdv+lqeoO7Y2OLnLbHZaxEhQ7MohpbPfirrCl0nx+mt71IAlZ60rBiNHCYoWyEtdQEh/RubNV1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKetHXm2gd+eJdDJVhfheKuk6ZuSr/Tmt3v6BDkmfgEi8tNxV2Y/9IJeL+Rp?=
 =?us-ascii?Q?i89FjZOSs26PmTEWgrk4FriyKm53B8nOFjWvhtXOm1/S4H7UX4oBaNMOVl2D?=
 =?us-ascii?Q?/rNPoxlJzTLIFlftsPFpbaWXnh1W8q7hoX8/Z+UlmOnHCNOEMtay2tCv68/b?=
 =?us-ascii?Q?GjtkyzXjFV2dK75rzV8hDAa8ux0WpbSU1SaKYEvmKEhjJC6qtZBQni2THKDv?=
 =?us-ascii?Q?Gz0UU053ycZOZyi+Adsllb60oOlxY+3PC4B74kRSD+ullXMBgIno0vD+fDcF?=
 =?us-ascii?Q?W6oQNAfiIpZhNB4SjD5ahkGTws2iY0qszNG3Hlmx2YpH0E2FQMbYOaOFH1aC?=
 =?us-ascii?Q?d/jUJWQQENhp9Ta5pTlM5Uh3JTx7CegARh8y+QH12JkCZID6SasUptfk07Hc?=
 =?us-ascii?Q?vA51FElDfNRe6t1R3fwj3sIdv7CPqUGXgHoHT2iwKWADNs/l1L3XxwLpB0vq?=
 =?us-ascii?Q?mxfZ5ObvQED0iY9bNoeB/bMkAGwlKMLiGPG7ayFIfTItLC4HKTiH8H+1cwkp?=
 =?us-ascii?Q?I2seEjG7Cvex0zxHbO85LSIJN0QdWL4TovHahg1jeLWsauD6GMrgXp3AEAhN?=
 =?us-ascii?Q?wCSvwt89rJmmbxqho4m++FU/ow1jwrxR5ZKXIqgQNXPyWirhFP2ab4TmJFnY?=
 =?us-ascii?Q?ZFOA57FyIjZs3qLpM3RJBCJJA9oKibV+WOqxNteuTZCur+gst3p8ZRRC1fOd?=
 =?us-ascii?Q?bgut4o6zPefPLm5AHBIW4nuzlbPz1/mDhYA+MAUKB1C+ryorrvly3zKXHHOk?=
 =?us-ascii?Q?UWVUd07cGA2+A7otvS4e2I9hKSxnvYmuVltCNp/qCVtNi0+FyLU/5zqQy/bX?=
 =?us-ascii?Q?56dy44B7KZW3VD0mRlBqNBBc+bK/ygLBBsoIwGHkgXzXO5IsvB6oVCEWXYph?=
 =?us-ascii?Q?sCvyVCUnA67Q60+z94K5hN9niDLKn1Gw0eSJaKZX7BRxPi1lC0eAPNmQBgcx?=
 =?us-ascii?Q?o0qrJKQYsA/yKPwquQt/DqD3cLvBClBHh//yKSEunx050R+HLHG2vBAU12gP?=
 =?us-ascii?Q?SUX87vvi0Hu/hGk79ccQptCnk3fHf9B4A5QANucjh8aXkStE5zVqxyqb7KXE?=
 =?us-ascii?Q?9qbebCpdsODOKP3XhdTbSOPq2UMR83g4I11cwAtF8NqMdBYmEmo9p32hwEdW?=
 =?us-ascii?Q?xJgcZxcX43GkLIyqnIyFcDWm3fHzgGtq9J11SsgfSJsjP28Bq9z+qCCr4hKM?=
 =?us-ascii?Q?qoxPNTfEaN4vco0/otUocWVcUPjV1JE2yYLLvp8wml2VGWPaI4nujQjV8rVh?=
 =?us-ascii?Q?PKh8WQabiid7kYRnwZhBydbOjP6PfSvxVGy/k5Xj0EyHIllX4BVjS158kOLK?=
 =?us-ascii?Q?FCr3Ag7eWJlkoLnd4ZZFhofKiIDY+eLnHNxUGbefFMANQVEZ05M5YuMSiGbs?=
 =?us-ascii?Q?nBLAMWspITgMBTW1z8RwwQvIsXss0Q2F+hQ302xFkTPeCK4KE17bt2LJ+G2h?=
 =?us-ascii?Q?lJiX9XqwITszOFRfiH++AFNofpnHTaNo0bPWxTxU2IG6yZ3WCEhwHmzEgc7y?=
 =?us-ascii?Q?hLGvg7nBjYAY8sOFrD0fki/SuPMGodczU2o9gzn4/FBMRcs+JUFl/vMW30Gt?=
 =?us-ascii?Q?3Sx4TSln92neEwhnB25ha9HEkW3PC8O2KW9O7aEmaiJzL0cvV6tuYkMI8c/P?=
 =?us-ascii?Q?99z2s08t008iZ9zzJplDhCs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e339f58-bf0b-4772-ea51-08dbd6c0ddea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:44.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5+e8eR8H0iboNtj29xl6wcigMkmIyBa9PGxsF7FEdk/jNj5o2gSNDOYZtjWX/w4V2K1kXPqN885I1ULVb4JijyQBsoFBZBBf11pHuJ2RHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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
 block/parallels.c | 128 ++++++++++++++++++++++++----------------------
 block/parallels.h |   4 ++
 2 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a30bb5fe0d..33bb8f1084 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -266,58 +266,31 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
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
@@ -327,15 +300,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
@@ -347,14 +320,59 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
 
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
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
@@ -371,33 +389,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
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
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
 
-    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
-                              host_off, to_allocate);
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
index 31ebbd6846..4e7aa6b80f 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -95,7 +95,11 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
 int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
                           uint32_t bitmap_size, int64_t off, uint32_t count);
 
+int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
+                                         int64_t *clusters);
+
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
 
+
 #endif
-- 
2.34.1


