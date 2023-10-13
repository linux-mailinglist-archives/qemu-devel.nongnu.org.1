Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2B7C8006
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3i-0006lj-3H; Fri, 13 Oct 2023 03:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3e-0006TZ-6T
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3a-0006i8-20
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so21809585e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183880; x=1697788680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctAg+ygeu7rzsPQrC3aOHToXqdGGNVBy7xN17sRX6WQ=;
 b=d38R7XGUXjngdrkX8igJYjQ5U5WHOL/lhgNwt39nQh3xjObx1E4J99ved4ivAVb2sY
 WUe4LgVdSt28Ty/RzrMaKCJ1zpzUGbbUPthkmwZAofLVyIEwtxynbGPJ6UXqhTgbCsRF
 7yEWO+f3jl4RUOXtlsWWGrHpYQU9ix+yQKxcaFxUf72mApMHaGeTVjx9gFAnyHpOdsv+
 FjRgbQd1C68jVUqa7ct9tL3e1ifv4onV02DOEJm2qZ305FF+MXXAGjKDa+wa/tdeW7kU
 4g2YOMT04zW4ivMPcqCg8knv+96310c3y9Y/KCBdqnxa8EyzS9ZthHEkgRAi1lmX9ikh
 11bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183880; x=1697788680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctAg+ygeu7rzsPQrC3aOHToXqdGGNVBy7xN17sRX6WQ=;
 b=LVI8Y4VC6skc0Xwu0XLgsRCxzvKT2gHmXIRdQez1eS8jP+gq1ier9NZBtIjKMB0+Gx
 YGTxxoMDt56vVaYeaDCPb5/4tZprnX7JLkhC/mYprP9KNzEC5k3LtJWEc+p2pQrk9hh4
 u7jg1JYAjEBJ+T3HyGUmhXf7mKw0NcaH5oq0yviGYZs+ubP8rDpe11HqDJNpWgz7ekB2
 0sELt+7v/2NiGSAfn6aOUUhS3u3hVeetNzQ+YHGuesZT0mWnvGsD7Hz67uqVjy+csZXB
 rARPzxdq+nT5GlJ9uGfnzVqiB3TxZlFR5nkVKT15lQyWqBLLxw39cOd0gFWUbxilHaxb
 2lLQ==
X-Gm-Message-State: AOJu0Yzc2HnVzDzKeMZbsCR3bOiHxplUh6e5nJWpiymabJw+PIUbITVV
 vlpuIFxZorxbfdUWk19yzxmDExORLj5s8y6ZVTA=
X-Google-Smtp-Source: AGHT+IFsg0FqsAqtsovggJXLhhb8m06eqNfVe6Jk34qA+MwQsiGWrD/eL8pbar8NrjrwZOo2Tll/EQ==
X-Received: by 2002:a05:600c:2247:b0:405:359e:ee43 with SMTP id
 a7-20020a05600c224700b00405359eee43mr24717289wmm.1.1697183880083; 
 Fri, 13 Oct 2023 00:58:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:57:59 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Jeff Cody <codyprime@gmail.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [RFC PATCH v2 02/78] block: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:29 +0300
