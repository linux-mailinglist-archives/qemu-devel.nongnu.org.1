Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3881F6BD
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOK-0005XG-Ql; Thu, 28 Dec 2023 05:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNw-0005Mm-Nu; Thu, 28 Dec 2023 05:13:04 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNt-0000at-MP; Thu, 28 Dec 2023 05:13:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFs+jcHtcBnMg3cRoiyAIT1kbW99AleRe2b0ZDpvji8yOVfUY6VHR3vNCRMF4bSvW/dBF3MeklX/A5g9nMmLySdUJsYWC7rB5yiCDKHxUH8riQ3D6RuVy1k7FHu3JzkHU10madbiByZTRdVsBb6BQJh8KpCMnsmrQCsvBRrgvW874Ll22i02+VVQW4B7oxWSmBvvckZvoIWr5J0CbtbyxzucpfwtQqyOZI4MIWw2gi86mh4lwsAzeROyOueohCk+KBnBfbfMga7YnKMAoASuXFGOLLEkEGkRqk7BlzyBSNcluG/QkIj7CM1G78iSgbRWVUpCfb8a4V678048mAQHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpECAwRB8Lh7KQMAwUs6yNclzlBlaMN4Cp0X7tp96gY=;
 b=kNgV9n8Jyd8HCZXWR5fz3AQ5BGBZ5swGlZ7mUURbZbA1E4q5w1ruwqUXDgZHRJkx7oqMVieIui9pd5KbGvAEOQ3lY+6x0z4/rvWHeHguLgcI534f9WJ0VtYyiOHDBML/ePJKJPJjmQtNbb8yExFbTFNqWFq/nrICQgZzJNbTL641FP1MZBuaNuuVeP96CZK9VBDUh4/gvUrRXpHdiDTOBgi1x0NOvzyFl3rMOqcpZIxepzRbFj4wR/lJcOqoyu0Agz86FJr12WkvGryuWmFKItJxHuZC7EuCfJGJJY4iwoeoayjblhF8WVaisu9r+7+De78AsHYjSPr2A0OSHphECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpECAwRB8Lh7KQMAwUs6yNclzlBlaMN4Cp0X7tp96gY=;
 b=QhAvAA1NsiOIiJgpLRKAwsqGTx1x94cn8eq76UbP1xEtWMnbsX01tl36ZKQ8NamMJ6sLGFZmwstFbQGVRedar2Fq20vLeEfxnsjRE7ACRAiMGhQlBJOHwbXYnPmjQWtdawoWWnOMHGhDYlr2oej90yrKuHWIbYVS0bMZ0koNGCl1/eZ1ypF6oim80cEdiyR+/qfkdHp9GgwCJvdOnZYiiszYFsHgd8B99mfiZwcLYYbMdp8TOm6IG87RJIBvM1wVHxMhiQDPuIe7jYPHhg31L1IkMgvlRskqDaxs3wej9CockBLsqe88rJXXuMehRiQDGX5eldr4bTZuldWGlmhNUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:46 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:46 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 11/21] parallels: Add dirty bitmaps saving
