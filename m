Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471D937793
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 14:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmRS-0001Jg-FF; Fri, 19 Jul 2024 08:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRL-0001BR-NS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRI-0007Ss-Vg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC5YYi024688;
 Fri, 19 Jul 2024 12:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=j
 cYPgfWkBn8MMQBcYZoHevBxGrKwDvGxmhBu+f1ftPI=; b=H3Rm5rqo8xzNTP/ga
 5uSrytL0HYnwAfpizQKr/6x4pUHMPY/9RPPKdD/BrvpiY5NZ1m/4EcQbjT7JieW3
 ts8BDCzPuyLojOaZXGo2acalkU/df4v7YsD+ScPk3dw+iPrshQCxciU9K48I8XF7
 hqggZE39AV44dBYVMFauEi2bNNhCS6H0z3rTBfICPSCk5Cq4KNBCH5ZtJeCIjsvz
 wiKIIwTeOJbLffnoMZGOYZS3E9S9Q3RWaQ5i5Cf50cQ7B/RQRutWwyju8LwPrniX
 /mAfbYMMRWbJvLzXynApyggeRDB0KsC5bS6NWd8QtdoewGxxbxmGQj/sFEK9LTRg
 7mvkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqub80mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:10:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBIhOY039597; Fri, 19 Jul 2024 12:05:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk386-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMD011010;
 Fri, 19 Jul 2024 12:05:16 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-2; Fri, 19 Jul 2024 12:05:16 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
Date: Fri, 19 Jul 2024 13:04:49 +0100
Message-Id: <20240719120501.81279-2-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-ORIG-GUID: EbFKeW5yHANiEe92mZE5lxQA1iNdcnId
X-Proofpoint-GUID: EbFKeW5yHANiEe92mZE5lxQA1iNdcnId
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation to skip initialization of the HostIOMMUDevice for mdev,
extract the checks that validate if a device is an mdev into helpers.

A vfio_device_is_mdev() is created, and subsystems consult VFIODevice::mdev
to check if it's mdev or not.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/helpers.c             | 14 ++++++++++++++
 hw/vfio/pci.c                 | 12 +++---------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e8ddf92bb185..98acae8c1c97 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -116,6 +116,7 @@ typedef struct VFIODevice {
     DeviceState *dev;
     int fd;
     int type;
+    bool mdev;
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
@@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
+bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b14edd46edc9..7e23e9080c9d 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -675,3 +675,17 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
 
     return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
 }
+
+bool vfio_device_is_mdev(VFIODevice *vbasedev)
+{
+    g_autofree char *subsys = NULL;
+    g_autofree char *tmp = NULL;
+
+    if (!vbasedev->sysfsdev) {
+        return false;
+    }
+
+    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
+    subsys = realpath(tmp, NULL);
+    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba546..b34e91468a53 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2963,12 +2963,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    char *subsys;
     int i, ret;
-    bool is_mdev;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    g_autofree char *tmp = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2997,14 +2994,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
      * stays in sync with the active working set of the guest driver.  Prevent
      * the x-balloon-allowed option unless this is minimally an mdev device.
      */
-    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
-    subsys = realpath(tmp, NULL);
-    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
-    free(subsys);
+    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
 
-    trace_vfio_mdev(vbasedev->name, is_mdev);
+    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
 
-    if (vbasedev->ram_block_discard_allowed && !is_mdev) {
+    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
         error_setg(errp, "x-balloon-allowed only potentially compatible "
                    "with mdev devices");
         goto error;
-- 
2.17.2


