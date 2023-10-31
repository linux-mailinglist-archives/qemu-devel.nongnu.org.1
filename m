Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49157DD688
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyR-0004HK-Hv; Tue, 31 Oct 2023 15:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxty5-00046j-3j
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxg-00067z-TR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HmBBCrKe2ne4gyX+BfiyEUMdmLaU5XOJBdBMPwsG6o=;
 b=Lo4dPOUmVZ2UhEF3SgEUmyDxhqv4JF/Y/Ks1PfSL4yzDwDv0mr3Z+a9DyI4awER3REQRWO
 V7xyD/GS2dDA0hjBRV8vbEQ5UmnnFszdHkJ4+0Q1i0yzjV4XARllKtYTH1Px6ExX90QxI5
 f5EbJPvL4124i0lKNC8fog9OCzgRyms=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-BvH_tbAWM6WWWLaQp7BAqA-1; Tue,
 31 Oct 2023 14:59:33 -0400
X-MC-Unique: BvH_tbAWM6WWWLaQp7BAqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D54A329ABA2A;
 Tue, 31 Oct 2023 18:59:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F9725C0;
 Tue, 31 Oct 2023 18:59:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/27] util/defer-call: move defer_call() to util/
Date: Tue, 31 Oct 2023 19:59:06 +0100
Message-ID: <20231031185918.346940-16-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The networking subsystem may wish to use defer_call(), so move the code
to util/ where it can be reused.

As a reminder of what defer_call() does:

This API defers a function call within a defer_call_begin()/defer_call_end()
section, allowing multiple calls to batch up. This is a performance
optimization that is used in the block layer to submit several I/O requests
at once instead of individually:

  defer_call_begin(); <-- start of section
  ...
  defer_call(my_func, my_obj); <-- deferred my_func(my_obj) call
  defer_call(my_func, my_obj); <-- another
  defer_call(my_func, my_obj); <-- another
  ...
  defer_call_end(); <-- end of section, my_func(my_obj) is called once

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230913200045.1024233-3-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/defer-call.h         | 16 ++++++++++++++++
 include/sysemu/block-backend-io.h |  4 ----
 block/blkio.c                     |  1 +
 block/io_uring.c                  |  1 +
 block/linux-aio.c                 |  1 +
 block/nvme.c                      |  1 +
 hw/block/dataplane/xen-block.c    |  1 +
 hw/block/virtio-blk.c             |  1 +
 hw/scsi/virtio-scsi.c             |  1 +
 block/plug.c => util/defer-call.c |  2 +-
 MAINTAINERS                       |  3 ++-
 block/meson.build                 |  1 -
 util/meson.build                  |  1 +
 13 files changed, 27 insertions(+), 7 deletions(-)
 create mode 100644 include/qemu/defer-call.h
 rename block/plug.c => util/defer-call.c (99%)

diff --git a/include/qemu/defer-call.h b/include/qemu/defer-call.h
new file mode 100644
index 0000000000..e2c1d24572
--- /dev/null
+++ b/include/qemu/defer-call.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Deferred calls
+ *
+ * Copyright Red Hat.
+ */
+
+#ifndef QEMU_DEFER_CALL_H
+#define QEMU_DEFER_CALL_H
+
+/* See documentation in util/defer-call.c */
+void defer_call_begin(void);
+void defer_call_end(void);
+void defer_call(void (*fn)(void *), void *opaque);
+
+#endif /* QEMU_DEFER_CALL_H */
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index cfcfd85c1d..d174275a5c 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -100,10 +100,6 @@ void blk_iostatus_set_err(BlockBackend *blk, int error);
 int blk_get_max_iov(BlockBackend *blk);
 int blk_get_max_hw_iov(BlockBackend *blk);
 
-void defer_call_begin(void);
-void defer_call_end(void);
-void defer_call(void (*fn)(void *), void *opaque);
-
 AioContext *blk_get_aio_context(BlockBackend *blk);
 BlockAcctStats *blk_get_stats(BlockBackend *blk);
 void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
diff --git a/block/blkio.c b/block/blkio.c
index 7cf6d61f47..0a0a6c0f5f 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -13,6 +13,7 @@
 #include "block/block_int.h"
 #include "exec/memory.h"
 #include "exec/cpu-common.h" /* for qemu_ram_get_fd() */
+#include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/io_uring.c b/block/io_uring.c
index 8429f341be..3a1e1f45b3 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -15,6 +15,7 @@
 #include "block/block.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
+#include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 49a37174c2..a2670b3e46 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -14,6 +14,7 @@
 #include "block/raw-aio.h"
 #include "qemu/event_notifier.h"
 #include "qemu/coroutine.h"
+#include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/nvme.c b/block/nvme.c
index dfbd1085fd..96b3f8f2fa 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index e9dd8f8a99..c4bb28c66f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/memalign.h"
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6a45033d15..a1f8e15522 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 42fcbcb45f..9c751bf296 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -18,6 +18,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "migration/qemu-file-types.h"
+#include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/block/plug.c b/util/defer-call.c
similarity index 99%
rename from block/plug.c
rename to util/defer-call.c
index f26173559c..037dc0abf0 100644
--- a/block/plug.c
+++ b/util/defer-call.c
@@ -22,7 +22,7 @@
 #include "qemu/coroutine-tls.h"
 #include "qemu/notify.h"
 #include "qemu/thread.h"
-#include "sysemu/block-backend.h"
+#include "qemu/defer-call.h"
 
 /* A function call that has been deferred until defer_call_end() */
 typedef struct {
diff --git a/MAINTAINERS b/MAINTAINERS
index cd8d6b140f..018ed62560 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2755,12 +2755,13 @@ S: Supported
 F: util/async.c
 F: util/aio-*.c
 F: util/aio-*.h
+F: util/defer-call.c
 F: util/fdmon-*.c
 F: block/io.c
-F: block/plug.c
 F: migration/block*
 F: include/block/aio.h
 F: include/block/aio-wait.h
+F: include/qemu/defer-call.h
 F: scripts/qemugdb/aio.py
 F: tests/unit/test-fdmon-epoll.c
 T: git https://github.com/stefanha/qemu.git block
diff --git a/block/meson.build b/block/meson.build
index f351b9d0d3..59ff6d380c 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -21,7 +21,6 @@ block_ss.add(files(
   'mirror.c',
   'nbd.c',
   'null.c',
-  'plug.c',
   'preallocate.c',
   'progress_meter.c',
   'qapi.c',
diff --git a/util/meson.build b/util/meson.build
index c4827fd70a..769b24f2e0 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -28,6 +28,7 @@ util_ss.add(when: 'CONFIG_WIN32', if_true: pathcch)
 if glib_has_gslice
   util_ss.add(files('qtree.c'))
 endif
+util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
-- 
2.41.0


