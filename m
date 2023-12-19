Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B42819044
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:04:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHq-00021i-42; Tue, 19 Dec 2023 13:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHk-00021K-RP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:44 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHi-000719-Kz
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmCm4mwHz4xMw;
 Wed, 20 Dec 2023 05:57:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmCh4PwLz4xCp;
 Wed, 20 Dec 2023 05:57:36 +1100 (AEDT)
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/47] vfio/container: Move per container device list in base
 container
Date: Tue, 19 Dec 2023 19:56:04 +0100
Message-ID: <20231219185643.725448-9-clg@redhat.com>
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

VFIO Device is also changed to point to base container instead of
legacy container.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  3 +--
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      | 23 +++++++++++++++--------
 hw/vfio/container.c                   | 12 ++++++------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 60f2785fe07cf71e3c65e85d933536c09170f4c6..9740cf9fbc65831647b30dcc415d3d1db5835661 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -90,7 +90,6 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
-    QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
 } VFIOContainer;
 
@@ -118,7 +117,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) container_next;
     QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
-    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f244f003d080a30e95b6daa97a132eeb5a271ae4..709096249642c7c597aa789264a09389e53664f3 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -39,6 +39,7 @@ typedef struct VFIOContainerBase {
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_ENTRY(VFIOContainerBase) next;
+    QLIST_HEAD(, VFIODevice) device_list;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b1a875ca93a44347f3652298995b89b5d9aed045..9415395ed9becc337cf25c5714c6b3c4c452c81b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -145,7 +145,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->container->bcontainer.space->as != &address_space_memory;
+    return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -179,6 +179,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     MigrationState *ms = migrate_get_current();
 
@@ -187,7 +188,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -205,9 +206,10 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 
 bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
@@ -222,13 +224,14 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  */
 bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     if (!migration_is_active(migrate_get_current())) {
         return false;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
         if (!migration) {
@@ -833,12 +836,13 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
                                      VFIOContainer *container)
 {
     VFIOPCIDevice *pcidev;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     Object *owner;
 
     owner = memory_region_owner(section->mr);
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
             continue;
         }
@@ -939,13 +943,14 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (!vbasedev->dirty_tracking) {
             continue;
         }
@@ -1036,6 +1041,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret = 0;
 
@@ -1046,7 +1052,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
         return -errno;
     }
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         if (vbasedev->dirty_tracking) {
             continue;
         }
@@ -1139,10 +1145,11 @@ int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
                                     VFIOBitmap *vbmap, hwaddr iova,
                                     hwaddr size)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
     int ret;
 
-    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         ret = vfio_device_dma_logging_report(vbasedev, iova, size,
                                              vbmap->bitmap);
         if (ret) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3ab74e26151efd7ae4027ed3b4cf04a835083ccc..63a906de933574706beddf54b78885e9a6c659df 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -888,7 +888,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     int ret;
 
     if (groupid < 0) {
@@ -915,9 +915,9 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
         return ret;
     }
 
-    container = group->container;
-    vbasedev->container = container;
-    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+    bcontainer = &group->container->bcontainer;
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return ret;
@@ -927,13 +927,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    if (!vbasedev->container) {
+    if (!vbasedev->bcontainer) {
         return;
     }
 
     QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->container = NULL;
+    vbasedev->bcontainer = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
-- 
2.43.0


