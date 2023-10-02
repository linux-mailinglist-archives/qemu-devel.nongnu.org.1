Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD37B4E71
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEko-0001SU-SH; Mon, 02 Oct 2023 04:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkg-0001RH-Lo; Mon, 02 Oct 2023 04:58:06 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEke-0003Q6-Ld; Mon, 02 Oct 2023 04:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHkRBEbCweH5KpDIyaljq2nyS4mx2vUfMfdLBNZDEMMx0Lk8ANdUmv/dxVy1K/dimwpW/3VkKPKXJCHnaNx7dToiTyLcWQE3WT0yyHXpqTQT3hxLUqEjUvXHaovuM0ieBlQZlqg8sJHKXDuzAyE+uRuAVJ3qfc2vYjL4+qOB+LJ9htUrwxMFc6nUWo/Knp/bFlkVB3FSsuPhipHs3F/hyLBz8ODliIQBwC5lrCNbfuZt61DqfsyTMd8tNDqmsI4yyOkoDd8kLn9Z1MLf5+oxSi//S2DgWQh4HLGf0amFo41otaQsryjjjKCqAN1q7EbA8LRkJjSU45tjkfHxCO9kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/YzbWkNcxjnPp0Qhix7dth/uiRO73xAHwUPv2TAIqs=;
 b=K9jhleO9TuTTvNG7RZcM8Xx52bXkzZeJacoXkUuXgbHbktaM/9i7tHZC3yPDnFkzJNZJbLcjEy+i2PAWHS9NCxUx9AY9V2zWUjgIrUotXS88QrzK1e0q5BOKVeYeSj3KWmZg5HRv6/GmvDWbV3/Mt8CBFuXomzFLCHHin+aKJLhlbi38XRpY5diWt7T9WN4hjImIu5pi9O3YyFKtPZQoxOBPqj0ec7GnZmv+6Re7lVppBvPzxT44ehIPKADwTDezcUbco+dkerZP97EjWW8R1+YflDbdDqnGDUpaKXt3BlPk2dzK8Aok7UZNWowwbXSrYHqnvLy5QCjCzoeXeKkYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/YzbWkNcxjnPp0Qhix7dth/uiRO73xAHwUPv2TAIqs=;
 b=jlE25z0bwVn46nuIeZrB/MWlT3UgqI6n14TJVe72uxy6TAY5oChkKSZlaAntLkjc7MMdvEB1+ZjlvMgKN+NDD4oCW1J8gHYjW4fmzw93bY5hSNq+y7xybrckxtWIm0rCxTO5uccDOmfsqw91kFBrf5kMslvIqy1L754aq/1ZRxbnCEh0YKU32RqMTgKch69Di32VJ1Cvd96o9prKXs3KKZ9ReS4UOvDJJy5lpmkAr5crCJ0GGy/48rPGPEx0ZDQsvhNUUDSEETieIOJV8pYepZ+7/1QIgrVwsW0caYEiqlrN5J+TvACYEaMJQr1Yy35hv4huzy8oNxqekj76BXPVVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:50 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 03/19] parallels: Move host clusters allocation to a separate
 function
