Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC4EAB7B98
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 04:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOMW-0007K8-09; Wed, 14 May 2025 22:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLm-0007EX-74
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLk-00046I-J9
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukG0DplxLouHehc1s/yLdGl7CQypHeBYiZcDtXDhYK0=;
 b=Bg63M9KjqhIZW2yORDtsho+YW4D0m0g7ZZc7iUpITdXKSORijwbkDV8HfrKQXxhcWRut/D
 GM8E1cyGj/4wsRNWxmVVa+NNrM518vXGWW7hJ9fi7J9B/fh4Vzq9YOD3dOWMD0Nx6iS0IO
 VtnQYfAOIq9t+vV/zNZbXaGWM7lSTkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Wmf-WKMBMCelw7Z02qEOWQ-1; Wed,
 14 May 2025 22:29:28 -0400
X-MC-Unique: Wmf-WKMBMCelw7Z02qEOWQ-1
X-Mimecast-MFC-AGG-ID: Wmf-WKMBMCelw7Z02qEOWQ_1747276167
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5687180045B; Thu, 15 May 2025 02:29:26 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBFE21955F24; Thu, 15 May 2025 02:29:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 06/14] mirror: Minor refactoring
Date: Wed, 14 May 2025 21:28:49 -0500
Message-ID: <20250515022904.575509-22-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 5791ba52 (v9.2) pre-initialized ret in mirror_dirty_init to
silence a false positive compiler warning, even though in all code
paths where ret is used, it was guaranteed to be reassigned
beforehand.  But since the function returns -errno, and -1 is not
always the right errno, it's better to initialize to -EIO.

An upcoming patch wants to track two bitmaps in
do_sync_target_write(); this will be easier if the current variables
related to the dirty bitmap are renamed.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250509204341.3553601-21-eblake@redhat.com>
---
 block/mirror.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a53582f17bb..34c6c5252e1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -841,7 +841,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     int64_t offset;
     BlockDriverState *bs;
     BlockDriverState *target_bs = blk_bs(s->target);
-    int ret = -1;
+    int ret = -EIO;
     int64_t count;

     bdrv_graph_co_rdlock();
@@ -1341,7 +1341,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
 {
     int ret;
     size_t qiov_offset = 0;
-    int64_t bitmap_offset, bitmap_end;
+    int64_t dirty_bitmap_offset, dirty_bitmap_end;

     if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
         bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
@@ -1388,11 +1388,11 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
      * Tails are either clean or shrunk, so for bitmap resetting
      * we safely align the range down.
      */
-    bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
-    bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
-    if (bitmap_offset < bitmap_end) {
-        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                                bitmap_end - bitmap_offset);
+    dirty_bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
+    dirty_bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
+    if (dirty_bitmap_offset < dirty_bitmap_end) {
+        bdrv_reset_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                                dirty_bitmap_end - dirty_bitmap_offset);
     }

     job_progress_increase_remaining(&job->common.job, bytes);
@@ -1430,10 +1430,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
          * at function start, and they must be still dirty, as we've locked
          * the region for in-flight op.
          */
-        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
-        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
-        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                              bitmap_end - bitmap_offset);
+        dirty_bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
+        dirty_bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                              dirty_bitmap_end - dirty_bitmap_offset);
         qatomic_set(&job->actively_synced, false);

         action = mirror_error_action(job, false, -ret);
-- 
2.49.0


