Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE477BD683
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:13:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmIe-0003Ey-S5; Mon, 09 Oct 2023 05:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpmID-0002bu-5H
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpmI7-0007iG-RP
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696842666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5b1eeQIjjRAhWFnzCyKsWFZNP/zYHrb3/4/DrZj/g0=;
 b=EaQj+yxNo8S01zjPbR8GK+dmg5dSXqE+ah+MF8ywRQtcTHu0ds8wT+h2aZGh8KLP9ooxqq
 4DwwlcPNbeQnKxkwVKOWhKzSYWpwGHhcsx8FS46QwJ4r5qaViX/STNu86i/mHNg43hOf3r
 qZlIhQvUWrAO3ZpyESnYosaYsd7uXNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-GhVE0tU7Pyig3784VELl6Q-1; Mon, 09 Oct 2023 05:11:00 -0400
X-MC-Unique: GhVE0tU7Pyig3784VELl6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B151810BDD;
 Mon,  9 Oct 2023 09:10:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A97C363F55;
 Mon,  9 Oct 2023 09:10:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v5 06/15] vfio/common: Extract out vfio_kvm_device_[add/del]_fd
Date: Mon,  9 Oct 2023 11:09:08 +0200
Message-ID: <20231009091035.433329-7-eric.auger@redhat.com>
In-Reply-To: <20231009091035.433329-1-eric.auger@redhat.com>
References: <20231009091035.433329-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Introduce two new helpers, vfio_kvm_device_[add/del]_fd
which take as input a file descriptor which can be either a group fd or
a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
which aliases to the legacy KVM_DEV_VFIO_GROUP.

vfio_kvm_device_[add/del]_group then call those new helpers.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 ++
 hw/vfio/common.c              | 69 +++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 23 deletions(-)

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
index 0397788aa5..d8ed432cb6 100644
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
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+#ifdef CONFIG_KVM
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_DEL,
+        .addr = (uint64_t)(unsigned long)&fd,
+    };
+
+    if (vfio_kvm_device_fd < 0) {
+        error_setg(errp, "KVM VFIO device isn't created yet");
+        return -EINVAL;
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno,
+                         "Failed to remove fd %d from KVM VFIO device", fd);
+        return -errno;
+    }
+#endif
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
 }
 
 static void vfio_kvm_device_del_group(VFIOGroup *group)
 {
-#ifdef CONFIG_KVM
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_GROUP,
-        .attr = KVM_DEV_VFIO_GROUP_DEL,
-        .addr = (uint64_t)(unsigned long)&group->fd,
-    };
+    Error *err = NULL;
 
-    if (vfio_kvm_device_fd < 0) {
-        return;
+    if (vfio_kvm_device_del_fd(group->fd, &err)) {
+        error_reportf_err(err, "group ID %d: ", group->groupid);
     }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_report("Failed to remove group %d from KVM VFIO device: %m",
-                     group->groupid);
-    }
-#endif
 }
 
 static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
-- 
2.41.0