Date: Mon,  2 Oct 2023 10:57:22 +0200
Message-Id: <20231002085738.369684-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d40034-72f2-4023-1e4b-08dbc325a724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81rb99q7maFokd8z9W0bPj4qY7t3yOXxUsItDM+09vQOXmNHPWLoOS3kC5lK9PpcuHZZ8iBR5Tbvt4or5tovQEw2KcTtupKeHB9lxzfxsYRdaJVYc44x+BRJR1fnnn8NwUEd2Xti7E+Y0yuyRLBTSGB/wSORKIkjoLvUtt4QMYhq+ybYEOPkKuEvnMrvWU7FA4IzxAyYeq8787b42nw4FzCJgrct+J1AfXF31q5iIKxdR0jozyClQ2hF+0EseJwHaV3/OdtFHKjXiY0o8vRTxs4xO8bMPTEjtng0Dp9X+HhUSdK71MuTIoEOoqjCbpCTWo5kXHeFnp2pARBvPezO+LsfyPjqMDlrajtPmE5ERjUZvdiepORIdbsbeKtZdyAJf+nyzyMUvJglDi2Cv+TfZDPI5IHu0rnkkcknG7KbPRXOgQul4i2Bu6pFWp6mCxchUH1jYSZmmUOjXkpq2MLQQTMgOzVx3jnHHw/2UbhgJXl8Mlglp1YKdZ2xtTLRpORoU4dmG0DRo40ah5T6s8BWzgyYRAUjX3EKy3f83aYqjrybKmI1fDv+zqyVptVGIOd3JJ2fbErNUw8hWk9cUl3yYxH2mmuVJ1h0pdQ56WKJxzBG6zJtVjLWrmoD6QTWADZL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JUh3QvlWH6yf1aXgfpTg+kentD0AtEmZHJJSayAAyb6UBOBOgyRCxZGLFhS?=
 =?us-ascii?Q?DlxhqlbezccecK9kG3Fp3pJDMIpaZT9RaVKfqxvj8Mn1XapcK1keGOTnjTfc?=
 =?us-ascii?Q?gi1XWgXw2jeBHB+KSxHvW3wsBPHe+8nqQLR9RdeqSIPWfns1evBIAbJTNyJL?=
 =?us-ascii?Q?bekE3G7AxPqZoVfCPvEJmmdHxCqqnk/CqEUny6fQLBmtr4r3M424VN3ccCCu?=
 =?us-ascii?Q?cDZD09PlYDB+h5BHMyR89XXU2HuRcqjTRqj405gqhF54Pm7kNyhP78fpk2ks?=
 =?us-ascii?Q?S3i7QbIz1S+fv7GztuoaiwGAwAbcG3KoCzDFxc4HiMP+24BpfNWO635BKEHG?=
 =?us-ascii?Q?dGxQe0YVGFxNJvmbUqzsFKsm0fU41JvyeZQyC/SEDKUNqnmzBM11A0GIdEDR?=
 =?us-ascii?Q?1SO+Ei15VR3M/HJZKg8Q2uq0m761zyOgSrETe/dlJnnK2tPOUAcz5UzslKSs?=
 =?us-ascii?Q?NFPkdYl/xQwGd+aP4Bsn9R77bV42Jg+Nvpwp3Bdw3yl/h/2nTE6BBJ22zcgs?=
 =?us-ascii?Q?ZhdTKJ+CkA18AS0shDsJfE02gaTS/h78GBoQI0qRrYv5g1eINj0voUPVJ+Hz?=
 =?us-ascii?Q?bt3Dx3Yq1wnnZVB3AdAnxqnZfrrLox+xUTzc3sWc0qUJyD0yHlR9CZ86pZHn?=
 =?us-ascii?Q?9oQE0rahloYB0S9sYDrDt0x5JxfbqBROJdnGuomHwIN259zr5/eQOfB+sxEu?=
 =?us-ascii?Q?WCtcfPtKLaZbnJ30rwSJ3qVXx9NUUQEoi5l7g6uWzwKEjCvB7aTw4R26Ejwv?=
 =?us-ascii?Q?07CkVh8HchLyFa+PJiwWpV3/itBxSFBOaooogVllJDbdqZr7C5ySXX+furyo?=
 =?us-ascii?Q?uTuLdDazg9I7silsaYPBbn7CwZbKXaywmpp9Eon35LT7wkhpWC1ZJNV1SouA?=
 =?us-ascii?Q?r3vdxm6y4CqoMel1LwAWZNTIyRd7VNMgM4OiiEUjMDVMo704Y6ztiE4lJJsN?=
 =?us-ascii?Q?AeZi3z5x8Zqn+NRPpwkvu9fQD1WlqKLO2QlHBj7uhyZ9Asa2eK9OXcCoSlNs?=
 =?us-ascii?Q?686JwVXIrUXfyN4pUKuO3iSzB2qBM5uPkkkUnpQuB/Q2HdG9cvYKjP3jc83U?=
 =?us-ascii?Q?AaQJD69UFsT3VK6uanz7vIpp9KvGf7rD7HW+ZLVf91hrLAC/dSzFpJ35bdJ+?=
 =?us-ascii?Q?I3y83C5TIRb9aNln5CKrhYZT+N+5BZsS36mHUtAUec4A4YJXtTBEZz29RSdj?=
 =?us-ascii?Q?G9WFxzE8pnrFU6k1eOhrw7s/QjfNduhIujqXLgy0loEY/2c3E1vfIyv5GzSz?=
 =?us-ascii?Q?smJYQwUw1o/zbZo0Nf0jOuLzCrakifpdjvU3/SOwiRF31EXAtSXFgA9lxYVO?=
 =?us-ascii?Q?hqkKD8BnU1DW6b+/EVdFfgvmYPqGY/Nb/bwds3jV9JI9UUkZDRY08SNAg9A3?=
 =?us-ascii?Q?SVvSHJDCm1Ie7NZAd9o25NXW/JRIR0Qeb3IY+JYSHjOrHxDHJTrUEaA3ODj/?=
 =?us-ascii?Q?00ywg9nZMGL2P03fQcNl0lcQRq+CG2GwU1/2mhnlo9UbU+1ZyDp/leAJHtis?=
 =?us-ascii?Q?jZfBcDogKZJ73k0F9FTZEAuUCy5E8r0WXOxHmqaMGHPVckS3etZvKwOV84Gs?=
 =?us-ascii?Q?vaQwHdLp6K4CRejhYC/XMKqUvuDK2juO+2V0TdAEtVb0QXvBLELHy1y3/wQB?=
 =?us-ascii?Q?eoe3OgxqSihplr8f52fVIVE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d40034-72f2-4023-1e4b-08dbc325a724
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:49.0444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9Bnqhz4QkuDSBoNIDPk5Gum0GTF93RsFWKzDlXjeo4+k/FDwZXCceaf8nKkZ9rjn1M5smkuJa7RBfTKc00SYKCRRayPmdwTdsKUERrs/Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::70d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
 block/parallels.c | 124 ++++++++++++++++++++++++----------------------
 block/parallels.h |   4 ++
 2 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index b5e19ff921..3c69afa04b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -264,58 +264,29 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
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
+    int64_t first_free, next_used, host_off, bytes, prealloc_clusters;
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
+        bytes = prealloc_clusters * s->cluster_size;
 
-        /*
-         * We require the expanded size to read back as zero. If the
-         * user permitted truncation, we try that; but if it fails, we
-         * force the safer-but-slower fallocate.
-         */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file, host_off + bytes,
-                                   false, PREALLOC_MODE_OFF,
-                                   BDRV_REQ_ZERO_WRITE, NULL);
+            ret = bdrv_truncate(bs->file, host_off + bytes, false,
+                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
                 s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
         }
         if (ret < 0) {
             return ret;
@@ -325,15 +296,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
@@ -345,14 +316,58 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
@@ -369,32 +384,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
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


