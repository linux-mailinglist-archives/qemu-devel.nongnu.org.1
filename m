Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBF7D9053
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZd-0000Il-MY; Fri, 27 Oct 2023 03:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYs-0007IT-Q5; Fri, 27 Oct 2023 03:47:23 -0400
Received: from mail-db5eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::704]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-00040L-QX; Fri, 27 Oct 2023 03:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr3uBQagVzx/8Wc7A2iOwVIigLR3lbYfO6eKYux4YlXLymKZQ+c/+m2OTq7JLUB6mCU1UHGMoxXd0Pu7IJZsAQminty/kW3qnPaMISIVkSAW00fakGZ85yZS+1CDVyYIeWfHA7eFEMH+KUgDn33oln2HENdEDtWVzQtwVsOXW8gx9PDdSV7Qjb0jrwfqz92z1B2FBpdD35LbCE4m7MLt3Y+V34BURJhDFhl7u5+Ogn3L84rB3tf3ZVIT1peX0mRqIb6uCfArc3XV/PqNcRijhtFDGVsZ25lbJHzg2JvMxvnQ6AgOud2Jvu2e2je98aG194yESwLZkK/SvZ+0lim1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjqSBFKXqJU2hAUfhWqXYXDLCOB51EzNML7tEqlJpl4=;
 b=HRr18ryBex8ti2A98nZLzxHFmYxkPhnjWA8pVW7AoVZZI5pGf3L6sZE6cvvGZg61H+BQUx8mWcZkg47wbsNho/BP1owOj0wSlViHScR30zvJYGXnOZlys6ftgzFCWwCBQR1Qm/1BBDayuYK69mZJOiuOwr+HSDjq4lwGttW0mJaMcu7Br0m0oJ4Rw27ZKoEAG8DnJVDN9k5SMYRURzcW8zUfiqt3185H/GqvVZ6XBNXJ6soYxSlRLYcmstzcddIvJicsgTJGNF7fYcbgVb2XtiPyjAk8od2TBi2iFPnxgXTN6YEjzPPWQrF69hk3D2+y3JjP1gNrFic1MMPJUZ1EWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjqSBFKXqJU2hAUfhWqXYXDLCOB51EzNML7tEqlJpl4=;
 b=YDpr2m/NoIcceKYzFhFT18qduDjHAHUJuEX48rDwskVTmE/6Mp9b2uxQdryIHDuGdasKpJtnu9M5j511jfQV6lqHtfpDR8cG8J8JNyjn7knsnuQ1rB54ODrNQKXxpACr0RTy0nVh2C9ZmHWSwMVAyOLsGOfhlebOmMfifgjCyTnymgFX6eNHUt9Mhoa3A2sGLwiFy80eIc8G30PiOLjfQphOGBCBWa7HND/KhAvXlmBj1UZWClerVilJoAKyjqq7+2+lUsiv1sf8ULaRRjxfLRBFEvvkkbVMDJzn7mP3MA78TCzAsX6ElnLhSWAU/y/FHKJasxiFqudNX9yQx63Jmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:48 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 10/21] parallels: Add dirty bitmaps saving
