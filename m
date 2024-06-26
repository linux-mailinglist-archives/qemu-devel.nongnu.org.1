Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E159184D8
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jun 2024 16:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTzG-0000rY-Ii; Wed, 26 Jun 2024 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTzD-0000oz-4o; Wed, 26 Jun 2024 10:51:03 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTz9-0005Ug-Sw; Wed, 26 Jun 2024 10:51:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8662260F46;
 Wed, 26 Jun 2024 17:50:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eoRt0i0IXKo0-aGvznVwT; Wed, 26 Jun 2024 17:50:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719413454;
 bh=jdtR5KedLtA8nYH1kzysbX30CDHfRJIk3o3vHQGa1vI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=s5WPuvz0H/3AkhTmarxrLwuk1uPusypk9W7HOoU3C1QluqLZf3G4eQX8k90LQzZ5F
 J8Oul9KR0Uzb0ik4+EgSxc2Ggyt2Sp6YZGsW0AY2NMzk1wERFGX0roX/5u8cZfjfeW
 3zecqLBvinN4n1QqJWQGkarZWW4AmIrNQQso+91s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 2/3] block/stream: implement final flush
Date: Wed, 26 Jun 2024 17:50:37 +0300
Message-Id: <20240626145038.458709-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626145038.458709-1-vsementsov@yandex-team.ru>
References: <20240626145038.458709-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Actually block job is not completed without the final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Mirror job already has mirror_flush() for this. So, it's OK.

Do this for stream job too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/stream.c | 67 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7031eef12b..893db258d4 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -160,6 +160,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t offset = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
+    bool need_final_flush = true;
 
     WITH_GRAPH_RDLOCK_GUARD() {
         unfiltered_bs = bdrv_skip_filters(s->target_bs);
@@ -175,10 +176,13 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     }
     job_progress_set_remaining(&s->common.job, len);
 
-    for ( ; offset < len; offset += n) {
-        bool copy;
+    for ( ; offset < len || need_final_flush; offset += n) {
+        bool copy = false;
+        bool error_is_read = true;
         int ret;
 
+        n = 0;
+
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
@@ -187,35 +191,46 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
             break;
         }
 
-        copy = false;
-
-        WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_co_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
-            if (ret == 1) {
-                /* Allocated in the top, no need to copy.  */
-            } else if (ret >= 0) {
-                /*
-                 * Copy if allocated in the intermediate images.  Limit to the
-                 * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).
-                 */
-                ret = bdrv_co_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
-                                                 s->base_overlay, true,
-                                                 offset, n, &n);
-                /* Finish early if end of backing file has been reached */
-                if (ret == 0 && n == 0) {
-                    n = len - offset;
+        if (offset < len) {
+            WITH_GRAPH_RDLOCK_GUARD() {
+                ret = bdrv_co_is_allocated(unfiltered_bs, offset, STREAM_CHUNK,
+                                           &n);
+                if (ret == 1) {
+                    /* Allocated in the top, no need to copy.  */
+                } else if (ret >= 0) {
+                    /*
+                     * Copy if allocated in the intermediate images.  Limit to
+                     * the known-unallocated area
+                     * [offset, offset+n*BDRV_SECTOR_SIZE).
+                     */
+                    ret = bdrv_co_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                                                     s->base_overlay, true,
+                                                     offset, n, &n);
+                    /* Finish early if end of backing file has been reached */
+                    if (ret == 0 && n == 0) {
+                        n = len - offset;
+                    }
+
+                    copy = (ret > 0);
                 }
-
-                copy = (ret > 0);
             }
-        }
-        trace_stream_one_iteration(s, offset, n, ret);
-        if (copy) {
-            ret = stream_populate(s->blk, offset, n);
+            trace_stream_one_iteration(s, offset, n, ret);
+            if (copy) {
+                ret = stream_populate(s->blk, offset, n);
+            }
+        } else {
+            assert(need_final_flush);
+            ret = blk_co_flush(s->blk);
+            if (ret < 0) {
+                error_is_read = false;
+            } else {
+                need_final_flush = false;
+            }
         }
         if (ret < 0) {
             BlockErrorAction action =
-                block_job_error_action(&s->common, s->on_error, true, -ret);
+                block_job_error_action(&s->common, s->on_error,
+                                       error_is_read, -ret);
             if (action == BLOCK_ERROR_ACTION_STOP) {
                 n = 0;
                 continue;
-- 
2.34.1


