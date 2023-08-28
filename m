Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664278BB47
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalCX-0006C0-Kt; Mon, 28 Aug 2023 18:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalCH-0005ke-GE; Mon, 28 Aug 2023 18:59:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalCE-0004nH-P8; Mon, 28 Aug 2023 18:59:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SM01YP003323; Mon, 28 Aug 2023 22:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HK2nCqKQt1QRfD2RDdEL/gMlnuOFQs+EMna4ht7zRfo=;
 b=lbeRpQMt9iY0urFwgHNQQn3CEv++iEHpdDU9YBsJUvwO3H+dvsLrAoWumG2kGvbN9FZN
 80TIlx4JczzPLUoWmEvHGf3JYuhLFVhPqZ1idcigr7CkD0PTlBML103LGYENCiZXKaTn
 UYATivICdofAB9k34bC2+GIIJSvGCgMH0cml0KTNfBZf5nKFMU8QHEjvuR4yRUFBdN3m
 YPq5g+4P97eKkcH0mHbDtTLBrAjz62EeeU0Wxki1iZMygOl77omCJ3MiQ160YucWSRs8
 kSnqo4zxjtQZT1VRsxDAru2nk62pcFvps4uYXrkoqO2JHOjlxB2E7MDrysbXFn7pNthy 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr51u585x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SMqLHf005684;
 Mon, 28 Aug 2023 22:58:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr51u585m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SM4dlp019174; Mon, 28 Aug 2023 22:58:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1e9ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37SMwivM63963640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 22:58:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B225258058;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD8F5805D;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 1/7] hw/fsi: Introduce IBM's Local bus
Date: Mon, 28 Aug 2023 17:58:36 -0500
Message-Id: <20230828225842.4045510-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828225842.4045510-1-ninad@linux.ibm.com>
References: <20230828225842.4045510-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z8i6tUbvCJGKi85asyYeOEY3oABW4RxF
X-Proofpoint-ORIG-GUID: TRnZbrYFSNG7HLh7aarROXstadwJ8_Fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280194
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
---
 hw/Kconfig            |  1 +
 hw/fsi/Kconfig        |  2 +
 hw/fsi/lbus.c         | 94 +++++++++++++++++++++++++++++++++++++++++++
 hw/fsi/meson.build    |  1 +
 hw/meson.build        |  1 +
 include/hw/fsi/bits.h | 15 +++++++
 include/hw/fsi/lbus.h | 48 ++++++++++++++++++++++
 include/qemu/bitops.h |  6 +++
 8 files changed, 168 insertions(+)
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 hw/fsi/meson.build
 create mode 100644 include/hw/fsi/bits.h
 create mode 100644 include/hw/fsi/lbus.h

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
index 0000000000..687449e14e
--- /dev/null
+++ b/hw/fsi/Kconfig
@@ -0,0 +1,2 @@
+config LBUS
+    bool
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
new file mode 100644
index 0000000000..afb26ef7ea
--- /dev/null
+++ b/hw/fsi/lbus.c
@@ -0,0 +1,94 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Local bus where FSI slaves are connected
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/fsi/lbus.h"
+
+#include "hw/qdev-properties.h"
+
+static void lbus_realize(BusState *bus, Error **errp)
+{
+    LBusNode *node;
+    LBus *lbus = LBUS(bus);
+
+    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_LBUS,
+                       (2 * 1024 * 1024) - 0x400);
+
+    QLIST_FOREACH(node, &lbus->devices, next) {
+        memory_region_add_subregion(&lbus->mr, node->ldev->address,
+                                    &node->ldev->iomem);
+    }
+}
+
+static void lbus_init(Object *o)
+{
+}
+
+static void lbus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    k->realize = lbus_realize;
+}
+
+static const TypeInfo lbus_info = {
+    .name = TYPE_LBUS,
+    .parent = TYPE_BUS,
+    .instance_init = lbus_init,
+    .instance_size = sizeof(LBus),
+    .class_init = lbus_class_init,
+};
+
+static Property lbus_device_props[] = {
+    DEFINE_PROP_UINT32("address", LBusDevice, address, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr)
+{
+    DeviceState *dev;
+    LBusNode *node;
+
+    dev = qdev_new(type);
+    qdev_prop_set_uint8(dev, "address", addr);
+    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+
+    /* Move to post_load */
+    node = g_malloc(sizeof(struct LBusNode));
+    node->ldev = LBUS_DEVICE(dev);
+    QLIST_INSERT_HEAD(&bus->devices, node, next);
+
+    return dev;
+}
+
+static void lbus_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_LBUS;
+    device_class_set_props(dc, lbus_device_props);
+}
+
+static const TypeInfo lbus_device_type_info = {
+    .name = TYPE_LBUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(LBusDevice),
+    .abstract = true,
+    .class_init = lbus_device_class_init,
+    .class_size = sizeof(LBusDeviceClass),
+};
+
+static void lbus_register_types(void)
+{
+    type_register_static(&lbus_info);
+    type_register_static(&lbus_device_type_info);
+}
+
+type_init(lbus_register_types);
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
new file mode 100644
index 0000000000..e1007d5fea
--- /dev/null
+++ b/hw/fsi/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
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
diff --git a/include/hw/fsi/bits.h b/include/hw/fsi/bits.h
new file mode 100644
index 0000000000..338ae483cf
--- /dev/null
+++ b/include/hw/fsi/bits.h
@@ -0,0 +1,15 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * Bit operation macros
+ */
+#ifndef FSI_BITS_H
+#define FSI_BITS_H
+
+#define BE_BIT(x)                          BIT(31 - (x))
+#define GENMASK(t, b) \
+    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
+#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))
+
+#endif /* FSI_BITS_H */
diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
new file mode 100644
index 0000000000..fafc065178
--- /dev/null
+++ b/include/hw/fsi/lbus.h
@@ -0,0 +1,48 @@
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
+#define TYPE_LBUS_DEVICE "lbus.device"
+OBJECT_DECLARE_TYPE(LBusDevice, LBusDeviceClass, LBUS_DEVICE)
+
+typedef struct LBusDevice {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+    uint32_t address;
+} LBusDevice;
+
+typedef struct LBusDeviceClass {
+    DeviceClass parent;
+
+    uint32_t config;
+} LBusDeviceClass;
+
+typedef struct LBusNode {
+    LBusDevice *ldev;
+
+    QLIST_ENTRY(LBusNode) next;
+} LBusNode;
+
+#define TYPE_LBUS "lbus"
+OBJECT_DECLARE_SIMPLE_TYPE(LBus, LBUS)
+
+typedef struct LBus {
+    BusState bus;
+
+    MemoryRegion mr;
+
+    QLIST_HEAD(, LBusNode) devices;
+} LBus;
+
+DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr);
+int lbus_add_device(LBus *bus, LBusDevice *dev);
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
-- 
2.39.2


