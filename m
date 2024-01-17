Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED619830203
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ221-0008Rs-55; Wed, 17 Jan 2024 04:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21y-0008PU-Lw
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21x-0006aa-5r
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705482976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGbgHPbepSaUtEc8A7xDBzFgtQfCe0LSdeWdpVuOkY8=;
 b=EHCA0dtNsw7zHCtj98GChewP862j5WW32hOiMIzuR2IGEaeyqyExxLeZeZjCX3onGwm87w
 QUPFnrukubs/Ks4uzZ2IxfEbbH9ryPLBa1rPjR4uVfEqyUtbp0UyeoxLKvkIY4Xra2FhnC
 TVaUnt3NSuOqt6Mi6+1AAEQa0vckZ0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-aAEol0csOGOoVurQ_Y8tiQ-1; Wed,
 17 Jan 2024 04:16:14 -0500
X-MC-Unique: aAEol0csOGOoVurQ_Y8tiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99DF4280FED2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:16:14 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 227E22166B32;
 Wed, 17 Jan 2024 09:16:10 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com
Subject: [PATCH 2/4] reset: Allow multiple stages of system resets
Date: Wed, 17 Jan 2024 17:15:57 +0800
Message-ID: <20240117091559.144730-3-peterx@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

QEMU resets do not have a way to order reset hooks.  Add one coarse grained
reset stage so that some devices can be reset later than some others.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/reset.h |  5 ++++
 hw/core/reset.c        | 60 +++++++++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 609e4d50c2..0de697ce9f 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -5,9 +5,14 @@
 
 typedef void QEMUResetHandler(void *opaque);
 
+#define  QEMU_RESET_STAGES_N  2
+
 void qemu_register_reset(QEMUResetHandler *func, void *opaque);
+void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
+                             bool skip_snap, int stage);
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque);
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
+void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage);
 void qemu_devices_reset(ShutdownCause reason);
 
 #endif
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 8cf60b2b09..a84c9bee84 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -36,55 +36,83 @@ typedef struct QEMUResetEntry {
     bool skip_on_snapshot_load;
 } QEMUResetEntry;
 
-static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
-    QTAILQ_HEAD_INITIALIZER(reset_handlers);
+typedef QTAILQ_HEAD(QEMUResetList, QEMUResetEntry) QEMUResetList;
+static QEMUResetList reset_handlers[QEMU_RESET_STAGES_N];
 
-static void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
-                                    bool skip_snap)
+static void __attribute__((__constructor__)) qemu_reset_handlers_init(void)
+{
+    QEMUResetList *head;
+    int i = 0;
+
+    for (i = 0; i < QEMU_RESET_STAGES_N; i++) {
+        head = &reset_handlers[i];
+        QTAILQ_INIT(head);
+    }
+}
+
+void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
+                             bool skip_snap, int stage)
 {
     QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
+    QEMUResetList *head;
+
+    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
+    head = &reset_handlers[stage];
 
     re->func = func;
     re->opaque = opaque;
     re->skip_on_snapshot_load = skip_snap;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+    QTAILQ_INSERT_TAIL(head, re, entry);
 }
 
 void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    /* By default, do not skip during load of a snapshot */
-    qemu_register_reset_one(func, opaque, false);
+    qemu_register_reset_one(func, opaque, false, 0);
 }
 
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
 {
-    qemu_register_reset_one(func, opaque, true);
+    qemu_register_reset_one(func, opaque, true, 0);
 }
 
-void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
+void qemu_unregister_reset_one(QEMUResetHandler *func, void *opaque, int stage)
 {
+    QEMUResetList *head;
     QEMUResetEntry *re;
 
-    QTAILQ_FOREACH(re, &reset_handlers, entry) {
+    assert(stage >= 0 && stage < QEMU_RESET_STAGES_N);
+    head = &reset_handlers[stage];
+
+    QTAILQ_FOREACH(re, head, entry) {
         if (re->func == func && re->opaque == opaque) {
-            QTAILQ_REMOVE(&reset_handlers, re, entry);
+            QTAILQ_REMOVE(head, re, entry);
             g_free(re);
             return;
         }
     }
 }
 
+void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
+{
+    qemu_unregister_reset_one(func, opaque, 0);
+}
+
 void qemu_devices_reset(ShutdownCause reason)
 {
     QEMUResetEntry *re, *nre;
+    QEMUResetList *head;
+    int stage;
 
     /* reset all devices */
-    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
-        if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
-            re->skip_on_snapshot_load) {
-            continue;
+    for (stage = 0; stage < QEMU_RESET_STAGES_N; stage++) {
+        head = &reset_handlers[stage];
+        QTAILQ_FOREACH_SAFE(re, head, entry, nre) {
+            if (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
+                re->skip_on_snapshot_load) {
+                continue;
+            }
+            re->func(re->opaque);
         }
-        re->func(re->opaque);
     }
 }
 
-- 
2.43.0


