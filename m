Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF281F6C2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNt-0005K5-3g; Thu, 28 Dec 2023 05:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNo-0005HT-HY; Thu, 28 Dec 2023 05:12:56 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNm-0000Sp-Ab; Thu, 28 Dec 2023 05:12:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPgUaCJOfZyzDBvfQcFmoRO4cESXYgvN8F3CKQs/dXP0ABTG6Jk5x1IDeyjWF0noRWFl8jVU7mLv7Rp08CKR/hwWfAVjtGe1but6bYBXM0HFxMdykQglKkGoX0M2yfcIIfX+Ki4F+wbFFHwBh8E4VvAQwlItjMUTW+bMqZZu6fl4izotKgyES4lm2WnStA0zjlJgkO6PNztUtL7XNPl9xlQjYICgmdjH9aLZJ43fbO6N3MAari6SmKItb8I+yq2SuDC1lBIvRfi8bZgLflgtYsd6webCt5wAg5tuy3QN1o4g3bGcwZ852mSkXw7Y1pYeVT+wUFsYWsH+bC7vys/Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLEBTAXP1y3bSSPP0h3JqoKN2wlm3/jxIfexYA7pjcc=;
 b=hSi1Kf1DLNvbr67hi+njQzdnK0EWL/4449eVnMzhkcP2cpqB6f+YlGos4WrQZe+vemWOBYjJjlhxDXZ8grOZ4CKxOpKhMB2bG0qegWqJx/gfcChUiTpuIakjRuRXI5NBVrHsaymYiKa4ZUbdQaQjRNS/b8vIfMJAsu20sc+0jHnzpE0TIMQr9hNH1mKz0vwMxGPOBCmNdAFeR2TsKus7UGYw19/4xelxZtyr0HklUZwtzyHyvznQYFhKbixr1YoyGAcGxJJlnA38X0TyHdgpemQprkPgAQp3Y1lOtCRcFeeKuoT9BxkXbxbqOiC6QSjDzQ5NUjJR5tqZs4T3mN59YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLEBTAXP1y3bSSPP0h3JqoKN2wlm3/jxIfexYA7pjcc=;
 b=FvSO83IfOrJa3+1KiczI0IGOZGK9VEFgpRNk4RA5f5u5lj6iprf1TvR5bL8L5myR79YJOY7o6yYDxGM70RQm344aH3J7461E2vrdb3EwahMvnAvdMMJiZ3hw/F/5us+FQp3MKrqWm+BtUuItGW/yQcpI9iTaY1OCXuqRNi0nnUgPLmgC8R5nC6+jkuMA1sGxYSSU5A0XPA11VleVebe6x5z4ktUbOcnhr+M0wua1fR5F6t5bD7SfUMwaG13zriShEf6JrSfXLvJz1ORnDmTb7RbWuB5ZPk0CvjUX94uyWOOHzpvlg5JZ69qYxGlfrHRvvGvjtXCZ/AhF6ofoBxP1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:43 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 06/21] parallels: Move host clusters allocation to a
 separate function
