Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9697BC9BC
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 22:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpDko-0001VQ-2v; Sat, 07 Oct 2023 16:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDkk-0001Ub-TD; Sat, 07 Oct 2023 16:18:22 -0400
Received: from mail-dm6nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::607]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qpDki-0005K9-5r; Sat, 07 Oct 2023 16:18:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0O7thiw/5X3fmuW/jrEQ8IeA72nI/b1bR45T+X2itdIlIFLb43qDJTWqKEPUp6n8XZRWu/PA+HQUF8J35FwyEEOzAz2Hrj8MLI4N8v5ln9pbJjeoBN6BGwtmKDmga29SdOVzvCTO28U4qEtEBDU74z2ZrzabQh2ll8jblGcbR/0qGilZDtDAjOd+G+PvE9a7vtzn5wWV0DsCS5Nm8IiplbIvKfaR5c/XsjX06MNTZykCMqH9N3LvgcidARiHujP1YB9c0Eyc9nWqqjAnnYZ/QGaOjeRvjRHnTWMyKrgHsVRQ7/IoHQxUPxu8hdxNrrtIjIZttLDM4aDtdgIEB8K0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKv5LQim9Z7dMoTDcj1jGx85RUUvIIw1MUVhHzMeGLE=;
 b=FjPPiAhYwBuwX3VQqvnvksPhxet0dKKMfh2Px5wAYp2yyLDno++VX3NIPE3i/3mC2E3oII2/xE0/ZajzHmf/G2Prsh3GfDNFl051CmPkfLuZRSQhANzUWiF8COVMc4oaMvE/Psae70Zr8cZK+LQDz+0th1l6/Ie7M0q+0KNOSzn6sXpj2N1yd07asneEewuqmeMWgIJ7mRyME+ECh01cC6RfBwC0MEOLeviuowCotpgGodz07aQQbpedbh2N90STt0gkZyqFeiA+SQqg2jJ3S8dos9IIDJeTEWPgDyN6QJesB6cQ9dzxbrwqqSGtDNj4K9QyijZEGbUZRg8iATCHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKv5LQim9Z7dMoTDcj1jGx85RUUvIIw1MUVhHzMeGLE=;
 b=c3z7NRQpXbBawqnr3CKQ/T7sh7y8Owy31RMRpdP4rST82QkWm/XUKwuikAVtu1OfiU5q1iv9dhPqhIWnn+G3Nbvw2kjZPIzrLNkU/COakD4mT6drAlS9EyJG0wxWRXyytQLMY2gvRN37UG2vzSY0QwqR7up9Eq6JLg+pZob1DKX3hDCYi+0I0NJwJ+4rdtpBhX0ryf4JGJL5oyN4uMIjSO/41yyA4SDZ8ZvOMno/aKaE8NYMzWNvB0f0hmGnnB5XpbND15bsljRpwgXcJFQlrJfO4zz1HNU9lQxz4EYFN5Kb7/Me7PycPy/qUYyVps1dEk9cIFQ9QjGrREVBIdLzOw==
