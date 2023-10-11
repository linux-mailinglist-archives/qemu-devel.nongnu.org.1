Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC77C583F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbIX-0000Od-4i; Wed, 11 Oct 2023 11:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqbIR-0000KD-GI; Wed, 11 Oct 2023 11:38:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqbIF-0001cc-K4; Wed, 11 Oct 2023 11:38:43 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BFWTQs012807; Wed, 11 Oct 2023 15:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=hUo5ZZRpetyZFYji0hRVWe6kX7Qse7xhP6ORj2p+LeI=;
 b=aS21fAWmJLEbvuwjqNY0U0TkEoLRS3H5p3WSs15QTBchi6eY8qDev9HOgBUATORD/oDx
 YCNeyBBrizqpUIMl6w7OUmU/oNcneg9VzDfpP/PEuOuPUqtuza9WMfTGFgwpM9YYBiMF
 r8N8cphQPru63tbs6Davr4csnf1WgNOnHTrGTilPeF+CYkkJsZjdNwMCvMaK2pUvMsms
 aYzqiz3trH++ck0zmhsPW6+uu425lP5bHglBL0OQ1v/4Jl4LdboixTVPkpUBMKm8DmOB
 b74Ecy2+i+x6hNSuWeVPf7g1zlzwDJ+yDJCmzmNuy68fhyEBPHLE0jltzJkBI9KNGp7F kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnxee090f-50
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:38:12 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BF2mab024892;
 Wed, 11 Oct 2023 15:14:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnx0d0hbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:14:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BEKkrL025927; Wed, 11 Oct 2023 15:13:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnngwb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:13:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39BFDhgb11534990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 15:13:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE94C58065;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8650658068;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v5 01/10] hw/fsi: Introduce IBM's Local bus
Date: Wed, 11 Oct 2023 10:13:30 -0500
Message-Id: <20231011151339.2782132-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011151339.2782132-1-ninad@linux.ibm.com>
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V1U9hS7nEZ4CKfJ3h-_KpwpgAvUvO9p7
X-Proofpoint-ORIG-GUID: Agfgu1nTrtCyWc06UvEdq0aMx8FgJrma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_10,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

The LBUS is modelled to maintain the qdev bus hierarchy and to take
advantage of the object model to automatically generate the CFAM
configuration block. The configuration block presents engines in the
order they are attached to the CFAM's LBUS. Engine implementations
should subclass the LBusDevice and set the 'config' member of
LBusDeviceClass to match the engine's type.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
- Incorporated Joel's review comments.
v5:
- Incorporated review comments by Cedric.
---
 include/hw/fsi/lbus.h | 51 +++++++++++++++++++++++++
 include/qemu/bitops.h |  6 +++
 hw/fsi/lbus.c         | 87 +++++++++++++++++++++++++++++++++++++++++++
 hw/Kconfig            |  1 +
 hw/fsi/Kconfig        |  2 +
 hw/fsi/meson.build    |  1 +
 hw/meson.build        |  1 +
 7 files changed, 149 insertions(+)
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/meson.build

diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
new file mode 100644
index 0000000000..408fe25831
--- /dev/null
+++ b/include/hw/fsi/lbus.h
@@ -0,0 +1,51 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Local bus and connected device structures.
+ */
+#ifndef FSI_LBUS_H
+#define FSI_LBUS_H
+
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
+OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
+
+#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
+#define FSI_LBUSDEV_IOMEM_SIZE    0x400
+
+typedef struct FSILBusDevice {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+    uint32_t address;
+} FSILBusDevice;
+
+typedef struct FSILBusDeviceClass {
+    DeviceClass parent;
+
+    uint32_t config;
+} FSILBusDeviceClass;
+
+typedef struct FSILBusNode {
+    FSILBusDevice *ldev;
+
+    QLIST_ENTRY(FSILBusNode) next;
+} FSILBusNode;
+
+#define TYPE_FSI_LBUS "fsi.lbus"
+OBJECT_DECLARE_SIMPLE_TYPE(FSILBus, FSI_LBUS)
+
+typedef struct FSILBus {
+    BusState bus;
+
+    MemoryRegion mr;
+
+    QLIST_HEAD(, FSILBusNode) devices;
+} FSILBus;
+
+DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr);
+int lbus_add_device(FSILBus *bus, FSILBusDevice *dev);
+#endif /* FSI_LBUS_H */
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index cb3526d1f4..e12496f619 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -618,4 +618,10 @@ static inline uint64_t half_unshuffle64(uint64_t x)
     return x;
 }
 
