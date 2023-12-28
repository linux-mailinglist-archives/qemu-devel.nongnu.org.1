Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E14981F66E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:45:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuJ-0008HB-DF; Thu, 28 Dec 2023 04:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuA-0008D2-VU; Thu, 28 Dec 2023 04:42:19 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu8-0008Gn-7R; Thu, 28 Dec 2023 04:42:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOEVbhuJLwLaQxhlC89Ed8yLIOoN567ISTdVUuQuW9eaqjRuWF3X+5SZZWCQf/6t26dup161oWUVdVSgaYrAli8cuHpaLraDWJ0UkgmJgtxw1X0ICisFeX3n7rlK3o2MzLUaIz1qJu2zf5DDr29xa5axG+qAvSUhw8BGLvPRnWL8l6Ij2e8hWe63cErm8Vqfx70eARpcbev4Dqj0TpzMMwbo3u5e3/PibdMQmKEKXOe54d40fpCfoVzQ4bCa2WUO1mgsRKxZrqBB6XWCEQjbvkyrQVxtWz3HfvxjOaaTnqkMMwQnKKOObuw5RNOvPA4kOlN8BvdJBKW4U0zHk9EvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpECAwRB8Lh7KQMAwUs6yNclzlBlaMN4Cp0X7tp96gY=;
 b=KJvGj3+EZbfrYoU2yvACtl8qhmacuqQ36Lxr1yWxjjMYXTdE451g436R6xPkabq7DLjv14/iuCUsEVrRFjn4H+neVBEpF435QSLZLO8ihDWOmJDJCQwsntN/hAGEq7bPE0WjNq030RSPG8BUWU0h4iMSzJTo5hWZs9c9zraXmx2e9yZfAeVjnVoe0R6UXt7fFZbFQbGNuqQYsaVwhnphPB/ki77TjhpfgSnYNbDK7zI6mg/EpTiPwJb9N7uQH11/cD5hRtGtjmMf96V6LnabZ3KKw/7HJNMeDVGVL7UzH/rFwlOZiGHN9eCoQ6fBahnJubPKG1qyA+Intx1rE3ZI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpECAwRB8Lh7KQMAwUs6yNclzlBlaMN4Cp0X7tp96gY=;
 b=shYGjrRB8R76ZiDn8Dp4/MhcfGG7xurNnQ7EZ4flI+spLsiC9Yp888KZvX7uyfr1fGlvtFtEI6kKBjJtBm5LHAlPj/qGH7sKS0FZqfol2zz5gvt0AO35vuwxG4FUmSKLDK7h57QP39qM7I/Fp8GGCFE57iCBSpE8F79tunKSW1TTpxbFnhi2zU0nELyidrW0IWuCZOYoT67G+e/sjiBTWjx9HLFWw7Ek4Su8YcOaD8TNFUjIk1gVlOL0UK3Ey2aahGCynfh1Gg47Sm6KcV+dpI42vGRTpGXy12A0YLxX7AbWc7ZGgmalhWQ27WpeGpTEy/4sQOP6+5xBrcQfUmvdbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:04 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:04 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 11/21] parallels: Add dirty bitmaps saving
