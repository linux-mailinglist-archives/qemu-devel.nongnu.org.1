Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487CA7AEBCD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6Xl-0002H5-0v; Tue, 26 Sep 2023 07:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xg-0002A8-Bw
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:53 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xc-0002Mt-3A
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728868; x=1727264868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hw1IHALwWiHpvTZiPvlwKN/Bk5Mag9iHiRepiqEq6c4=;
 b=VqDD+7h+wahB7sw7TQNHkNcSgm5F7kjDse7etTdjHV8VjBZqxihKjdso
 VKu9+Ja5Ie4Ws9JwoHAlfnZcaqi+koggMP4FVFGThi8yjnZj12XMndD/Y
 oNWD8taY64B1NGbuG2WNQZ9D2NZRlqgKyT06E3ZUZlndWHSMK+WQMhQrf
 aF+F7HzvD/Vfbe5QxhQiz33xk53S4Jq80Drve08q05cvF96bNypE3cSwQ
 wVosyXwcI+ZPsGdhwWNEuAR9AMrSlo0eMvS7YsyJjBukHP8aNBb4+pMGh
 JVR535AZuvIOZuoOjSDVbpJnfiKsMQ9tbXQkUiupDi+kxbP34ys5k8mRe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825429"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825429"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789656"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789656"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 05/12] vfio/common: Extract out vfio_kvm_device_[add/del]_fd
Date: Tue, 26 Sep 2023 19:32:48 +0800
Message-Id: <20230926113255.1177834-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce two new helpers, vfio_kvm_device_[add/del]_fd
which take as input a file descriptor which can be either a group fd or
a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
which aliases to the legacy KVM_DEV_VFIO_GROUP.

vfio_kvm_device_[add/del]_group then call those new helpers.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  3 ++
 hw/vfio/common.c              | 55 +++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e0483893d1..c4e7c3b4a7 100644
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
index de6b4a86e2..959b1362bb 100644
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
2.34.1


