Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7127E2AB9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r037e-0002YQ-GW; Mon, 06 Nov 2023 12:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037c-0002Xo-UT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r037Z-00070Q-PK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699290640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Du5YL3nQiNSvA7+97bv/GKr2/L/cZNmIRLUQKPEa0OM=;
 b=KUH94RfuJyVdIY4Ss0zI+fViDUm5XBr6dOkVbxSdB71qRd8lnBqHAPnotgibPpwp5ue64+
 a35rh8sltmyY/XVAiDN006evlaA1ZOwDnlL61o/lL4nMgNqeBMOcStHdUKN9Mn8A6zmaf5
 1E1Fylp7uicyb3lhbcJNPV0rFBZ8yG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-9R4IbSFYPvOySlD_HHOQaA-1; Mon, 06 Nov 2023 12:10:39 -0500
X-MC-Unique: 9R4IbSFYPvOySlD_HHOQaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 063E08678AA;
 Mon,  6 Nov 2023 17:10:39 +0000 (UTC)
Received: from localhost (unknown [10.39.193.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABAFB40C6EB9;
 Mon,  6 Nov 2023 17:10:38 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 3/3] file-posix: fix over-writing of returning zone_append
 offset
Date: Mon,  6 Nov 2023 18:10:31 +0100
Message-ID: <20231106171031.1084277-4-hreitz@redhat.com>
In-Reply-To: <20231106171031.1084277-1-hreitz@redhat.com>
References: <20231106171031.1084277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 block/file-posix.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c0ce9c258..b862406c71 100644
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
2.41.0


