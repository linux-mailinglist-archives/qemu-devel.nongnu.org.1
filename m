Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2527986B9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaFH-0007L3-Bo; Fri, 08 Sep 2023 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeaFD-0007DF-59
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:05:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeaF9-0000u5-2v
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:05:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388BemIA030506; Fri, 8 Sep 2023 12:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=gB2G7jdPvqrYU1CkNlz3L4YlMrhIjeMgdTiWeZl54ks=;
 b=rod/meDn2kgqOPhI+Pnq6SahJ/QN9ns24M7XF0EgSl5TVYAhHhRc606aKZxP/Q/q1vTS
 hW1VSPVHXqRpnLlP4hU3ryJmfUFgsIhRX6S6prnReP14SUBydvrT2zb4mZtZUnnEVlxU
 xUNYA1xEJlHXv+Ew3zMLt+bT16oZkz3zGI505dO+zp3oAyH5Ws6M8Cifs4oIU/JndgWV
 yPUh0FIMwzNFNbKlarOJtLg9pGtaaxDDFuf9TRfx0KndTIQvDNFTKFNmxU+5LwN3MS4V
 E6VlMGnsHxdZ8DaFbBhhzPdYJfZYG5AfCVmcOgkAuif9Mw58HBQkYF6t1jQLgj/wZYOX IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t02x9g1rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 12:05:45 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 388ANB0n039974; Fri, 8 Sep 2023 12:05:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug92en2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 12:05:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388C5hgl022996;
 Fri, 8 Sep 2023 12:05:43 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-173-55.vpn.oracle.com
 [10.175.173.55])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3suug92ekd-1; Fri, 08 Sep 2023 12:05:43 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFC] vfio/common: Add an option to relax vIOMMU migration
 blocker
Date: Fri,  8 Sep 2023 13:05:21 +0100
Message-Id: <20230908120521.50903-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=789 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080111
X-Proofpoint-ORIG-GUID: uGbwYA8uChmhCbBM5aXCddY3upD2IdQ-
X-Proofpoint-GUID: uGbwYA8uChmhCbBM5aXCddY3upD2IdQ-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an option 'x-migration-iommu-pt' to VFIO that allows it to relax
whether the vIOMMU usage blocks the migration. The current behaviour
is kept and we block migration in the following conditions:

* By default if the guest does try to use vIOMMU migration is blocked
when migration is attempted, just like having the migration blocker in
the first place [Current behaviour]

* Migration starts with no vIOMMU mappings, but guest kexec's itself
with IOMMU on ('iommu=on intel_iommu=on') and ends up using the vIOMMU.
here we cancel the migration with an error message [Added behaviour]

This is meant to be used for older VMs (5.10) cases where we can relax
the usage and that IOMMU is passed for the sole need of interrupt
remapping while the guest is old enough to not check for DMA translation
services while probe its IOMMU devices[0]. The option is useful for
managed VMs where you *steer* some of the guest behaviour and you know
you won't use it for more than interrupt remapping.

[0] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/

Default is 'disabled' for this option given the second bullet point
above depends on guest behaviour (thus undeterministic). But let the
user enable it if it can tolerate migration failures.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Followup from discussion here:
https://lore.kernel.org/qemu-devel/d5d30f58-31f0-1103-6956-377de34a790c@redhat.com/

This is a smaller (and simpler) take than [0], but is likely the only
option thinking in old guests, or managed guests that only want to use
vIOMMU for interrupt remapping. The work in [0] has stronger 'migration
will work' guarantees (of course except for the usual no convergence 
or network failuresi that are agnostic to vIOMMU), and a bit better in
limiting what guest can do. But it also depends in slightly recent
guests. I think both are useful.

About the patch itself:

* cancelling migration was done via vfio_migration_set_error() but
I can always use migrate_cancel() if migration is active, or add
a migration blocker when it's not active.

