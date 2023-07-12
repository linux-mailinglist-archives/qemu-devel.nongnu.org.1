Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8775004C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURz-0004HW-OU; Wed, 12 Jul 2023 03:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURv-0004Gt-NB
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:47 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURu-0006nC-3H
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147586; x=1720683586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tkDvermhgfWRIZNI4Wawk8SJbDx1h6yBqk6rcJ7ZYqI=;
 b=SfH9WViahJdxXM1wLRe7YGXJJnIkzEvGEev0Rw2Uc3j0IgYQseJ+YC8c
 kYDQDFXlyNWkarx1FRfU99gbaSm1+/ZNko2I+bLq4NqjsHpSHRqnoctL6
 Xn1iCHdgXxJe3NE6I8UnmXyq63ndleq6cZFy383F+FUY3RHUlKlwtqrTE
 LVm18lhdFNk2FLWWDCBjm2ACW6+iR9iml6EEZ/2kHqOYFl+9TTSaXUiLX
 1vGO+A6DWQISID5E2f72f9doqOSM822vhBqVR2XIaXddQbKA/84EdQ5bB
 LdJuA3q8ekG4bJyKM3jRqqJaQaCpB1lq7RKageqD2PDZ9RLMUW/92j7P5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953717"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024054"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024054"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 12/24] vfio/platform: Use vfio_[attach/detach]_device
Date: Wed, 12 Jul 2023 15:25:16 +0800
Message-Id: <20230712072528.275577-13-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Let the vfio-platform device use vfio_attach_device() and
vfio_detach_device(), hence hiding the details of the used
IOMMU backend.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/platform.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5af73f9287..8e3d4ac458 100644
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
-- 
2.34.1


