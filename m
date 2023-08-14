Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59A77B4F0
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 11:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTPQ-0001to-Mk; Mon, 14 Aug 2023 04:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPP-0001tc-2v; Mon, 14 Aug 2023 04:58:43 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPM-0007Dl-BG; Mon, 14 Aug 2023 04:58:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a7aedc57ffso3251380b6e.2; 
 Mon, 14 Aug 2023 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692003518; x=1692608318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83pvTrAjuHaay4ZofSxWl5nSk7lL3j/A6UrQMnbxH+I=;
 b=c/Jca4A9Zeb62jd70pXxBDkj8ChTZgZhz/X0TDVDMU3a/ObkOXyfZ73UyW07Rw2jPA
 l6cyslTOGXbI/o5NkcyLST71s09sa30PpgmJsAbPGm8EtzOQ0w9WCvAwcgmmaRs7domo
 xRaWSGkJz1q4sY439lGSKisflFJ+yA2RzE/NRExHtSd7qYuTgIee+wQovFl39keCDaJ3
 gpiWOyR7GMvReYAgubN9qVP3kJkTTJ1ymBtXe82PMmX62do6NM8z93V5XCidmB3lp/cA
 AoUJ8zRHvPeFeWNVeJ4f4JwY8tJXCfmfEL2vH9o0lpfEYqFlizgnMjog7swXvYsweVq+
 H5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692003518; x=1692608318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83pvTrAjuHaay4ZofSxWl5nSk7lL3j/A6UrQMnbxH+I=;
 b=FnfoGzz+LABegKKq01ktwMSXeAH5Whet1lOW6XCCQjkuyVB0eT8jDNBclkWddyZm3P
 8LSAVjQ4da18k1aedompsq/k1K/mOFWbB28wn09bFd4RqzgnlTikLlWTcPZ1pzcf6yl3
 NqIGxHsy4s5MXHyYTq4OEY5NTJrAcYyYBxCHnnPUglhlz4h1yIigMr8fB+0FATuEUUbY
 IH2qso6//FAk3uzFiXnGqM8uIwnd6owoa0/FWr3z8iVHI3nE3peLTBzsn8V8m3crWNzz
 M7Y8BoZkDyZrbt8vfuoZl4G1RVVyBArDElaro4wog+Ndib8+nbar6RgMUSDjvVapgI1i
 aekA==
X-Gm-Message-State: AOJu0YxU+vPe+HjT3lbvJXC+Gm76Kve2w/2A9MpNb1ALsphmhBWUFhzK
 9hwFu2Y1grzAMnKoA9Cnfp2lFO8KQKrR0XWFYk0=
X-Google-Smtp-Source: AGHT+IEiSx0zl9fm5mUWt4f10OMARHu4FIzVtZeBaerwSZMniza642ZiOIPBDN5N+ZX4RJzpd+dD7A==
X-Received: by 2002:a05:6358:724e:b0:129:c9c0:ca64 with SMTP id
 i14-20020a056358724e00b00129c9c0ca64mr7736260rwa.15.1692003517706; 
 Mon, 14 Aug 2023 01:58:37 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.250]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a632918000000b00528db73ed70sm8238890pgb.3.2023.08.14.01.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 01:58:37 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2 3/4] qcow2: add zoned emulation capability
Date: Mon, 14 Aug 2023 16:58:01 +0800
Message-Id: <20230814085802.61459-4-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814085802.61459-1-faithilikerun@gmail.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

By adding zone operations and zoned metadata, the zoned emulation
capability enables full emulation support of zoned device using
a qcow2 file. The zoned device metadata includes zone type,
zoned device state and write pointer of each zone, which is stored
to an array of unsigned integers.

Each zone of a zoned device makes state transitions following
the zone state machine. The zone state machine mainly describes
five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
READ ONLY and OFFLINE states will generally be affected by device
internal events. The operations on zones cause corresponding state
changing.

Zoned devices have a limit on zone resources, which puts constraints on
write operations into zones.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c          | 676 ++++++++++++++++++++++++++++++++++++++++-
 block/qcow2.h          |   2 +
 docs/interop/qcow2.txt |   2 +
 3 files changed, 678 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c1077c4a4a..5ccf79cbe7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -194,6 +194,164 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