Date: Thu, 28 Dec 2023 11:12:22 +0100
Message-Id: <20231228101232.372142-12-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 479ad605-d105-4eb6-e381-08dc078d8993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho9slYCPwe6wwYYMsyVjPhcIolk8lAUO0HFoxJBEj3a477iifgiRJua+HjzJBE7+Yp+m14Nc5/0aMGzuMSTudwPsGfODA4p5YkT/YN7yDeHK6jYxubTM2+YCH0dNvwcJQ5C5cHGEnyjuwheM+rzlhvSW2A3BrpWRwpbbcf6zKp3gZ/iqQD2VX4WAdkBe1crqDYB/5Nt6WWa7KY8Z8CGuYTCgsQA/5kjYPTT179fviKQaHfID3YTqeJdHSny5nhLo/NgWT8jBXN0qz8JTk7SNJfvWvBVp0zyCnuz7lKi8WYuE76uucEOfx30qamotAN7HPANWOPau9K4aDOgLv7+0LeSpaQ53gsMwn4tIWKpiEE9iAIDQXiOwebMWTHCyg0lFk4w+x+2UL71xRM7q/baL/eqJqdn/lkvfF/8dEePsye8+A3GaiWvVnm05uVGP3vZjMgTSDc+EYUeTgJM2IwQzmsnBSq+W5gh9XH5gh6EOFR2mcVV/YLQnzQZjkHpvlqqRIhFq2PM1tA9k4uxod2oS4X7FSS2cw9J8wQUH9j8K3Y4TNuwha0eLQoaSIQrGoNxTrky2rKWVwfPr1A6q/v7DJUR8YxK8tnzw2xstyxciFq6VhEl35DWfT2uMcr5yG4fCRE3CeiLUL1cpbVVYpaqTgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYEeg2zxbl9B6g64ZkeAgiSCB6GbWX5O8nb+sPTNQrjOY/kwKGPuZC2dST/R?=
 =?us-ascii?Q?UzntKlImKNPgb8kggMNbWEago1A+GJsFuji/WrQQ+HmazlDu9xoTnzNUX9Es?=
 =?us-ascii?Q?vun+Jsp61cMWjj4DWKquy7bcRm/aIyUpqzj/0ssbTMWkbTtBJ0KuZJeDrbj1?=
 =?us-ascii?Q?VRSjTCDWoWVcBFR2dm8n+drZWxr62EvMIzuUaRD1blh+hM+Gi1gQOUA/67jo?=
 =?us-ascii?Q?ZdQwVHyJiBsTIImaeG9MQxXagRg8M2Fzii1DdnCri5yrn5JYhiKF5mdA3G0M?=
 =?us-ascii?Q?K3tUg5RqWSbgGl1GnrOrTcjYCTE+SB/XD61RCMSj5e8Hv6Zi/Tm0bBtntGFY?=
 =?us-ascii?Q?OfwmIhRZxRKkXMmk/EsKq9Zo1toa0UmVFG4BvjapU+jyi1nUL9T3580EHGPk?=
 =?us-ascii?Q?VMTXB1TQDrajAD3j/DWM0cdbd9Lc4eHb5HmtoonYp89QOX/0weAh9yWkgXnj?=
 =?us-ascii?Q?pTg9EPvHDlNsyu1vwZqTMSff5bE9x3SVhxjVSsqwzq8HQwidac4dFIt0agxl?=
 =?us-ascii?Q?2Vd4tloNLfux/kCiaQaSBUQrvBbz7WD7d+ya1bdhIrNUKUrSbGl3wr3HSkY1?=
 =?us-ascii?Q?1FDnTwUtw7P4DPAdJSrCpfBwev+Ovqwyt1uFOqCh/ARXtpl6lnTFyztyuIno?=
 =?us-ascii?Q?VDN1JmkdJ2Ab3RD+O0psoF5EAZdFz49COj8ktecOA6LTZVwAN5QP8VwvOp7+?=
 =?us-ascii?Q?/dACGtbAF0ldQGUWMjiORVpmrUIF8KBwE08XNLxbmJg7Fw5OknokPDGerD7S?=
 =?us-ascii?Q?+5Xa6F9x55WIUlZ5c5h6xNUTtWn9GMDLcT5Tmkp+NkwhGcDliKzJaMkiOjj7?=
 =?us-ascii?Q?6rZ5SY+boY/i8iGgRZbKvGW/dSZxp2QmZfpCeuZD/baE3lodtaguXv9nPjws?=
 =?us-ascii?Q?JWNd8naDhvG1q8jGScqGqj3Ync+0D8gP1O20UxGrcGTIUpS/xcwyL8P6qfUI?=
 =?us-ascii?Q?psOsEWfj13ouQKw7NBZjt5OLMyyvmeeLuzNfpG3pA2b7Pw49TnayD3C9xUDH?=
 =?us-ascii?Q?RFg6iBBt9kOPFmsDQE2hXhb4ARvBseGZrCXVLcGKubYaGvydhFGIetPyYyhF?=
 =?us-ascii?Q?Sc78q838PdUUhUG7Y87U5Bigcb7nFNYeI7bk+AlNdTDajaYKRUGppzwLpX6/?=
 =?us-ascii?Q?9gS7g/UbLRcR4gsJfpHn5tLVS/63fgnoRevh32EEDJukNqN8gxUCVA2zdPDA?=
 =?us-ascii?Q?1oJXl8xuq/Ox4Nr3toufeLx0rRLVGKnVvM3BXJOz+F/KGGeHwE2/qBl5QK/i?=
 =?us-ascii?Q?M5kpKLk/iS8OENesDVkqX9vlHtLCWC50Z5itquDq4dZMX/lUV2s8gp9bSscz?=
 =?us-ascii?Q?/9t/ZlDytZKuhGJ3OtQYVUE320tAmaJXZKkll7jg4TswigMLoBfCi2asxACI?=
 =?us-ascii?Q?twttiNtPqjRTnD3VY8Z6bfXkQ82cUufFkmszn0B60KOB+DL/IanzTfhGW+0a?=
 =?us-ascii?Q?uKs2e5oop85Io/BmzuTqTROPKC2Zc+1RQRBfuIFvt9Cs/laV8soQsR/v8dI+?=
 =?us-ascii?Q?J6LVpPX6ZWdiNKKKIW7xun5By8MbkgRl4WUVSF3lb1NRDOmkMz2Fj1Gv3TT/?=
 =?us-ascii?Q?oNN/eFHHe1HGx1qPpA/Z/0zqgbL6/oFpO2DVc6o06gHhpzBYM0l6BtP7o+wF?=
 =?us-ascii?Q?DX6Ow45rZZXBfUjCVwyGO48=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479ad605-d105-4eb6-e381-08dc078d8993
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:46.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZLEcNChaa8HbqUaJ2Qs/+FX+VwwmzKud2Tz3j30qjl3sGAWi7atjpJEtVS1/yWCSO8U4V/U5Z++jE7GARre8JWIHhFwvWZqDNb2VY4dE5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
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


