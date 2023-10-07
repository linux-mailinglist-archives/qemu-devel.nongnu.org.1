Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6E7BC9BD
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 22:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpDl6-0001Yu-7i; Sat, 07 Oct 2023 16:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDl2-0001YE-RA; Sat, 07 Oct 2023 16:18:40 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDkx-0005L4-08; Sat, 07 Oct 2023 16:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3RzZTBcTu7wgtOrY2GqZ9HtrdDx9+rgqGHxXNWooh+A6KWe0SoZ9w6pjco7EckvW73klEgFWFv02HrFnQxwsxwmzdKepMxB9hHzc0fMVmSg6RTQqkOfWBk7AwTz9H9tLwSUDYXl2KEWDA1OCQ9dIdE6Kqh4pJisc+OBTutLc7h6iChr7ZTQkFrMMzmlvUPUgFPU0RWV1jjcs8qEEDCl7cGGWoQu9TaiEzcQTC2Ih8OKMWXYoDbk3WT9/RMhyTws29YCei6+FV589WyZBrJMq9zVJXl71q+OQsgMy9OHJiB4Ab/RBUYx5IvKGi295yjqSqtuCyDzyWRT6BRACV5m7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PccgJ8wsn3Bj8I/m52cx/oLKIkdJ094X2846ZnrExIk=;
 b=QEi5gbNwLWGFv8mxAsONPg4273spaNndSCravS55aUFrx4266BOHM7szdKwevp8GeZgawasZpUSlZvEQ2nZhB/qF1iP81381mw4PqpTHCy7AHxS2Ii6OAr+nwt0QKhHqc0jEq4jh9xh0UuzrhezCya9Ii2JJsuPvrnwnPYIoAcbWECAotvQ8oW8Ulmm/rCH6iupbPn4mbXNOxpsPwNob3ijTqzforQwraQDlJv2dB3TorqMm+IYa0pkBzlNnHiukF6BWYnWqA9pepYXJER9ihqnFPEqEUbdTiYU6+Ws9way+Jsb59UbfpOGpZkGwtyD7mx+xQbpnCy2Pas/SkHS6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PccgJ8wsn3Bj8I/m52cx/oLKIkdJ094X2846ZnrExIk=;
 b=AnSwQDLWI60CUUahKdGKSOBj+Bh4h7dVxkhdlyU/uoAq7xrneWIvBMwu2opBsgZHZf8UFBT6ZyGntYpHOYlz+LosxGnNx3M1naYv5Fd9zY99PuRzXlkkrUV7h+n8TpF3AAAwNC6Y+qfgannhXL6zvEixrC2p8roRhyExPY2hZwVGfRK78cEcho4RdAK9BHfqHoEH4gXG76ywbKDHZ1F1tQN9aU0h3WI8henbIci5+1MQRxhsmIIyQjrILcDGhXsbklmr6A9GBSZPl/nCF7Wgts0GNgyg8JFyuVN0z6Dc+1sptSWEGSDb6BZOLWo5QjSGzbFiSv2heyrcBWDi3XrJFQ==
