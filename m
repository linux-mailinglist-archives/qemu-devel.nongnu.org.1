Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867C70324D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyahf-00052n-C3; Mon, 15 May 2023 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahb-00050y-PE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahY-00023K-Sr
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684166732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=227nPLZ/tilrIc9yT43eUOpb89fWbtEhYabWG7aFPLs=;
 b=E7QHWkbNBNEOoycKNn9hm0K8NQEELZhyh6uRDwrRx6QkObIiAhoRMrAHKQB4s0MyfXiWzE
 yBsBH65v8p9ZrXirs/jvIjBmUuyjdolNiyi7WGVBaJMm10Kx2GsD46f4wxo1hPydXoxJdc
 vucYnAW3DEouwlUiykfOiYevx+rXy6I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-sLGbCM4MNySNThQqQaFpuQ-1; Mon, 15 May 2023 12:05:28 -0400
X-MC-Unique: sLGbCM4MNySNThQqQaFpuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14E771C0513D;
 Mon, 15 May 2023 16:05:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5723F140E917;
 Mon, 15 May 2023 16:05:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PULL v2 09/16] file-posix: add tracking of the zone write pointers
Date: Mon, 15 May 2023 12:04:59 -0400
Message-Id: <20230515160506.1776883-10-stefanha@redhat.com>
In-Reply-To: <20230515160506.1776883-1-stefanha@redhat.com>
References: <20230515160506.1776883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Sam Li <faithilikerun@gmail.com>

Since Linux doesn't have a user API to issue zone append operations to
zoned devices from user space, the file-posix driver is modified to add
zone append emulation using regular writes. To do this, the file-posix
driver tracks the wp location of all zones of the device. It uses an
array of uint64_t. The most significant bit of each wp location indicates
if the zone type is conventional zones.

