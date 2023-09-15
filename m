Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1207A13F5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 04:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgyqb-0007Lz-O7; Thu, 14 Sep 2023 22:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqU-0007Kr-AD; Thu, 14 Sep 2023 22:46:14 -0400
Received: from mail-sn1nam02on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::60a]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qgyqR-0001Um-Be; Thu, 14 Sep 2023 22:46:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEXFshB/v/QJwcxCvK0OsfnzzbUTtytF4763U28UMYo8zFAMz5sP1qK8anpIeDI1tScZdJ/JCaXXnoQxwm9ERCtbBHxJx+FCpPR/M3I8geO3XYaLsZtw7LVO0pHQ5KXIiYCVsAbKBB6FNhzlUBKCsGcpATIDunztwBWzoa/bGjSuLNfE6lSMZ4xmTE869ktLg2E8IRotdbu/ySLqRCbJrrNFgoXEDkFH02MZ5vB9IC0SUz3Qp01jLvM/y9c5KOW6bSHORqmk9bMDVv3fNwMWXj7KGDURnZsBfjFUgA7QF0DQl5y2SlL8pcTGyrf8cHVEnHA/FrKUj6kAv2s203pnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wb+fDgWUHVWN492avgFz7D0P7TzZZRyrDY7sVUaidA=;
 b=nZVMzWEdXQCJu7oWNPxAJ3CwedVr2hUrQIkBCC2O7DTJSxf6XhksWvLD8247gpdQDf7xx5Me2qFhVoe24988jTxcHD/jYY1DKoNts9HW194CckRMmNw51syoOahyn8A8g79VyfNiBDlhYuZgtUimdSHUzZDdqiNabrhUKc0rLg70buA2boo0Z7BE3nXS3XpuC1Fk34CK2d6sHIIczy0sO3su76h7VPGWsDH7dhOiq1htisKbg4zeeL9TgxW5oaCQmE6XS84KAhX2X5T4xrOk5gUvzYn3rRNE4mYqvbS89HE/E7hz0aCOUkWbBVUZMDM27//+KHLbQWyt0Xf1XEwkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wb+fDgWUHVWN492avgFz7D0P7TzZZRyrDY7sVUaidA=;
 b=a85JsVjcq6fP8wDH6LJqCBzO0IbK9V0mbw2DnfjY8dyuVvMZ2m2MnMEE6JyTL/ze7cAcfwGvX9sEsuqh9NDQutDr6/3lf3fLh0Ca2rhBV2Xc8AEVO7ht48mvKne6OT2lLoWXq8RVhVt/2tUxSDmtWdOtuhWKbe7h8wqXnZENqhcTCj3+HKlq2iosxJ4bIl12+CnPkPwWgF9KcT/o1loQGACzmEusAso1NUEY1PSxCi3NngFYUauo9vBjB8wsoolOntOmStTeNuWPCWrpp6ePhWJ/EgUcx2Gc+SyRn7Kq3LO77fAHqMDOBb3YKi8PW3IRa2cyhUZxT73Qvb7+Mzz9Zg==
Received: from MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 02:46:04 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::b8) by MW4P223CA0005.outlook.office365.com
 (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 02:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 02:46:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 19:46:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 14 Sep 2023 19:46:00 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Sep 2023 19:46:00 -0700
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 1/4] vfio: new command line params for device memory NUMA
 nodes