Date: Thu, 28 Dec 2023 10:41:43 +0100
Message-Id: <20231228094153.370291-11-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c0a3f4c-c17d-42a8-0569-08dc07893f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe6b7Wx8+Se6kzYEZtDbiPABlSy+s6cgTBGNLCL+X5sKM7qo7tIy0ZluGBRXiGf0cByr7oMdwHvU9atPObyXO9tH8tjFWztTHvVIluDx7NVrYOQQHZly3hwzIaqVQNllIJJNscrTIq0z29hheO7prY9VES5vB+sTpte0D7Nfxsp6n62vDmlA2Gc2Z1bs0eXvws8kJWGIKDjJMJ14glRsd7aMN63eVifBzbxW9kvc/h24UZwivlV1qI/Y3jTKp9i/GZtK13erDNbOuScz5BE0H3YsxexZ/eY1iQ4M6AmDoN4vPLKWJYGk02bKBC7e3sJTfzSRbLWqcymEeXoDGZO7r8ZXN9EJ06uczevsz46ebrlXgNrLMj/EiTwH5Tz/7BuKY65b9arfJUoGYY/cxz35hbQUxLX5fKH1Lb3/TAqTu0I0IfyNwYd4is8Dt5FHbKyf9+6nmqDt00Y0IWvb+uLAVyZzsQdrtjTkDv7fOH3Uqr2MC7w0BRb6JCFX2VlTf8Qgz5o5EyJ+b19L/4H0E2Bickli77wU1V5B7nNnjlxfLK91dlN2OFgOxM41E2K20y6ODU7BAAaxc0cOybg6cRW/JrELzBdO0qVZs6DK/G2ypkkDL1qr1Vnj58E/uR11/+BxsSrNscCGkgS48rAykwKb3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4p9MThU334eNN/73V7rzgJA3EptE/HH8HD84WJTt+sX8bU0cAlPoa7rTSU7?=
 =?us-ascii?Q?BxKxn/wI/d1rkEId86HhPfbl6fAxUdEFiWWW3qva9jbquuX7FNZBG9YtryvJ?=
 =?us-ascii?Q?Sal4Fs5RAXyZTM1gLTr+8fedFJpMo+9OYV8UMGBD156edAY2oNVAqOeb+gaC?=
 =?us-ascii?Q?b/K31WSSjsCsq4VmC+O99AmOcXS+PNV4ABmm0H4No0N7w3nAKNNi1YenT3uS?=
 =?us-ascii?Q?oA6ZSLonaLhrqlqhkL/KWfMocbb/INkyiMUaf4hsxgupLPnKWu8N/guz0V35?=
 =?us-ascii?Q?55lokB0ubdtF/4q/nQQ6PBglnug81k03neuGry9pMVGpno+wg+/hnvTEMFuf?=
 =?us-ascii?Q?Pu+ZetCet2s/ChkhLyrZ/kMqNxG2UaEfu2zhqWazEYHDkdV/mN0FossJNxsJ?=
 =?us-ascii?Q?CUH5iV9W/1I7WUpTCXpXr29/y4LyiuloPDKeETc2QxW5pMW0doVn9L/PhsGQ?=
 =?us-ascii?Q?Vu6wbDcnWDL8Ios99jm8Gt+yh3qT+Vx5WlMBX+ZBF4rlcEO8QlYSoHxHIUHD?=
 =?us-ascii?Q?7ORwWNgl2i+vREy+c9g01gijj1OIMJS1g3BDe4da9Bly1L+fNMSyawjgCVgn?=
 =?us-ascii?Q?tmY4+0lIIf/BXGsww5HL3PRCDMU41b2k5UZJSFavPZ9KjcMHI3I8lVkP3owK?=
 =?us-ascii?Q?DJvwP7EqARaM7hy3HFEbkARlg2SXYrh4qQs19r7zx9xTsYAAMqlkP2ks0zz/?=
 =?us-ascii?Q?7mzQPWiQjUdXYsrjwPwQYqxdYbmRUgBZcwfbNli1rzrF3Yc/+3V52YMf7rEk?=
 =?us-ascii?Q?veND0i98cR7vEILt1k5uMYz5JwzBWPJi0lsQDdLlq6tD/tRz/TA8y49RvYV1?=
 =?us-ascii?Q?6F97g5VUJIOX5BpbgTrOFVDQLAEuXygixBOI5vixTeT9QRNWXM+0rTNfx9aV?=
 =?us-ascii?Q?Nfbpfo7KcvVX7zv1fbfHUbZhVKHTd20N2ttSxOuwibK10TZfm10cpeCfsKwy?=
 =?us-ascii?Q?WGk8xsYw0F2Twe5OCw/JvF8dRmg4utIu4wcBtvQ0WwXnWVqiMJLoAHgfTyFw?=
 =?us-ascii?Q?6HeerkU01Uk6OqGEwhogIs8gxIBiBzi0DbbFtRq6iltWhDxxwb67MFf4eGCS?=
 =?us-ascii?Q?EwAriJ5VPNFLPXUu5zxOZJu3lQz5Wia8W/6RbxbIImxyAXhisZqSV5itZM1k?=
 =?us-ascii?Q?MhXh6l5yLzxTJIUZm9C2R0/S/36/kolIYpIx2YbzZDe3XKM1HluvOBk2y0cv?=
 =?us-ascii?Q?/lCkdinM/ZoN6YtJ6QmXlGAVMnZ4vnOUdyC1e+GsmtzxoomPyg4D7NilzW8a?=
 =?us-ascii?Q?HFcpiF4xqwf9f4NRCksLck8OnxyVu12EwK+Yr8d8egXRSjr+1XQago8tORS8?=
 =?us-ascii?Q?s9JqC6a/PD70HzoeiOlCd1FiqBsH0yLi4dUPlq/erlMaYlTsgWEOjNeX7M5R?=
 =?us-ascii?Q?ToWWlVd9ADLlV45be6OMQhHpmUxc0pBCitxuZKGkQaI8tYBA85sg+6IurEaX?=
 =?us-ascii?Q?f/26qX8ZwkGIdp2ZQ3gO8GfjTikwf/DX0/grU1dz7cKHzhSdMY4v8miOkAQe?=
 =?us-ascii?Q?okdfjuXeZwOoTCF1a9GtUIFlnk85ZMbpqjeIlDiutB0u5OXaSdvYFwaerb43?=
 =?us-ascii?Q?Xos7npOxaAUMyAnIMAjCbi0kqAVbDc2LkzP4lCbafJxJIh4GOMAbOCd1KIld?=
 =?us-ascii?Q?KD+xpjcwQyhh849ci46vD+Y=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0a3f4c-c17d-42a8-0569-08dc07893f84
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:03.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU7yPFlJhDzEZ1OF7HPSLU+kq1SbsuiuXcvYsiqrly1plYimFuFqTdTlL/LUL1xqh+8jOe3rLXyat2BvJ8RUwgWSKNs6MU6N9ge+MBYIr4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
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

