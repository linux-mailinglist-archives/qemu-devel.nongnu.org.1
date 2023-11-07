Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EACD7E48F0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RKa-0006Hq-43; Tue, 07 Nov 2023 14:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKW-0006GM-Hn; Tue, 07 Nov 2023 14:01:40 -0500
Received: from mail-dm6nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::611]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r0RKT-0004H1-AL; Tue, 07 Nov 2023 14:01:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB33jYjq9XF8Z3F2wYyVPo3W8bIL0irCEoZDdr6KewT8QUwbqLOlPe/5mqJnn0DpsZcbMTVyqZviqc6bnb17yEsfI9ZgXU76OWr3qoM8CChwqplxJgZOv5cQTUhR9zNaPh3jDvCklasT/KpQyu/Ly7vyWQU7xQdL2Th/G7zaVjxiEfkDzm+qMXDM7nsSjstegYJtjS5myhjHX7/6OD/PaKqeQxfC9m4YOyN2l/Uhc9uhAUdDDlzunorgJZehShrq1c7XymNvz4nImQ8ZnZneDtCwrr3RayONQh3XzejLLk7nPI3QqICpf1gMV14/26HvZ7E9rttuu4MDisjoxQDp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2uvUl3bjuStgQrWUWhOtEdZmuTFQMKbydC0g8BuXBw=;
 b=UfIMrul9rz5eKCQ51l1pxMFfuH/sCKyC/YXI51z+l/MSH6YSdtioBC3DVO/DI+UCjxpoToyoSGdiSi6nGnPh5qn9TAwC7o9wgEmYNuXEH+piKPVeaH91GyuHRzqPrpO0FKoHWKGVjNmN1ozjOd3LFSy5tik0jJLCzMiLHNrP2w+ZJz7YVygGnfQOU5/fRugqzBLCTZqHOJw0SC34yIU5vxE7bEHz7zQ9kRzQ4Gdfoy3p7UblJGf4W1vWTYJeyGT+9m5pSaRF2zDHlj4eAsfTWVNYrO9tRh1Tas6KSpX81Kek5BFLh/0DFUGgWPY+4Lg4f18FBE9Hf5lWnR/sv5UGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2uvUl3bjuStgQrWUWhOtEdZmuTFQMKbydC0g8BuXBw=;
 b=SxOHbTAMpqq3fffKi4z9kd+qwTB2R+BfpKBHX/5H2uY+30v2hROtWFmZgDz5fHLjND19RUop0QDlLduM8GlVJ37MC8p9c0M0WJTVtWqcc54pZlKCokLppR31il6shdK0OAKFDhJz5625aNpxPiBKw6KolaXfl7piZGoXUd1Lb+sFJokFYzcpfLSdax5WJa0Q531iK2FgHLERy+LlzfszXCVP4l7XiZm09XBYE0lHsSOKaxcNECJgyzrb0XtdOKzheS4x/jp5nVLT8HUOLbfcUgp3zP8hXKsciyPBNXw7rhH15sgMKnfKBXije0nlfjs6EUNXGxdu+EWlcsUf/8X1BA==