Date: Thu, 14 Sep 2023 19:45:56 -0700
Message-ID: <20230915024559.6565-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915024559.6565-1-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d2a141-cac7-4e47-bef2-08dbb595e74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09zunvNbk9AF92eWojs46+9ZWNDpRCXuIOyuJixuvCqsLXNpgVN+mwlbp65TCcN8WzZlpMaK4HJTvp1T53I5iyT5BPlzWmouZaSnj63XpZJCBqi5dkqtNVLSlE9PDEKbATuJujb9rl5aRRFZktOupPNjpP4exaiAwbygN/71BG4uEKIJANIuhnpBQE97mpCkqYgHHX3oOfAi0cgCZjBWRf3AFbzuXt6nuZ43sx0HSA+h0dr8RIujdmty43KFyPeRwLS0r1pRyeinGpKJi5c/slVq11ZhvcEBIkxWX8SVOJPuFY0oCM2RJ5vo+BW+D1zwccCbet0LId1Nwf56oBv2TQdag/lO1l+BNZ1Ry6PNa2wb5Azu2dTdTfTB1uF79SptKukG+1CYJRM21mhfuSLwxsv7DOEQ9WuvasK2k4WRyUKCD6U2EfYqua+Yo53E9I/0aiiQWSe3sXo/yMRV1jeStFknjpSE1jeiM6DheBHXZ1iK6x2C5rdCZwmgaT+MnZylQGWLgElPbExioj0701htnlQGje8dGEZHIknu/hABGqxU3aBj+jHEbcxiHQVvxABjq/oWqbXLNhH8F4wbyTuQgBT9rOSdwXMlJ5eRhEiRhWUK8KKPBEJPaaWvNy+WaqPc/bL5XIB9fqbFsFfFPfx52MtHs6DhwgXx21fatIg6wViKAZ7cFZ2JwZFK+3OOuNzVQHsF3YcYBCmRUavhvtF9qPW19y3wTWpdOUMh7wwwrUDOk1Gk9SXpzC8K/j1OkZc6
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(41300700001)(36756003)(110136005)(7636003)(316002)(2876002)(82740400003)(8676002)(8936002)(40480700001)(2906002)(70206006)(70586007)(4326008)(356005)(54906003)(426003)(336012)(6666004)(5660300002)(83380400001)(7696005)(1076003)(86362001)(26005)(2616005)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:46:03.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d2a141-cac7-4e47-bef2-08dbb595e74b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::60a;
 envelope-from=ankita@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ankit Agrawal <ankita@nvidia.com>

The CPU cache coherent device memory can be added as a set of
NUMA nodes distinct from the system memory nodes. The Qemu currently
do not provide a mechanism to support node creation for a vfio-pci
device.

Introduce new command line parameters to allow host admin provide
the desired starting NUMA node id (pxm-ns) and the number of such
nodes (pxm-nc) associated with the device. In this implementation,
a numerically consecutive nodes from pxm-ns to pxm-ns + pxm-nc
is created. Also validate the requested range of nodes to check
for conflict with other nodes and to ensure that the id do not cross
QEMU limit.

Since the QEMU's SRAT and DST builder code needs the proximity
domain (PXM) id range, expose PXM start and count as device object
properties.

The device driver module communicates support for such feature through
sysfs. Check the presence of the feature to activate the code.

E.g. the following argument adds 8 PXM nodes starting from id 0x10.
-device vfio-pci-nohotplug,host=<pci-bdf>,pxm-ns=0x10,pxm-nc=8

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/vfio/pci.c               | 144 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h               |   2 +
 include/hw/pci/pci_device.h |   3 +
 3 files changed, 149 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a205c6b113..cc0c516161 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -42,6 +42,8 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "qapi/visitor.h"
+#include "include/hw/boards.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2955,6 +2957,22 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     }
 }
 