The zones wp can be changed due to the following operations issued:
- zone reset: change the wp to the start offset of that zone
- zone finish: change to the end location of that zone
- write to a zone
- zone append

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Message-id: 20230508051510.177850-2-faithilikerun@gmail.com
[Fix errno propagation from handle_aiocb_zone_mgmt()
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-common.h     |  14 +++
 include/block/block_int-common.h |   5 +
 block/file-posix.c               | 178 ++++++++++++++++++++++++++++++-
 3 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 1576fcf2ed..93196229ac 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -118,6 +118,14 @@ typedef struct BlockZoneDescriptor {
     BlockZoneState state;
 } BlockZoneDescriptor;
 
+/*
+ * Track write pointers of a zone in bytes.
+ */
+typedef struct BlockZoneWps {
+    CoMutex colock;
+    uint64_t wp[];
+} BlockZoneWps;
+
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
     int cluster_size;
@@ -240,6 +248,12 @@ typedef enum {
 #define BDRV_SECTOR_BITS   9
 #define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BITS)
 
+/*
+ * Get the first most significant bit of wp. If it is zero, then
+ * the zone type is SWR.
+ */
+#define BDRV_ZT_IS_CONV(wp)    (wp & (1ULL << 63))
+
 #define BDRV_REQUEST_MAX_SECTORS MIN_CONST(SIZE_MAX >> BDRV_SECTOR_BITS, \
                                            INT_MAX >> BDRV_SECTOR_BITS)
 #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index e6975d3933..1674b4745d 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -891,6 +891,8 @@ typedef struct BlockLimits {
 
     /* maximum number of active zones */
     uint32_t max_active_zones;
+
+    uint32_t write_granularity;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
@@ -1252,6 +1254,9 @@ struct BlockDriverState {
     CoMutex bsc_modify_lock;
     /* Always non-NULL, but must only be dereferenced under an RCU read guard */
     BdrvBlockStatusCache *block_status_cache;
+
+    /* array of write pointers' location of each zone in the zoned device. */
+    BlockZoneWps *wps;
 };
 
 struct BlockBackendRootState {
diff --git a/block/file-posix.c b/block/file-posix.c
index e143de8217..56f57515d4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1323,9 +1323,93 @@ static int hdev_get_max_segments(int fd, struct stat *st)
 }
 
 #if defined(CONFIG_BLKZONED)
+/*
+ * If the reset_all flag is true, then the wps of zone whose state is
+ * not readonly or offline should be all reset to the start sector.
+ * Else, take the real wp of the device.
+ */
+static int get_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
+                        unsigned int nrz, bool reset_all)
+{
+    struct blk_zone *blkz;
+    size_t rep_size;
+    uint64_t sector = offset >> BDRV_SECTOR_BITS;
+    BlockZoneWps *wps = bs->wps;
+    unsigned int j = offset / bs->bl.zone_size;
+    unsigned int n = 0, i = 0;
+    int ret;
+    rep_size = sizeof(struct blk_zone_report) + nrz * sizeof(struct blk_zone);
+    g_autofree struct blk_zone_report *rep = NULL;
+
+    rep = g_malloc(rep_size);
+    blkz = (struct blk_zone *)(rep + 1);
+    while (n < nrz) {
+        memset(rep, 0, rep_size);
+        rep->sector = sector;
+        rep->nr_zones = nrz - n;
+
+        do {
+            ret = ioctl(fd, BLKREPORTZONE, rep);
+        } while (ret != 0 && errno == EINTR);
+        if (ret != 0) {
+            error_report("%d: ioctl BLKREPORTZONE at %" PRId64 " failed %d",
+                    fd, offset, errno);
+            return -errno;
+        }
+
+        if (!rep->nr_zones) {
+            break;
+        }
+
+        for (i = 0; i < rep->nr_zones; ++i, ++n, ++j) {
+            /*
+             * The wp tracking cares only about sequential writes required and
+             * sequential write preferred zones so that the wp can advance to
+             * the right location.
+             * Use the most significant bit of the wp location to indicate the
+             * zone type: 0 for SWR/SWP zones and 1 for conventional zones.
+             */
+            if (blkz[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+                wps->wp[j] |= 1ULL << 63;
+            } else {
+                switch(blkz[i].cond) {
+                case BLK_ZONE_COND_FULL:
+                case BLK_ZONE_COND_READONLY:
+                    /* Zone not writable */
+                    wps->wp[j] = (blkz[i].start + blkz[i].len) << BDRV_SECTOR_BITS;
+                    break;
+                case BLK_ZONE_COND_OFFLINE:
+                    /* Zone not writable nor readable */
+                    wps->wp[j] = (blkz[i].start) << BDRV_SECTOR_BITS;
+                    break;
+                default:
+                    if (reset_all) {
+                        wps->wp[j] = blkz[i].start << BDRV_SECTOR_BITS;
+                    } else {
+                        wps->wp[j] = blkz[i].wp << BDRV_SECTOR_BITS;
+                    }
+                    break;
+                }
+            }
+        }
+        sector = blkz[i - 1].start + blkz[i - 1].len;
+    }
+
+    return 0;
+}
+
+static void update_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
+                            unsigned int nrz)
+{
+    if (get_zones_wp(bs, fd, offset, nrz, 0) < 0) {
+        error_report("update zone wp failed");
+    }
+}
+
 static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
                                      Error **errp)
 {
+    BDRVRawState *s = bs->opaque;
     BlockZoneModel zoned;
     int ret;
 
@@ -1376,6 +1460,23 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     if (ret > 0) {
         bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
     }
+
+    ret = get_sysfs_long_val(st, "physical_block_size");
+    if (ret >= 0) {
+        bs->bl.write_granularity = ret;
+    }
+
+    /* The refresh_limits() function can be called multiple times. */
+    g_free(bs->wps);
+    bs->wps = g_malloc(sizeof(BlockZoneWps) +
+            sizeof(int64_t) * bs->bl.nr_zones);
+    ret = get_zones_wp(bs, s->fd, 0, bs->bl.nr_zones, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "report wps failed");
+        bs->wps = NULL;
+        return;
+    }
+    qemu_co_mutex_init(&bs->wps->colock);
 }
 #else /* !defined(CONFIG_BLKZONED) */
 static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
@@ -2061,7 +2162,7 @@ static int handle_aiocb_zone_mgmt(void *opaque)
         ret = ioctl(fd, aiocb->zone_mgmt.op, &range);
     } while (ret != 0 && errno == EINTR);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 #endif
 
@@ -2347,9 +2448,15 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
+    int ret;
 
     if (fd_open(bs) < 0)
         return -EIO;
