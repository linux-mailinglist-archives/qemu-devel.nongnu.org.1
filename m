Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549477F0640
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 14:03:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4hRH-0005vv-PZ; Sun, 19 Nov 2023 08:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r4hQv-0005u5-4u; Sun, 19 Nov 2023 08:01:54 -0500
Received: from mail-mw2nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::620]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r4hQr-0006f4-0F; Sun, 19 Nov 2023 08:01:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJeD4vMvDw7MM5OczNlLGPwmS+TSZSP5uDEFJ05vXCsK+y4UiFsAoWSQ1EW7MyMhd6EU5/8iENAIlCz38ZU4+XI0wvVAQM0PsTEqmASBhddnaHXFSFd6OOErAeJYwfuAzPPoPInguy2USV+N+ZvQv9UElz+MPJaGEd0HqCy7EhCYN2mqCsShRmIwNM49LE2IbspbPLhvFlEZmeMrhthVUHpb8D0N53HkXO8EIEUXR/nF00VhxPZkZqk0d8T5yV2NfjThFGTfmfNDVuOdTKLu3JxgqTD6KmRMCstjWOVLk9BVoKFxDqAEj6YxT+UPJ/6f5XGbeRWKo5BSPbPuMMT8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jResKhJ8wnSxvF0QME9Sbjj21BkUWrlyyXjyZo04xDA=;
 b=hvaO2GgaZ+4HMaVF3y3MBXEI9aYQ3AuGe24e/peEH3T3SxKeftymQw7TTEX7iRiPfV1zVngYm8GrWBibFZhjBhsws9E11RxA0nNxHcukBXy1x43s2lDecLAxeRxHcuuPYhT3TWbWKUhY5Ef01fxmCTCLubr1bjvgQyESOwHc9wllczVeSAnuZRL4Fbbxa813xqyhFn59O5lYylxdsh/oh05DFp7HZ8Xc+cvDUBh0xFelWthSMgMUIjadeCOU+fPCOeIyUwC9aejwN8O1j59oSggIsuTq1gf+wOQukeX6sJKzF1+74DrivPSAQkxdVAaPyuzWRlCs0CpqeKOU8gmsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jResKhJ8wnSxvF0QME9Sbjj21BkUWrlyyXjyZo04xDA=;
 b=FScJraT9ICCc2mBF/9NL0yER8r0H32RCRheLNGC0dPd81Mf+CClu4i4VX9UthPPGFiiPMJHQ7Ml19o6iZ267FbVq6khzDvR1DFBXWvgEthRWZ5+iHEGBpP6cpgOyBnGG31dxqG4HKWKX4Gge3986CuO/W2M/1HVHFN+BK0/qoWNSdg1jhdTUqABx+5Q9TqSrmmiu76DwZAcbAKLctFjP+9+5IrCXLzFFbdylT6t7OWaZZRCWOVRgDVYrm+SrooZPFUlWYOKGUOHXTheCKYMLNMQkaW2Ugkd62owBgE6d5LgdIXWdaIdss9GDlH2iNFeCxIZaHQoE8leYdh/qsLgX0w==
Received: from CYXPR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:cf::20)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 13:01:43 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::6c) by CYXPR02CA0014.outlook.office365.com
 (2603:10b6:930:cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sun, 19 Nov 2023 13:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Sun, 19 Nov 2023 13:01:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 19 Nov
 2023 05:01:29 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 19 Nov
 2023 05:01:28 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 19 Nov 2023 05:01:21 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <mst@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <david@redhat.com>, <gshan@redhat.com>,
 <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/2] qom: new object to associate device to numa node
Date: Sun, 19 Nov 2023 18:31:10 +0530
Message-ID: <20231119130111.761-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231119130111.761-1-ankita@nvidia.com>
References: <20231119130111.761-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dc48fa-27b5-4c1a-186f-08dbe8ffad0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8S+n3qaEB3Rbpo0Rlk/z5duscZvxHgh3uIbOSEzenQ+EeuD5Or4ai1XlLbqkCRaa2/lo8jnxcXJOMGS1yWaKxVbAhvmdFgS6lYDaVrCAQsjj8oSHeKS8wYZ0V/W/Js8+8NG+6EC9AGrlDOFk+w6CUOztPRbImhxluFRaqNXi14tX9g4DYZlaSDn6uGFHtIwIBu32mNmfXy27wdLCVuo4oAxwJccNEX26epfvx2DYOv3GNhCjazEx7P/MEjyaExWdwUk7CWVd0Mx8P6Ah0M7dKi8Ya/b5u4zhJHd+xkgfXqzPPYdiPrlly1H9pjfmxEOEaGnYSR1e90DOulg6c1cBVo+k9+2fQ1/a1AXBlu+1Zi8NwmoJTqRV742T+5ALTmWFNUXi0H2vCZKb7gb3zdd6YGano0otm1CEzIva6iWrkkg74Yudk7JLUwykyew1u99nzVuJpKuHVSw1caAJpvKJ7o1aFejOVYxy+Cu0rCv3zIchjy2cf57ZNZWMzb9iANjBfdw50xT0zc9V0LEENRJvpSA534SREY0eHTjY9U48vY+I6UFBU8MhujlpzKsMyc9FZ072OzBTWok76arVlRjqN580VWX2wdynSQZKYQaJaaiqbjePLeHRIX6EG6szYRAqPrJliO2sXjTJtwe83FcdfnVSGCwp2ea2NdxxlWErQVPDNVchAXIwcfPuMOHZ/15tIVCPmHbIl4dksj5xL3o4p8qA1DEoHU/nmGpP738VUkLzA4Gb8pztVJRyo/uqevLAwtoKG1ni7aMzsqIx0NlqESiVw/2IIcfgVCFmFtIxqCk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(8676002)(4326008)(8936002)(7416002)(26005)(36756003)(82740400003)(2876002)(70586007)(6666004)(2906002)(316002)(54906003)(110136005)(86362001)(5660300002)(478600001)(70206006)(966005)(7696005)(2616005)(356005)(7636003)(36860700001)(40460700003)(47076005)(1076003)(921008)(83380400001)(41300700001)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 13:01:41.9272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dc48fa-27b5-4c1a-186f-08dbe8ffad0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
Received-SPF: softfail client-ip=2a01:111:f400:7e89::620;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
partitioning of the GPU device resources (including device memory) into
several (upto 8) isolated instances. Each of the partitioned memory needs
a dedicated NUMA node to operate. The partitions are not fixed and they
can be created/deleted at runtime.