Received: from PH8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:510:2d2::11)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sat, 7 Oct
 2023 20:18:30 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::86) by PH8PR15CA0018.outlook.office365.com
 (2603:10b6:510:2d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.34 via Frontend
 Transport; Sat, 7 Oct 2023 20:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 20:18:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 7 Oct 2023
 13:18:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 7 Oct 2023 13:18:11 -0700
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 7 Oct 2023 13:18:04 -0700
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
Subject: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a new
 object
Date: Sun, 8 Oct 2023 01:47:40 +0530
Message-ID: <20231007201740.30335-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231007201740.30335-1-ankita@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8ddff0-4101-4dcd-a66e-08dbc77291e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jKsTpbBTZ0wjGde6xDvef8r8jt3SBBJwcwP+pYOhDvZ+ZGGYVfA9DI1FbfK71bd291F2mp/AdoXRkk3v5a3IQWlLuTIF8gtHsStEf2vNV1/CmxyNODSC3CHvzeUVAFdKSjwl0M9FZ0StpjuaeaSuketm5T6WWYN6tiEkZx8CKxZgrJzHDnhOpkp3kuDCOQEQM/nNcwlExJO0cdWyDKhS89LDDuE7q13GGMaFTUqexIDQbiM/1Fq1flE93xE9H5bY1IBYTidDi/xLfEyoABxav6BphFkjXDDHlBryn/lVkuFBhD+1HsgaBud/c5elC+2V/4A+6SBJbs5IqmCdSQNW+0zsmMrxm7AE8pAeW8Ka71GmTedZScX2evwxD95KYYx/u7Wuz5cxiPz3DjoBcVNmelU+HziBq1u32vDxHnuHl9dcqKOTjX35lXIIR4U1DB6mGfEEdE+uoeXRVY1OhwhBvy2bw4ecVA5A6KsM2SoVZrJ2+S6wiIg1UHu1phRRGXuu61lr/tmf+p0VBIr7bjn12A7J7iLBnFO7WoIWwXmIm2VhsxnVGLxd0WZntb2uunk3JDeJ0gd12nFijEoGjetVPaKzkRACmjAci3BJHyXKFWizz5y+rfBHm+7w8hb88wwXGix1xYnS5ob6aNJZzn177nj5Jp2eH1zHk9tFSCV7SYr29lJ4Ho14DF0DS5Okkc3cydYO77aNznSMMreqrXIMWFKo7ZrzQ5ksbk63+9MbPhYi+A0fJzPk4C0Rv2/YoCLcuxCCxiR2MEyg7PuGdBuLNJqcd7Nce6jUBr67P/7qT0=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(40480700001)(36756003)(86362001)(921005)(7636003)(356005)(82740400003)(36860700001)(26005)(426003)(47076005)(336012)(2876002)(7416002)(2906002)(83380400001)(966005)(6666004)(2616005)(478600001)(7696005)(8676002)(4326008)(8936002)(70586007)(70206006)(41300700001)(316002)(5660300002)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 20:18:28.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8ddff0-4101-4dcd-a66e-08dbc77291e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60b;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
partitioning of the GPU device resources (including device memory) into
several (upto 8) isolated instances. Each of the partitioned memory needs
a dedicated NUMA node to operate. The partitions are not fixed and they
can be created/deleted at runtime.

Unfortunately Linux OS does not provide a means to dynamically create/destroy
NUMA nodes and such feature implementation is not expected to be trivial. The
nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
we utilize the GI Affinity structures that allows association between nodes
and devices. Multiple GI structures per BDF is possible, allowing creation of
multiple nodes by exposing unique PXM in each of these structures.

Introducing a new nvidia-acpi-generic-initiator object, which inherits from
the generic acpi-generic-initiator object to allow a BDF to be associated with
more than 1 nodes.

An admin can provide the range of nodes using numa-node-start and
numa-node-count and link it to a device by providing its id. The following
sample creates 8 nodes and link them to the device dev0:

        -numa node,nodeid=2 \
        -numa node,nodeid=3 \
        -numa node,nodeid=4 \
        -numa node,nodeid=5 \
        -numa node,nodeid=6 \
        -numa node,nodeid=7 \
        -numa node,nodeid=8 \
        -numa node,nodeid=9 \
        -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
        -object nvidia-acpi-generic-initiator,id=gi0,device=dev0,numa-node-start=2,numa-node-count=8 \

[1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 61 ++++++++++++++++++++++++
 include/hw/acpi/acpi-generic-initiator.h | 12 +++++
 qapi/qom.json                            | 24 +++++++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
index 1ae79639be..8ef887c3a4 100644
--- a/hw/acpi/acpi-generic-initiator.c
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -150,3 +150,64 @@ void build_srat_generic_initiator(GArray *table_data)
     }
     g_slist_free(list);
 }
