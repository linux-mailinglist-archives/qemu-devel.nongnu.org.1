Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C280212C
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 07:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9fZW-0000cg-H4; Sun, 03 Dec 2023 01:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZP-0000bD-Hc; Sun, 03 Dec 2023 01:03:12 -0500
Received: from mail-bn8nam12on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::60e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r9fZN-0006Tt-32; Sun, 03 Dec 2023 01:03:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvT+K5/mX+qsyhirbUYKt2l6JHs1jS7fbq6tzAB3M08GUDXlkYrbusy0HTHFNZ2OrKIqCXRfuNbkl6BJYKq2JlnazqCkV8RjZGVdsBwu+lQL9hJJaLN7xLZDsuZQEDFMH/LWE7v2UasSRJmuxiXL7z5oVsFXI7kV5Fn9mprfhySz5qJxk8mb+/Yxfev+pRxeLdpsf3hWLZjBOUmiL59d+UcqTy0CvFy9cbrUIxmvDw0B9qtS3EJG8X54M9O16Ff/k/qbq+prac63Dcq6QoDVeq/MleHntClyBmPX0nKl0lSitirSgmj8A4FQ5NfkFrgnLDy3PhFxVMyKCb2Ai5ZuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqQ7ssj34V4gK8Owvm6uj91vBhL46w+dkL/4Tp752Og=;
 b=ZW30P01VWyIY7PXg7ZOU0bN1IKPBRAXLfw3pXnBubkX2a1MIY5lKIuOQnodZ71xvD7Sww8wpT7jZb5nTshu0jw0UmYVfJZ6tQZm4pZbTnwDwMZ1DQpCsvBWykSNKrcEFo4HosKDEmmGWtKwYe47oczDvpZDmaAN12MnsZ+V8sayNGxh0yNUlgxI+gebIh4nrKVk9tH2fJtnYnBTBt64krzrutp98j1Izd3dIx+B/n9zDUPyA7dwyNefUbS+Ri6Yn/ZIQfkm4cvCksceO50+ys8zyqjMY7kPdecltiSGwIPO6Xhvj9grOj8gh9BZh4ssDQdmsNc49zJ1fdJPxAb0/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqQ7ssj34V4gK8Owvm6uj91vBhL46w+dkL/4Tp752Og=;
 b=P2C7YWrZE0jlIaw9jba6xaGN0bD3rTWRzk32Lw4RG3BXq5lyMiz0NHFITCreNk/QGhfTRXSFF1HZe78kYFV7znj8tQZm8v+Jwg7dOgIdq9J+adCnN6x41UnBVfgaJ8Xuot2ACyXWJ4+F//znXAW8UVcQrP1/UpreGw1NPlZ144jIwi/m2WecPZxLy4F5qUI3+BGOCmf8toE3Q0wgdwodxC9zg0+IvVTYIMr2KjIT8wVR2o6Xu9IW9jpEp+hP+14MIRvM5MbSfdy9q7dhRw6IzB+6oDCI/LKh8JbHFg7bs2dLiBDt+hKAUigogNXGQ1DWLFnU+UieFfghqBuX7UQbcA==
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 06:03:03 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::47) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.30 via Frontend
 Transport; Sun, 3 Dec 2023 06:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Sun, 3 Dec 2023 06:03:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 2 Dec 2023
 22:03:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 2 Dec 2023 22:03:01 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 2 Dec 2023 22:02:54 -0800
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
Subject: [PATCH v5 1/2] qom: new object to associate device to numa node
Date: Sun, 3 Dec 2023 11:32:44 +0530
Message-ID: <20231203060245.31593-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231203060245.31593-1-ankita@nvidia.com>
References: <20231203060245.31593-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bc9687-8e3b-4356-b5ee-08dbf3c5821f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6fYyZlt0vYB2hELIvBFC+wLRjQVb35zAXDc55WYgiFW2/bk/ON4jQbxWQAFH1SlELoqsvIYmGG3Z1NQcynfA2DZVNEqsNq/8DI+oSI7ohPRiNiquVPHfdHUcMTTwQDN4xvInO+C7QdMKoY19fXSobQWHHatPime3iKQMPgdUlnuaUX3RNq4YG3KlRbPGcrc71Wcv7+qcALMPFRLVg0INzNrJeR5q3KunJCY58cGhu7yJBfhwMQbDmKTMMTiTjW1xLWH50KizfN7AzP3nJLrjVjnmUJQqr1zciD0Klwo4lHXx9x5QpWQyuYkBjSnmqd4Flhf9encJ7aSaWNYXwEYVQeLc+0P1XAuC6eoTbxiPYTqU+MQB/kzXlEC6rDFvM26bCW7x6PhtDyA5vTXJklJMzVaf7sVW8fnWniHw3Ynsz5aNxvvpN8nDfS7j1a4g35FIV/QKUU7xTUbAQV3oiTVd+3wtcg7Lac7MB+qOYUVSdfsIBdjL7kHaHHgPnM+t+2ZFn0XkbhTgIcwst6D1dCR9erMeVT5imNy52sWtZEEK3cTKVgaJWdAIgm5riWdUfh++aCQxDLZgsH2+nlXSdHNoyvl10IjlFKTz1ciywXl0KT1/ad66NpzL3StQx+L2E8AqlTid+tdkBy2rBL/5et/tP8n1KNzl+YZcMtL42H7Q23sdAGzx6M7kKC1y/rbCjiaKwQDSFngzJbAB4ZW1Wr/JV3amjucIr7TQshfa0ssCSe4v7KiOzLtARUUrVm6vl83anb8nU+ExQXpSEQfRKPGdH6R+/E/G7zh2zHl6Wi7Pmc=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(110136005)(70586007)(70206006)(54906003)(316002)(478600001)(40460700003)(966005)(6666004)(7416002)(5660300002)(921008)(41300700001)(36756003)(2906002)(2876002)(86362001)(4326008)(8676002)(8936002)(1076003)(2616005)(36860700001)(83380400001)(40480700001)(47076005)(7636003)(356005)(26005)(336012)(426003)(82740400003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 06:03:01.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bc9687-8e3b-4356-b5ee-08dbf3c5821f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::60e;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
supported. The following sample creates 8 nodes and link them to the PCI
device dev0:

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
 hw/acpi/acpi-generic-initiator.c         | 70 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi-generic-initiator.h | 27 +++++++++
 qapi/qom.json                            | 17 ++++++
 4 files changed, 115 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
new file mode 100644
index 0000000000..e05e28e962
--- /dev/null
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi-generic-initiator.h"
+#include "hw/pci/pci_device.h"
+#include "qapi/error.h"
+#include "qapi/qapi-builtin-visit.h"
+#include "qapi/visitor.h"
+#include "qemu/error-report.h"
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
+    bitmap_zero(gi->host_nodes, MAX_NODES);
+    gi->pci_dev = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->pci_dev);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->pci_dev = g_strdup(val);
+}
+
+static void
+acpi_generic_initiator_set_host_nodes(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint16List *l = NULL, *host_nodes = NULL;
+
+    visit_type_uint16List(v, name, &host_nodes, errp);
+
+    for (l = host_nodes; l; l = l->next) {
+        if (l->value >= MAX_NODES) {
+            error_setg(errp, "Invalid host-nodes value: %d", l->value);
+            break;
+        } else {
+            bitmap_set(gi->host_nodes, l->value, 1);
+        }
+    }
+
+    qapi_free_uint16List(host_nodes);
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "host-nodes", "int", NULL,
+        acpi_generic_initiator_set_host_nodes, NULL, NULL);
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
index 0000000000..41b0c8cda2
--- /dev/null
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -0,0 +1,27 @@
+#ifndef ACPI_GENERIC_INITIATOR_H
+#define ACPI_GENERIC_INITIATOR_H
+
+#include "hw/mem/pc-dimm.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
+#include "sysemu/numa.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_dev;
+    DECLARE_BITMAP(host_nodes, MAX_NODES);
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+        ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..efcc4b8dfd 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -794,6 +794,21 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @AcpiGenericInitiatorProperties:
+#
+# Properties for acpi-generic-initiator objects.
+#
+# @pci-dev: PCI device ID to be associated with the node
+#
+# @host-nodes: numa node list
+#
+# Since: 9.0
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { 'pci-dev': 'str',
+            'host-nodes': ['uint16'] } }
+
 ##
 # @RngProperties:
 #
@@ -911,6 +926,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -981,6 +997,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
-- 
2.34.1