---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 66 +++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |  7 +++-
 hw/vfio/pci.c                 |  2 ++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e9b895459534..95ef386af45f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -140,6 +140,7 @@ typedef struct VFIODevice {
     bool no_mmap;
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
+    bool iommu_passthrough;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
@@ -227,6 +228,7 @@ extern VFIOGroupList vfio_group_list;
 bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
+bool vfio_devices_all_iommu_passthrough(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 134649226d43..4adf9fec08f1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -433,6 +433,22 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
+bool vfio_devices_all_iommu_passthrough(void)
+{
+    VFIODevice *vbasedev;
+    VFIOGroup *group;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if (!vbasedev->iommu_passthrough) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
     return vbasedev->group->container->space->as != &address_space_memory;
@@ -1194,6 +1210,18 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+
+        /*
+         * Any attempts to use make vIOMMU mappings will fail the live migration
+         */
+        if (vfio_devices_all_iommu_passthrough()) {
+            MigrationState *ms = migrate_get_current();
+
+            if (migration_is_setup_or_active(ms->state)) {
+                vfio_set_migration_error(-EOPNOTSUPP);
+            }
+        }
+
         memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 
         return;
@@ -1628,6 +1656,44 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
     VFIOGroup *group;
     int ret = 0;
 
+    /*
+     * vIOMMU models traditionally define the maximum address space width, which
+     * is a superset of the effective IOVA addresses being used e.g.
+     * intel-iommu defines 39-bit and 48-bit, and similarly AMD hardware.  The
+     * problem is that these limits are really big, for device dirty trackers
+     * when the iommu gets passed for the sole usage of interrupt remapping i.e.
+     * >=256 vCPUs while IOMMU is kept in passthrough mode.
+     *
+     * With x-migration-iommu-pt assume that a guest being migrated won't use
+     * the vIOMMU in a non passthrough manner (throughout migration). In that
+     * case, try to use the boot memory layout that VFIO DMA maps to minimize
+     * having to stress high dirty tracking limits, and fail on any new gIOMMU
+     * mappings which may:
+     *
+     * 1) Prevent the migration from starting i.e. gIOMMU mappings done
+     * migration which would be no different than having the migration blocker.
+     * So this behaviour is obviously kept.
+     *
+     * 2) Cancelling an active migration i.e. new gIOMMU mappings mid migration
+     * From a Linux guest perspective this means for example the guest kexec's
+     * with 'iommu=on intel_iommu=on amd_iommu=on' or etc and at boot it will
+     * establish some vIOMMU mappings.
+     *
+     * This option should be specially relevant for old guests (<5.10) which
+     * don't probe for DMA translation services being off when initializing
+     * IOMMU devices, thus ending up in crashes when dma-translation=off is
+     * passed.
+     *
+     */
+    if (vfio_devices_all_iommu_passthrough() &&
+        !QLIST_EMPTY(&container->giommu_list)) {
+        ret = EOPNOTSUPP;
+        error_report("vIOMMU mappings active "
+                     "cannot start dirty tracking, err %d (%s)",
+                     -ret, strerror(ret));
+        return -ret;
+    }
+
     vfio_dirty_tracking_init(container, &ranges);
     feature = vfio_device_feature_dma_logging_start_create(container,
                                                            &ranges);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index da43dcd2fe07..21304c8a90bc 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -970,10 +970,15 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
-    if (vfio_viommu_preset(vbasedev)) {
+    if (vfio_viommu_preset(vbasedev) &&
+        !vfio_devices_all_iommu_passthrough()) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
         goto add_blocker;
+    } else if (vfio_devices_all_iommu_passthrough()) {
+        warn_report("%s: Migration maybe blocked or cancelled"
+                    "if vIOMMU is used beyond interrupt remapping",
+                    vbasedev->name);
     }
 
     trace_vfio_migration_realize(vbasedev->name);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3c37d036e727..5276a49fca12 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3507,6 +3507,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("x-migration-iommu-pt", VFIOPCIDevice,
+                     vbasedev.iommu_passthrough, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                      vbasedev.ram_block_discard_allowed, false),
-- 
2.39.3


