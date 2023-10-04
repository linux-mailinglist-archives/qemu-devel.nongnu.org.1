Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF017B842D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo44u-000754-CO; Wed, 04 Oct 2023 11:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44p-00074b-Gb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44n-0006mh-Os
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsAWIbxqmygrLD13Fbk2FEGoL9KkYhdTkj/PRSK1VnM=;
 b=AZ709tk2PIZqOu2svJkWdVUIIH6V5m0LMo97D2fKAFw8Jt3p6EaQY3qk3MeIcsEaVWr3bm
 t1hZhGoL/kJcJ11Nr1WxbfJjBLGsdVGiuPtJJApq7TSaKDDamnMUSxZdLEDzNS88tfd/RM
 rp2HyYiGFdYlns7JaELIPW+uopy9+Ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-ESiLadZhN-26gginVc6omQ-1; Wed, 04 Oct 2023 11:46:11 -0400
X-MC-Unique: ESiLadZhN-26gginVc6omQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB5D95BC55;
 Wed,  4 Oct 2023 15:46:10 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E98D440C6EC1;
 Wed,  4 Oct 2023 15:46:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v4 14/15] vfio/common: Introduce a global VFIODevice list
Date: Wed,  4 Oct 2023 17:44:01 +0200
Message-ID: <20231004154518.334760-15-eric.auger@redhat.com>
In-Reply-To: <20231004154518.334760-1-eric.auger@redhat.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some functions iterate over all the VFIODevices. This is currently
achieved by iterating over all groups/devices. Let's
introduce a global list of VFIODevices simplifying that scan.

This will also be useful while migrating to IOMMUFD by hiding the
group specificity.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 45 +++++++++++++++--------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bf12e40667..54905b9dd4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -131,6 +131,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
+    QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
     VFIOContainer *container;
     char *sysfsdev;
@@ -232,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b14f04c9b0..5dd03763d2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -48,6 +48,8 @@
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
+static VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
@@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 
 bool vfio_mig_active(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
+    if (QLIST_EMPTY(&vfio_device_list)) {
         return false;
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration_blocker) {
-                return false;
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration_blocker) {
+            return false;
         }
     }
     return true;
@@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
  */
 static bool vfio_multiple_devices_migration_is_supported(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
     bool all_support_p2p = true;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration) {
-                device_num++;
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration) {
+            device_num++;
 
-                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
-                    all_support_p2p = false;
-                }
+            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                all_support_p2p = false;
             }
         }
     }
@@ -1777,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 void vfio_reset_handler(void *opaque)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized) {
-                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized) {
+            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized && vbasedev->needs_reset) {
-                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
     }
 }
@@ -2657,6 +2648,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     container = group->container;
     vbasedev->container = container;
     QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return ret;
 }
@@ -2665,6 +2657,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
+    QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->container = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
-- 
2.41.0


