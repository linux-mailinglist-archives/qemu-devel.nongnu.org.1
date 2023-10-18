Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E297CD899
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38D-0000ye-Ny; Wed, 18 Oct 2023 05:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37o-0000Ly-4i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37m-0003SZ-1O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:45:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvl0tVfz4xbN;
 Wed, 18 Oct 2023 20:45:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvj0CBLz4xbC;
 Wed, 18 Oct 2023 20:45:52 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/22] vfio/common: Extract out vfio_kvm_device_[add/del]_fd
Date: Wed, 18 Oct 2023 11:45:15 +0200
Message-ID: <20231018094531.733211-7-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Introduce two new helpers, vfio_kvm_device_[add/del]_fd
which take as input a file descriptor which can be either a group fd or
a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
which aliases to the legacy KVM_DEV_VFIO_GROUP.

vfio_kvm_device_[add/del]_group then call those new helpers.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 ++
 hw/vfio/common.c              | 55 +++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0483893d14b536a79c372b8d02471255ea3da25..c4e7c3b4a7757087ab4bc02b634216bf3ae857d6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -226,6 +226,9 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
+int vfio_kvm_device_add_fd(int fd, Error **errp);
+int vfio_kvm_device_del_fd(int fd, Error **errp);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0397788aa58c8deaa8cf3ed19fa8eb40e91d7678..d8ed432cb6d0e8e955984401cdbbe921d87636f7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1818,17 +1818,17 @@ void vfio_reset_handler(void *opaque)
     }
 }
 
-static void vfio_kvm_device_add_group(VFIOGroup *group)
+int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
     struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_GROUP,
-        .attr = KVM_DEV_VFIO_GROUP_ADD,
-        .addr = (uint64_t)(unsigned long)&group->fd,
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+        .addr = (uint64_t)(unsigned long)&fd,
     };
 
     if (!kvm_enabled()) {
-        return;
+        return 0;
     }
 
     if (vfio_kvm_device_fd < 0) {
@@ -1837,38 +1837,61 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
         };
 
         if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
-            error_report("Failed to create KVM VFIO device: %m");
-            return;
+            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+            return -errno;
         }
 
         vfio_kvm_device_fd = cd.fd;
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_report("Failed to add group %d to KVM VFIO device: %m",
-                     group->groupid);
+        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
+                         fd);
+        return -errno;
     }
 #endif
+    return 0;
 }
 
-static void vfio_kvm_device_del_group(VFIOGroup *group)
+int vfio_kvm_device_del_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
     struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_GROUP,
-        .attr = KVM_DEV_VFIO_GROUP_DEL,
-        .addr = (uint64_t)(unsigned long)&group->fd,
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_DEL,
+        .addr = (uint64_t)(unsigned long)&fd,
     };
 
     if (vfio_kvm_device_fd < 0) {
-        return;
+        error_setg(errp, "KVM VFIO device isn't created yet");
+        return -EINVAL;
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_report("Failed to remove group %d from KVM VFIO device: %m",
-                     group->groupid);
+        error_setg_errno(errp, errno,
+                         "Failed to remove fd %d from KVM VFIO device", fd);
+        return -errno;
     }
 #endif
+    return 0;
+}
+
+static void vfio_kvm_device_add_group(VFIOGroup *group)
+{
+    Error *err = NULL;
+
+    if (vfio_kvm_device_add_fd(group->fd, &err)) {
+        error_reportf_err(err, "group ID %d: ", group->groupid);
+    }
+}
+
+static void vfio_kvm_device_del_group(VFIOGroup *group)
+{
+    Error *err = NULL;
+
+    if (vfio_kvm_device_del_fd(group->fd, &err)) {
+        error_reportf_err(err, "group ID %d: ", group->groupid);
+    }
 }
 
 static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
-- 
2.41.0