+static void vfio_pci_get_dev_mem_pxm_start(Object *obj, Visitor *v,
+                                           const char *name,
+                                           void *opaque, Error **errp)
+{
+    uint64_t pxm_start = (uintptr_t) opaque;
+    visit_type_uint64(v, name, &pxm_start, errp);
+}
+
+static void vfio_pci_get_dev_mem_pxm_count(Object *obj, Visitor *v,
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
@@ -2974,6 +2992,125 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static int validate_dev_numa(uint32_t dev_node_start, uint32_t num_nodes)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int i;
+
+    if (num_nodes >= MAX_NODES) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < num_nodes; i++) {
+        if (ms->numa_state->nodes[dev_node_start + i].present) {
+            return -EBUSY;
+        }
+    }
+
+    return 0;
+}
+
+static int mark_dev_node_present(uint32_t dev_node_start, uint32_t num_nodes)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int i;
+
+    for (i = 0; i < num_nodes; i++) {
+        ms->numa_state->nodes[dev_node_start + i].present = true;
+    }
+
+    return 0;
+}
+
+
+static bool vfio_pci_read_cohmem_support_sysfs(VFIODevice *vdev)
+{
+    gchar *contents = NULL;
+    gsize length;
+    char *path;
+    bool ret = false;
+    uint32_t supported;
+
+    path = g_strdup_printf("%s/coherent_mem", vdev->sysfsdev);
+    if (g_file_get_contents(path, &contents, &length, NULL) && length > 0) {
+        if ((sscanf(contents, "%u", &supported) == 1) && supported) {
+            ret = true;
+        }
+    }
+
+    if (length) {
+        g_free(contents);
+    }
+    g_free(path);
+
+    return ret;
+}
+
+static int vfio_pci_dev_mem_probe(VFIOPCIDevice *vPciDev,
+                                         Error **errp)
+{
+    Object *obj = NULL;
+    VFIODevice *vdev = &vPciDev->vbasedev;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int ret = 0;
+    uint32_t dev_node_start = vPciDev->dev_node_start;
+    uint32_t dev_node_count = vPciDev->dev_nodes;
+
+    if (!vdev->sysfsdev || !vfio_pci_read_cohmem_support_sysfs(vdev)) {
+        ret = -ENODEV;
+        goto done;
+    }
+
+    if (vdev->type == VFIO_DEVICE_TYPE_PCI) {
+        obj = vfio_pci_get_object(vdev);
+    }
+
+    /* Since this device creates new NUMA node, hotplug is not supported. */
+    if (!obj || DEVICE_CLASS(object_get_class(obj))->hotpluggable) {
+        ret = -EINVAL;
+        goto done;
+    }
+
+    /*
+     * This device has memory that is coherently accessible from the CPU.
+     * The memory can be represented seperate memory-only NUMA nodes.
+     */
+    vPciDev->pdev.has_coherent_memory = true;
+
+    /*
+     * The device can create several NUMA nodes with consecutive IDs
+     * from dev_node_start to dev_node_start + dev_node_count.
+     * Verify
+     * - whether any node ID is occupied in the desired range.
+     * - Node ID is not crossing MAX_NODE.
+     */
+    ret = validate_dev_numa(dev_node_start, dev_node_count);
+    if (ret) {
+        goto done;
+    }
+
+    /* Reserve the node by marking as present */
+    mark_dev_node_present(dev_node_start, dev_node_count);
+
+    /*
+     * To have multiple unique nodes in the VM, a series of PXM nodes are
+     * required to be added to VM's SRAT. Send the information about the
+     * starting node ID and the node count to the ACPI builder code.
+     */
+    object_property_add(OBJECT(vPciDev), "dev_mem_pxm_start", "uint64",
+                        vfio_pci_get_dev_mem_pxm_start, NULL, NULL,
+                        (void *) (uintptr_t) dev_node_start);
+
+    object_property_add(OBJECT(vPciDev), "dev_mem_pxm_count", "uint64",
+                        vfio_pci_get_dev_mem_pxm_count, NULL, NULL,
+                        (void *) (uintptr_t) dev_node_count);
+
+    ms->numa_state->num_nodes += dev_node_count;
+
+done:
+    return ret;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
@@ -3291,6 +3428,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    ret = vfio_pci_dev_mem_probe(vdev, errp);
+    if (ret && ret != -ENODEV) {
+        error_report("Failed to setup device memory with error %d", ret);
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3454,6 +3596,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
+    DEFINE_PROP_UINT32("pxm-ns", VFIOPCIDevice, dev_node_start, 0),
+    DEFINE_PROP_UINT32("pxm-nc", VFIOPCIDevice, dev_nodes, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a2771b9ff3..eef5ddfd06 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -158,6 +158,8 @@ struct VFIOPCIDevice {
     uint32_t display_yres;
     int32_t bootindex;
     uint32_t igd_gms;
+    uint32_t dev_node_start;
+    uint32_t dev_nodes;
     OffAutoPCIBAR msix_relo;
     uint8_t pm_cap;
     uint8_t nv_gpudirect_clique;
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


