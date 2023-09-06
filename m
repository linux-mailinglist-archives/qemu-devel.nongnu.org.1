Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637BF794380
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 21:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxmu-0006Cu-DV; Wed, 06 Sep 2023 15:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmm-0006BY-PR
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmj-0008A0-AV
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694026912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCK+lnfLAYtw1mOtOApL/BAriyzaovAFIXtqHAPBx7E=;
 b=UR/YYC4MefkayGtPdGINbBaadX1I/DGoWbk6x7FoEAdKxdgq7frK+M9RjAIeB1zne3i6D9
 ArTUv0v7TGecTvMHyCraDz2KSkeZux3+7reA7+jVxvuY18ECAxtyYFzqDwfGfnVBDV77qn
 dtZlgE6s5FKj5c1A9dF9mH7BkL3/RKY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-GEOy8nXNO9aTyOXA76zMLA-1; Wed, 06 Sep 2023 15:01:49 -0400
X-MC-Unique: GEOy8nXNO9aTyOXA76zMLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 611B61C0754F;
 Wed,  6 Sep 2023 19:01:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1DA2140E964;
 Wed,  6 Sep 2023 19:01:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 2/3] rcu: add drain_call_rcu_co() API
Date: Wed,  6 Sep 2023 15:01:40 -0400
Message-ID: <20230906190141.1286893-3-stefanha@redhat.com>
In-Reply-To: <20230906190141.1286893-1-stefanha@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

call_drain_rcu() has limitations that make it unsuitable for use in
qmp_device_add(). Introduce a new coroutine version of drain_call_rcu()
with the same functionality but that does not drop the BQL. The next
patch will use it to fix qmp_device_add().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS         |  2 ++
 docs/devel/rcu.txt  | 21 +++++++++++++++++
 include/qemu/rcu.h  |  1 +
 util/rcu-internal.h |  8 +++++++
 util/rcu-co.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
 util/rcu.c          |  3 ++-
 util/meson.build    |  2 +-
 7 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 util/rcu-internal.h
 create mode 100644 util/rcu-co.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b29568ed4..7f98253bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2908,6 +2908,8 @@ F: include/qemu/rcu*.h
 F: tests/unit/rcutorture.c
 F: tests/unit/test-rcu-*.c
 F: util/rcu.c
+F: util/rcu-co.c
+F: util/rcu-internal.h
 
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.txt
index 2e6cc607a1..344764527f 100644
--- a/docs/devel/rcu.txt
+++ b/docs/devel/rcu.txt
@@ -130,6 +130,27 @@ The core RCU API is small:
 
             g_free_rcu(&foo, rcu);
 
+     void coroutine_fn drain_call_rcu_co(void);
+
+        drain_call_rcu_co() yields until the reclamation phase is finished.
+        Reclaimer functions previously submitted with call_rcu1() in this
+        thread will have finished by the time drain_call_rcu_co() returns.
+
+     void drain_call_rcu(void);
+
+        drain_call_rcu() releases the Big QEMU Lock (BQL), if held, waits until
+        the reclamation phase is finished, and then re-acquires the BQL, if
+        previously held.  Reclaimer functions previously submitted with
+        call_rcu1() in this thread will have finished by the time
+        drain_call_rcu() returns.
+
+        drain_call_rcu() has the following limitations:
+        1. It deadlocks when called within an RCU read-side critical section.
+        2. All functions on the call stack must be designed to handle dropping
+           the BQL.
+
+        Prefer drain_call_rcu_co() over drain_call_rcu().
+
      typeof(*p) qatomic_rcu_read(p);
 
         qatomic_rcu_read() is similar to qatomic_load_acquire(), but it makes
diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index fea058aa9f..53055df1dc 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -141,6 +141,7 @@ struct rcu_head {
 };
 
 void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
+void coroutine_fn drain_call_rcu_co(void);
 void drain_call_rcu(void);
 
 /* The operands of the minus operator must have the same type,
diff --git a/util/rcu-internal.h b/util/rcu-internal.h
new file mode 100644
index 0000000000..7d85366d54
--- /dev/null
+++ b/util/rcu-internal.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+
+#ifndef RCU_INTERNAL_H
+#define RCU_INTERNAL_H
+
+extern int in_drain_call_rcu;
+
+#endif /* RCU_INTERNAL_H */
diff --git a/util/rcu-co.c b/util/rcu-co.c
new file mode 100644
index 0000000000..920fcacb7a
--- /dev/null
+++ b/util/rcu-co.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * RCU APIs for coroutines
+ *
+ * The RCU coroutine APIs are kept separate from the main RCU code to avoid
+ * depending on AioContext APIs in rcu.c. This is necessary because at least
+ * tests/unit/ptimer-test.c has replacement functions for AioContext APIs that
+ * conflict with the real functions.
+ *
+ * It's also nice to logically separate the core RCU code from the coroutine
+ * APIs :).
+ */
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "qemu/atomic.h"
+#include "qemu/coroutine.h"
+#include "qemu/rcu.h"
+#include "rcu-internal.h"
+
+typedef struct {
+    struct rcu_head rcu;
+    Coroutine *co;
+} RcuDrainCo;
+
+static void drain_call_rcu_co_bh(void *opaque)
+{
+    RcuDrainCo *data = opaque;
+
+    /* Re-enter drain_call_rcu_co() where it yielded */
+    aio_co_wake(data->co);
+}
+
+static void drain_call_rcu_co_cb(struct rcu_head *node)
+{
+    RcuDrainCo *data = container_of(node, RcuDrainCo, rcu);
+    AioContext *ctx = qemu_coroutine_get_aio_context(data->co);
+
+    /*
+     * drain_call_rcu_co() might still be running in its thread, so schedule a
+     * BH in its thread. The BH only runs after the coroutine has yielded.
+     */
+    aio_bh_schedule_oneshot(ctx, drain_call_rcu_co_bh, data);
+}
+
+void coroutine_fn drain_call_rcu_co(void)
+{
+    RcuDrainCo data = {
+        .co = qemu_coroutine_self(),
+    };
+
+    qatomic_inc(&in_drain_call_rcu);
+    call_rcu1(&data.rcu, drain_call_rcu_co_cb);
+    qemu_coroutine_yield(); /* wait for drain_rcu_co_bh() */
+    qatomic_dec(&in_drain_call_rcu);
+}
diff --git a/util/rcu.c b/util/rcu.c
index e587bcc483..2519bd7d5c 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -32,6 +32,7 @@
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockable.h"
+#include "rcu-internal.h"
 #if defined(CONFIG_MALLOC_TRIM)
 #include <malloc.h>
 #endif
@@ -46,7 +47,7 @@
 unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
 
 QemuEvent rcu_gp_event;
-static int in_drain_call_rcu;
+int in_drain_call_rcu;
 static QemuMutex rcu_registry_lock;
 static QemuMutex rcu_sync_lock;
 
diff --git a/util/meson.build b/util/meson.build
index a375160286..849d56f756 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -43,7 +43,7 @@ util_ss.add(files('keyval.c'))
 util_ss.add(files('crc32c.c'))
 util_ss.add(files('uuid.c'))
 util_ss.add(files('getauxval.c'))
-util_ss.add(files('rcu.c'))
+util_ss.add(files('rcu.c', 'rcu-co.c'))
 if have_membarrier
   util_ss.add(files('sys_membarrier.c'))
 endif
-- 
2.41.0


