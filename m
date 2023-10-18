Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094197CD891
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38N-0001Dr-5U; Wed, 18 Oct 2023 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37v-0000PU-2H
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:14 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37q-0003SZ-7u
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvr2X5gz4xZg;
 Wed, 18 Oct 2023 20:46:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvp1rcKz4xbC;
 Wed, 18 Oct 2023 20:45:58 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/22] vfio/platform: Use vfio_[attach/detach]_device
Date: Wed, 18 Oct 2023 11:45:17 +0200
Message-ID: <20231018094531.733211-9-clg@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

Let the vfio-platform device use vfio_attach_device() and
vfio_detach_device(), hence hiding the details of the used
IOMMU backend.

Drop the trace event for vfio-platform as we have similar
one in vfio_attach_device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/platform.c   | 43 +++----------------------------------------
 hw/vfio/trace-events |  1 -
 2 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5af73f928766c16cd36010ca0d07c65ae5c5eb16..8e3d4ac45824ec69afb523f8f0e668327122cd02 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -529,12 +529,7 @@ static VFIODeviceOps vfio_platform_ops = {
  */
 static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 {
-    VFIOGroup *group;
-    VFIODevice *vbasedev_iter;
-    char *tmp, group_path[PATH_MAX], *group_name;
-    ssize_t len;
     struct stat st;
-    int groupid;
     int ret;
 
     /* @sysfsdev takes precedence over @host */
@@ -557,47 +552,15 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return -errno;
     }
 
-    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
-    len = readlink(tmp, group_path, sizeof(group_path));
-    g_free(tmp);
-
-    if (len < 0 || len >= sizeof(group_path)) {
-        ret = len < 0 ? -errno : -ENAMETOOLONG;
-        error_setg_errno(errp, -ret, "no iommu_group found");
-        return ret;
-    }
-
-    group_path[len] = 0;
-
-    group_name = basename(group_path);
-    if (sscanf(group_name, "%d", &groupid) != 1) {
-        error_setg_errno(errp, errno, "failed to read %s", group_path);
-        return -errno;
-    }
-
-    trace_vfio_platform_base_device_init(vbasedev->name, groupid);
-
-    group = vfio_get_group(groupid, &address_space_memory, errp);
-    if (!group) {
-        return -ENOENT;
-    }
-
-    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
-            error_setg(errp, "device is already attached");
-            vfio_put_group(group);
-            return -EBUSY;
-        }
-    }
-    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
+    ret = vfio_attach_device(vbasedev->name, vbasedev,
+                             &address_space_memory, errp);
     if (ret) {
-        vfio_put_group(group);
         return ret;
     }
 
     ret = vfio_populate_device(vbasedev, errp);
     if (ret) {
-        vfio_put_group(group);
+        vfio_detach_device(vbasedev);
     }
 
     return ret;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8ac13eb106db68c4f547b1b3819f96272309a124..0eb2387cf24c920b0904ec4012b0fcd3f2e8b3cf 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -121,7 +121,6 @@ vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
 vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
 vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
 vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"
-- 
2.41.0


