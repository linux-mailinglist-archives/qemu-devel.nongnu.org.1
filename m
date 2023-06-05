Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33070723455
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 03:07:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6LAR-0004Vl-GC; Mon, 05 Jun 2023 21:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2j-0003Xs-No
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:21 -0400
Received: from mail-dm3nam02on2052.outbound.protection.outlook.com
 ([40.107.95.52] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1q6K2h-0000vY-Pl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:55:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzc/acmzHhWbazSHLoW5suJwENVse9yKeunebUdz9yz+4rmff1m3dXx7up7n0UU+lXn6f7URGtzm5HxLEImTaj43X27u+kNILOnslyIp4AVNPW4g5cOSlqfnJVRBUw9uIFBJfTxu1kqn8VYN8QNvwv165wrCvsqyBeGntXcgXCbM6Sd/N5nM0zSzoKtkcOKy8Ef1W0iFlXw9ZOgBI1MwHve2Ai65RuPigtGdoksq9Bk5QQ7e5LE/50E6WSGWaQxxtO822Cafd5che9g5l8tI8N8bWCXNW2NwVDRh2nszncvEsNSOzG7a52efSCdqVBIAlgKoq8eFBvKWNDN6u7akEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXoSoxsyOd2eKWqGhqFjOahHn+StOsZWtRsy0h6IBT0=;
 b=SA4uR581lcPfR4IwnBnc/HTJfksDxlE/jS+v6ZGMOIKrIygW+nkx5uNsJd6yFgmIe/+al6Bv4gRLRl0SuqeIFBpoAm9vpJfTq9C4qhZSaEA1zjPr7VDklRQKlF3p9W0pUx7yhj0K/MHwK9r1+W7PfrrJkW5EO4ccaVR5QAYPUFNLMH+U5oKuqsXAGJcPd3elbGlDvNMTUdFgUVLOLQrN+2hJRwLudxqUDbDWoBZ30wP+9aQrmhQ4wt34cVz1iOslb4ohhf13QYLN+yAOP1ZVuxHtyfJ14jrp5AfhNvIoCm9UF2wNJD0aW57t6xJINoR9BDY1DHU2r+jL/nZG+tdprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXoSoxsyOd2eKWqGhqFjOahHn+StOsZWtRsy0h6IBT0=;
 b=QDxzDJeTntZYv/X0fNdeSLXZ2+r1zslVuZL4IxybpvnHJby3l18CeL0P7UcfFbcVj/GyvGaHZt3xOB52F9jPa+pc70lW2x2NB7YV/twk1DGHMXeZfL/1kWBrfJkd0UQ90G1P3U9492t6z/300jW6+JZ1RQICgk5Pl3Ex3aSeVUPJq1oqElFZLj0DFCBVy68s4Q4cyIC0oeG+5l64yANnBzeSPp4lsY7uYYagq8L+FZx0jaDlBdVKEX/1IQYtRqXl5iFvL+2He7LQEnto7eth69DBh2xFXv5Y8QOpx5jbimclJrTkCfH/I8XpT9Nd/fCGK4Suras5yxwy1F5MpyNZoQ==
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 23:50:13 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d6) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 23:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 23:50:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 16:50:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 5 Jun 2023 16:50:05 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 5 Jun 2023 16:50:05 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>
CC: <qemu-devel@nongnu.org>
Subject: [RFC v1 1/4] qemu: add GPU memory information as object
Date: Mon, 5 Jun 2023 16:50:02 -0700
Message-ID: <20230605235005.20649-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605235005.20649-1-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f1d8bd-8778-4865-6419-08db661f9b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yCvHUIWiEwAwa0HOol/mOAlIKt8oLKB/015HN0AX7RBxask6S41tEgs0EiTFh7aH9q1KXuPIL25lSo7c7BNatMCAqeA8JJI0+Vvmn7A+zV+7MjGUcV0MsC9kbm0VJy31RotrAJjwPwoua5vJJhhD0+9iJq5j4M2Ngpd8/j3FuvaVW1Kdk0wR3hiE3LdOELDnHlkmQFbf3DWdjU58gV2UVr7dWj6JdOF0yy2suba6V4xbyHupMK3AgoPAD6hDKQxZJj+OXf3Xg2QqQir6pD54C7m5oPp+DlP4CNSR6R5r8O78IAozKSuspHQwQTBC3OSXQNm5on/sqbwpztLmxEX05LX3uy09nA169rifwckr9JYbMLYeKkk8ERqjLG0OmWwWcZk3VyjQlKzp+6k2XEGSG6YzHtRXd2HzwJgXiTrlNqDJZw9gmJzd+qd8jUWBz12KSFdhun52P3AYY5V+5n+5gY6IRSlrEd6CA9LHLSYfPWqQm6eqBYgNGIwISYkf5J02qp0UxzO25rbVZAos5rrdFQcC4orD0d1kpFzO4OkDCFlFJxEiqI8To0ptG3C8Cpe5aSvq+Zme+jYPT49E7NIIAMLbPqKUVmFUHW7+Ij1CbHu97U4/HwLvC5ZxzUe3Ed9LCE+MV4J9kCQyTtuaV1pUM72FtxIMywqUuB5T2CI2lC8dH3bYaHfTrw9dtfG/cCcTYgP6VFBDXCjW6NPsNaUbV01UAfTi1MSKwMkNTYItY3GCDv6qniy0hBigyx8lRP4
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(2616005)(41300700001)(336012)(7696005)(426003)(6666004)(47076005)(186003)(26005)(36860700001)(83380400001)(40460700003)(40480700001)(478600001)(110136005)(4326008)(82310400005)(70586007)(7636003)(356005)(70206006)(316002)(82740400003)(8676002)(5660300002)(8936002)(2906002)(86362001)(2876002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 23:50:13.7891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1d8bd-8778-4865-6419-08db661f9b55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
Received-SPF: softfail client-ip=40.107.95.52; envelope-from=ankita@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Jun 2023 21:07:19 -0400
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

From: Ankit Agrawal <ankita@nvidia.com>

The GPU memory is exposed as device BAR1 to the VM and is discovered
by QEMU through the VFIO_DEVICE_GET_REGION_INFO ioctl. QEMU performs
the mapping to it.

The GPU memory can be added in the VM as (upto 8) separate NUMA nodes.
To achieve this, QEMU inserts a series of the PXM domains in the SRAT
and communicate this range of nodes to the VM through DSD properties.

These PXM start and count are added as object properties and pushed to
the SRAT and DST builder code.

The code is activated only for a set of NVIDIA devices supporting the
feature.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/pci-quirks.c        | 13 +++++++
 hw/vfio/pci.c               | 72 +++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h               |  1 +
 include/hw/pci/pci_device.h |  3 ++
 4 files changed, 89 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f0147a050a..b7334ccd1d 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1751,3 +1751,16 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return 0;
 }
