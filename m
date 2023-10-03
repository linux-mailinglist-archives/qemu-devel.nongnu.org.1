Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C17B64D1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbDh-0004gE-R1; Tue, 03 Oct 2023 04:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDc-0004eD-Q5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDb-00063d-5O
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696323446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t8VWc2veUeWD2kah/MNb40uj4RjwtmcTWLm0rHOIYg=;
 b=AYZ2w5jt1Ihv7iTSt5+8CcdNYGCy+zOMI2wrsPRSaHjCx1XR580qi9jYXmr+JjJmIS/OHy
 gD42gSCnmost9QaRTnJ93UkxDn4yRuOSGVB7JERGb6smFn1W+kuJwmYePu+Qb0h7h5Gh1w
 gpcv/zeWrlRjMmlJepQ68uH0W+3LnwU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-DgRq1Vx8M0WZ3V2JPOCorQ-1; Tue, 03 Oct 2023 04:57:09 -0400
X-MC-Unique: DgRq1Vx8M0WZ3V2JPOCorQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 169123C100A8;
 Tue,  3 Oct 2023 08:57:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E90EB2156701;
 Tue,  3 Oct 2023 08:57:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v3 5/5] hw/vfio: add ramfb migration support
Date: Tue,  3 Oct 2023 12:56:44 +0400
Message-ID: <20231003085644.1220326-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.

Turn it off by default on machines <= 8.1 for compatibility reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/vfio/pci.h     |  3 +++
 hw/core/machine.c |  1 +
 hw/vfio/display.c | 23 +++++++++++++++++++++++
 hw/vfio/pci.c     | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2d836093a8..fd06695542 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -173,6 +173,7 @@ struct VFIOPCIDevice {
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
+    OnOffAuto ramfb_migrate;
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     VFIODisplay *dpy;
@@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
+extern const VMStateDescription vfio_display_vmstate;
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 47a07d1d9b..f2f8940a85 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,6 +32,7 @@
 
 GlobalProperty hw_compat_8_1[] = {
     { "ramfb", "x-migrate", "off" },
+    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index bec864f482..de5bf71dd1 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -542,3 +542,26 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
     vfio_display_edid_exit(vdev->dpy);
     g_free(vdev->dpy);
 }
+
+static bool migrate_needed(void *opaque)
+{
+    /*
+     * If we are here, it's because vfio_display_needed(), which is only true
+     * when dpy->ramfb_migrate atm.
+     *
+     * If the migration condition is changed, we should check here if
+     * ramfb_migrate is true. (this will need a way to lookup the associated
+     * VFIOPCIDevice somehow, or fields to be moved, ..)
+     */
+    return true;
+}
+
+const VMStateDescription vfio_display_vmstate = {
+    .name = "VFIODisplay",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = migrate_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
+    }
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3b2ca3c24c..4689f2e5c1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2608,6 +2608,25 @@ static bool vfio_msix_present(void *opaque, int version_id)
     return msix_present(pdev);
 }
 
+static bool vfio_display_needed(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+
+    /* the only thing that justifies the VFIODisplay sub-section atm */
+    return vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
+}
+
+const VMStateDescription vmstate_vfio_display = {
+    .name = "VFIOPCIDevice/VFIODisplay",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vfio_display_needed,
+    .fields = (VMStateField[]){
+        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_vfio_pci_config = {
     .name = "VFIOPCIDevice",
     .version_id = 1,
@@ -2616,6 +2635,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_vfio_display,
+        NULL
     }
 };
 
@@ -3275,6 +3298,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (!vfio_migration_realize(vbasedev, errp)) {
             goto out_deregister;
         }
+        if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
+            if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
+                vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
+            } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
+                error_setg(errp, "x-ramfb-migrate requires migration");
+                goto out_deregister;
+            }
+        }
     }
 
     vfio_register_err_notifier(vdev);
@@ -3484,6 +3515,7 @@ static const TypeInfo vfio_pci_dev_info = {
 
 static Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


