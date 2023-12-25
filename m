Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7981DE24
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 05:57:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHd1A-0007wX-53; Sun, 24 Dec 2023 23:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd17-0007vL-Ts; Sun, 24 Dec 2023 23:56:41 -0500
Received: from mail-sn1nam02on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::60e]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rHd12-0001iO-3o; Sun, 24 Dec 2023 23:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBfTzHOj1ll8u4DiuB8SN2nCNcZ0VdIAg22fU0l0l7dOqIayEc2P+IIFx3KxJt3fXyvEe8QV/iLi0hXUiBDxKrrNskdYzpg0RIwud2dVOUX4ED76GHMbZc2LUX37kmKS1cQQgHXFWHefAZzc5OtxfvhnMyx/+ZOx7s0Hy2/mNHa406Rt2GdpxRVf5uWRM+hpS7mRKjLK0WD1lcPUYKHnMGpokXBCVcSof4dC1cloQpj0NTzuX4iikl5wAVE5e7BgQ7wDrgxc2muhLgjTsAFPAI2Dy7fQS3KUtPL34UsS1i8PmYheBJFMrHA2XqNVPGZDne5fXGChnv5DPuycmeGvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXeJPm6PlSkTN/xUNdpKvL1M9GFbiIOBBz9u5WLRC8I=;
 b=Jn9a+AoOaJ3QQIjsInoLQCufhFrwkhvgACzIkO8VnrEnTXF46PXgXNuNxcEIVKOXrjqmUv76GV46brP0so5mwzZ/KwwkNIsVuPnqtfsYsg1mwxtiXFhmEHbT75PlqmxSA+Jk9rF/sHPVqrIRzDXk/qatBxHX8wiezXXR6Lt4HOpJop6AIQbIetQlL8FL5vEtQMWuB3wpEFvm+f1OJAaPpV9eU/yc3o2iuDUyN85P/9llHgjMCJhBLX1mmGwdHbkgJdzJiRKoX2oDyrxoHbtb4MYNJ6WkcWN4CHzD3ebNfaNyx3+0xXoMBEtEL368ZqWw4qsQcOZDtvPf9zrpa4voDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXeJPm6PlSkTN/xUNdpKvL1M9GFbiIOBBz9u5WLRC8I=;
 b=Jo1cNcNAlasiVXRaDRZ0Q4XAurUT7UvbDF4Rz5nLsNQisZA6+kqcYs3/mRCVpjRV0Oz+EQSirveVUMN3DUFxjAexKqySssUaBfn9cIlXjfIUAN2slbT6WguwHWfR5icQrvJ1mNvI7yXbMOjsX4Yep2HCP/vflZ1iaI2F/y6XKqlRdDYL9c35QLlmIafCjfOgv+Fmz+CMzUjw3yUtyWTWpgPgI8lTRRN+nF+ZsIx89GjPX9xTbmAjPzsU0gBlJ1zvrwgxsSMFZSpV94EWoqnhDG6g70dtUgGRbBznvZNUTnWjjpq7ED32WFhvnfBIn0sDyJxM16yNwidHb2kQlk8viQ==
Received: from BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 04:56:26 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::d1) by BL1PR13CA0199.outlook.office365.com
 (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.16 via Frontend
 Transport; Mon, 25 Dec 2023 04:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Mon, 25 Dec 2023 04:56:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 24 Dec
 2023 20:56:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 24 Dec 2023 20:56:19 -0800
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 24 Dec 2023 20:56:13 -0800
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
Subject: [PATCH v6 1/2] qom: new object to associate device to numa node
Date: Mon, 25 Dec 2023 10:26:02 +0530
Message-ID: <20231225045603.7654-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231225045603.7654-1-ankita@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 89812a94-6ba0-4fdb-818c-08dc0505d985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9gApDOlZ30M7ML3jXIRLyvKpgOruqoEttvJ3QAKm9a+hHuGzGiZJxxVlaQqu3dHhdT/E8605q0VPDLWcTkrK3xc9jgMiRHQkpmMRtr0Jkt0Z0ZCZeCn93IsO46IBMaqDOizFapPuGKTmBXjqcWZVBlNP14myjg6yuPGHI/U8emU3UoJ1jsKTkFAcSc6QsOOlGd+n5EasTbhfRt8j+LdUhpHpRbvcJgNQKNmd4Jc7cyCzzF3KYY0gQ+SZGGDqQqD102cCLMJxqwzH7nFY0KFxe+MhBo0ts5KvqA01b3APgEMoNtMfxn3OF+NFHeze5EvW1UXK4tziYRWa5aasNUIdg1Co19qrtYcMUFyDaYSOFqK7vauMnYiL1yejh2Q7Np/79a8w6lYnlEWyRSNvSYJTrfaaBLBxvhEOev/rYS8O7NXajGbJjNBvOwMFqFLXL8BrCmCAA579CWTMYRzo5H/93DMJFqKKoUQACjcb4ecCoENvAirmNMhO1EKbTgcl/YkkBrAL4dqyQz6iDpbv1RysEbQbuzRnz/Ovf5e1tYBaNHTtvGT1DuUS9J4/XltnhXgD/pEv2UPyoaKflA2RUeLl19rzTBlcKsmvcSfpw6paBZ0vH/VAdr2SGIhnIOLpaf1SJFvxQ0ShCb6cp5UZu+uSl+w3Vwaf1aIKMQV+kymK8ZXKxTzbF8+tBb4zddJSYmc33RNE8A8ZSnSdwJnjJMllT4gxSwQiim5BYzPU0X0z0vdkv+2Ao+kBjkqnkLvpzIJ5J6hxjckaVmPrTEhelTwrADBQncoIVVjsW4O3UrginY=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(26005)(7696005)(2616005)(83380400001)(336012)(426003)(86362001)(8936002)(40480700001)(316002)(54906003)(70206006)(8676002)(70586007)(4326008)(6666004)(110136005)(966005)(478600001)(7636003)(82740400003)(921011)(47076005)(36860700001)(356005)(40460700003)(7416002)(2876002)(41300700001)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 04:56:26.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89812a94-6ba0-4fdb-818c-08dc0505d985
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::60e;
 envelope-from=ankita@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.594,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.979, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
use this object to build the requisite GI Affinity Structure. On a multi
device system, each device supporting the features needs a unique
acpi-generic-initiator object with its own set of NUMA nodes associated to it.

An admin can provide the range of nodes through a uint16 array host-nodes
and link it to a device by providing its id. Currently, only PCI device is
supported. The following sample creates 8 nodes per PCI device for a VM
with 2 PCI devices and link them to the respecitve PCI device using
acpi-generic-initiator objects:

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,host-nodes=2-9 \

-numa node,nodeid=10 -numa node,nodeid=11 -numa node,nodeid=12 \
-numa node,nodeid=13 -numa node,nodeid=14 -numa node,nodeid=15 \
-numa node,nodeid=16 -numa node,nodeid=17 \
-device vfio-pci-nohotplug,host=0009:01:01.0,bus=pcie.0,addr=05.0,rombar=0,id=dev1 \
-object acpi-generic-initiator,id=gi1,pci-dev=dev1,host-nodes=10-17 \

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
index 0000000000..9643b81951
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
index c53ef978ff..7b33d4a53c 100644
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
+# @host-nodes: numa node list associated with the PCI device.
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