+/* Bitwise operations at the word level. */
+#define BE_BIT(x)                          BIT(31 - (x))
+#define GENMASK(t, b) \
+    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
+#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))
+
 #endif
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
new file mode 100644
index 0000000000..d7117d1299
--- /dev/null
+++ b/hw/fsi/lbus.c
@@ -0,0 +1,87 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Local bus where FSI slaves are connected
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/fsi/lbus.h"
+
+#include "hw/qdev-properties.h"
+
+static void lbus_realize(BusState *bus, Error **errp)
+{
+    FSILBusNode *node;
+    FSILBus *lbus = FSI_LBUS(bus);
+
+    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
+                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_SIZE);
+
+    QLIST_FOREACH(node, &lbus->devices, next) {
+        memory_region_add_subregion(&lbus->mr, node->ldev->address,
+                                    &node->ldev->iomem);
+    }
+}
+
+static void lbus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    k->realize = lbus_realize;
+}
+
+static const TypeInfo lbus_info = {
+    .name = TYPE_FSI_LBUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(FSILBus),
+    .class_init = lbus_class_init,
+};
+
+static Property lbus_device_props[] = {
+    DEFINE_PROP_UINT32("address", FSILBusDevice, address, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr)
+{
+    DeviceState *dev;
+    FSILBusNode *node;
+    BusState *state = BUS(bus);
+
+    dev = qdev_new(type);
+    qdev_prop_set_uint8(dev, "address", addr);
+    qdev_realize_and_unref(dev, state, &error_fatal);
+
+    /* Move to post_load */
+    node = g_malloc(sizeof(struct FSILBusNode));
+    node->ldev = FSI_LBUS_DEVICE(dev);
+    QLIST_INSERT_HEAD(&bus->devices, node, next);
+
+    return dev;
+}
+
+static void lbus_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_FSI_LBUS;
+    device_class_set_props(dc, lbus_device_props);
+}
+
+static const TypeInfo lbus_device_type_info = {
+    .name = TYPE_FSI_LBUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(FSILBusDevice),
+    .abstract = true,
+    .class_init = lbus_device_class_init,
+    .class_size = sizeof(FSILBusDeviceClass),
+};
+
+static void lbus_register_types(void)
+{
+    type_register_static(&lbus_info);
+    type_register_static(&lbus_device_type_info);
+}
+
+type_init(lbus_register_types);
diff --git a/hw/Kconfig b/hw/Kconfig
index ba62ff6417..2ccb73add5 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -9,6 +9,7 @@ source core/Kconfig
 source cxl/Kconfig
 source display/Kconfig
 source dma/Kconfig
+source fsi/Kconfig
 source gpio/Kconfig
 source hyperv/Kconfig
 source i2c/Kconfig
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
new file mode 100644
index 0000000000..e650c660f0
--- /dev/null
+++ b/hw/fsi/Kconfig
@@ -0,0 +1,2 @@
+config FSI_LBUS
+    bool
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
new file mode 100644
index 0000000000..4074d3a7d2
--- /dev/null
+++ b/hw/fsi/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
diff --git a/hw/meson.build b/hw/meson.build
index c7ac7d3d75..6c71ee9cfa 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -43,6 +43,7 @@ subdir('virtio')
 subdir('watchdog')
 subdir('xen')
 subdir('xenpv')
+subdir('fsi')
 
 subdir('alpha')
 subdir('arm')
-- 
2.39.2