+#if defined(CONFIG_BLKZONED)
+    if (type & QEMU_AIO_WRITE && bs->wps) {
+        qemu_co_mutex_lock(&bs->wps->colock);
+    }
+#endif
 
     /*
      * When using O_DIRECT, the request must be aligned to be able to use
@@ -2362,12 +2469,15 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
 #ifdef CONFIG_LINUX_IO_URING
     } else if (s->use_linux_io_uring) {
         assert(qiov->size == bytes);
-        return luring_co_submit(bs, s->fd, offset, qiov, type);
+        ret = luring_co_submit(bs, s->fd, offset, qiov, type);
+        goto out;
 #endif
 #ifdef CONFIG_LINUX_AIO
     } else if (s->use_linux_aio) {
         assert(qiov->size == bytes);
-        return laio_co_submit(s->fd, offset, qiov, type, s->aio_max_batch);
+        ret = laio_co_submit(s->fd, offset, qiov, type,
+                              s->aio_max_batch);
+        goto out;
 #endif
     }
 
@@ -2384,7 +2494,35 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     };
 
     assert(qiov->size == bytes);
-    return raw_thread_pool_submit(handle_aiocb_rw, &acb);
+    ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
+    goto out; /* Avoid the compiler err of unused label */
+
+out:
+#if defined(CONFIG_BLKZONED)
+{
+    BlockZoneWps *wps = bs->wps;
+    if (ret == 0) {
+        if (type & QEMU_AIO_WRITE && wps && bs->bl.zone_size) {
+            uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
+            if (!BDRV_ZT_IS_CONV(*wp)) {
+                /* Advance the wp if needed */
+                if (offset + bytes > *wp) {
+                    *wp = offset + bytes;
+                }
+            }
+        }
+    } else {
+        if (type & QEMU_AIO_WRITE) {
+            update_zones_wp(bs, s->fd, 0, 1);
+        }
+    }
+
+    if (type & QEMU_AIO_WRITE && wps) {
+        qemu_co_mutex_unlock(&wps->colock);
+    }
+}
+#endif
+    return ret;
 }
 
 static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -2487,6 +2625,9 @@ static void raw_close(BlockDriverState *bs)
     BDRVRawState *s = bs->opaque;
 
     if (s->fd >= 0) {
+#if defined(CONFIG_BLKZONED)
+        g_free(bs->wps);
+#endif
         qemu_close(s->fd);
         s->fd = -1;
     }
@@ -3284,6 +3425,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
     const char *op_name;
     unsigned long zo;
     int ret;
+    BlockZoneWps *wps = bs->wps;
     int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
 
     zone_size = bs->bl.zone_size;
@@ -3301,6 +3443,14 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
         return -EINVAL;
     }
 
+    uint32_t i = offset / bs->bl.zone_size;
+    uint32_t nrz = len / bs->bl.zone_size;
+    uint64_t *wp = &wps->wp[i];
+    if (BDRV_ZT_IS_CONV(*wp) && len != capacity) {
+        error_report("zone mgmt operations are not allowed for conventional zones");
+        return -EIO;
+    }
+
     switch (op) {
     case BLK_ZO_OPEN:
         op_name = "BLKOPENZONE";
@@ -3338,7 +3488,27 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                         len >> BDRV_SECTOR_BITS);
     ret = raw_thread_pool_submit(handle_aiocb_zone_mgmt, &acb);
     if (ret != 0) {
+        update_zones_wp(bs, s->fd, offset, i);
         error_report("ioctl %s failed %d", op_name, ret);
+        return ret;
+    }
+
+    if (zo == BLKRESETZONE && len == capacity) {
+        ret = get_zones_wp(bs, s->fd, 0, bs->bl.nr_zones, 1);
+        if (ret < 0) {
+            error_report("reporting single wp failed");
+            return ret;
+        }
+    } else if (zo == BLKRESETZONE) {
+        for (unsigned int j = 0; j < nrz; ++j) {
+            wp[j] = offset + j * zone_size;
+        }
+    } else if (zo == BLKFINISHZONE) {
+        for (unsigned int j = 0; j < nrz; ++j) {
+            /* The zoned device allows the last zone smaller that the
+             * zone size. */
+            wp[j] = MIN(offset + (j + 1) * zone_size, offset + len);
+        }
     }
 
     return ret;
-- 
2.40.1


