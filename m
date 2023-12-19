Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26981904B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfLg-0000Tx-Jy; Tue, 19 Dec 2023 14:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfLE-0007rg-0I
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:01:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKh-0007uM-0P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmHJ6fTSz4xSQ;
 Wed, 20 Dec 2023 06:00:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmHD4DNSz4wc3;
 Wed, 20 Dec 2023 06:00:40 +1100 (AEDT)
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
Subject: [PULL 45/47] vfio: Introduce a helper function to initialize
 VFIODevice
Date: Tue, 19 Dec 2023 19:56:41 +0100
Message-ID: <20231219185643.725448-46-clg@redhat.com>
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

Introduce a helper function to replace the common code to initialize
VFIODevice in pci, platform, ap and ccw VFIO device.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/ap.c                  |  8 ++------
 hw/vfio/ccw.c                 |  8 ++------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/pci.c                 |  6 ++----
 hw/vfio/platform.c            |  6 ++----
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index efcba19f6663af28bffacf954469a9986b8ae8f0..b8aa8a549532442a31c8e85ce385c992d84f6bd5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -257,4 +257,6 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 /* Returns 0 on success, or a negative errno. */
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
+void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
+                      DeviceState *dev, bool ram_discard);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 95fe7cd98b6fdad5d8ca12a798f9aff91ca5b3f4..e157aa1ff79c1ad96b9102d54d4c11da1bd719ba 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -226,18 +226,14 @@ static void vfio_ap_instance_init(Object *obj)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    vbasedev->type = VFIO_DEVICE_TYPE_AP;
-    vbasedev->ops = &vfio_ap_ops;
-    vbasedev->dev = DEVICE(vapdev);
-    vbasedev->fd = -1;
-
     /*
      * vfio-ap devices operate in a way compatible with discarding of
      * memory in RAM blocks, as no pages are pinned in the host.
      * This needs to be set before vfio_get_device() for vfio common to
      * handle ram_block_discard_disable().
      */
-    vbasedev->ram_block_discard_allowed = true;
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
+                     DEVICE(vapdev), true);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 6305a4c1b86412c9706027939460176b62a6345d..90e4a534371684c08e112364e1537eb8979f73f4 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -683,11 +683,6 @@ static void vfio_ccw_instance_init(Object *obj)
     VFIOCCWDevice *vcdev = VFIO_CCW(obj);
     VFIODevice *vbasedev = &vcdev->vdev;
 
-    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
-    vbasedev->ops = &vfio_ccw_ops;
-    vbasedev->dev = DEVICE(vcdev);
-    vbasedev->fd = -1;
-
     /*
      * All vfio-ccw devices are believed to operate in a way compatible with
      * discarding of memory in RAM blocks, ie. pages pinned in the host are
@@ -696,7 +691,8 @@ static void vfio_ccw_instance_init(Object *obj)
      * needs to be set before vfio_get_device() for vfio common to handle
      * ram_block_discard_disable().
      */
-    vbasedev->ram_block_discard_allowed = true;
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
+                     DEVICE(vcdev), true);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 3592c3d54ecd68d4bfd23d4c3402a393fb1f2eb0..678987080228e9f69890bd955de452fe7ec06cca 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -652,3 +652,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
     }
     vbasedev->fd = fd;
 }
+
+void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
+                      DeviceState *dev, bool ram_discard)
+{
+    vbasedev->type = type;
+    vbasedev->ops = ops;
+    vbasedev->dev = dev;
+    vbasedev->fd = -1;
+
+    vbasedev->ram_block_discard_allowed = ram_discard;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 87405584d774810c8349825fafec34945a915121..1874ec1aba987cac6cb83f86650e7a5e1968c327 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3327,10 +3327,8 @@ static void vfio_instance_init(Object *obj)
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
 
-    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
-    vbasedev->ops = &vfio_pci_ops;
-    vbasedev->dev = DEVICE(vdev);
-    vbasedev->fd = -1;
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
+                     DEVICE(vdev), false);
 
     vdev->nv_gpudirect_clique = 0xFF;
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 506eb8193f2b047bc810e50236ae82fb7dfc7693..a8d9b7da633e0717421acbe9a951334b074b6607 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -657,10 +657,8 @@ static void vfio_platform_instance_init(Object *obj)
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
-    vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
-    vbasedev->ops = &vfio_platform_ops;
-    vbasedev->dev = DEVICE(vdev);
-    vbasedev->fd = -1;
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
+                     DEVICE(vdev), false);
 }
 
 #ifdef CONFIG_IOMMUFD
-- 
2.43.0


