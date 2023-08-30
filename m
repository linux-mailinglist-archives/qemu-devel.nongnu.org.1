Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A979578D54D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:56:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIpI-0004I3-Ua; Wed, 30 Aug 2023 06:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpC-0004Ha-Il
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:26 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIpA-0007fH-8c
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392804; x=1724928804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SvlSSQEEskjTcJO2Ju6WBWVkXRHLlMua+97gnXK3DqQ=;
 b=Ym/rllxaVjDMfhti5w9LCb9uUg4NxUnVEa7fqxtrir3zBac88xjmUJ16
 5+ORLFE5OuP4iAUFiON8zsHE39x+5HeQ5WRW07FiqFguB6foJ2D23yFMq
 uPO/tTdXbfk+04JhdDMTIUytNwv7Mk8ggkRfo4aZ+hjwsRvSiFnO2IJNI
 lP8QN3RowJV+deikGyyk0Fa4tGfE5frzKuWyzEYMhVy4sFNKQP6n8FHNP
 ibUvm5NYSpzmVJAa6k4sVoASRwtvILbbegu3/MT95gc8YTWThiIL1qF7K
 RRfEBCWhVwK2PhF9E0vz9oZ4SyvuGU6NAmpgVqqPJDCIddZ3swnDiXetD A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016540"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866123"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866123"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 10/22] vfio/platform: Use vfio_[attach/detach]_device
Date: Wed, 30 Aug 2023 18:37:42 +0800
Message-Id: <20230830103754.36461-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Let the vfio-platform device use vfio_attach_device() and
vfio_detach_device(), hence hiding the details of the used
IOMMU backend.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/platform.c   | 43 ++++---------------------------------------
 hw/vfio/trace-events |  2 +-
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5af73f9287..5c08c39315 100644
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
@@ -557,47 +552,17 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return -errno;
     }
 
-    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
-    len = readlink(tmp, group_path, sizeof(group_path));
-    g_free(tmp);
+    trace_vfio_platform_base_device_init(vbasedev->name);
 
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
index 8016d9f0d2..bd32970854 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -124,7 +124,7 @@ vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # platform.c
-vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
+vfio_platform_base_device_init(char *name) "%s"
 vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
 vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
 vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"
-- 
2.34.1


