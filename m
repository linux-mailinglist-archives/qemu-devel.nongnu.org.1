Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428C9377A3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 14:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmV6-0002HH-0t; Fri, 19 Jul 2024 08:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmV1-0001zE-7Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:14:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmUy-0000l0-9Q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:14:10 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JCB99u028799;
 Fri, 19 Jul 2024 12:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=W
 wVIIqWqlmi00xFxgBaYOmtesHvjg7aE87bm0cHmgSI=; b=GNBRoTLoTl7w6kBLv
 GcqJMjOMWzL4DS/NRkSZwxZ3OypQFLt+Rdg6Zk9L792rMoktOHdWSKk+HP9WEuif
 GYInAsReGjzS+uzyqICWeI26pnJ8freip5Hj3C8m7JSo849nVMSfOXVHVegSZZy9
 /6uAzT93AkOe8NGXOhuaY2L/m2yBP//u0wAUwFiULuTbSTenk8fMULprRhIhCZS5
 JJkB1DJQ4cfk7j+D8BeA0/r0jRybK4Yg3WUUH1iThWEcfOPhxWOIk18cy3zib8uS
 CATTbI/mWPe8EIileQTdl5Ya31nARjOgBAIrYFa1QQWK9j6jxiGS4o/7tliAbTeA
 OkvzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqwqr0j3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:14:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBkm10039489; Fri, 19 Jul 2024 12:05:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk3fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DML011010;
 Fri, 19 Jul 2024 12:05:27 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-6; Fri, 19 Jul 2024 12:05:27 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
Date: Fri, 19 Jul 2024 13:04:53 +0100
Message-Id: <20240719120501.81279-6-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=783
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-GUID: wJci7lKwroTckcyzP_HrdAqMOi4OGFRc
X-Proofpoint-ORIG-GUID: wJci7lKwroTckcyzP_HrdAqMOi4OGFRc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

There's generally two modes of operation for IOMMUFD:

1) The simple user API which intends to perform relatively simple things
with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
to VFIO and mainly performs IOAS_MAP and UNMAP.

2) The native IOMMUFD API where you have fine grained control of the
IOMMU domain and model it accordingly. This is where most new feature
are being steered to.

For dirty tracking 2) is required, as it needs to ensure that
the stage-2/parent IOMMU domain will only attach devices
that support dirty tracking (so far it is all homogeneous in x86, likely
not the case for smmuv3). Such invariant on dirty tracking provides a
useful guarantee to VMMs that will refuse incompatible device
attachments for IOMMU domains.

Dirty tracking insurance is enforced via HWPT_ALLOC, which is
responsible for creating an IOMMU domain. This is contrast to the
'simple API' where the IOMMU domain is created by IOMMUFD automatically
when it attaches to VFIO (usually referred as autodomains) but it has
the needed handling for mdevs.

To support dirty tracking with the advanced IOMMUFD API, it needs
similar logic, where IOMMU domains are created and devices attached to
compatible domains. Essentially mimicking kernel
iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
it falls back to IOAS attach.

The auto domain logic allows different IOMMU domains to be created when
DMA dirty tracking is not desired (and VF can provide it), and others where
it is. Here it is not used in this way given how VFIODevice migration
state is initialized after the device attachment. But such mixed mode of
IOMMU dirty tracking + device dirty tracking is an improvement that can
be added on. Keep the 'all of nothing' of type1 approach that we have
been using so far between container vs device dirty tracking.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  9 ++++
 include/sysemu/iommufd.h      |  5 +++
 backends/iommufd.c            | 30 +++++++++++++
 hw/vfio/iommufd.c             | 84 +++++++++++++++++++++++++++++++++++
 backends/trace-events         |  1 +
 5 files changed, 129 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 98acae8c1c97..1a96678f8c38 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
+typedef struct VFIOIOASHwpt {
+    uint32_t hwpt_id;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOIOASHwpt) next;
+} VFIOIOASHwpt;
+
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
@@ -135,6 +142,8 @@ typedef struct VFIODevice {
     HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
+    VFIOIOASHwpt *hwpt;
+    QLIST_ENTRY(VFIODevice) hwpt_next;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 57d502a1c79a..e917e7591d05 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp);
+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t pt_id, uint32_t flags,
+                                uint32_t data_type, uint32_t data_len,
+                                void *data_ptr, uint32_t *out_hwpt,
+                                Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2b3d51af26d2..a94d3b90c05c 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -208,6 +208,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
+                                uint32_t pt_id, uint32_t flags,
+                                uint32_t data_type, uint32_t data_len,
+                                void *data_ptr, uint32_t *out_hwpt,
+                                Error **errp)
+{
+    int ret, fd = be->fd;
+    struct iommu_hwpt_alloc alloc_hwpt = {
+        .size = sizeof(struct iommu_hwpt_alloc),
+        .flags = flags,
+        .dev_id = dev_id,
+        .pt_id = pt_id,
+        .data_type = data_type,
+        .data_len = data_len,
+        .data_uptr = (uintptr_t)data_ptr,
+    };
+
+    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
+                                     data_len, (uintptr_t)data_ptr,
+                                     alloc_hwpt.out_hwpt_id, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to allocate hwpt");
+        return false;
+    }
+
+    *out_hwpt = alloc_hwpt.out_hwpt_id;
+    return true;
+}
+
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 077dea8f1b64..545f4a404125 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -212,10 +212,88 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
+                                         VFIOIOMMUFDContainer *container,
+                                         Error **errp)
+{
+    IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    uint32_t flags = 0;
+    VFIOIOASHwpt *hwpt;
+    uint32_t hwpt_id;
+    int ret;
+
+    /* Try to find a domain */
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+        if (ret) {
+            /* -EINVAL means the domain is incompatible with the device. */
+            if (ret == -EINVAL) {
+                /*
+                 * It is an expected failure and it just means we will try
+                 * another domain, or create one if no existing compatible
+                 * domain is found. Hence why the error is discarded below.
+                 */
+                error_free(*errp);
+                *errp = NULL;
+                continue;
+            }
+
+            return false;
+        } else {
+            vbasedev->hwpt = hwpt;
+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+            return true;
+        }
+    }
+
+    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
+                                    container->ioas_id, flags,
+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
+                                    &hwpt_id, errp)) {
+        return false;
+    }
+
+    hwpt = g_malloc0(sizeof(*hwpt));
+    hwpt->hwpt_id = hwpt_id;
+    QLIST_INIT(&hwpt->device_list);
+
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+    if (ret) {
+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
+        g_free(hwpt);
+        return false;
+    }
+
+    vbasedev->hwpt = hwpt;
+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    return true;
+}
+
+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
+                                         VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
+
+    QLIST_REMOVE(vbasedev, hwpt_next);
+    vbasedev->hwpt = NULL;
+
+    if (QLIST_EMPTY(&hwpt->device_list)) {
+        QLIST_REMOVE(hwpt, next);
+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
+        g_free(hwpt);
+    }
+}
+
 static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                           VFIOIOMMUFDContainer *container,
                                           Error **errp)
 {
+    /* mdevs aren't physical devices and will fail with auto domains */
+    if (!vbasedev->mdev) {
+        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
+    }
+
     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
 
@@ -227,6 +305,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
         error_report_err(err);
     }
+
+    if (vbasedev->hwpt) {
+        iommufd_cdev_autodomains_put(vbasedev, container);
+    }
+
 }
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
@@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
+    QLIST_INIT(&container->hwpt_list);
 
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
diff --git a/backends/trace-events b/backends/trace-events
index 211e6f374adc..4d8ac02fe7d6 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
-- 
2.17.2


