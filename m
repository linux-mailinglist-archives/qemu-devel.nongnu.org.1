Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EAF7063BE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCh-0002b1-DK; Wed, 17 May 2023 05:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBj-0000wC-Qy; Wed, 17 May 2023 05:11:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBh-0006PQ-Nk; Wed, 17 May 2023 05:11:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 845EC6837;
 Wed, 17 May 2023 12:10:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E9A0E5F08;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: (nullmailer pid 3626717 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7.2.3 17/30] block: Fix use after free in
 blockdev_mark_auto_del()
Date: Wed, 17 May 2023 12:10:29 +0300
Message-Id: <20230517091042.3626593-17-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

job_cancel_locked() drops the job list lock temporarily and it may call
aio_poll(). We must assume that the list has changed after this call.
Also, with unlucky timing, it can end up freeing the job during
job_completed_txn_abort_locked(), making the job pointer invalid, too.

For both reasons, we can't just continue at block_job_next_locked(job).
Instead, start at the head of the list again after job_cancel_locked()
and skip those jobs that we already cancelled (or that are completing
anyway).

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e2626874a32602d4e52971c786ef5ffb4430629d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 blockdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3f1dec6242..ae27a41efa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -152,12 +152,22 @@ void blockdev_mark_auto_del(BlockBackend *blk)
 
     JOB_LOCK_GUARD();
 
-    for (job = block_job_next_locked(NULL); job;
-         job = block_job_next_locked(job)) {
-        if (block_job_has_bdrv(job, blk_bs(blk))) {
+    do {
+        job = block_job_next_locked(NULL);
+        while (job && (job->job.cancelled ||
+                       job->job.deferred_to_main_loop ||
+                       !block_job_has_bdrv(job, blk_bs(blk))))
+        {
+            job = block_job_next_locked(job);
+        }
+        if (job) {
+            /*
+             * This drops the job lock temporarily and polls, so we need to
+             * restart processing the list from the start after this.
+             */
             job_cancel_locked(&job->job, false);
         }
-    }
+    } while (job);
 
     dinfo->auto_del = 1;
 }
-- 
2.39.2