+
+static inline int qcow2_get_wp(uint64_t wp)
+{
+    /* clear state and type information */
+    return ((wp << 5) >> 5);
+}
+
+static inline int qcow2_get_zs(uint64_t wp)
+{
+    return (wp >> 60);
+}
+
+static inline void qcow2_set_wp(uint64_t *wp, BlockZoneState zs)
+{
+    uint64_t addr = qcow2_get_wp(*wp);
+    addr |= ((uint64_t)zs << 60);
+    *wp = addr;
+}
+
+/*
+ * File wp tracking: reset zone, finish zone and append zone can
+ * change the value of write pointer. All zone operations will change
+ * the state of that/those zone.
+ * */
+static inline void qcow2_wp_tracking_helper(int index, uint64_t wp) {
+    /* format: operations, the wp. */
+    printf("wps[%d]: 0x%x\n", index, qcow2_get_wp(wp)>>BDRV_SECTOR_BITS);
+}
+
+/*
+ * Perform a state assignment and a flush operation that writes the new wp
+ * value to the dedicated location of the disk file.
+ */
+static int qcow2_write_wp_at(BlockDriverState *bs, uint64_t *wp,
+                             uint32_t index, BlockZoneState zs) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qcow2_set_wp(wp, zs);
+    ret = bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
+        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
+
+    if (ret < 0) {
+        goto exit;
+    }
+    qcow2_wp_tracking_helper(index, *wp);
+    return ret;
+
+exit:
+    error_report("Failed to write metadata with file");
+    return ret;
+}
+
+static int qcow2_check_active(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (!s->zoned_header.max_active_zones) {
+        return 0;
+    }
+
+    if (s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
+        < s->zoned_header.max_active_zones) {
+        return 0;
+    }
+
+    return -1;
+}
+
+static int qcow2_check_open(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    if (!s->zoned_header.max_open_zones) {
+        return 0;
+    }
+
+    if (s->nr_zones_exp_open + s->nr_zones_imp_open
+        < s->zoned_header.max_open_zones) {
+        return 0;
+    }
+
+    if(s->nr_zones_imp_open) {
+        ret = qcow2_check_active(bs);
+        if (ret == 0) {
+            /* TODO: it takes O(n) time complexity (n = nr_zones).
+             * Optimizations required. */
+            /* close one implicitly open zones to make it available */
+            for (int i = s->zoned_header.zone_nr_conv;
+            i < bs->bl.nr_zones; ++i) {
+                uint64_t *wp = &s->wps->wp[i];
+                if (qcow2_get_zs(*wp) == BLK_ZS_IOPEN) {
+                    ret = qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED);
+                    if (ret < 0) {
+                        return ret;
+                    }
+                    s->wps->wp[i] = *wp;
+                    s->nr_zones_imp_open--;
+                    s->nr_zones_closed++;
+                    break;
+                }
+            }
+            return 0;
+        }
+        return ret;
+    }
+
+    return -1;
+}
+
+/*
+ * The zoned device has limited zone resources of open, closed, active
+ * zones.
+ */
+static int qcow2_check_zone_resources(BlockDriverState *bs,
+                                      BlockZoneState zs)
+{
+    int ret;
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        ret = qcow2_check_active(bs);
+        if (ret < 0) {
+            error_report("No enough active zones");
+            return ret;
+        }
+        return ret;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_open(bs);
+        if (ret < 0) {
+            error_report("No enough open zones");
+            return ret;
+        }
+        return ret;
+    default:
+        return -EINVAL;
+    }
+
+}
+
+static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *temp = g_malloc(s->zoned_header.zonedmeta_size);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
+                     s->zoned_header.zonedmeta_size, temp, 0);
+    if (ret < 0) {
+        error_report("Can not read metadata\n");
+        return ret;
+    }
+
+    memcpy(s->wps->wp, temp, s->zoned_header.zonedmeta_size);
+    return 0;
+}
+
 /*
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -456,7 +614,19 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 be32_to_cpu(zoned_ext.max_active_zones);
             zoned_ext.max_append_sectors =
                 be32_to_cpu(zoned_ext.max_append_sectors);
+            zoned_ext.zonedmeta_offset =
+                be64_to_cpu(zoned_ext.zonedmeta_offset);
+            zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
             s->zoned_header = zoned_ext;
+            s->wps = g_malloc(sizeof(BlockZoneWps)
+                    + s->zoned_header.zonedmeta_size);
+            ret = qcow2_refresh_zonedmeta(bs);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "zonedmeta: "
+                                             "Could not update zoned meta");
+                return ret;
+            }
+            qemu_co_mutex_init(&s->wps->colock);
 
 #ifdef DEBUG_EXT
             printf("Qcow2: Got zoned format extension: "
@@ -2001,6 +2171,14 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.zoned = s->zoned_header.zoned;
+    bs->bl.nr_zones = s->zoned_header.nr_zones;
+    bs->wps = s->wps;
+    bs->bl.max_append_sectors = s->zoned_header.max_append_sectors;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
 }
 
 static int qcow2_reopen_prepare(BDRVReopenState *state,
@@ -2691,9 +2869,26 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
     uint64_t host_offset;
     QCowL2Meta *l2meta = NULL;
     AioTaskPool *aio = NULL;
+    int64_t start_offset, start_bytes;
+    BlockZoneState zs;
+    int64_t end;
+    uint64_t *wp;
+    int64_t zone_size = bs->bl.zone_size;
+    int index;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
+    start_offset = offset;
+    start_bytes = bytes;
+    /* The offset should not less than the wp of that
+     * zone where offset starts.  */
+    if (zone_size) {
+        index = start_offset / zone_size;
+        wp = &s->wps->wp[index];
+        if (offset < qcow2_get_wp(*wp)) {
+            return -EINVAL;
+        }
+    }
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
 
         l2meta = NULL;
