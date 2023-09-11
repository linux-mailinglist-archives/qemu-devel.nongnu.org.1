Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42479A50C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgs-0003xz-KR; Mon, 11 Sep 2023 03:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgj-0003qJ-5u
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbge-00081e-CZ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5S1Jvgz4xFD;
 Mon, 11 Sep 2023 17:50:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5P5JS1z4x5q;
 Mon, 11 Sep 2023 17:50:17 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 03/13] qdev: Add qdev_add_vm_change_state_handler_full()
Date: Mon, 11 Sep 2023 09:49:58 +0200
Message-ID: <20230911075008.462712-4-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add qdev_add_vm_change_state_handler_full() variant that allows setting
a prepare callback in addition to the main callback.

This will facilitate adding P2P support for VFIO migration in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/runstate.h         |  3 +++
 hw/core/vm-change-state-handler.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 764a0fc6a4554857bcff339c668b48193b40c3a4..08afb97695bd6a7c7f1fb852f475be710eb4ac35 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -23,6 +23,9 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *prepare_cb, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 1f3630986d54e1fc70ac7d62f646296af3f7f3cf..8e2639224e7572b77be0f3c44e12d7321f18b535 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -55,8 +55,20 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque)
+{
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
+}
+
+/*
+ * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
+ * argument too.
+ */
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *prepare_cb, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio(cb, opaque, depth);
+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
+                                                      depth);
 }
-- 
2.41.0


