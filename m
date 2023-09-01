Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3B78F9DB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMX-0007A7-Tk; Fri, 01 Sep 2023 04:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMV-00079d-QJ
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMJ-00018y-H5
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F77ttu5NaSze98bCA84XrJ3cszTz3sC/YXdEN0xhy+0=;
 b=GHN4wdNG9raQmuhWV+hw0gcERBNmgD25BTRr1tkptgcP1UowDKKOEoobO/4DTJdLVSKMGT
 n5WT9rxBfPC5owJUN86SZ7yCjB4JAtthqI+PFqesJefsEftueMH83i3smnNK51iL4k0CFf
 ePYjoK0eVeIhwnkziLDlRcAi/nBCfXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-mtNcXcwuMpOlKCZwrxPL-Q-1; Fri, 01 Sep 2023 04:18:25 -0400
X-MC-Unique: mtNcXcwuMpOlKCZwrxPL-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42163185A791;
 Fri,  1 Sep 2023 08:18:25 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3967140E96E;
 Fri,  1 Sep 2023 08:18:24 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 08/14] fsdev: Use ThrottleDirection instread of bool is_write
Date: Fri,  1 Sep 2023 10:18:03 +0200
Message-ID: <20230901081804.31377-9-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: zhenwei pi <pizhenwei@bytedance.com>

'bool is_write' style is obsolete from throttle framework, adapt
fsdev to the new style.

Cc: Greg Kurz <groug@kaod.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230728022006.1098509-9-pizhenwei@bytedance.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 fsdev/qemu-fsdev-throttle.h |  4 ++--
 fsdev/qemu-fsdev-throttle.c | 14 +++++++-------
 hw/9pfs/cofile.c            |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index a21aecddc7..daa8ca2494 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -23,14 +23,14 @@ typedef struct FsThrottle {
     ThrottleState ts;
     ThrottleTimers tt;
     ThrottleConfig cfg;
-    CoQueue      throttled_reqs[2];
+    CoQueue      throttled_reqs[THROTTLE_MAX];
 } FsThrottle;
 
 int fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
 
 void fsdev_throttle_init(FsThrottle *);
 
-void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
+void coroutine_fn fsdev_co_throttle_request(FsThrottle *, ThrottleDirection ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 1c137d6f0f..d912da906d 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -94,22 +94,22 @@ void fsdev_throttle_init(FsThrottle *fst)
     }
 }
 
-void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
+void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst,
+                                            ThrottleDirection direction,
                                             struct iovec *iov, int iovcnt)
 {
-    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
-
+    assert(direction < THROTTLE_MAX);
     if (throttle_enabled(&fst->cfg)) {
         if (throttle_schedule_timer(&fst->ts, &fst->tt, direction) ||
-            !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
-            qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
+            !qemu_co_queue_empty(&fst->throttled_reqs[direction])) {
+            qemu_co_queue_wait(&fst->throttled_reqs[direction], NULL);
         }
 
         throttle_account(&fst->ts, direction, iov_size(iov, iovcnt));
 
-        if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
+        if (!qemu_co_queue_empty(&fst->throttled_reqs[direction]) &&
             !throttle_schedule_timer(&fst->ts, &fst->tt, direction)) {
-            qemu_co_queue_next(&fst->throttled_reqs[is_write]);
+            qemu_co_queue_next(&fst->throttled_reqs[direction]);
         }
     }
 }
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 9c5344039e..71174c3e4a 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -252,7 +252,7 @@ int coroutine_fn v9fs_co_pwritev(V9fsPDU *pdu, V9fsFidState *fidp,
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
-    fsdev_co_throttle_request(s->ctx.fst, true, iov, iovcnt);
+    fsdev_co_throttle_request(s->ctx.fst, THROTTLE_WRITE, iov, iovcnt);
     v9fs_co_run_in_worker(
         {
             err = s->ops->pwritev(&s->ctx, &fidp->fs, iov, iovcnt, offset);
@@ -272,7 +272,7 @@ int coroutine_fn v9fs_co_preadv(V9fsPDU *pdu, V9fsFidState *fidp,
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
-    fsdev_co_throttle_request(s->ctx.fst, false, iov, iovcnt);
+    fsdev_co_throttle_request(s->ctx.fst, THROTTLE_READ, iov, iovcnt);
     v9fs_co_run_in_worker(
         {
             err = s->ops->preadv(&s->ctx, &fidp->fs, iov, iovcnt, offset);
-- 
2.41.0


