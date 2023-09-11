Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FEF79A509
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbh6-0004Em-TB; Mon, 11 Sep 2023 03:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgx-00047X-Bl
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgu-0008Cl-2W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5p2kbdz4xMC;
 Mon, 11 Sep 2023 17:50:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5m2XPPz4xM5;
 Mon, 11 Sep 2023 17:50:36 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yanghang Liu <yanghliu@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/13] vfio/migration: Block VFIO migration with postcopy
 migration
Date: Mon, 11 Sep 2023 09:50:06 +0200
Message-ID: <20230911075008.462712-12-clg@redhat.com>
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

VFIO migration is not compatible with postcopy migration. A VFIO device
in the destination can't handle page faults for pages that have not been
sent yet.

Doing such migration will cause the VM to crash in the destination:

qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
qemu: hardware error: vfio: DMA mapping failed, unable to continue

To prevent this, block VFIO migration with postcopy migration.

Reported-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 71855468fe985291e2d009b81c6efd29abcbe755..20994dc1d60b1606728415fec17c19cfd00c4dee 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
 
 /* ---------------------------------------------------------------------- */
 
+static int vfio_save_prepare(void *opaque, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+
+    /*
+     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
+     */
+    if (runstate_check(RUN_STATE_SAVE_VM)) {
+        return 0;
+    }
+
+    if (migrate_postcopy_ram()) {
+        error_setg(
+            errp, "%s: VFIO migration is not supported with postcopy migration",
+            vbasedev->name);
+        return -EOPNOTSUPP;
+    }
+
+    return 0;
+}
+
 static int vfio_save_setup(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -640,6 +661,7 @@ static bool vfio_switchover_ack_needed(void *opaque)
 }
 
 static const SaveVMHandlers savevm_vfio_handlers = {
+    .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
     .state_pending_estimate = vfio_state_pending_estimate,
-- 
2.41.0


