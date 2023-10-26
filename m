Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302C7D86F8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3X9-0000sc-B3; Thu, 26 Oct 2023 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3Wd-0000Vd-Ui; Thu, 26 Oct 2023 12:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3WZ-0007o3-Vv; Thu, 26 Oct 2023 12:48:03 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QGj0CM011235; Thu, 26 Oct 2023 16:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rkfCJi8WHgrfuZfGh2uNIii6bx0mcIuRo1CTeVWNF9A=;
 b=EBQ1+JN4scTQRnCaYvFgNmE0cAT/31g2U7qWk1XxPxHYPgRB1KIAa/oEgUrGqcIlbkjT
 unswahaCe8L0amIlfanAY08KR5UFOY5HTHpGdZWP50gcoZjKYI+9auiWDMLMQ7k6eReq
 AkmdTzviJ6lj6okdMgit5MRgSLuF3p+c/2X/PxM00FauTzJT/qFl2oTHfiRZrVu3rttT
 0yTCB7DcBoLEtfYGK0rA8R3VaTsTwYZyt84gaOaRZivQ4n3Jp1BGn3Fyp+nkQXj/c/Pz
 UPkEB+r6MGaLiKEdjRDYKjJ5dtJzekQPcn4IE6v4k81Wu0nl2UsVP16jVUt7eluIOtJB FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyuw8g2yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:47 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QGjaMG015364;
 Thu, 26 Oct 2023 16:47:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyuw8g2ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QGM3BW023794; Thu, 26 Oct 2023 16:47:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvrytfpsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QGljhb18547270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 16:47:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ECD758059;
 Thu, 26 Oct 2023 16:47:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84A0F58043;
 Thu, 26 Oct 2023 16:47:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 16:47:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v7 01/10] hw/fsi: Introduce IBM's Local bus
Date: Thu, 26 Oct 2023 11:47:32 -0500
Message-Id: <20231026164741.1184058-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026164741.1184058-1-ninad@linux.ibm.com>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tFdZnsX0A4ncOUyR_8RnzwIm1Crd-aFC
X-Proofpoint-ORIG-GUID: jh1gmH7nn0QZLQ0497k9JAeA0WsCXDFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_15,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310260145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
- Incorporated Joel's review comments.
v5:
- Incorporated review comments by Cedric.
v6:
- Incorporated review comments by Cedric & Daniel.
v7:
- Incorporated review comments by Philippe.
---
 include/hw/fsi/lbus.h | 43 +++++++++++++++++++++++++
 hw/fsi/lbus.c         | 74 +++++++++++++++++++++++++++++++++++++++++++
 hw/Kconfig            |  1 +
 hw/fsi/Kconfig        |  2 ++
 hw/fsi/meson.build    |  1 +
 hw/meson.build        |  1 +
 6 files changed, 122 insertions(+)
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/meson.build

diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
new file mode 100644
index 0000000000..4fa696bbdb
--- /dev/null
+++ b/include/hw/fsi/lbus.h
@@ -0,0 +1,43 @@
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
+#define TYPE_FSI_LBUS "fsi.lbus"
+OBJECT_DECLARE_SIMPLE_TYPE(FSILBus, FSI_LBUS)
+
+typedef struct FSILBus {
+    BusState bus;
+
+    MemoryRegion mr;
+} FSILBus;
+
+DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr);
+int lbus_add_device(FSILBus *bus, FSILBusDevice *dev);
+#endif /* FSI_LBUS_H */
diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
new file mode 100644
index 0000000000..3a7335dde5
--- /dev/null
+++ b/hw/fsi/lbus.c
@@ -0,0 +1,74 @@
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
+static void lbus_init(Object *o)
+{
+    FSILBus *lbus = FSI_LBUS(o);
+
+    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
+                       FSI_LBUS_MEM_REGION_SIZE - FSI_LBUSDEV_IOMEM_SIZE);
+}
+
+static const TypeInfo lbus_info = {
+    .name = TYPE_FSI_LBUS,
+    .parent = TYPE_BUS,
+    .instance_init = lbus_init,
+    .instance_size = sizeof(FSILBus),
+};
+
+static Property lbus_device_props[] = {
+    DEFINE_PROP_UINT32("address", FSILBusDevice, address, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+DeviceState *lbus_create_device(FSILBus *bus, const char *type, uint32_t addr)
+{
+    DeviceState *ds;
+    BusState *state = BUS(bus);
+    FSILBusDevice *dev;
+
+    ds = qdev_new(type);
+    qdev_prop_set_uint32(ds, "address", addr);
+    qdev_realize_and_unref(ds, state, &error_fatal);
+
+    dev = FSI_LBUS_DEVICE(ds);
+    memory_region_add_subregion(&bus->mr, dev->address,
+                                &dev->iomem);
+
+    return ds;
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
index 9ca7b38c31..2c00936c28 100644
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
index f01fac4617..463d702683 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -44,6 +44,7 @@ subdir('virtio')
 subdir('watchdog')
 subdir('xen')
 subdir('xenpv')
+subdir('fsi')
 
 subdir('alpha')
 subdir('arm')
-- 
2.39.2