+
+bool vfio_has_cpu_coherent_devmem(VFIOPCIDevice *vdev)
+{
+    switch (vdev->device_id) {
+    /* Nvidia */
+    case 0x2342:
+    case 0x2343:
+    case 0x2345:
+        return true;
+    }
+
+    return false;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ec9a854361..403516ffb3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -42,6 +42,8 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "qapi/visitor.h"
+#include "include/hw/boards.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2824,6 +2826,22 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     }
 }
 
+static void vfio_pci_get_gpu_mem_pxm_start(Object *obj, Visitor *v,
+                                           const char *name,
+                                           void *opaque, Error **errp)
+{
+    uint64_t pxm_start = (uintptr_t) opaque;
+    visit_type_uint64(v, name, &pxm_start, errp);
+}
+
+static void vfio_pci_get_gpu_mem_pxm_count(Object *obj, Visitor *v,
+                                           const char *name,
+                                           void *opaque, Error **errp)
+{
+    uint64_t pxm_count = (uintptr_t) opaque;
+    visit_type_uint64(v, name, &pxm_count, errp);
+}
+
 static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
@@ -2843,6 +2861,53 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static int vfio_pci_nvidia_dev_mem_probe(VFIOPCIDevice *vPciDev,
+                                         Error **errp)
+{
+    unsigned int num_nodes;
+    MemoryRegion *nv2mr = g_malloc0(sizeof(*nv2mr));
+    Object *obj = NULL;
+    VFIODevice *vdev = &vPciDev->vbasedev;
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (!vfio_has_cpu_coherent_devmem(vPciDev)) {
+        return -ENODEV;
+    }
+
+    if (vdev->type == VFIO_DEVICE_TYPE_PCI) {
+        obj = vfio_pci_get_object(vdev);
+    }
+
+    if (!obj) {
+        return -EINVAL;
+    }
+
+    /*
+     * This device has memory that is coherently accessible from the CPU.
+     * The memory can be represented by upto 8 seperate memory-only
+     * NUMA nodes.
+     */
+    vPciDev->pdev.has_coherent_memory = true;
+    num_nodes = 8;
+
+    /*
+     * To have 8 unique nodes in the VM, a series of PXM nodes are
+     * required to be added to VM's SRAT. Send the information about
+     * the starting PXM ID and the count to the ACPI builder code.
+     */
+    object_property_add(OBJECT(vPciDev), "gpu_mem_pxm_start", "uint64",
+                        vfio_pci_get_gpu_mem_pxm_start, NULL, NULL,
+                        (void *) (uintptr_t) ms->numa_state->num_nodes);
+
+    object_property_add(OBJECT(vPciDev), "gpu_mem_pxm_count", "uint64",
+                        vfio_pci_get_gpu_mem_pxm_count, NULL, NULL,
+                        (void *) (uintptr_t) num_nodes);
+
+    ms->numa_state->num_nodes += num_nodes;
+
+    return 0;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
@@ -3151,6 +3216,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->vendor_id == PCI_VENDOR_ID_NVIDIA) {
+        ret = vfio_pci_nvidia_dev_mem_probe(vdev, errp);
+        if (ret && ret != -ENODEV) {
+            error_report("Failed to setup NVIDIA dev_mem with error %d", ret);
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 177abcc8fb..d8791f8f1f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -226,4 +226,5 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
+bool vfio_has_cpu_coherent_devmem(VFIOPCIDevice *vdev);
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..aacd2279ae 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -157,6 +157,9 @@ struct PCIDevice {
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
 
+    /* GPU coherent memory */
+    bool has_coherent_memory;
+
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
-- 
2.17.1