Received: from MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:01:20 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::97) by MN2PR11CA0006.outlook.office365.com
 (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 19:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:00:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 11:00:57 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 11:00:50 -0800
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
Subject: [PATCH v3 1/2] qom: new object to associate device to numa node
Date: Wed, 8 Nov 2023 00:30:38 +0530
Message-ID: <20231107190039.19434-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231107190039.19434-1-ankita@nvidia.com>
References: <20231107190039.19434-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: d5927039-2272-443e-7c11-08dbdfc3ed30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5Ei29YoNxo2hdMT3Cb74AvPRYCwnlFt6+AVHlTTuzVLQ6RZ9GmjPqXcR+8A8Dlac3elUqRznRrdZ/keVeizMC7/U2/kaiFcG9TvgD7gPMSgAyZbkNZg+VtxMWuhzGYHbWhJpBBN0nkNANR+5uL1vBYQpa0s2fgcZQ9fkPaZrrOfF9wpyUq8S4P9lsNfrTcUfI4uIQLgIlUUJLnQ2L+l1qMlpdm/k4zYtUPYOQdVuQjA5eMuK234ay7cS5jg6HfB8uLsPSBNYeQMfdAwr4IiY5VoJobpGdOZZ2GBDBP2D2MhXIa/IikmX87sSrFdKbMee1Mp36KbtPvYH2C6FIjJ8as8IGD7AwtKK1kABdaqhpF2Q/PABBr6nuaW8Bexh56jAA+23OXGMHcAs8uyyk7nROBrZn9ptDWwyNpMOAAYHNjmXOphjy7kOh9N0+LEJL39zBL58EMr0as35HzFziPDn6PuHSWeIB/aX2lg/FHEd9G64WpLsOogzNPSStMmPyiKwfRIgK7XVk3XIApCxQdF/4t1FrU7LF8KBWtSRaItLHUvMVh+Ws7Yhalf17aw6twx0o+8Mte4IjFDFhlpGBEGksouokiDZF+aovit6AsaBl6w7KZYP1iRh5sgre5hZ5TX084jgvWsPnaNv9H2W5D0iprrdr9n6bPF5V/SmQ262oxovpyDOUGVBsdpiOl1wX58zgTmA6ShMAg4oMHpSoibS71lu62vbRZXT+306zh8mUlWdDWfc6RUuFbnDhjVK7DS44hHfqDuGi2hSEqyi/Tldxu2B7/1enoL16fByv9tKHE=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(47076005)(2876002)(26005)(336012)(2906002)(40460700003)(83380400001)(426003)(7636003)(356005)(82740400003)(36860700001)(41300700001)(8676002)(921008)(8936002)(966005)(4326008)(6666004)(478600001)(86362001)(7696005)(70206006)(70586007)(316002)(54906003)(110136005)(7416002)(40480700001)(2616005)(5660300002)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:01:19.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5927039-2272-443e-7c11-08dbdfc3ed30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
Received-SPF: softfail client-ip=2a01:111:f400:fe59::611;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

An admin can provide the range of nodes using a ':' delimited numalist and
link it to a device by providing its id. The node ids are extracted from
numalist and stores as a uint16List. The following sample creates 8 nodes
and link them to the device dev0:

-numa node,nodeid=2 \
-numa node,nodeid=3 \
-numa node,nodeid=4 \
-numa node,nodeid=5 \
-numa node,nodeid=6 \
-numa node,nodeid=7 \
-numa node,nodeid=8 \
-numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,device=dev0,numalist=2:3:4:5:6:7:8:9 \

[1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 80 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi-generic-initiator.h | 29 +++++++++
 qapi/qom.json                            | 16 +++++
 4 files changed, 126 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
new file mode 100644
index 0000000000..0699c878e2
--- /dev/null
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
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
+static void acpi_generic_initiator_set_device(Object *obj, const char *val,
+                                              Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->device = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_nodelist(Object *obj, const char *val,
+                                            Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    char *value = g_strdup(val);
+    uint16_t node;
+    uint16List **tail = &(gi->nodelist);
+    char *nodestr = value ? strtok(value, ":") : NULL;
+
+    while (nodestr) {
+        if (sscanf(nodestr, "%hu", &node) != 1) {
+            error_setg(errp, "failed to read node-id");
+            return;
+        }
+
+        if (node >= MAX_NODES) {
+            error_setg(errp, "invalid node-id");
+            return;
+        }
+
+        QAPI_LIST_APPEND(tail, node);
+        nodestr = strtok(NULL, ":");
+    }
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_DEVICE_PROP, NULL,
+                                  acpi_generic_initiator_set_device);
+    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_NODELIST_PROP,
+                                  NULL, acpi_generic_initiator_set_nodelist);
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
index 0000000000..bb127b2541
--- /dev/null
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -0,0 +1,29 @@
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
+#define ACPI_GENERIC_INITIATOR_DEVICE_PROP "device"
+#define ACPI_GENERIC_INITIATOR_NODELIST_PROP "nodelist"
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
index fa3e88c8e6..66d2bffdcc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -779,6 +779,20 @@
 { 'struct': 'VfioUserServerProperties',
   'data': { 'socket': 'SocketAddress', 'device': 'str' } }
 
+##
+# @AcpiGenericInitiatorProperties:
+#
+# Properties for acpi-generic-initiator objects.
+#
+# @device: the ID of the device to be associated with the node
+#
+# @nodelist: delimited numa node list
+#
+# Since: 8.2
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { 'device': 'str', 'nodelist': 'str' } }
+
 ##
 # @RngProperties:
 #
@@ -896,6 +910,7 @@
 ##
 { 'enum': 'ObjectType',
   'data': [
+    'acpi-generic-initiator',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -966,6 +981,7 @@
             'id': 'str' },
   'discriminator': 'qom-type',
   'data': {
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
-- 
2.17.1