Message-Id: <e54aa70630d6d524886d7950b84d5bda39c3d605.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 block/block-copy.c    |  1 +
 block/file-posix.c    |  1 +
 block/io.c            |  1 +
 block/iscsi.c         |  1 +
 block/qcow2-cluster.c |  5 ++++-
 block/vhdx.c          | 17 +++++++++++++----
 6 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 1c60368d72..b4ceb6a079 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -473,78 +473,79 @@ static int coroutine_fn GRAPH_RDLOCK
 block_copy_do_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                    BlockCopyMethod *method, bool *error_is_read)
 {
     int ret;
     int64_t nbytes = MIN(offset + bytes, s->len) - offset;
     void *bounce_buffer = NULL;
 
     assert(offset >= 0 && bytes > 0 && INT64_MAX - offset >= bytes);
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
     assert(offset < s->len);
     assert(offset + bytes <= s->len ||
            offset + bytes == QEMU_ALIGN_UP(s->len, s->cluster_size));
     assert(nbytes < INT_MAX);
 
     switch (*method) {
     case COPY_WRITE_ZEROES:
         ret = bdrv_co_pwrite_zeroes(s->target, offset, nbytes, s->write_flags &
                                     ~BDRV_REQ_WRITE_COMPRESSED);
         if (ret < 0) {
             trace_block_copy_write_zeroes_fail(s, offset, ret);
             *error_is_read = false;
         }
         return ret;
 
     case COPY_RANGE_SMALL:
     case COPY_RANGE_FULL:
         ret = bdrv_co_copy_range(s->source, offset, s->target, offset, nbytes,
                                  0, s->write_flags);
         if (ret >= 0) {
             /* Successful copy-range, increase chunk size.  */
             *method = COPY_RANGE_FULL;
             return 0;
         }
 
         trace_block_copy_copy_range_fail(s, offset, ret);
         *method = COPY_READ_WRITE;
         /* Fall through to read+write with allocated buffer */
+        fallthrough;
 
     case COPY_READ_WRITE_CLUSTER:
     case COPY_READ_WRITE:
         /*
          * In case of failed copy_range request above, we may proceed with
          * buffered request larger than BLOCK_COPY_MAX_BUFFER.
          * Still, further requests will be properly limited, so don't care too
          * much. Moreover the most likely case (copy_range is unsupported for
          * the configuration, so the very first copy_range request fails)
          * is handled by setting large copy_size only after first successful
          * copy_range.
          */
 
         bounce_buffer = qemu_blockalign(s->source->bs, nbytes);
 
         ret = bdrv_co_pread(s->source, offset, nbytes, bounce_buffer, 0);
         if (ret < 0) {
             trace_block_copy_read_fail(s, offset, ret);
             *error_is_read = true;
             goto out;
         }
 
         ret = bdrv_co_pwrite(s->target, offset, nbytes, bounce_buffer,
                              s->write_flags);
         if (ret < 0) {
             trace_block_copy_write_fail(s, offset, ret);
             *error_is_read = false;
             goto out;
         }
 
     out:
         qemu_vfree(bounce_buffer);
         break;
 
     default:
         abort();
     }
 
     return ret;
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index 50e2b20d5c..31c7719da5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -972,69 +972,70 @@ static int raw_check_lock_bytes(int fd, uint64_t perm, uint64_t shared_perm,
 static int raw_handle_perm_lock(BlockDriverState *bs,
                                 RawPermLockOp op,
                                 uint64_t new_perm, uint64_t new_shared,
                                 Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     int ret = 0;
     Error *local_err = NULL;
 
     if (!s->use_lock) {
         return 0;
     }
 
     if (bdrv_get_flags(bs) & BDRV_O_INACTIVE) {
         return 0;
     }
 
     switch (op) {
     case RAW_PL_PREPARE:
         if ((s->perm | new_perm) == s->perm &&
             (s->shared_perm & new_shared) == s->shared_perm)
         {
             /*
              * We are going to unlock bytes, it should not fail. If it fail due
              * to some fs-dependent permission-unrelated reasons (which occurs
              * sometimes on NFS and leads to abort in bdrv_replace_child) we
              * can't prevent such errors by any check here. And we ignore them
              * anyway in ABORT and COMMIT.
              */
             return 0;
         }
         ret = raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
             ret = raw_check_lock_bytes(s->fd, new_perm, new_shared, errp);
             if (!ret) {
                 return 0;
             }
             error_append_hint(errp,
                               "Is another process using the image [%s]?\n",
                               bs->filename);
         }
         /* fall through to unlock bytes. */
+        fallthrough;
     case RAW_PL_ABORT:
         raw_apply_lock_bytes(s, s->fd, s->perm, ~s->shared_perm,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
             warn_report_err(local_err);
         }
         break;
     case RAW_PL_COMMIT:
         raw_apply_lock_bytes(s, s->fd, new_perm, ~new_shared,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it cannot
              * fail. Something weird happened, report it.
              */
             warn_report_err(local_err);
         }
         break;
     }
     return ret;
 }
 
 /* Sets a specific flag */
diff --git a/block/io.c b/block/io.c
index e7f9448d5a..cc05457d02 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2007,43 +2007,44 @@ static inline void coroutine_fn
 bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     BlockDriverState *bs = child->bs;
 
     bdrv_check_request(offset, bytes, &error_abort);
 
     qatomic_inc(&bs->write_gen);
 
     /*
      * Discard cannot extend the image, but in error handling cases, such as
      * when reverting a qcow2 cluster allocation, the discarded range can pass
      * the end of image file, so we cannot assert about BDRV_TRACKED_DISCARD
      * here. Instead, just skip it, since semantically a discard request
      * beyond EOF cannot expand the image anyway.
      */
     if (ret == 0 &&
         (req->type == BDRV_TRACKED_TRUNCATE ||
          end_sector > bs->total_sectors) &&
         req->type != BDRV_TRACKED_DISCARD) {
         bs->total_sectors = end_sector;
         bdrv_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
     if (req->bytes) {
         switch (req->type) {
         case BDRV_TRACKED_WRITE:
             stat64_max(&bs->wr_highest_offset, offset + bytes);
             /* fall through, to set dirty bits */
+            fallthrough;
         case BDRV_TRACKED_DISCARD:
             bdrv_set_dirty(bs, offset, bytes);
             break;
         default:
             break;
         }
     }
 }
 
 /*
  * Forwards an already correctly aligned write request to the BlockDriver,
  * after possibly fragmenting it.
  */
diff --git a/block/iscsi.c b/block/iscsi.c
index 5640c8b565..2fb7037748 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1430,69 +1430,70 @@ static void iscsi_nop_timed_event(void *opaque)
 static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
 {
     struct scsi_task *task = NULL;
     struct scsi_readcapacity10 *rc10 = NULL;
     struct scsi_readcapacity16 *rc16 = NULL;
     int retries = ISCSI_CMD_RETRIES; 
 
     do {
         if (task != NULL) {
             scsi_free_scsi_task(task);
             task = NULL;
         }
 
         switch (iscsilun->type) {
         case TYPE_DISK:
             task = iscsi_readcapacity16_sync(iscsilun->iscsi, iscsilun->lun);
             if (task != NULL && task->status == SCSI_STATUS_GOOD) {
                 rc16 = scsi_datain_unmarshall(task);
                 if (rc16 == NULL) {
                     error_setg(errp, "iSCSI: Failed to unmarshall readcapacity16 data.");
                 } else {
                     iscsilun->block_size = rc16->block_length;
                     iscsilun->num_blocks = rc16->returned_lba + 1;
                     iscsilun->lbpme = !!rc16->lbpme;
                     iscsilun->lbprz = !!rc16->lbprz;
                     iscsilun->use_16_for_rw = (rc16->returned_lba > 0xffffffff);
                 }
                 break;
             }
             if (task != NULL && task->status == SCSI_STATUS_CHECK_CONDITION
                 && task->sense.key == SCSI_SENSE_UNIT_ATTENTION) {
                 break;
             }
             /* Fall through and try READ CAPACITY(10) instead.  */
+            fallthrough;
         case TYPE_ROM:
             task = iscsi_readcapacity10_sync(iscsilun->iscsi, iscsilun->lun, 0, 0);
             if (task != NULL && task->status == SCSI_STATUS_GOOD) {
                 rc10 = scsi_datain_unmarshall(task);
                 if (rc10 == NULL) {
                     error_setg(errp, "iSCSI: Failed to unmarshall readcapacity10 data.");
                 } else {
                     iscsilun->block_size = rc10->block_size;
                     if (rc10->lba == 0) {
                         /* blank disk loaded */
                         iscsilun->num_blocks = 0;
                     } else {
                         iscsilun->num_blocks = rc10->lba + 1;
                     }
                 }
             }
             break;
         default:
             return;
         }
     } while (task != NULL && task->status == SCSI_STATUS_CHECK_CONDITION
              && task->sense.key == SCSI_SENSE_UNIT_ATTENTION
              && retries-- > 0);
 
     if (task == NULL || task->status != SCSI_STATUS_GOOD) {
         error_setg(errp, "iSCSI: failed to send readcapacity10/16 command");
     } else if (!iscsilun->block_size ||
                iscsilun->block_size % BDRV_SECTOR_SIZE) {
         error_setg(errp, "iSCSI: the target returned an invalid "
                    "block size of %d.", iscsilun->block_size);
     }
     if (task) {
         scsi_free_scsi_task(task);
     }
 }
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f4f6cd6ad0..c50143d493 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1327,36 +1327,39 @@ static int coroutine_fn calculate_l2_meta(BlockDriverState *bs,
 /*
  * Returns true if writing to the cluster pointed to by @l2_entry
  * requires a new allocation (that is, if the cluster is unallocated
  * or has refcount > 1 and therefore cannot be written in-place).
  */
 static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
 {
     switch (qcow2_get_cluster_type(bs, l2_entry)) {
     case QCOW2_CLUSTER_NORMAL:
+        fallthrough;
     case QCOW2_CLUSTER_ZERO_ALLOC:
         if (l2_entry & QCOW_OFLAG_COPIED) {
             return false;
         }
-        /* fallthrough */
+        fallthrough;
     case QCOW2_CLUSTER_UNALLOCATED:
+        fallthrough;
     case QCOW2_CLUSTER_COMPRESSED:
+        fallthrough;
     case QCOW2_CLUSTER_ZERO_PLAIN:
         return true;
     default:
         abort();
     }
 }
 
 /*
  * Returns the number of contiguous clusters that can be written to
  * using one single write request, starting from @l2_index.
  * At most @nb_clusters are checked.
  *
  * If @new_alloc is true this counts clusters that are either
  * unallocated, or allocated but with refcount > 1 (so they need to be
  * newly allocated and COWed).
  *
  * If @new_alloc is false this counts clusters that are already
  * allocated and can be overwritten in-place (this includes clusters
  * of type QCOW2_CLUSTER_ZERO_ALLOC).
  */
diff --git a/block/vhdx.c b/block/vhdx.c
index a67edcc03e..9000b3fcea 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1176,60 +1176,65 @@ static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
               QEMUIOVector *qiov)
 {
     BDRVVHDXState *s = bs->opaque;
     int ret = 0;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
     QEMUIOVector hd_qiov;
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     qemu_co_mutex_lock(&s->lock);
 
     while (nb_sectors > 0) {
         /* We are a differencing file, so we need to inspect the sector bitmap
          * to see if we have the data or not */
         if (s->params.data_bits & VHDX_PARAMS_HAS_PARENT) {
             /* not supported yet */
             ret = -ENOTSUP;
             goto exit;
         } else {
             vhdx_block_translate(s, sector_num, nb_sectors, &sinfo);
 
             qemu_iovec_reset(&hd_qiov);
             qemu_iovec_concat(&hd_qiov, qiov,  bytes_done, sinfo.bytes_avail);
 
             /* check the payload block state */
             switch (s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) {
-            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
+            case PAYLOAD_BLOCK_NOT_PRESENT:
+                fallthrough;
             case PAYLOAD_BLOCK_UNDEFINED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED_v095:
+                fallthrough;
             case PAYLOAD_BLOCK_ZERO:
                 /* return zero */
                 qemu_iovec_memset(&hd_qiov, 0, 0, sinfo.bytes_avail);
                 break;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_preadv(bs->file, sinfo.file_offset,
                                      sinfo.sectors_avail * BDRV_SECTOR_SIZE,
                                      &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     goto exit;
                 }
                 break;
             case PAYLOAD_BLOCK_PARTIALLY_PRESENT:
                 /* we don't yet support difference files, fall through
                  * to error */
+                fallthrough;
             default:
                 ret = -EIO;
                 goto exit;
                 break;
             }
             nb_sectors -= sinfo.sectors_avail;
             sector_num += sinfo.sectors_avail;
             bytes_done += sinfo.bytes_avail;
         }
     }
     ret = 0;
@@ -1330,155 +1335,159 @@ static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                QEMUIOVector *qiov, int flags)
 {
     int ret = -ENOTSUP;
     BDRVVHDXState *s = bs->opaque;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
     uint64_t bat_entry = 0;
     uint64_t bat_entry_offset = 0;
     QEMUIOVector hd_qiov;
     struct iovec iov1 = { 0 };
     struct iovec iov2 = { 0 };
     int sectors_to_write;
     int bat_state;
     uint64_t bat_prior_offset = 0;
     bool bat_update = false;
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     qemu_co_mutex_lock(&s->lock);
 
     ret = vhdx_user_visible_write(bs, s);
     if (ret < 0) {
         goto exit;
     }
 
     while (nb_sectors > 0) {
         bool use_zero_buffers = false;
         bat_update = false;
         if (s->params.data_bits & VHDX_PARAMS_HAS_PARENT) {
             /* not supported yet */
             ret = -ENOTSUP;
             goto exit;
         } else {
             vhdx_block_translate(s, sector_num, nb_sectors, &sinfo);
             sectors_to_write = sinfo.sectors_avail;
 
             qemu_iovec_reset(&hd_qiov);
             /* check the payload block state */
             bat_state = s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK;
             switch (bat_state) {
             case PAYLOAD_BLOCK_ZERO:
                 /* in this case, we need to preserve zero writes for
                  * data that is not part of this write, so we must pad
                  * the rest of the buffer to zeroes */
                 use_zero_buffers = true;
-                /* fall through */
-            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
+                fallthrough;
+            case PAYLOAD_BLOCK_NOT_PRESENT:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED:
+                fallthrough;
             case PAYLOAD_BLOCK_UNMAPPED_v095:
+                fallthrough;
             case PAYLOAD_BLOCK_UNDEFINED:
                 bat_prior_offset = sinfo.file_offset;
                 ret = vhdx_allocate_block(bs, s, &sinfo.file_offset,
                                           &use_zero_buffers);
                 if (ret < 0) {
                     goto exit;
                 }
                 /*
                  * once we support differencing files, this may also be
                  * partially present
                  */
                 /* update block state to the newly specified state */
                 vhdx_update_bat_table_entry(bs, s, &sinfo, &bat_entry,
                                             &bat_entry_offset,
                                             PAYLOAD_BLOCK_FULLY_PRESENT);
                 bat_update = true;
                 /*
                  * Since we just allocated a block, file_offset is the
                  * beginning of the payload block. It needs to be the
                  * write address, which includes the offset into the
                  * block, unless the entire block needs to read as
                  * zeroes but truncation was not able to provide them,
                  * in which case we need to fill in the rest.
                  */
                 if (!use_zero_buffers) {
                     sinfo.file_offset += sinfo.block_offset;
                 } else {
                     /* zero fill the front, if any */
                     if (sinfo.block_offset) {
                         iov1.iov_len = sinfo.block_offset;
                         iov1.iov_base = qemu_blockalign(bs, iov1.iov_len);
                         memset(iov1.iov_base, 0, iov1.iov_len);
                         qemu_iovec_concat_iov(&hd_qiov, &iov1, 1, 0,
                                               iov1.iov_len);
                         sectors_to_write += iov1.iov_len >> BDRV_SECTOR_BITS;
                     }
 
                     /* our actual data */
                     qemu_iovec_concat(&hd_qiov, qiov, bytes_done,
                                       sinfo.bytes_avail);
 
                     /* zero fill the back, if any */
                     if ((sinfo.bytes_avail - sinfo.block_offset) <
                          s->block_size) {
                         iov2.iov_len = s->block_size -
                                       (sinfo.bytes_avail + sinfo.block_offset);
                         iov2.iov_base = qemu_blockalign(bs, iov2.iov_len);
                         memset(iov2.iov_base, 0, iov2.iov_len);
                         qemu_iovec_concat_iov(&hd_qiov, &iov2, 1, 0,
                                               iov2.iov_len);
                         sectors_to_write += iov2.iov_len >> BDRV_SECTOR_BITS;
                     }
                 }
 
-                /* fall through */
+                fallthrough;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 /* if the file offset address is in the header zone,
                  * there is a problem */
                 if (sinfo.file_offset < (1 * MiB)) {
                     ret = -EFAULT;
                     goto error_bat_restore;
                 }
 
                 if (!use_zero_buffers) {
                     qemu_iovec_concat(&hd_qiov, qiov,  bytes_done,
                                       sinfo.bytes_avail);
                 }
                 /* block exists, so we can just overwrite it */
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_pwritev(bs->file, sinfo.file_offset,
                                       sectors_to_write * BDRV_SECTOR_SIZE,
                                       &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     goto error_bat_restore;
                 }
                 break;
             case PAYLOAD_BLOCK_PARTIALLY_PRESENT:
                 /* we don't yet support difference files, fall through
                  * to error */
+                fallthrough;
             default:
                 ret = -EIO;
                 goto exit;
                 break;
             }
 
             if (bat_update) {
                 /* this will update the BAT entry into the log journal, and
                  * then flush the log journal out to disk */
                 ret =  vhdx_log_write_and_flush(bs, s, &bat_entry,
                                                 sizeof(VHDXBatEntry),
                                                 bat_entry_offset);
                 if (ret < 0) {
                     goto exit;
                 }
             }
 
             nb_sectors -= sinfo.sectors_avail;
             sector_num += sinfo.sectors_avail;
             bytes_done += sinfo.bytes_avail;
 
         }
     }
 
     goto exit;
-- 
2.39.2


