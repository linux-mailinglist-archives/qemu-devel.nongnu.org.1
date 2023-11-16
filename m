Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED87EDCBB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XWn-0004wk-SB; Thu, 16 Nov 2023 03:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWl-0004ur-4E; Thu, 16 Nov 2023 03:15:07 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWh-0008Vt-T1; Thu, 16 Nov 2023 03:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700122503; x=1731658503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7ulUb8BDAYNNaq8Q6Oq4m/NU6hhquqsc+3+9P7+Z1W4=;
 b=azJpgXFfEnG9uDOoh5nkOvlCa3DWewp/1ynSC/tSptZVp2Zho0WiP+1J
 jptC3zQXb45KUqwsEUk6uaLc9hO1bQ3G40r/4eHnPaJYXvZyhjDW5SlMZ
 TqnPF55v7z2ScFrqYjLo3Mbe7UrRlJesgQ3ui/mwog0nhrUiMAtaE3BXw
 Pp8E5Ut8JrhZe99ObHJI91gVENHAFbysWSASxrooBN3vQTv5l1x/XJbiH
 MHKwMRTNgd59xU62cqt8voGestuuax5hhwPczfpxZATmgtXlhogNu0XAO
 3PfYiYZ9UE21sPSzsLXGDM3tsOqynge2FIGW7yJH/8HbedCqEm7Q765pG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389898337"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="389898337"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768846157"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="768846157"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:57 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v2 5/5] vfio: Introduce a helper function to initialize
 VFIODevice
Date: Thu, 16 Nov 2023 15:59:09 +0800
Message-Id: <20231116075909.1987656-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
References: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce a helper function to replace the common code to initialize
VFIODevice in pci, platform, ap and ccw VFIO device.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/ap.c                  |  8 ++------
 hw/vfio/ccw.c                 |  8 ++------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/pci.c                 |  6 ++----
 hw/vfio/platform.c            |  6 ++----
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7954531d05..fa430cb288 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -256,4 +256,6 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
+void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
+                      DeviceState *dev, bool ram_discard);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 31ea9644c5..84c83f66fe 100644
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
index 8de2fd809b..0b1873e922 100644
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
index 3592c3d54e..6789870802 100644
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
index 5a2b7a2d6b..31ad27d716 100644
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
index 506eb8193f..a8d9b7da63 100644
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
2.34.1


