Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA97CFA7F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScX-0005n4-31; Thu, 19 Oct 2023 08:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScV-0005lj-2G; Thu, 19 Oct 2023 08:59:23 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScT-0002g2-1o; Thu, 19 Oct 2023 08:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goPCdXJyKGiNr5pGwILz3uQQTxEtKfWPH2woGRlsIsdYsHujugLtT7pLO+yHYS/4Pnt5Bc6T38SAmWod0khHvIZMpW6RFFnR3wrg0oEVMUXFmbVCzkDmxBBtH6+dYj9P4ztyrXNoMs2zAssTWVJW/ojZHtc9mvTIrlEIHW7sV8H8hBkqZQAg/6DJpeSXhZ0z56zwhoivwHD/1tjad+z4gI0RCGz109afuVASo1mibPoH7B3RHArWynOU48rU3iqPPQbrN32SeTMnEFOqXvB2JfJNZ1QXhsnR/pMbTQU9BKxsfhlsSv4KEl+cCd3u5PH48PUFA99LShQthc6Lq8J+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ROKceqzdFsLtvMFETFdrK7Cy0QaljPXiPODplEFpg=;
 b=IO3armO/ywc0/7cDhtCtfhB2OmJsV8D8Egq+SGt2CBmaIsLH008uPMmM7RlWlVU4XW22UTO+leuvSq15er4J8RGRkknjM5gxn6zJjHWDoU/04ds0JOlwcLbJYadUxH1D74P33eEpcQEpm1ZvloLdpjMYOoNRwE3jEsUd4PLEorf9Mhw/LLqwSgf4SeGvJ1W+Fwv4RrAuNvpjCKoDXz6rWd4uMXqAwpRwst5/LWuFO7iNZ56qzEEDQraytaQd9/oMqdZIvxQNUOwkLGybzoJPCPAxDHs94IwYI7FlK/CSfhdH9li7oAAlYJ0waNFJIXmS1kC/1y4gHmYOGg7ZdM+sIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ROKceqzdFsLtvMFETFdrK7Cy0QaljPXiPODplEFpg=;
 b=uFbbxq9/7/BhQPnzPX++XCy05xxnVR1SBJSEWM1I0VZ4+ab612ozeADhd24gj3zlQ0PicaDq7NIJ1jsQ0sElhWbr2fnCVgZThsPigHChbPMq8ROEL6sLV/btN/g+B13V5L85sfTcIOJgWNzC1x5SnTKr3JdAnKOfOr1r1T+QdIkAKPA7qx1/Hw/yYlqC7YKpa3boz6NW2KMTBra8zupJnBm7Mqag8fWDhWOAib5cnkE6Mp7lMQBM++fwrSfngDNoJqT5vOnGXZICxOMeLRMpF9eDnt8a/BI4O+Hcz0IbiX76VbmwJEZB1PSTR3sfvPN27ZjR52GFNQ81v7yxBz1fNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:12 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:12 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 10/20] parallels: Add dirty bitmaps saving
