Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5B75F248
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWS-00084c-J0; Mon, 24 Jul 2023 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsWB-0007nM-GM
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:19 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW8-0000np-Gi
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5638180156aso2389946a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193415; x=1690798215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYjCaoiHAm8swBEnNC+m57LDdWlBhajl9tKWF/1FxQ4=;
 b=J/sSz1SD1fxwBoi4iHmAhjN41U5OUoZUlGVvNSJsvSG/FN/W7QDTO+BsypUX4EFrRO
 rEE9bvXLbm5xR1G8NcA315oQ3EHvy3F/yMZWA+PF3tcmqq8h5vCbkWIYAL/RaMzgpIb2
 v55bEqKuNbC6JrUoyAnWMbH1lcl/Zj8+veRhS995f6MehYusvaa8n+zjVXGXWKKw3RNg
 1e1dCRo7SfHgY6ZkBlTEDnXKxrEZy5DHvogXCDv9KpSlYN+OONNbScaGN19MDMKBYRYu
 IJYOicT9vkgFWjsEMU4qhMUwuzlcE04g3BwM6dg4kW5TrGgCgfy5Bt04UYfpoWSOSs7q
 FOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193415; x=1690798215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYjCaoiHAm8swBEnNC+m57LDdWlBhajl9tKWF/1FxQ4=;
 b=kTD2kticMaDU8AQISEBHcSe2MxLexw/jUWVkKfNm3KSojd4C7N0IAu20Z0JXXBq8iS
 Z+KrYAMDPu6u0YH03gE1AhGLop3MLpEX6eLzwNC8ozJsXFnDOUeX2JUAI/qN5gP0ehyY
 1y5CN88RrU1AZEEH1kL0k/xaUR5YYUUQ5VH1+HRfQ/vOcHaip0LpVScYoTTO1NVG+YYy
 qqUP2PNrusLQuHozKTxaJ6XZJ1YNPy3AmvUWm0K/qZKTLv3Jqy2ntmSBHO/+eGhMz1LK
 rIaX9jsYTJ6zcbddiiwWWaXMvywdPfL6QG6adl7++WvAqYuCeHoBfFCpdlIcohjDOqYd
 wv1Q==
X-Gm-Message-State: ABy/qLbdHujYoRcRwOrESdbXEawvroMkgBLJFs4btJurO1BENRvKg8x/
 3yaJ50yAARIjTsWZWmkIyJzDxg==
X-Google-Smtp-Source: APBJJlH8YGpBtweUOIoFi3Zx2zpIMFRPVZMxUE+L9ka+RL0CiIrtDkRwvh76oxuE7MqX2q8Lb9c3cg==
X-Received: by 2002:a17:903:230a:b0:1bb:a85c:23cc with SMTP id
 d10-20020a170903230a00b001bba85c23ccmr2111947plh.15.1690193415312; 
 Mon, 24 Jul 2023 03:10:15 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:14 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 8/9] fsdev: Use ThrottleDirection instread of bool is_write
Date: Mon, 24 Jul 2023 18:09:38 +0800
Message-Id: <20230724100939.1022984-9-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

'bool is_write' style is obsolete from throttle framework, adapt
fsdev to the new style.

Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 fsdev/qemu-fsdev-throttle.c | 14 +++++++-------
 fsdev/qemu-fsdev-throttle.h |  4 ++--
 hw/9pfs/cofile.c            |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

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
2.34.1