@@ -2739,6 +2934,47 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
         qiov_offset += cur_bytes;
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
+
+    if (zone_size) {
+        index = start_offset / zone_size;
+        wp = &s->wps->wp[index];
+        uint64_t wpv = *wp;
+        if (!QCOW2_ZT_IS_CONV(wpv)) {
+            /*
+             * Implicitly open one closed zone to write if there are zone resources
+             * left.
+             */
+            zs = qcow2_get_zs(wpv);
+            if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
+                ret = qcow2_check_zone_resources(bs, zs);
+                if (ret < 0) {
+                    goto fail_nometa;
+                }
+
+                if (zs == BLK_ZS_CLOSED) {
+                    s->nr_zones_closed--;
+                    s->nr_zones_imp_open++;
+                } else {
+                    s->nr_zones_imp_open++;
+                }
+            }
+
+            /* align up (start_offset, zone_size), the start offset is not
+             * necessarily power of two. */
+            end = ((start_offset + zone_size) / zone_size) * zone_size;
+            if (start_offset + start_bytes <= end) {
+                *wp = start_offset + start_bytes;
+            } else {
+                ret = -EINVAL;
+                goto fail_nometa;
+            }
+
+            ret = qcow2_write_wp_at(bs, wp, index,BLK_ZS_IOPEN);
+            if (ret < 0) {
+                goto fail_nometa;
+            }
+        }
+    }
     ret = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -3136,7 +3372,9 @@ int qcow2_update_header(BlockDriverState *bs)
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
             .max_append_sectors =
-                cpu_to_be32(s->zoned_header.max_append_sectors)
+                cpu_to_be32(s->zoned_header.max_append_sectors),
+            .zonedmeta_offset   = cpu_to_be64(s->zoned_header.zonedmeta_offset),
+            .zonedmeta_size     = cpu_to_be64(s->zoned_header.zonedmeta_size)
         };
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
                              &zoned_header, sizeof(zoned_header),
@@ -3541,7 +3779,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t *refcount_table;
-    int ret;
+    uint64_t zoned_meta_size, zoned_clusterlen;
+    int ret, offset, i;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
@@ -3847,6 +4086,48 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->zoned_header.max_open_zones = qcow2_opts->max_open_zones;
         s->zoned_header.max_active_zones = qcow2_opts->max_active_zones;
         s->zoned_header.max_append_sectors = qcow2_opts->max_append_sectors;