Received: from PH7PR17CA0026.namprd17.prod.outlook.com (2603:10b6:510:323::19)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sat, 7 Oct
 2023 20:18:15 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::47) by PH7PR17CA0026.outlook.office365.com
 (2603:10b6:510:323::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Sat, 7 Oct 2023 20:18:14 +0000
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
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 20:18:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 7 Oct 2023
 13:17:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 7 Oct 2023 13:17:56 -0700
Received: from sgarnayak-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 7 Oct 2023 13:17:49 -0700
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
Subject: [PATCH v2 1/3] qom: new object to associate device to numa node
Date: Sun, 8 Oct 2023 01:47:38 +0530
Message-ID: <20231007201740.30335-2-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231007201740.30335-1-ankita@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e7478-0c2d-4d1b-ad6e-08dbc772886e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dawmfNpLrfYMQQqZNrZGhlrBn2hYsGjLGzEnX+JiZya8NFmEv7FPtJoxKTSWq0RszoXUu+EnirArhutGtsKn27m4jRzW3oT8GYT3z9tU1TfiOcaZ+a/OoCXdmO+piCua8r9R9ebr8onKlAb20CPGsyVpav7dD65Lyf//TzCvTCXoftiDIYRK1iApB7OVGveS/nY1nEkzPf7teZHTwL+j1nhScFi00PZKCMY79zN/qUCKMM/ZlCqpmDbslKvUuKPcMjs1aiwjW216bxgx2ReT4Og/KdoawNLzY6vJwtsG/vdnvbWET6nyK4YzItF2sr2+rEj02JWhyRWE2iZJBCh9Pe5onSXqN9y3ZuuzE73ruWWcdqOkmFrT3C7UuAmqIZB7fV2obseoJjGb5eO8L5NPzXyTSVHNg84SWF8kcXTCTNUr6fswYv2Zcqfili4pmi3UJAku1Tyn69JF1fPpu1Id5GgmGUCHBTEYbyPr40+7CLFy4Er8rDIIDf7EftnzTTQar9i3EUvSz398PKZDaqZvZAXDnCiHUKYr8UAQyugp1rPF3vnjJelnfhQOx7O3TD5yKf8fHrpE/6CzLUYdpnSpAAJEBo4NTUBAF217ix0yviNHuhmD7B0FYJWJ0li08HHiF3eegcNRUnpGbRSAaFDy5xedAD7WSpFttrfKpR/l4JZ5Yh5/kGNB1NjLUB5DyWqXA1IUunfcet5DrtvTU27hJWKQcARH5a1Ick1s7qQsbeZVW5jOk+w6+bxTFmFaLBOy
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(1076003)(40460700003)(36756003)(86362001)(40480700001)(921005)(7636003)(356005)(82740400003)(36860700001)(26005)(47076005)(426003)(336012)(7416002)(2876002)(2906002)(83380400001)(6666004)(2616005)(7696005)(478600001)(8676002)(4326008)(8936002)(70586007)(41300700001)(316002)(70206006)(5660300002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 20:18:13.0961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e7478-0c2d-4d1b-ad6e-08dbc772886e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
Received-SPF: softfail client-ip=2a01:111:f400:fe59::607;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

The CPU cache coherent device memory can be added as NUMA nodes
distinct from the system memory nodes. These nodes are associated
with the device and Qemu needs a way to maintain this link.

Introduce a new acpi-generic-initiator object to allow host admin
provide the device and the corresponding NUMA node. Qemu maintain
this association and use this object to build the requisite GI
Affinity Structure.

The admin provides the id of the device and the NUMA node id such
as in the following example.
-device vfio-pci-nohotplug,host=<bdf>,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,device=dev0,node=2 \

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 hw/acpi/acpi-generic-initiator.c         | 74 ++++++++++++++++++++++++
 hw/acpi/meson.build                      |  1 +
 include/hw/acpi/acpi-generic-initiator.h | 30 ++++++++++
 qapi/qom.json                            | 20 ++++++-
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
new file mode 100644
index 0000000000..6406736090
--- /dev/null
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -0,0 +1,74 @@
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
+    gi->node = MAX_NODES;
+    gi->node_count = 1;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->device);
+}
+
+static void acpi_generic_initiator_set_device(Object *obj, const char *value,
+                                              Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->device = g_strdup(value);
+}
+
+static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
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
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_DEVICE_PROP, NULL,
+                                  acpi_generic_initiator_set_device);
+    object_class_property_add(oc, ACPI_GENERIC_INITIATOR_NODE_PROP, "uint32",
+                              NULL, acpi_generic_initiator_set_node, NULL,
+                              NULL);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379..22252836ed 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -5,6 +5,7 @@ acpi_ss.add(files(
   'bios-linker-loader.c',
   'core.c',
   'utils.c',
+  'acpi-generic-initiator.c',
 ))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c', 'cpu_hotplug.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-hotplug-stub.c'))
diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
new file mode 100644
index 0000000000..e67e6e23b1
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
+#define ACPI_GENERIC_INITIATOR_DEVICE_PROP "device"
+#define ACPI_GENERIC_INITIATOR_NODE_PROP "node"
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *device;
+    uint32_t node;
+    uint32_t node_count;
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+        ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#endif
diff --git a/qapi/qom.json b/qapi/qom.json
index fa3e88c8e6..86c87a161c 100644
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
+# @node: the ID of the numa node
+#
+# Since: 8.0
+##
+{ 'struct': 'AcpiGenericInitiatorProperties',
+  'data': { 'device': 'str', 'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -947,7 +961,8 @@
     'tls-creds-x509',
     'tls-cipher-suites',
     { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
-    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
+    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },
+    'acpi-generic-initiator'
   ] }
 
 ##
@@ -1014,7 +1029,8 @@
       'tls-creds-x509':             'TlsCredsX509Properties',
       'tls-cipher-suites':          'TlsCredsProperties',
       'x-remote-object':            'RemoteObjectProperties',
-      'x-vfio-user-server':         'VfioUserServerProperties'
+      'x-vfio-user-server':         'VfioUserServerProperties',
+      'acpi-generic-initiator':     'AcpiGenericInitiatorProperties'
   } }
 
 ##
-- 
2.17.1


