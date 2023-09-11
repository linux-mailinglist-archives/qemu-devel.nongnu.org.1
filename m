Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBC79A508
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgr-0003tZ-0U; Mon, 11 Sep 2023 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgj-0003qK-5v
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:29 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgd-00081W-PT
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5P1rpLz4xF3;
 Mon, 11 Sep 2023 17:50:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5M3Qfmz4x5q;
 Mon, 11 Sep 2023 17:50:15 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 02/13] sysemu: Add prepare callback to struct VMChangeStateEntry
Date: Mon, 11 Sep 2023 09:49:57 +0200
Message-ID: <20230911075008.462712-3-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Add prepare callback to struct VMChangeStateEntry.

The prepare callback is optional and can be set by the new function
qemu_add_vm_change_state_handler_prio_full() that allows setting this
callback in addition to the main callback.

The prepare callbacks and main callbacks are called in two separate
phases: First all prepare callbacks are called and only then all main
callbacks are called.

The purpose of the new prepare callback is to allow all devices to run a
preliminary task before calling the devices' main callbacks.

This will facilitate adding P2P support for VFIO migration where all
VFIO devices need to be put in an intermediate P2P quiescent state
before being stopped or started by the main callback.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/runstate.h |  4 ++++
 softmmu/runstate.c        | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c2e2ac564bb002d208b125ab6269e097de..764a0fc6a4554857bcff339c668b48193b40c3a4 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -16,6 +16,10 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority);
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *prepare_cb,
+                                           void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index f3bd8628181303792629fa4079f09abf63fd9787..1652ed0439b4d39e5719d5b7caa002aa297789b6 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
 }
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
+    VMChangeStateHandler *prepare_cb;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -293,12 +294,39 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
  */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
+{
+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
+                                                      priority);
+}
+
+/**
+ * qemu_add_vm_change_state_handler_prio_full:
+ * @cb: the main callback to invoke
+ * @prepare_cb: a callback to invoke before the main callback
+ * @opaque: user data passed to the callbacks
+ * @priority: low priorities execute first when the vm runs and the reverse is
+ *            true when the vm stops
+ *
+ * Register a main callback function and an optional prepare callback function
+ * that are invoked when the vm starts or stops running. The main callback and
+ * the prepare callback are called in two separate phases: First all prepare
+ * callbacks are called and only then all main callbacks are called. As its
+ * name suggests, the prepare callback can be used to do some preparatory work
+ * before invoking the main callback.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *prepare_cb,
+                                           void *opaque, int priority)
 {
     VMChangeStateEntry *e;
     VMChangeStateEntry *other;
 
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
+    e->prepare_cb = prepare_cb;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -333,10 +361,22 @@ void vm_state_notify(bool running, RunState state)
     trace_vm_state_notify(running, state, RunState_str(state));
 
     if (running) {
+        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->prepare_cb) {
+                e->prepare_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
     } else {
+        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->prepare_cb) {
+                e->prepare_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
-- 
2.41.0