+        s->zoned_header.nr_zones = qcow2_opts->size / qcow2_opts->zone_size;
+
+        zoned_meta_size =  sizeof(uint64_t) * s->zoned_header.nr_zones;
+        g_autofree uint64_t *meta = NULL;
+        meta = g_new0(uint64_t, s->zoned_header.nr_zones);
+
+        for (i = 0; i < s->zoned_header.zone_nr_conv; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+            meta[i] |= 1ULL << 59;
+        }
+        for (; i < s->zoned_header.nr_zones; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+            /* For sequential zones, the first four most significant bit
+             * indicates zone states. */
+            meta[i] |= ((uint64_t)BLK_ZS_EMPTY << 60);
+        }
+
+        offset = qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
+        if (offset < 0) {
+            error_setg_errno(errp, -offset, "Could not allocate clusters "
+                                            "for zoned metadata size");
+            goto out;
+        }
+        s->zoned_header.zonedmeta_offset = offset;
+        s->zoned_header.zonedmeta_size = zoned_meta_size;
+
+        zoned_clusterlen = size_to_clusters(s, zoned_meta_size)
+                * s->cluster_size;
+        assert(qcow2_pre_write_overlap_check(bs, 0, offset,
+                                             zoned_clusterlen,false) == 0);
+        ret = bdrv_pwrite_zeroes(blk_bs(blk)->file, offset,
+                                 zoned_clusterlen, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not zero fill zoned metadata");
+            goto out;
+        }
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not write zoned metadata "
+                                         "to disk");
+            goto out;
+        }
     }
 
     /* Create a full header (including things like feature table) */
@@ -4190,6 +4471,393 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     return ret;
 }
 
