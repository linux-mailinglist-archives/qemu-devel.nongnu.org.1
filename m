Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6733BAA09BF
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 13:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDl-0006vb-I1; Tue, 29 Apr 2025 07:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDg-0006sT-1h; Tue, 29 Apr 2025 07:33:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008FH-Ef; Tue, 29 Apr 2025 07:33:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1399A611A0;
 Tue, 29 Apr 2025 14:33:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-NjKzBwzc; Tue, 29 Apr 2025 14:33:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926420;
 bh=/rG8UY5S3NYVU1597V40CSKWbjuXV6Z6w9PPCbf6m1E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oFB9TLz07EpVDUQTxJyVOKTrU+gKjSkbv7Bhvlf10R8bjMPWHBQzI6y+3ak9mXDQB
 50OHyFnqzST1FIRM9gDJaUmjoR64n72KhF8buVCHhpzFAyCAMSsNETlafCBTg8BOjl
 1MtrCF0NLqPyemUhvICY1tXPvEYhrjtnBxYHnkqg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 3/8] block: refactor error handling of commit_iteration
Date: Tue, 29 Apr 2025 14:33:27 +0300
Message-ID: <20250429113335.423535-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Message-Id: <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 62 ++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 3ee0ade7df..0fbf684728 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -129,51 +129,59 @@ static void commit_clean(Job *job)
 }
 
 static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *n, void *buf)
+                            int64_t *requested_bytes, void *buf)
 {
+    int64_t bytes = *requested_bytes;
     int ret = 0;
-    bool copy;
     bool error_in_source = true;
 
     /* Copy if allocated above the base */
     WITH_GRAPH_RDLOCK_GUARD() {
         ret = bdrv_co_common_block_status_above(blk_bs(s->top),
             s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-            n, NULL, NULL, NULL);
+            &bytes, NULL, NULL, NULL);
     }
 
-    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
-    trace_commit_one_iteration(s, offset, *n, ret);
-    if (copy) {
-        assert(*n < SIZE_MAX);
+    trace_commit_one_iteration(s, offset, bytes, ret);
 
-        ret = blk_co_pread(s->top, offset, *n, buf, 0);
-        if (ret >= 0) {
-            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
-            if (ret < 0) {
-                error_in_source = false;
-            }
-        }
-    }
     if (ret < 0) {
-        BlockErrorAction action = block_job_error_action(&s->common,
-                                                         s->on_error,
-                                                         error_in_source,
-                                                         -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT) {
-            return ret;
-        } else {
-            *n = 0;
-            return 0;
+        goto fail;
+    }
+
+    if (ret & BDRV_BLOCK_ALLOCATED) {
+        assert(bytes < SIZE_MAX);
+
+        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
+        if (ret < 0) {
+            goto fail;
         }
+
+        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
+        if (ret < 0) {
+            error_in_source = false;
+            goto fail;
+        }
+
+        block_job_ratelimit_processed_bytes(&s->common, bytes);
     }
+
     /* Publish progress */
-    job_progress_update(&s->common.job, *n);
 
-    if (copy) {
-        block_job_ratelimit_processed_bytes(&s->common, *n);
+    job_progress_update(&s->common.job, bytes);
+
+    *requested_bytes = bytes;
+
+    return 0;
+
+fail:
+    BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
+                                                     error_in_source, -ret);
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return ret;
     }
 
+    *requested_bytes = 0;
+
     return 0;
 }
 
-- 
2.48.1


