Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB23741396
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyC-0000IM-Aw; Wed, 28 Jun 2023 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxu-0008JH-Kr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxn-0005HY-V1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LREAmbiCaAcrea5MbzOl3rlWDJdAWltW49/x0gkOMfA=;
 b=G/MjhC96r+382lMIMdU0IkIiodnTnzKdhW6GXuKeOLQriM3bad2uLx1XnnXYhkXu0slT9q
 EfbVs8uGuCP0CPcjzR6t5sQBAsJqi5ry4PAMhLb2wlFAR/wCj2CMeZtHPq2Z9hyiIKFXA5
 l5Z5yWBcNsduAAAsSCHZ9jORkjHlJI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-0YNfy_9VOUyNOonoPM17FQ-1; Wed, 28 Jun 2023 10:16:01 -0400
X-MC-Unique: 0YNfy_9VOUyNOonoPM17FQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A33F1C4769E;
 Wed, 28 Jun 2023 14:15:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6E8440C2063;
 Wed, 28 Jun 2023 14:15:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/23] file-posix: remove incorrect coroutine_fn calls
Date: Wed, 28 Jun 2023 16:15:15 +0200
Message-ID: <20230628141526.293104-13-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

raw_co_getlength is called by handle_aiocb_write_zeroes, which is not a coroutine
function.  This is harmless because raw_co_getlength does not actually suspend,
but in the interest of clarity make it a non-coroutine_fn that is just wrapped
by the coroutine_fn raw_co_getlength.  Likewise, check_cache_dropped was only
a coroutine_fn because it called raw_co_getlength, so it can be made non-coroutine
as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-2-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ac1ed54811..9e8e3d8ca5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -193,7 +193,7 @@ static int fd_open(BlockDriverState *bs)
     return -EIO;
 }
 
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs);
+static int64_t raw_getlength(BlockDriverState *bs);
 
 typedef struct RawPosixAIOData {
     BlockDriverState *bs;
@@ -1974,7 +1974,7 @@ static int handle_aiocb_write_zeroes(void *opaque)
 #ifdef CONFIG_FALLOCATE
     /* Last resort: we are trying to extend the file with zeroed data. This
      * can be done via fallocate(fd, 0) */
-    len = raw_co_getlength(aiocb->bs);
+    len = raw_getlength(aiocb->bs);
     if (s->has_fallocate && len >= 0 && aiocb->aio_offset >= len) {
         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
         if (ret == 0 || ret != -ENOTSUP) {
@@ -2666,7 +2666,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-        int64_t cur_length = raw_co_getlength(bs);
+        int64_t cur_length = raw_getlength(bs);
 
         if (offset != cur_length && exact) {
             error_setg(errp, "Cannot resize device files");
@@ -2684,7 +2684,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
 }
 
 #ifdef __OpenBSD__
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2703,7 +2703,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
         return st.st_size;
 }
 #elif defined(__NetBSD__)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2728,7 +2728,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
         return st.st_size;
 }
 #elif defined(__sun__)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     struct dk_minfo minfo;
@@ -2759,7 +2759,7 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
     return size;
 }
 #elif defined(CONFIG_BSD)
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int fd = s->fd;
@@ -2831,7 +2831,7 @@ again:
     return size;
 }
 #else
-static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+static int64_t raw_getlength(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
     int ret;
@@ -2850,6 +2850,11 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
 }
 #endif
 
+static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
+{
+    return raw_getlength(bs);
+}
+
 static int64_t coroutine_fn raw_co_get_allocated_file_size(BlockDriverState *bs)
 {
     struct stat st;
@@ -3215,7 +3220,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
          * round up if necessary.
          */
         if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
-            int64_t file_length = raw_co_getlength(bs);
+            int64_t file_length = raw_getlength(bs);
             if (file_length > 0) {
                 /* Ignore errors, this is just a safeguard */
                 assert(hole == file_length);
@@ -3237,7 +3242,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
 
 #if defined(__linux__)
 /* Verify that the file is not in the page cache */
-static void coroutine_fn check_cache_dropped(BlockDriverState *bs, Error **errp)
+static void check_cache_dropped(BlockDriverState *bs, Error **errp)
 {
     const size_t window_size = 128 * 1024 * 1024;
     BDRVRawState *s = bs->opaque;
@@ -3252,7 +3257,7 @@ static void coroutine_fn check_cache_dropped(BlockDriverState *bs, Error **errp)
     page_size = sysconf(_SC_PAGESIZE);
     vec = g_malloc(DIV_ROUND_UP(window_size, page_size));
 
-    end = raw_co_getlength(bs);
+    end = raw_getlength(bs);
 
     for (offset = 0; offset < end; offset += window_size) {
         void *new_window;
@@ -4468,7 +4473,7 @@ static int cdrom_reopen(BlockDriverState *bs)
 
 static bool coroutine_fn cdrom_co_is_inserted(BlockDriverState *bs)
 {
-    return raw_co_getlength(bs) > 0;
+    return raw_getlength(bs) > 0;
 }
 
 static void coroutine_fn cdrom_co_eject(BlockDriverState *bs, bool eject_flag)
-- 
2.41.0


