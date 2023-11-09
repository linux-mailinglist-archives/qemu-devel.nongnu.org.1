Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19067E6B87
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:51:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15O8-0002Jy-26; Thu, 09 Nov 2023 08:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ne-0000Gt-HC; Thu, 09 Nov 2023 08:47:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NU-0002Cs-SB; Thu, 09 Nov 2023 08:47:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDCC331B22;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C81FC344C8;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461888 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Naohiro Aota <nao.aota@gmail.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Sam Li <faithilikerun@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 42/55] file-posix: fix over-writing of returning
 zone_append offset
Date: Thu,  9 Nov 2023 16:42:46 +0300
Message-Id: <20231109134300.1461632-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Naohiro Aota <nao.aota@gmail.com>

raw_co_zone_append() sets "s->offset" where "BDRVRawState *s". This pointer
is used later at raw_co_prw() to save the block address where the data is
written.

When multiple IOs are on-going at the same time, a later IO's
raw_co_zone_append() call over-writes a former IO's offset address before
raw_co_prw() completes. As a result, the former zone append IO returns the
initial value (= the start address of the writing zone), instead of the
proper address.

Fix the issue by passing the offset pointer to raw_co_prw() instead of
passing it through s->offset. Also, remove "offset" from BDRVRawState as
there is no usage anymore.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Message-Id: <20231030073853.2601162-1-naohiro.aota@wdc.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit ad4feaca61d76fecad784e6d5e7bae40d0411c46)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 4e2902f66f..7f540b03ed 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -160,7 +160,6 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool use_linux_aio:1;
     bool use_linux_io_uring:1;
-    int64_t *offset; /* offset of zone append operation */
     int page_cache_inconsistent; /* errno from fdatasync failure */
     bool has_fallocate;
     bool needs_alignment;
@@ -2445,12 +2444,13 @@ static bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov)
     return true;
 }
 
-static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
+static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
                                    uint64_t bytes, QEMUIOVector *qiov, int type)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
     int ret;
+    uint64_t offset = *offset_ptr;
 
     if (fd_open(bs) < 0)
         return -EIO;
@@ -2513,8 +2513,8 @@ out:
             uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
-                    *s->offset = *wp;
-                    trace_zbd_zone_append_complete(bs, *s->offset
+                    *offset_ptr = *wp;
+                    trace_zbd_zone_append_complete(bs, *offset_ptr
                         >> BDRV_SECTOR_BITS);
                 }
                 /* Advance the wp if needed */
@@ -2539,14 +2539,14 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes, QEMUIOVector *qiov,
                                       BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ);
 }
 
 static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
                                        int64_t bytes, QEMUIOVector *qiov,
                                        BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
 static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
@@ -3509,8 +3509,6 @@ static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
     int64_t zone_size_mask = bs->bl.zone_size - 1;
     int64_t iov_len = 0;
     int64_t len = 0;
-    BDRVRawState *s = bs->opaque;
-    s->offset = offset;
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
@@ -3531,7 +3529,7 @@ static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
     }
 
     trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
-    return raw_co_prw(bs, *offset, len, qiov, QEMU_AIO_ZONE_APPEND);
+    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND);
 }
 #endif
 
-- 
2.39.2