Unfortunately Linux OS does not provide a means to dynamically create/destroy
NUMA nodes and such feature implementation is not expected to be trivial. The
nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
we utilize the Generic Initiator Affinity structures that allows association
between nodes and devices. Multiple GI structures per BDF is possible,
allowing creation of multiple nodes by exposing unique PXM in each of these
structures.

Introduce a new acpi-generic-initiator object to allow host admin provide the
device and the corresponding NUMA nodes. Qemu maintain this association and
use this object to build the requisite GI Affinity Structure.

An admin can provide the range of nodes through a uint16 array host-nodes
and link it to a device by providing its id. Currently, only PCI device is
supported and an error is returned for acpi device. The following sample
creates 8 nodes and link them to the PCI device dev0:

-numa node,nodeid=2 \
-numa node,nodeid=3 \
-numa node,nodeid=4 \
-numa node,nodeid=5 \
-numa node,nodeid=6 \
-numa node,nodeid=7 \
-numa node,nodeid=8 \
-numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \

[1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 84 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi-generic-initiator.h | 30 +++++++++
 qapi/qom.json                            | 18 +++++
 4 files changed, 133 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
new file mode 100644
index 0000000000..5ea51cb81e
--- /dev/null
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qapi/qapi-builtin-visit.h"
+#include "qapi/visitor.h"
+#include "qom/object_interfaces.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/pci.h"
+#include "hw/pci/pci_device.h"
+#include "sysemu/numa.h"
+#include "hw/acpi/acpi-generic-initiator.h"
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
+
+static void acpi_generic_initiator_init(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    gi->device = NULL;
+    gi->nodelist = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->device);
+    qapi_free_uint16List(gi->nodelist);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->device = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_acpi_device(Object *obj, const char *val,
+                                                   Error **errp)
+{
+    error_setg(errp, "Generic Initiator ACPI device not supported");
+}
+
+static void
+acpi_generic_initiator_set_host_nodes(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint16List *l;
+
+    visit_type_uint16List(v, name, &(gi->nodelist), errp);
+
+    for (l = gi->nodelist; l; l = l->next) {
+        if (l->value >= MAX_NODES) {
+            error_setg(errp, "Invalid host-nodes value: %d", l->value);
+            qapi_free_uint16List(gi->nodelist);
+            return;
+        }
+    }
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_PCI_DEVICE_PROP,
+                                  NULL, acpi_generic_initiator_set_pci_device);
+    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_ACPI_DEVICE_PROP,
+                                  NULL, acpi_generic_initiator_set_acpi_device);
+    object_class_property_add(oc, ACPI_GENERIC_INITIATOR_HOSTNODE_PROP, "int",
+        NULL,
+        acpi_generic_initiator_set_host_nodes,
+        NULL, NULL);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379..2268589519 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,5 +1,6 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
+  'acpi-generic-initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
new file mode 100644
index 0000000000..db3ed02c80
--- /dev/null
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -0,0 +1,30 @@
+#ifndef ACPI_GENERIC_INITIATOR_H
+#define ACPI_GENERIC_INITIATOR_H
+
+#include "hw/mem/pc-dimm.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "qemu/uuid.h"
+#include "hw/acpi/aml-build.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+#define ACPI_GENERIC_INITIATOR_PCI_DEVICE_PROP "pci-dev"
+#define ACPI_GENERIC_INITIATOR_ACPI_DEVICE_PROP "acpi-dev"
+#define ACPI_GENERIC_INITIATOR_HOSTNODE_PROP "host-nodes"
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *device;
+    uint16List *nodelist;
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+        ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..f726f5ea41 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,22 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @AcpiGenericInitiatorProperties:
+#
+# Properties for acpi-generic-initiator objects.
+#
+# @pci-dev: PCI device ID to be associated with the node
+#
+# @acpi-dev: ACPI device ID to be associated with the node
+#
+# @host-nodes: numa node list
+#
+# Since: 8.2
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { '*pci-dev': 'str', '*acpi-dev': 'str', 'host-nodes': ['uint16'] } }
+
 ##
 # @RngProperties:
 #
@@ -911,6 +927,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -981,6 +998,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
-- 
2.34.1


