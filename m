Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F2819049
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:05:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfKD-0005t2-1K; Tue, 19 Dec 2023 14:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJG-0004lO-NQ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:25 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfJD-0007Nf-53
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:59:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmFT4j20z4xR5;
 Wed, 20 Dec 2023 05:59:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmFP2CFkz4xS5;
 Wed, 20 Dec 2023 05:59:05 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 26/47] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Date: Tue, 19 Dec 2023 19:56:22 +0100
Message-ID: <20231219185643.725448-27-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This helper will be used by both legacy and iommufd backends.

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  3 +++
 hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fba8737ab2cb23118c0819f600379773d718ed18..1006061afb0cc13d78d804afa54e79cfb0f5c972 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                    struct vfio_pci_hot_reset_info **info_p);
+
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b692c98bba1b931ebb1a4254a7f56061..eb55e8ae88e1686d31f821df73789212bde46884 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2445,22 +2445,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
     return (strcmp(tmp, name) == 0);
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                    struct vfio_pci_hot_reset_info **info_p)
 {
-    VFIOGroup *group;
     struct vfio_pci_hot_reset_info *info;
-    struct vfio_pci_dependent_device *devices;
-    struct vfio_pci_hot_reset *reset;
-    int32_t *fds;
-    int ret, i, count;
-    bool multi = false;
+    int ret, count;
 
-    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
-
-    if (!single) {
-        vfio_pci_pre_reset(vdev);
-    }
-    vdev->vbasedev.needs_reset = false;
+    assert(info_p && !*info_p);
 
     info = g_malloc0(sizeof(*info));
     info->argsz = sizeof(*info);
@@ -2468,24 +2459,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret && errno != ENOSPC) {
         ret = -errno;
+        g_free(info);
         if (!vdev->has_pm_reset) {
             error_report("vfio: Cannot reset device %s, "
                          "no available reset mechanism.", vdev->vbasedev.name);
         }
-        goto out_single;
+        return ret;
     }
 
     count = info->count;
-    info = g_realloc(info, sizeof(*info) + (count * sizeof(*devices)));
-    info->argsz = sizeof(*info) + (count * sizeof(*devices));
-    devices = &info->devices[0];
+    info = g_realloc(info, sizeof(*info) + (count * sizeof(info->devices[0])));
+    info->argsz = sizeof(*info) + (count * sizeof(info->devices[0]));
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret) {
         ret = -errno;
+        g_free(info);
         error_report("vfio: hot reset info failed: %m");
+        return ret;
+    }
+
+    *info_p = info;
+    return 0;
+}
+
+static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+{
+    VFIOGroup *group;
+    struct vfio_pci_hot_reset_info *info = NULL;
+    struct vfio_pci_dependent_device *devices;
+    struct vfio_pci_hot_reset *reset;
+    int32_t *fds;
+    int ret, i, count;
+    bool multi = false;
+
+    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
+
+    if (!single) {
+        vfio_pci_pre_reset(vdev);
+    }
+    vdev->vbasedev.needs_reset = false;
+
+    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
+
+    if (ret) {
         goto out_single;
     }
+    devices = &info->devices[0];
 
     trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
 
-- 
2.43.0


