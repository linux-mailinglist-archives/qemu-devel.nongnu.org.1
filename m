Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B20750048
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURq-0004CE-PM; Wed, 12 Jul 2023 03:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURo-0004Bv-VF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:40 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURn-0006nC-6u
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147579; x=1720683579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BXrueUNFSBhC6cdVQiHrpHnZmiIRPkjdZlx5ebgQHvg=;
 b=UbLac3cJtlTGwJ3G7D654Kjs5VITE0/Urp6BB/W829krzp3cCfZUuwyq
 cTay52v2OHeF08El5cjGAvo3h3sGeGzjUROwCo+Zpgau6cGlNPq4+eIQJ
 54JVPEl1cJ57o2Opbs5LXhgSHMqo7gfjWCWOgyhKqVgaHPqN4vfp5aTSW
 erilBKisJMZqnnpgMRfzhU9XjrDvWXPjZttrz3Q6gHNDeRpQnEDL3ihUE
 olphaebph8Xw0oT/5I5k1hyAp2rYcRdhQZSygtnrH5DttRgHVf9cDoDV1
 P1Yc3QBPnYbbZTnhJm24lgmKjPkEPUiEiMLcS5KRq038OkC96+a95XjNO w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953615"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835023968"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835023968"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 05/24] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Date: Wed, 12 Jul 2023 15:25:09 +0800
Message-Id: <20230712072528.275577-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

...which will be used by both legacy and iommufd container.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c              | 50 ++++++++++++++++++++++++-----------
 include/hw/vfio/vfio-common.h |  3 +++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 67150e4575..b9d493b211 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1759,17 +1759,17 @@ void vfio_reset_handler(void *opaque)
     }
 }
 
-static void vfio_kvm_device_add_group(VFIOGroup *group)
+int vfio_kvm_device_add_fd(int fd)
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
@@ -1779,37 +1779,57 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
 
         if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
             error_report("Failed to create KVM VFIO device: %m");
-            return;
+            return -ENODEV;
         }
 
         vfio_kvm_device_fd = cd.fd;
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_report("Failed to add group %d to KVM VFIO device: %m",
-                     group->groupid);
+        error_report("Failed to add fd %d to KVM VFIO device: %m",
+                     fd);
+        return -errno;
     }
 #endif
+    return 0;
 }
 
-static void vfio_kvm_device_del_group(VFIOGroup *group)
+static void vfio_kvm_device_add_group(VFIOGroup *group)
+{
+    if (vfio_kvm_device_add_fd(group->fd)) {
+        error_report("Failed to add group %d to KVM VFIO device",
+                     group->groupid);
+    }
+}
+
+int vfio_kvm_device_del_fd(int fd)
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
+        return -EINVAL;
     }
 
     if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_report("Failed to remove group %d from KVM VFIO device: %m",
-                     group->groupid);
+        error_report("Failed to remove fd %d from KVM VFIO device: %m",
+                     fd);
+        return -EBADF;
     }
 #endif
+    return 0;
+}
+
+static void vfio_kvm_device_del_group(VFIOGroup *group)
+{
+    if (vfio_kvm_device_del_fd(group->fd)) {
+        error_report("Failed to remove group %d from KVM VFIO device",
+                     group->groupid);
+    }
 }
 
 static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5e376c436e..598c3ce079 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -220,6 +220,9 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
+int vfio_kvm_device_add_fd(int fd);
+int vfio_kvm_device_del_fd(int fd);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
-- 
2.34.1