Date: Thu, 19 Oct 2023 14:58:44 +0200
Message-Id: <20231019125854.390385-11-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b652caf-392e-418e-8795-08dbd0a330cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZifmBI7YHsM4Da4KHQdRkEY3oTqwB/t+9venAp8ioL1Fum+2rbjUiuy/V6k8KQuLiYEWagvtrHa2gL5wAOUEmneNNkIq4MwwRv1tEFXXV6Ps1yn3AGo41vcvO7htvN1gxazn0uCMy4FaHIHkWD6TWrSxZd4Hvgh2eHQ8IdigQf9/Ry4Q9HRIwE7nedtmO+Cwr4UTK8xZXTwD2ooJoUcgXimn3WgZ6LRHcrWMfffu0FcTLR9ofNHJZBssYlC7naei9KMoN10G0OtfcLPc0MrirqLJjXKUvlBCcRVj0o4UIqMO/o1qbfXAVsxJAJXc8K2b91gMJdfSV9fnzb4vuEDMQkFBX3zfBaFSwtOHEy/1GQRepTwYj5o1Vlmdzms3SGgP75HT+84c6WSX+Z8d1o1edDGs+VuhGiBmPPEB0XBnVMv/0NQ0JCl97CNidO603hziAj3Wl7wU+n/mFBOGq+PAO0cCAN75FqLp1jhA9+N8cp8YaG7XBThgBcZOBt43AeJMbLOVMiT2vmnAj4b/dwF7xrkFaq1JyHmZbg/kOqelSDdKyIx1XXYyckCzIB9gG0dVCWrSGqzfZBcmvhw3/nNPXm3zugVkEokdaZbfK1OlKyxBY7I9EGH480tJe/YeyHLrTxdrR/eH58DPQeYBXJojg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAr+U1aMATqS4Zb1Y4gLJQHVa6Vco2pHeOIqGstrHPuN5K7PwU7ovuwwQ3mq?=
 =?us-ascii?Q?qdrY7KcDUfie0Z3RlhAoVlgIdT553uTc0NplG7eOGy0dq9eRd1ASJp4MSZ7b?=
 =?us-ascii?Q?/uRFaHWn7iYQ+RsXME7B8WAp+/78NwWm5sW3GYj39yVDbien6JBREOFsFWcl?=
 =?us-ascii?Q?4LvUsln7BEi5Rd3FL409CewrOg+M4Ri1PKWdbBVujjmrvTaXky8kgtNSCb4y?=
 =?us-ascii?Q?efuUdf7w3ORldoS6CTAsfdFZvfpfRt43QibLI82wGuvzEbLrRd6vJtfWN9oh?=
 =?us-ascii?Q?DuRED4ExifJAii1USbCptnPJn1XvLgeRu3ddeWoB/9yaQYS8YuR2aFpeTZBz?=
 =?us-ascii?Q?tEYbyMXEY3yOx8KUpxn/iPznVWDw98ZjYCwMLplF7ygHWdQS4e5I8SZK90xZ?=
 =?us-ascii?Q?ShedwkdeiZqe16MflpXColsXlXKY9q2VlYB2eRorGXJBA3TaeQQCIVkNoXjE?=
 =?us-ascii?Q?EKgnFt51TmlU2S60eGeYHuESdfPPRhoL7Od49JoMiUb9JjptEQY5D+lvlIbP?=
 =?us-ascii?Q?mTdsDEqet0ys0wSPR+t6pTmYGp76WScUOyqIk3071eGmYJhf7yvo/cvLhg2y?=
 =?us-ascii?Q?KwZYKgGq1OxGgWn4iaLN7Y3HA6VgB6rP7HK5Pbdgcn4N02Dufo2TEoFcQF/X?=
 =?us-ascii?Q?EASt4qE87EHeC/OkLfcQ+UkgHN358Q6CvEBy4efHuHf7Nq/3PBRX8uGNfpAr?=
 =?us-ascii?Q?RSQsApyxF50ZkVRRwFzLJ007wCkF/cN4IBU0iJaOQN8PNC5mkgM6mg8QmTui?=
 =?us-ascii?Q?UhRx1deqACkCwmkIhtsqo3aUcaZBxWNm8h5ozyLv1vW219PykOjQNMq8CYEG?=
 =?us-ascii?Q?EhFBwQ+WukYs99KEz5LVnciUh3vHIjXfwFsdLbDGafbJzE/uso551dZGKZvy?=
 =?us-ascii?Q?6frJ6bY2KQGpKSTBSvF1mnu5aBqYOLRcLdeRKw/L5FcTCJPk25FMrBV3QMia?=
 =?us-ascii?Q?cwoIKnUx/92AtH+yTlMWpEiawwwjXBwTy0+7IQcTJiMdViFdBN7Qcu3qaBQ1?=
 =?us-ascii?Q?ErCuFPC/bF4/vFAnjgolLp8MQSxmL+2JZSdce3H6324kt7f+I3UHDHng7FKO?=
 =?us-ascii?Q?IwnRNCEkZO6YAZyCmFOusSn0yGt1jz2n+oH1lrFgUIP8IalNTTAIqZXAtUyD?=
 =?us-ascii?Q?sw7kQ2l44MsKzuP4X8cGodeEgldiZMOqrOE2DgvLdZhMAClACryuIBEmje8K?=
 =?us-ascii?Q?Z3k1vg7ur7qbFV1ClOgWz9a6WincTfi6UUQVtZzTB+5V25Q8dq489xTBEHuJ?=
 =?us-ascii?Q?z8yM6XgkHtPgE8nmVE4Qx4ZueXUdoHj5NKwwY2sLR9jWenrRttWIKyZMHLIw?=
 =?us-ascii?Q?JbEINnC1DHxIBa8p/rb2SjYijxCoqeW5k0IvBodiwJzNleiiwjaSR+GNJFNM?=
 =?us-ascii?Q?cz/YGdrAsqM1s3lPD8e66sXT4oAvT9Hd6+htRgnImZf75AeU+AQ5KK3Lkl8S?=
 =?us-ascii?Q?VwBUYvJQWGqJA/pIiQezeSsrWgUEn+GfhpJvh2+0WmmUcktnWPpL3ICB5H0c?=
 =?us-ascii?Q?Hak8Q+H7dpnV7PKeJiw+5oPeV2kVBjDjTWevo3Zf1b0VJv4M1nynXTGQVj2d?=
 =?us-ascii?Q?g1eCjH773zSMdQUtT2zMZjnxkaohFNPyG8lATF47fW0nU5XoUsBy2sXQb0zP?=
 =?us-ascii?Q?fzkft5MMcw7nz8kT9Y8wsWI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b652caf-392e-418e-8795-08dbd0a330cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:12.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exkt60UQ8BHwgbO3aEA+5mnGs3XlFuYNh/AZ6z98DuJnzmKAnzghvNfFR2bHrBgRph/TgfYGX/OVb/ykJ95EjCj3vp5kkN7OCbkzcTjfh5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

Now dirty bitmaps can be loaded but there is no their saving. Add code for
dirty bitmap storage.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 167 ++++++++++++++++++++++++++++++++++++++++++
 block/parallels.c     |  16 +++-
 block/parallels.h     |   5 ++
 3 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 8a109f005a..0a632a2331 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
@@ -301,3 +302,169 @@ out:
 
     return ret;
 }
+
+static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                                  uint8_t **buf, int *buf_size)
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
+void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                              Error **errp)
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
index 2ee2b42038..bb1e765ec8 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1470,14 +1470,25 @@ fail:
 static int parallels_inactivate(BlockDriverState *bs)
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
@@ -1528,6 +1539,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
     .bdrv_inactivate            = parallels_inactivate,
+    .bdrv_co_can_store_new_dirty_bitmap = parallels_co_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 4e7aa6b80f..18b4f8068e 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -100,6 +100,11 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
 
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
+void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                              Error **errp);
+bool coroutine_fn
+parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        uint32_t granularity, Error **errp);
 
 
 #endif
-- 
2.34.1


