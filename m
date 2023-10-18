Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0D7CD883
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38i-0001QO-PH; Wed, 18 Oct 2023 05:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38S-0001Lj-Qe
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38Q-0003aU-O0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9QwX1gF6z4xcF;
 Wed, 18 Oct 2023 20:46:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9QwV0xsyz4xbC;
 Wed, 18 Oct 2023 20:46:33 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/22] hw/vfio: add ramfb migration support
Date: Wed, 18 Oct 2023 11:45:31 +0200
Message-ID: <20231018094531.733211-23-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.

Turn it off by default on machines <= 8.1 for compatibility reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
[ clg:  - checkpatch fixes
  	- improved warn_report() in vfio_realize() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h     |  3 +++
 hw/core/machine.c |  1 +
 hw/vfio/display.c | 21 +++++++++++++++++++++
 hw/vfio/pci.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 stubs/ramfb.c     |  2 ++
 5 files changed, 74 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0d89eb761ece426ca1df40f63461b2bb1bcf1ab0..fba8737ab2cb23118c0819f600379773d718ed18 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -174,6 +174,7 @@ struct VFIOPCIDevice {
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
+    OnOffAuto ramfb_migrate;
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     VFIODisplay *dpy;
@@ -227,4 +228,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
+extern const VMStateDescription vfio_display_vmstate;
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6305f2d7a4bbe25e0c132737bc8ebda83f7fd3a2..05aef2cf9f7c6d196971423ec301e03c8a58309d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,7 @@
 GlobalProperty hw_compat_8_1[] = {
     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
     { "ramfb", "x-migrate", "off" },
+    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 837d9e6a309e834601c125e36faadf81c1c5172e..7a10fa8604aa54cdc31f1c82e05b50d43e15ae5e 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -544,3 +544,24 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
     vfio_display_edid_exit(vdev->dpy);
     g_free(vdev->dpy);
 }
+
+static bool migrate_needed(void *opaque)
+{
+    VFIODisplay *dpy = opaque;
+    bool ramfb_exists = dpy->ramfb != NULL;
+
+    /* see vfio_display_migration_needed() */
+    assert(ramfb_exists);
+    return ramfb_exists;
+}
+
+const VMStateDescription vfio_display_vmstate = {
+    .name = "VFIODisplay",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = migrate_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
+        VMSTATE_END_OF_LIST(),
+    }
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6e3f6aba28e55311e8bcc4ac757e18c8aa2433f1..b27011cee72a0fb3b2d57d297c0b5c2ccff9d9a6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2675,6 +2675,33 @@ static bool vfio_msix_present(void *opaque, int version_id)
     return msix_present(pdev);
 }
 
+static bool vfio_display_migration_needed(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+
+    /*
+     * We need to migrate the VFIODisplay object if ramfb *migration* was
+     * explicitly requested (in which case we enforced both ramfb=on and
+     * display=on), or ramfb migration was left at the default "auto"
+     * setting, and *ramfb* was explicitly requested (in which case we
+     * enforced display=on).
+     */
+    return vdev->ramfb_migrate == ON_OFF_AUTO_ON ||
+        (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO && vdev->enable_ramfb);
+}
+
+const VMStateDescription vmstate_vfio_display = {
+    .name = "VFIOPCIDevice/VFIODisplay",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vfio_display_migration_needed,
+    .fields = (VMStateField[]){
+        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate,
+                               VFIODisplay),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_vfio_pci_config = {
     .name = "VFIOPCIDevice",
     .version_id = 1,
@@ -2683,6 +2710,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_vfio_display,
+        NULL
     }
 };
 
@@ -3300,6 +3331,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->ramfb_migrate == ON_OFF_AUTO_ON && !vdev->enable_ramfb) {
+        warn_report("x-ramfb-migrate=on but ramfb=off. "
+                    "Forcing x-ramfb-migrate to off.");
+        vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
+    }
+    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
+        if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
+            vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
+        } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
+            error_setg(errp, "x-ramfb-migrate requires enable-migration");
+            goto out_deregister;
+        }
+    }
+
     if (!pdev->failover_pair_id) {
         if (!vfio_migration_realize(vbasedev, errp)) {
             goto out_deregister;
@@ -3511,6 +3556,8 @@ static const TypeInfo vfio_pci_dev_info = {
 
 static Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/stubs/ramfb.c b/stubs/ramfb.c
index 48143f33542f4c8382525a926a3d0fc37fad8771..cf64733b10cda2fd9bdcfacd6e4990a0123ec60f 100644
--- a/stubs/ramfb.c
+++ b/stubs/ramfb.c
@@ -2,6 +2,8 @@
 #include "qapi/error.h"
 #include "hw/display/ramfb.h"
 
+const VMStateDescription ramfb_vmstate = {};
+
 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
 {
 }
-- 
2.41.0