+static int coroutine_fn
+qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
+                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t zone_size = s->zoned_header.zone_size;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t size = bs->bl.nr_zones * zone_size;
+    unsigned int nrz = *nr_zones;
+    int i = 0;
+    int si;
+
+    if (offset >= capacity) {
+        error_report("offset %" PRId64 " is equal to or greater than the"
+                     "device capacity %" PRId64 "", offset, capacity);
+        return -EINVAL;
+    }
+
+    if (nrz > bs->bl.nr_zones) {
+        error_report("nr_zones %" PRId32 " should not exceed the device zones"
+                     "%" PRId32 "", nrz, bs->bl.nr_zones);
+        return -EINVAL;
+    }
+
+    if (zone_size > 0) {
+        si = offset / zone_size;
+        qemu_co_mutex_lock(&s->wps->colock);
+        for (; i < nrz; ++i) {
+            if (i + si >= bs->bl.nr_zones) {
+                break;
+            }
+
+            zones[i].start = (si + i) * zone_size;
+
+            /* The last zone can be smaller than the zone size */
+            if ((si + i + 1) == bs->bl.nr_zones && size > capacity) {
+                uint32_t l = zone_size - (size - capacity);
+                zones[i].length = l;
+                zones[i].cap = l;
+            } else {
+                zones[i].length = zone_size;
+                zones[i].cap = zone_size;
+            }
+
+            uint64_t wp = s->wps->wp[si + i];
+            if (QCOW2_ZT_IS_CONV(wp)) {
+                zones[i].type = BLK_ZT_CONV;
+                zones[i].state = BLK_ZS_NOT_WP;
+                /* Clear the zone type bit */
+                wp &= ~(1ULL << 59);
+            } else {
+                zones[i].type = BLK_ZT_SWR;
+                zones[i].state = qcow2_get_zs(wp);
+                /* Clear the zone state bits */
+                wp = qcow2_get_wp(wp);
+            }
+            zones[i].wp = wp;
+        }
+        qemu_co_mutex_unlock(&s->wps->colock);
+    }
+    *nr_zones = i;
+    return 0;
+}
+
+static int qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t *wp = &s->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zs(*wp);
+
+    switch(zs) {
+    case BLK_ZS_EMPTY:
+        ret = qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);
+        if (ret < 0) {
+            goto unlock;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        s->nr_zones_imp_open--;
+        break;
+    case BLK_ZS_EOPEN:
+        return 0;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
+        if (ret < 0) {
+            goto unlock;
+        }
+        s->nr_zones_closed--;
+        break;
+    case BLK_ZS_FULL:
+        break;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+    ret = qcow2_write_wp_at(bs, wp, index, BLK_ZS_EOPEN);
+    if (!ret) {
+        s->nr_zones_exp_open++;
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&s->wps->colock);
+    return ret;
+}
+
+static int qcow2_close_zone(BlockDriverState *bs, uint32_t index) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t *wp = &s->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zs(*wp);
+
+    switch(zs) {
+    case BLK_ZS_EMPTY:
+        break;
+    case BLK_ZS_IOPEN:
+        s->nr_zones_imp_open--;
+        break;
+    case BLK_ZS_EOPEN:
+        s->nr_zones_exp_open--;
+        break;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
+        if (ret < 0) {
+            goto unlock;
+        }
+        s->nr_zones_closed--;
+        break;
+    case BLK_ZS_FULL:
+        break;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+
+    if (zs == BLK_ZS_EMPTY) {
+        ret = qcow2_write_wp_at(bs, wp, index, BLK_ZS_EMPTY);
+    } else {
+        ret = qcow2_write_wp_at(bs, wp, index, BLK_ZS_CLOSED);
+        if (!ret) {
+            s->nr_zones_closed++;
+        }
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&s->wps->colock);
+    return ret;
+}
+
+static int qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t *wp = &s->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zs(*wp);
+
+    switch(zs) {
+    case BLK_ZS_EMPTY:
+        ret = qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);
+        if (ret < 0) {
+            goto unlock;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        s->nr_zones_imp_open--;
+        break;
+    case BLK_ZS_EOPEN:
+        s->nr_zones_exp_open--;
+        break;
+    case BLK_ZS_CLOSED:
+        ret = qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
+        if (ret < 0) {
+            goto unlock;
+        }
+        s->nr_zones_closed--;
+        break;
+    case BLK_ZS_FULL:
+        ret = 0;
+        goto unlock;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+
+    *wp = ((uint64_t)index + 1) * s->zoned_header.zone_size;
+    ret = qcow2_write_wp_at(bs, wp, index, BLK_ZS_FULL);
+
+unlock:
+    qemu_co_mutex_unlock(&s->wps->colock);
+    return ret;
+}
+
+static int qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
+                            int64_t len) {
+    BDRVQcow2State *s = bs->opaque;
+    int nrz = bs->bl.nr_zones;
+    int zone_size = bs->bl.zone_size;
+    int n, ret = 0;
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t *wp = &s->wps->wp[index];
+    if (len == bs->total_sectors << BDRV_SECTOR_BITS) {
+        n = nrz;
+        index = 0;
+    } else {
+        n = len / zone_size;
+    }
+
+    for (int i = 0; i < n; ++i) {
+        uint64_t *wp_i = (uint64_t *)(wp + i);
+        uint64_t wpi_v = *wp_i;
+        if (QCOW2_ZT_IS_CONV(wpi_v)) {
+            continue;
+        }
+        
+        BlockZoneState zs = qcow2_get_zs(wpi_v);
+        switch (zs) {
+        case BLK_ZS_EMPTY:
+            break;
+        case BLK_ZS_IOPEN:
+            s->nr_zones_imp_open--;
+            break;
+        case BLK_ZS_EOPEN:
+            s->nr_zones_exp_open--;
+            break;
+        case BLK_ZS_CLOSED:
+            s->nr_zones_closed--;
+            break;
+        case BLK_ZS_FULL:
+            break;
+        default:
+            ret = -EINVAL;
+            goto unlock;
+        }
+
+        if (zs == BLK_ZS_EMPTY) {
+            continue;
+        }
+
+        *wp_i = ((uint64_t)index + i) * zone_size;
+        ret = qcow2_write_wp_at(bs, wp_i, index + i, BLK_ZS_EMPTY);
+        if (ret < 0) {
+            goto unlock;
+        }
+        /* clear data */
+        ret = qcow2_co_pwrite_zeroes(bs, qcow2_get_wp(*wp_i), zone_size, 0);
+        if (ret < 0) {
+            error_report("Failed to reset zone at 0x%" PRIx64 "", *wp_i);
+        }
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&s->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
+                                           int64_t offset, int64_t len)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret = 0;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_size = s->zoned_header.zone_size;
+    int64_t zone_size_mask = zone_size - 1;
+    uint32_t index = offset / zone_size;
+    BlockZoneWps *wps = s->wps;
+
+    if (offset >= capacity) {
+        error_report("offset %" PRId64 " is equal to or greater than the"
+                     "device capacity %" PRId64 "", offset, capacity);
+        return -EINVAL;
+    }
+
+    if (offset & zone_size_mask) {
+        error_report("sector offset %" PRId64 " is not aligned to zone size"
+                     " %" PRId64 "", offset / 512, zone_size / 512);
+        return -EINVAL;
+    }
+
+    if (((offset + len) < capacity && len & zone_size_mask) ||
+        offset + len > capacity) {
+        error_report("number of sectors %" PRId64 " is not aligned to zone"
+                     " size %" PRId64 "", len / 512, zone_size / 512);
+        return -EINVAL;
+    }
+
+    qemu_co_mutex_lock(&wps->colock);
+    uint64_t wpv = wps->wp[index];
+    if (QCOW2_ZT_IS_CONV(wpv) && len != capacity) {
+        error_report("zone mgmt operations are not allowed for "
+                     "conventional zones");
+        ret = -EIO;
+        goto unlock;
+    }
+    qemu_co_mutex_unlock(&wps->colock);
+
+    switch(op) {
+    case BLK_ZO_OPEN:
+        ret = qcow2_open_zone(bs, index);
+        break;
+    case BLK_ZO_CLOSE:
+        ret = qcow2_close_zone(bs, index);
+        break;
+    case BLK_ZO_FINISH:
+        ret = qcow2_finish_zone(bs, index);
+        break;
+    case BLK_ZO_RESET:
+        ret = qcow2_reset_zone(bs, index, len);
+        break;
+    default:
+        error_report("Unsupported zone op: 0x%x", op);
+        ret = -ENOTSUP;
+        break;
+    }
+    return ret;
+
+unlock:
+    qemu_co_mutex_unlock(&wps->colock);
+    return ret;
+}
+
+static int coroutine_fn
+qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
+                     BdrvRequestFlags flags)
+{
+    assert(flags == 0);
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t index;
+    int ret;
+    int64_t zone_size_mask = bs->bl.zone_size - 1;
+    int64_t iov_len = 0;
+    int64_t len = 0;
+
+    if (*offset >= capacity) {
+        error_report("*offset %" PRId64 " is equal to or greater than the"
+                     "device capacity %" PRId64 "", *offset, capacity);
+        return -EINVAL;
+    }
+
+    /* offset + len should not pass the end of that zone starting from offset */
+    if (*offset & zone_size_mask) {
+        error_report("sector offset %" PRId64 " is not aligned to zone size "
+                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+        return -EINVAL;
+    }
+
+    int64_t wg = bs->bl.write_granularity;
+    int64_t wg_mask = wg - 1;
+    for (int i = 0; i < qiov->niov; i++) {
+        iov_len = qiov->iov[i].iov_len;
+        if (iov_len & wg_mask) {
+            error_report("len of IOVector[%d] %" PRId64 " is not aligned to "
+                         "block size %" PRId64 "", i, iov_len, wg);
+            return -EINVAL;
+        }
+    }
+    len = qiov->size;
+    index = *offset / bs->bl.zone_size;
+
+    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
+        return -ENOTSUP;
+    }
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t wp = s->wps->wp[index];
+    uint64_t wp_i = qcow2_get_wp(wp);
+    ret = qcow2_co_pwritev_part(bs, wp_i, len, qiov, 0, 0);
+    if (ret == 0) {
+        *offset = wp_i;
+        /* the zone state is set to full when the wp reaches the end */
+        uint64_t wp_final = s->wps->wp[index];
+        if (!(qcow2_get_wp(wp_final) & zone_size_mask)) {
+            ret = qcow2_write_wp_at(bs, &wp_final, index, BLK_ZS_FULL);
+        }
+    } else {
+        error_report("qcow2: zap failed");
+    }
+
+    qemu_co_mutex_unlock(&s->wps->colock);
+    return ret;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_copy_range_from(BlockDriverState *bs,
                          BdrvChild *src, int64_t src_offset,
@@ -6238,6 +6906,10 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pwritev_part   = qcow2_co_pwritev_part,
     .bdrv_co_flush_to_os    = qcow2_co_flush_to_os,
 
+    .bdrv_co_zone_report    = qcow2_co_zone_report,
+    .bdrv_co_zone_mgmt    = qcow2_co_zone_mgmt,
+    .bdrv_co_zone_append    = qcow2_co_zone_append,
+
     .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
     .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
diff --git a/block/qcow2.h b/block/qcow2.h
index 3694c8d217..38b779ae32 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -248,6 +248,8 @@ typedef struct Qcow2ZonedHeaderExtension {
     uint32_t max_active_zones;
     uint32_t max_open_zones;
     uint32_t max_append_sectors;
+    uint64_t zonedmeta_offset;
+    uint64_t zonedmeta_size;
 } QEMU_PACKED Qcow2ZonedHeaderExtension;
 
 typedef struct Qcow2UnknownHeaderExtension {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index ef2ba6f670..739e2c62c6 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -354,6 +354,8 @@ The fields of the zoned extension are:
           20 - 23:  max_active_zones
           24 - 27:  max_open_zones
           28 - 31:  max_append_sectors
+          32 - 39:  zonedmeta_offset
+          40 - 47:  zonedmeta_size
 
 == Full disk encryption header pointer ==
 
-- 
2.40.1