Date: Thu, 28 Dec 2023 11:12:17 +0100
Message-Id: <20231228101232.372142-7-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: fe39646c-0756-4fcc-191d-08dc078d87ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5giPrEzPScV51HrO69+Ok4BLyV1AFw8tHvBwmTJ/Sv8Pd0cLerVFx+Fcln+o7/IcCaGWxVeqTBarR8WdIBCSCxjjqQ1OUt7+hx+X6ugRCY/2pxCbvrwJ/hQ7A8fdxVZcTq/vXDi8JT7P//A+blOx4wHDvOfB4eh/n9+2GiX8flHGCDK+6Zmny2vP8hyNNUIQJqAI5sY/JVjQQqtUPnwmT6PQSU5lRfiBugglJZfoqvfICwtJWJp/JMrLOxOs6EUTqxQaaya1vfIEQ3xKE4+r8BBlgyb08s0FObn6pe0a32DAT+h2+e9xdbTB+X4mzTAlIMl6tP2AWJE8/i4k8A/No0f5j52xJb2MrzfMy4nei4+2JsAIAYqbEkg5XUZR7Ry8SanW/hzOTGhsEHXklKZA/9sw20WtE3QCzBJfe3L7F5p/QeuxV/Pg0cT1HjNTAaeNgx9bVM8KHBT7GOGvJdAUVU7tUxYKAFmXs3DVoQIcyOU32hnMYh4X05TGtwMzvbxb8z+jfQxN8TIAYPDrPlS0Jf4V75/7Qnxu4duQTRdbEMOzcuC8VJZz1pr86/YDUnttpsmu5VaVquzkOq0bsDsOMSs/q9RMpLuLiywtCg1TJRJ8qvgIbMjHHG1osXSO5vmr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nrNaXrYspHaG8eS8J7WP4ON4TGN/99bXIRrMVH/at7tdT7eJEiDOvcWgGUXy?=
 =?us-ascii?Q?PIrTMP0zoC9lZ+9sDHu92CX9YxmXPzUx3l28gPkuhBXARgbQy3NDWcSK7LEe?=
 =?us-ascii?Q?W1oXzeUPBryMyWKmBdTbXHzimJKR+CCqUpBBoIabXvydfMf4ZFmb4b0xez5P?=
 =?us-ascii?Q?unhW37/FhMw8OWKMSz82hGdXxbDE8asFe3TKhOKXYkt1vUcPEMHtYrTYetf+?=
 =?us-ascii?Q?vOgfdST7FLu85L5fPkqOXPl163YARqMZO5HVj2H6JLm2qhrjFJainZBLQ8Bo?=
 =?us-ascii?Q?jFcBnb6XcYLRMFAxlwSbvr5FG8SZxKCLd6WC0VKcGJiRHCy6ea0xYfks4Vts?=
 =?us-ascii?Q?ztRX+NYebjdAlNfZZsHWsas8uiyjnotCvvUevYplsKXYFWmi+xf8gheLYwDe?=
 =?us-ascii?Q?wpXM4oenFAqzHC3jY8ArtS6kiXHW5TTJyKbIgqV4GLQH2X0AuiQSLFUjnvHe?=
 =?us-ascii?Q?FCJ7dCOeXF7lSerlPEz6C2ZMeVbhBP4zhsd4fLnsLYoeW4ZhligmJjjgw6zj?=
 =?us-ascii?Q?xaeZewAPpoVCE0a35L4y5Bb0woG3OtgKTFuVzA12WssrQsM52QCgbuoKR9V1?=
 =?us-ascii?Q?Uc8DWM9iQjC7lfeS1rNJC//YlXJbF94OXV1GiFm1uH1SOQ5gUDDPa884GViT?=
 =?us-ascii?Q?a+He9fupOorlCLvYUi9h2FO7oS6u8bZO6KOPjecrSVB0V8cRuJhahBMKDJuZ?=
 =?us-ascii?Q?a2vjQg/bzTF6KICRzLZFQp4aFcJ6c5KLe/gMxULW8NrXcT/ufxmP9hJzAG3C?=
 =?us-ascii?Q?5h+SzGpaBWXSexNZeLGiXT1hru8WhRIDjITJXpxlnXTGD6XkwmTWl/f/5yII?=
 =?us-ascii?Q?W5+1TSdQBfqxRUOizAnbGfjd+6KN0AwkeHatkhD5zOjaffPWKfswQcS7xVqR?=
 =?us-ascii?Q?h/91wr/7YcAj3a/gabGL2jowi86nwYm4TT7U5v5b4ejQzF9uemBu1Sx8MpoT?=
 =?us-ascii?Q?+xhTtSn3OZYHuBzzRh5B330yc1mgUJQj4LZyAjc0zGHMPo0qy+Aeyz9/+vj9?=
 =?us-ascii?Q?d7fG5Y7YDeJ/DTsexBR2Isx0TWXT/9WW8UGRbnuwt6BoGjl4m+pcojwRqKTi?=
 =?us-ascii?Q?h0KB+jYMHereClECKb2MIGzwlgPMCcxhY95hho0xia57+HfORJ3ndD3NRL9G?=
 =?us-ascii?Q?bpiPknqClcq3AmKPMdxfY1AoeYyj+BIJRIWUGq298vtUeWLrRtJ47l1lz6nN?=
 =?us-ascii?Q?NMbiKtx2XQfaN806pTk2MYRvqOKddYwLBmdcIYC93547TX1lIOwghHLQDVWO?=
 =?us-ascii?Q?6LTcgQ7kKWaQKbKdiSE+t17L4HR2PKLLSbvVYib/7catEgWbsWC9rvyi1eER?=
 =?us-ascii?Q?WQnWauC7NmU/epde7TwBTrALRj5KmrWFNOZbh6lpGOMcYLtEeu2x2yMh2W+J?=
 =?us-ascii?Q?sf2pAL2VhWMXrMsS1yzDDw3BscAfTgyzTDY6gE/FImaUrcTYdMpaLx0RDFw6?=
 =?us-ascii?Q?deai02PQE6EUexzzlsN6BhwRqwbG2Kk6Bs8RYNlFfxia+TM22/V1Rgg3GL0N?=
 =?us-ascii?Q?JWe5d86fp3wrJwvZiZYznwBdBPyNbmFnSTSno+Gj6diQ+y7tiPuk5qs9Gcsl?=
 =?us-ascii?Q?PxA4OWy+XdQMWOUbPq2fUKdY7yl1gCWyMayTkqtCMv7exeWdoqKfeRVp4AFc?=
 =?us-ascii?Q?EyXZ56nqmc7QsEewFd4tn2g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39646c-0756-4fcc-191d-08dc078d87ab
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:42.8976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTrIjdE+mLC2ZoH0WVs9HSuw/riU+B1VWolHs83wjDhF5+OAHjfi+WnVVPEYJ+cyw2MKXhlds+W2jqPSuDh5pi9hmkS1gi3a1mfIRF4ryyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

For parallels images extensions we need to allocate host clusters
without any connection to BAT. Move host clusters allocation code to
parallels_allocate_host_clusters().

This function can be called not only from coroutines so all the
*_co_* functions were replaced by corresponding wrappers.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 128 ++++++++++++++++++++++++----------------------
 block/parallels.h |   3 ++
 2 files changed, 71 insertions(+), 60 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 13726fb3d5..658902ae51 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,58 +268,31 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
-static int64_t coroutine_fn GRAPH_RDLOCK
-allocate_clusters(BlockDriverState *bs, int64_t sector_num,
-                  int nb_sectors, int *pnum)
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters)
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
@@ -329,15 +302,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
@@ -349,14 +322,59 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
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
@@ -373,33 +391,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
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
index 02b857b4a4..493c89e976 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -95,6 +95,9 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
 int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
                           uint32_t bitmap_size, int64_t off, uint32_t count);
 
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.40.1