Now dirty bitmaps can be loaded but there is no their saving. Add code for
dirty bitmap storage.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 168 ++++++++++++++++++++++++++++++++++++++++++
 block/parallels.c     |  16 +++-
 block/parallels.h     |   5 ++
 3 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index b4e14c88f2..c83d1ea393 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
@@ -300,3 +301,170 @@ out:
 
     return ret;
 }
+
+static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
+                                               BdrvDirtyBitmap *bitmap,
+                                               uint8_t **buf, int *buf_size)
+{
+    BDRVParallelsState *s = bs->opaque;
+    ParallelsFeatureHeader *fh;
+    ParallelsDirtyBitmapFeature *bh;
+    uint64_t *l1_table, l1_size, granularity, limit;
+    int64_t bm_size, ser_size, offset, buf_used;
+    int64_t alloc_size = 1;
+    const char *name;
+    uint8_t *bm_buf;
+    QemuUUID uuid;
+    int ret = 0;
+
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
+        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        return;
+    }
+
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
+    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
+    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
+
+    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
+    /* Check if there is enough space for the final section */
+    if (*buf_size - buf_used < sizeof(*fh)) {
+        return;
+    }
+
+    name = bdrv_dirty_bitmap_name(bitmap);
+    ret = qemu_uuid_parse(name, &uuid);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap: ID parsing error: '%s'", name);
+        return;
+    }
+
+    fh = (ParallelsFeatureHeader *)*buf;
+    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
+    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
+
+    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
+    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
+
+    bh->l1_size = cpu_to_le32(l1_size);
+    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
+    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
+    memcpy(bh->id, &uuid, sizeof(uuid));
+
+    bm_buf = qemu_blockalign(bs, s->cluster_size);
+
+    offset = 0;
+    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
+        uint64_t idx = offset / limit;
+        int64_t cluster_off, end, write_size;
+
+        offset = QEMU_ALIGN_DOWN(offset, limit);
+        end = MIN(bm_size, offset + limit);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
+                                                          end - offset);
+        assert(write_size <= s->cluster_size);
+
+        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
+        if (write_size < s->cluster_size) {
+            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
+        }
+
+        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
+        if (cluster_off <= 0) {
+            goto end;
+        }
+
+        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
+        if (ret < 0) {
+            memset(&fh->magic, 0, sizeof(fh->magic));
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  cluster_off, 1);
+            goto end;
+        }
+
+        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
+        offset = end;
+    }
+
+    *buf_size -= buf_used;
+    *buf += buf_used;
+
+end:
+    qemu_vfree(bm_buf);
+}
+
+void GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    ParallelsFormatExtensionHeader *eh;
+    int remaining = s->cluster_size;
+    uint8_t *buf, *pos;
+    int64_t header_off, alloc_size = 1;
+    g_autofree uint8_t *hash = NULL;
+    size_t hash_len = 0;
+    int ret;
+
+    s->header->ext_off = 0;
+
+    if (!bdrv_has_named_bitmaps(bs)) {
+        return;
+    }
+
+    buf = qemu_blockalign0(bs, s->cluster_size);
+
+    eh = (ParallelsFormatExtensionHeader *)buf;
+    pos = buf + sizeof(*eh);
+
+    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
+    }
+
+    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
+    if (header_off < 0) {
+        error_report("Can't save dirty bitmap: cluster allocation error");
+        ret = header_off;
+        goto end;
+    }
+
+    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
+                             (const char *)(buf + sizeof(*eh)),
+                             s->cluster_size - sizeof(*eh),
+                             &hash, &hash_len, errp);
+    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
+        error_report("Can't save dirty bitmap: hash error");
+        ret = -EINVAL;
+        goto end;
+    }
+    memcpy(eh->check_sum, hash, hash_len);
+
+    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap: IO error");
+        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                              header_off, 1);
+        goto end;
+    }
+
+    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
+end:
+    qemu_vfree(buf);
+}
+
+bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                                          const char *name,
+                                                          uint32_t granularity,
+                                                          Error **errp)
+{
+    if (bdrv_find_dirty_bitmap(bs, name)) {
+        error_setg(errp, "Bitmap already exists: %s", name);
+        return false;
+    }
+
+    return true;
+}
diff --git a/block/parallels.c b/block/parallels.c
index f38dd2309c..a49922c6a7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1466,14 +1466,25 @@ fail:
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
+    Error *err = NULL;
     int ret;
 
+    parallels_store_persistent_dirty_bitmaps(bs, &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Lost persistent bitmaps during "
+                          "inactivation of node '%s': ",
+                          bdrv_get_device_or_node_name(bs));
+    }
+
     s->header->inuse = 0;
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                        PREALLOC_MODE_OFF, 0, NULL);
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+                        true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret < 0) {
+        error_report("Failed to truncate image: %s", strerror(-ret));
+    }
 
     return ret;
 }
@@ -1525,6 +1536,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
     .bdrv_inactivate            = parallels_inactivate,
+    .bdrv_co_can_store_new_dirty_bitmap = parallels_co_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 493c89e976..9db4f5c908 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -101,5 +101,10 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
+void GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool coroutine_fn
+parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        uint32_t granularity, Error **errp);
 
 #endif
-- 
2.40.1