Date: Fri, 27 Oct 2023 09:46:25 +0200
Message-Id: <20231027074636.430139-11-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 389bf89d-0d2c-44d1-e32c-08dbd6c0df01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1BX/M5bP8TTOdAzphtwC9gQNsh/v5KgyShAHy2Ok0HXocFBoLyUea7P0s0wyvgPz2Z4K/furp/kYxY7KJ5BgwdwlLuXmmnYnmvcfnq1Zt1XKuU3Wn8j0MBfY/TEGz7KV2BpDfrSk2NtNv/nt91Xqv9BrQh2xyBsuEWDgkr3aSndDt4ZWVZqbWt+xuyi4dDp2VDKOErw1+Ym1arnpFv+5/2MgqDMFvEvUydIq1Se0hEya6AIw0rFixt5Yot22J5LkhRN3AAnN/8EGjydSUpMkEoVXBUB8ATxK7fH5prCYBrWIWGvnwoTP2l7tMuDCh6uxuDcwC7MJyRN5sShYUcb3gNZLtCrGofZmZgDTVv2/AoN6zaOBWRVuQxqbGXdyHAzWXAgN3vwYOMbJDxyM5Vrn9JcRmnn6XmVsg+DffDyYbxBVPNZNqnDMwMNgR9Ts+/I1Vb3EaU3whDgwHLl/Pz1S9cqiYzNH2+zxGvWCyaxByNHCXAXLxAvpm4Pm2pXoyQyOmwpj/U5NSi/iNaP9BlIPm9RFUGXSA3B3nFaL+/Ohy0lrSREVyWq/B9FNwmEhsq+kKiS8FmR3BjsUkq7rdJk9WjXMfhaRkZ29W6Yd4HKegdxV2oUN/fVG2xo3W9QeA7UbhdmsF8KsuBXEYy3ul5dYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1Lw7XXclY0XekJCJwEdAmZHrrBx+aDAshm5bTMiDP+yBjIQdCHMt2GsX436?=
 =?us-ascii?Q?JWIpQUbANeYzlK8NbWVajGrUd6k9rgmmwXbMe9RjFEdu9RsvVLmbmJEk4D1V?=
 =?us-ascii?Q?Zuvy6jFzjOBU0WqCs1p6ptY9ZaZso0ATSt7mmYVmX/IB107zy8Jw1YbqxLwa?=
 =?us-ascii?Q?MP03i7qwNv698JcDeupMZz63iC1MrX0dUlaa7iXvn1mPyR0hHBIs0nt9bWZM?=
 =?us-ascii?Q?sUme5R5fbhCnUthesNv78AAHWdzFW5dgEa9xwFRcDLTeBA7yHmnK/fwo6bKf?=
 =?us-ascii?Q?jHGZ8KshBCq3TGRXAtGNwsTHCQThJU1j3NP4yYFlWZt82szQlWmtpyEjTb3Z?=
 =?us-ascii?Q?1NUer1uhvRnXWXlzqSDpTlYw3YrELdFT6KJ0TVWfQNsoWd2qyL76DvWjBgGj?=
 =?us-ascii?Q?B4V8irfFAGv9RYjQ6YM0BVmXeqnHswAMp6H0DY5OtQvamTLC1bqsuMWamyQa?=
 =?us-ascii?Q?0ZRhL0BuMAB0h/A/FwBe6w/PjKsEfxFtY5j8LKYBuhng1lYZyCmkOIxEdDSf?=
 =?us-ascii?Q?evcg0O4hxsQhcoVti7KfqrPC/t/IDQ+Ivlmw5harAL0e1R7mKlwO0WgFIhWd?=
 =?us-ascii?Q?UXQ5qeiKBPoWDl40F7Mp2rqlkt2R5vsXfr+lqQczzJUa7BG/FpkVxz+JIWMA?=
 =?us-ascii?Q?SqUMJuyX0H4eQcYNgVcqct6zAt8EaKFa0qZf79GYzK8fpEhAr8kRT5PAPGi4?=
 =?us-ascii?Q?IIFg6olpRgGaSmtnvRrJvEIYlbIVk9w48JBzEixG1vloMBHM8k9IV9x0iCB1?=
 =?us-ascii?Q?t4JWQO+UkHjbaAIa6LqQEHH1sxTSbyrGA7d5WS4cp8K0Lk2bsZshqrBCnA5R?=
 =?us-ascii?Q?4xtv+2JBBubuUKWhzEu2xGIeWLbj1vQS0DMQp4hxHnAVziiQqBoDEk2wwan2?=
 =?us-ascii?Q?UOzIH59bLwfiTGMgiNip+/DwekHSg1IICepRrRAoM5ayqomoiTibBfUdZ1TV?=
 =?us-ascii?Q?O80cX6IcnOy/UA+UB2AnVcnnZd3F41XGD9z99PjEFJ3tM9oO8XcHgxNj3WlW?=
 =?us-ascii?Q?vJyqfwIgEFiLUFtjRtuBP6AOaNT0LksblczwrpCwLKukWqGwwtgtkqFNUUW8?=
 =?us-ascii?Q?BgKS899L6mPXjrZ7WArxmqrsmkHeKX9zGkMVTmU6no0ObwyF9lnesesOP6sb?=
 =?us-ascii?Q?LEbfdAAxEL2f8rKnAGICRtUnP2MqFHUHv6ilhRUH0Hc7OVAvyfp+OSPyAput?=
 =?us-ascii?Q?c+xIcau8mxLktMmhCnGb3i6Bxw7pJ4lnO4UqiDUhX4qbagcZe6q54HTICzMf?=
 =?us-ascii?Q?ZUVgKpJXZGzpYeg4sVrRYK7Xg8ZAH0oTyBq+aIbUXza3BYaLMR62lxpZLSD/?=
 =?us-ascii?Q?HzL5oLTFOGoncL8P7UpiYZ4vqjRpRpJLNBoOTSi+JCDbTXjaLWlHOJd16fVC?=
 =?us-ascii?Q?wwmbVgJYh5/CpswTMIcWyL3JiXwhQcov544NFnkVhik5U/FAj+FY1EByrUjs?=
 =?us-ascii?Q?uDMV893q5t5/bUgIaaCRxGv9QF2KLDN4mpht1ksXFPTuGRl/efZQoUQolhMm?=
 =?us-ascii?Q?SXs43wX/WdggeboyDlCC6DitQfEx23vbJX6iS5e7Loccx3hAlaXznqnsKds4?=
 =?us-ascii?Q?CD3r6UpWq1mXxL9J+6GDH7meLV10OyInAJkHR1fXSzSaui1Zl7tNqGE/WSP+?=
 =?us-ascii?Q?pT3y1kAJBvdkxSOYvbjF3Ks=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389bf89d-0d2c-44d1-e32c-08dbd6c0df01
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:46.7715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aigh6oJNRhXNHAEjeFoy2o8mSjk7AemZW0xw4HipLQ+gZhNTFGT+E6oFgupKACz8NQw3VyR/Ghk8ml/7g8cX//XP6Rtb6NwdxqbiOtSiu4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::704;
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
index 925aa9e569..2d82e8ff6a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1468,14 +1468,25 @@ fail:
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
@@ -1525,6 +1536,7 @@ static BlockDriver bdrv_parallels = {
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