+
+static void
+nvidia_acpi_generic_initiator_set_node_start(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= MAX_NODES) {
+        return;
+    }
+
+    gi->node = value;
+}
+
+static void
+nvidia_acpi_generic_initiator_set_node_count(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    gi->node_count = value;
+}
+
+static void nvidia_acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add(oc, NVIDIA_ACPI_GENERIC_INITIATOR_NODE_START_PROP,
+                              "uint32", NULL,
+                              nvidia_acpi_generic_initiator_set_node_start,
+                              NULL, NULL);
+    object_class_property_add(oc, NVIDIA_ACPI_GENERIC_INITIATOR_NODE_COUNT_PROP,
+                              "uint32", NULL,
+                              nvidia_acpi_generic_initiator_set_node_count,
+                              NULL, NULL);
+}
+
+static const TypeInfo nvidia_acpi_generic_initiator_info = {
+    .parent = TYPE_ACPI_GENERIC_INITIATOR,
+    .name = TYPE_NVIDIA_ACPI_GENERIC_INITIATOR,
+    .instance_size = sizeof(NvidiaAcpiGenericInitiator),
+    .class_size = sizeof(NvidiaAcpiGenericInitiatorClass),
+    .class_init = nvidia_acpi_generic_initiator_class_init,
+};
+
+static void
+nvidia_acpi_generic_initiator_register_types(void)
+{
+    type_register_static(&nvidia_acpi_generic_initiator_info);
+}
+type_init(nvidia_acpi_generic_initiator_register_types);
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
index e8e2670309..3e4cf42064 100644
--- a/include/hw/acpi/acpi-generic-initiator.h
+++ b/include/hw/acpi/acpi-generic-initiator.h
@@ -9,10 +9,14 @@
 #include "qom/object_interfaces.h"
 
 #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+#define TYPE_NVIDIA_ACPI_GENERIC_INITIATOR "nvidia-acpi-generic-initiator"
 
 #define ACPI_GENERIC_INITIATOR_DEVICE_PROP "device"
 #define ACPI_GENERIC_INITIATOR_NODE_PROP "node"
 
+#define NVIDIA_ACPI_GENERIC_INITIATOR_NODE_START_PROP "numa-node-start"
+#define NVIDIA_ACPI_GENERIC_INITIATOR_NODE_COUNT_PROP "numa-node-count"
+
 typedef struct AcpiGenericInitiator {
     /* private */
     Object parent;
@@ -47,6 +51,14 @@ typedef struct PCIDeviceHandle {
     uint64_t res1;
 } PCIDeviceHandle;
 
+typedef struct NvidiaAcpiGenericInitiator {
+    AcpiGenericInitiator parent;
+} NvidiaAcpiGenericInitiator;
+
+typedef struct NvidiaAcpiGenericInitiatorClass {
+        AcpiGenericInitiatorClass parent_class;
+} NvidiaAcpiGenericInitiatorClass;
+
 void build_srat_generic_initiator(GArray *table_data);
 
 #endif
diff --git a/qapi/qom.json b/qapi/qom.json
index 86c87a161c..c29ad1388d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -793,6 +793,24 @@
 { 'struct': 'AcpiGenericInitiatorProperties',
   'data': { 'device': 'str', 'node': 'uint32' } }
 
+##
+# @NvidiaAcpiGenericInitiatorProperties:
+#
+# Properties for nvidia-acpi-generic-initiator objects.
+#
+# @device: the ID of the device to be associated with the nodes
+#
+# @numa-node-start: the ID of the numa node
+#
+# @numa-node-count: count of the numa nodes assocuated with the device
+#
+# Since: 8.0
+##
+{ 'struct': 'NvidiaAcpiGenericInitiatorProperties',
+  'data': { 'device': 'str',
+            'numa-node-start': 'uint32',
+            'numa-node-count': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -962,7 +980,8 @@
     'tls-cipher-suites',
     { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
     { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },
-    'acpi-generic-initiator'
+    'acpi-generic-initiator',
+    'nvidia-acpi-generic-initiator'
   ] }
 
 ##
@@ -1030,7 +1049,8 @@
       'tls-cipher-suites':          'TlsCredsProperties',
       'x-remote-object':            'RemoteObjectProperties',
       'x-vfio-user-server':         'VfioUserServerProperties',
-      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties'
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'nvidia-acpi-generic-initiator':     'NvidiaAcpiGenericInitiatorProperties'
   } }
 
 ##
-- 
2.17.1


