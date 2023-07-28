Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC68766253
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5u-0007zE-CK; Thu, 27 Jul 2023 22:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5s-0007yR-Je
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5q-000744-Tm
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so18402725ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510837; x=1691115637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9iF4jVh41otFASCZmoc1VL/sJXGCh2dQxBqUQfIoLI=;
 b=JPPOCFtytHdtOJdV9PsjLqtyfPMh8e8yHGKgcvN9G+zKQ1ZGqV68HOtVmk51iQIez9
 eACWwa/Gwa7pkmE/6rt5humiI7ZMRlCb1VN12/aWshtkZLuOut0qWltl2G9ropD1BLP0
 Gn9nLH7lN6OskXDtQZgTe2XkemNl5TkHisFitO21FrmW2d9MznncQKsX6KDRo630KkVb
 c+Y4Z8i2tJr7W7qvXTsV/yNEBvs2ekhl+SOJqCtwM4pjV99hvJ4ueyguQ5Mf6b0ssZlf
 RySZeElR/ENP45XyP6PxZ3AFPBdKKg6cCXTvGtLXTUT0lp8jj739d2ZzLcl9MPHarSPc
 pFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510837; x=1691115637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9iF4jVh41otFASCZmoc1VL/sJXGCh2dQxBqUQfIoLI=;
 b=SswZ6g96pd9PbSjALcLa/ywRJ4NAfWtCc5ZQL9qbL6QFbo5tdr9FHDQUpT+Eb4bSUQ
 qXLsCpykDgNMe6CDIAoMgWNsLR3p1UOeNTPHtz8LxRlIHiCWhas0QmtojlTstH2BxHtV
 I42K1TI5DxjK/YNOeqnwHytZ21CT4+3dvS7wtfLCD3IuoS3n08LXNnYmka5Z/5VepcTx
 IIN4U8XYBe/W5OsDxXFPrH1aMn5W7fKSTqxrHqGVua13d3DT962EIU3TZxFisoAhfzA+
 q7dUYJHjvO/x1kG0dYrSTVdAlEGkm/2jA2ke/5dRrCFkOms63dB+iXUh0WX8wQHKxr5s
 O1pw==
X-Gm-Message-State: ABy/qLYk9MahU9MsuFNvl7+zSjYN1T7XESGay5vkX9OtXaSBscbDAa+2
 08kH+0HVAb3tfhqZVZxmRoMRBQ==
X-Google-Smtp-Source: APBJJlELzRp2vWAAJRLYJIclzHKdqKRyHOngGv6WeNtRexV9CKG2crjRp+rPHXTyF+hK2u+Cnm2HKA==
X-Received: by 2002:a17:902:d481:b0:1b8:3936:7b64 with SMTP id
 c1-20020a170902d48100b001b839367b64mr599479plg.1.1690510837548; 
 Thu, 27 Jul 2023 19:20:37 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:37 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v5 8/9] fsdev: Use ThrottleDirection instread of bool is_write
Date: Fri, 28 Jul 2023 10:20:05 +0800
Message-Id: <20230728022006.1098509-9-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'bool is_write' style is obsolete from throttle framework, adapt
fsdev to the new style.

Cc: Greg Kurz <groug@kaod.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
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


