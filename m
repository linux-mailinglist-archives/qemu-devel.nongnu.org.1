Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A279924B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 00:31:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qejyo-0001gI-AR; Fri, 08 Sep 2023 18:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qejyk-0001dh-Tw; Fri, 08 Sep 2023 18:29:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qejyg-0003Gk-Iz; Fri, 08 Sep 2023 18:29:30 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388MCjxs015128; Fri, 8 Sep 2023 22:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ms8NsXLE1c0sb3iga+GgtfTCbntUKzbabj4OZJC22So=;
 b=SyqOVe7QabGpdHHa0uwwi5NvaAg6JrVZ+sYdcPzixhFTUzX5xH3wQkC10oGIVrXaz55d
 aas4GntyoFSzD/yNPVz8kTdQKv6hK9LRTs6aUgAm1/TtOOL6Sm7EArGQpQeBmEQBlKA1
 Vwf6PEw6uphPSiRVhDbkWLf6dVHaOlhnJ08N0hwXwlQlrjZ5MS7qiGcNWO03XW+zCGps
 2e1JVpxQy9W2DNletAO6tj1Ft9JNlKc4gTxquFuaZKV9Sdxy1oZw1c3tOw1Fu5lHgTUE
 zJijxYrvS/dNjsPQvffi5AIsS9BKbn12MaIdBk2//yEAkjJhM8J/KRu9tktvHydnMXCU hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0c6ygb28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:12 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388MF9mY023176;
 Fri, 8 Sep 2023 22:29:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0c6ygb22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388LgCaM001667; Fri, 8 Sep 2023 22:29:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctfjkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388MTA7L27591118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 22:29:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B48258061;
 Fri,  8 Sep 2023 22:29:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3C9158056;
 Fri,  8 Sep 2023 22:29:09 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 22:29:09 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 04/10] hw/fsi: Introduce IBM's FSI
Date: Fri,  8 Sep 2023 17:28:53 -0500
Message-Id: <20230908222859.3381003-5-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908222859.3381003-1-ninad@linux.ibm.com>
References: <20230908222859.3381003-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FOyOwru7o3CnSiduoIEL3vA79qE-2BYk
X-Proofpoint-ORIG-GUID: P93Zh6DoRJedbKVKQ7TbqcTzWtNU5iYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=997
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080201
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

This commit models the FSI bus. CFAM is hanging out of FSI bus. The bus
is model such a way that it is embeded inside the FSI master which is a
bus controller.

The FSI master: A controller in the platform service processor (e.g.
BMC) driving CFAM engine accesses into the POWER chip. At the
hardware level FSI is a bit-based protocol supporting synchronous and
DMA-driven accesses of engines in a CFAM.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v2:
- Incorporated review comments by Joel
---
 hw/fsi/cfam.c               |   3 +-
 hw/fsi/fsi-master.c         | 203 ++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi.c                |  54 ++++++++++
 hw/fsi/meson.build          |   2 +-
 include/hw/fsi/cfam.h       |   8 +-
 include/hw/fsi/fsi-master.h |  30 ++++++
 include/hw/fsi/fsi-slave.h  |   4 +-
 include/hw/fsi/fsi.h        |  31 ++++++
 8 files changed, 327 insertions(+), 8 deletions(-)
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi.c
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi.h

diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
index 9a9e65d33f..414dcebe63 100644
--- a/hw/fsi/cfam.c
+++ b/hw/fsi/cfam.c
@@ -7,12 +7,13 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
 
-#include "hw/fsi/bits.h"
 #include "hw/fsi/cfam.h"
+#include "hw/fsi/fsi.h"
 #include "hw/fsi/engine-scratchpad.h"
 
 #include "hw/qdev-properties.h"
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
new file mode 100644
index 0000000000..fe1693539a
--- /dev/null
+++ b/hw/fsi/fsi-master.c
@@ -0,0 +1,203 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface master
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+
+#include "qemu/log.h"
+
+#include "hw/fsi/bits.h"
+#include "hw/fsi/fsi-master.h"
+
+#define TYPE_OP_BUS "opb"
+
+#define TO_REG(x)                               ((x) >> 2)
+
+#define FSI_MMODE                               TO_REG(0x000)
+#define   FSI_MMODE_IPOLL_DMA_EN                BE_BIT(0)
+#define   FSI_MMODE_HW_ERROR_RECOVERY_EN        BE_BIT(1)
+#define   FSI_MMODE_RELATIVE_ADDRESS_EN         BE_BIT(2)
+#define   FSI_MMODE_PARITY_CHECK_EN             BE_BIT(3)
+#define   FSI_MMODE_CLOCK_DIVIDER_0             BE_GENMASK(4, 13)
+#define   FSI_MMODE_CLOCK_DIVIDER_1             BE_GENMASK(14, 23)
+#define   FSI_MMODE_DEBUG_EN                    BE_BIT(24)
+
+#define FSI_MDELAY                              TO_REG(0x004)
+#define   FSI_MDELAY_ECHO_0                     BE_GENMASK(0, 3)
+#define   FSI_MDELAY_SEND_0                     BE_GENMASK(4, 7)
+#define   FSI_MDELAY_ECHO_1                     BE_GENMASK(8, 11)
+#define   FSI_MDELAY_SEND_1                     BE_GENMASK(12, 15)
+
+#define FSI_MENP0                               TO_REG(0x010)
+#define FSI_MENP32                              TO_REG(0x014)
+#define FSI_MSENP0                              TO_REG(0x018)
+#define FSI_MLEVP0                              TO_REG(0x018)
+#define FSI_MSENP32                             TO_REG(0x01c)
+#define FSI_MLEVP32                             TO_REG(0x01c)
+#define FSI_MCENP0                              TO_REG(0x020)
+#define FSI_MREFP0                              TO_REG(0x020)
+#define FSI_MCENP32                             TO_REG(0x024)
+#define FSI_MREFP32                             TO_REG(0x024)
+
+#define FSI_MAEB                                TO_REG(0x070)
+#define   FSI_MAEB_ANY_CPU_ERROR                BE_BIT(0)
+#define   FSI_MAEB_ANY_DMA_ERROR                BE_GENMASK(1, 16)
+#define   FSI_MAEB_ANY_PARITY_ERROR             BE_BIT(17)
+
+#define FSI_MVER                                TO_REG(0x074)
+#define   FSI_MVER_VERSION                      BE_GENMASK(0, 7)
+#define   FSI_MVER_BRIDGES                      BE_GENMASK(8, 15)
+#define   FSI_MVER_PORTS                        BE_GENMASK(16, 23)
+
+#define FSI_MRESP0                              TO_REG(0x0d0)
+#define   FSI_MRESP0_RESET_PORT_GENERAL         BE_BIT(0)
+#define   FSI_MRESP0_RESET_PORT_ERROR           BE_BIT(1)
+#define   FSI_MRESP0_RESET_ALL_BRIDGES_GENERAL  BE_BIT(2)
+#define   FSI_MRESP0_RESET_ALL_PORTS_GENERAL    BE_BIT(3)
+#define   FSI_MRESP0_RESET_MASTER               BE_BIT(4)
+#define   FSI_MRESP0_RESET_PARITY_ERROR_LATCH   BE_BIT(5)
+
+#define FSI_MRESB0                              TO_REG(0x1d0)
+#define   FSI_MRESB0_RESET_GENERAL              BE_BIT(0)
+#define   FSI_MRESB0_RESET_ERROR                BE_BIT(1)
+#define   FSI_MRESB0_SET_DMA_SUSPEND            BE_BIT(5)
+#define   FSI_MRESB0_CLEAR_DMA_SUSPEND          BE_BIT(6)
+#define   FSI_MRESB0_SET_DELAY_MEASURE          BE_BIT(7)
+
+#define FSI_MECTRL                              TO_REG(0x2e0)
+#define   FSI_MECTRL_TEST_PULSE                 BE_GENMASK(0, 7)
+#define   FSI_MECTRL_INHIBIT_PARITY_ERROR       BE_GENMASK(8, 15)
+#define   FSI_MECTRL_ENABLE_OPB_ERR_ACK         BE_BIT(16)
+#define   FSI_MECTRL_AUTO_TERMINATE             BE_BIT(17)
+#define   FSI_MECTRL_PORT_ERROR_FREEZE          BE_BIT(18)
+
+static uint64_t fsi_master_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSIMasterState *s = FSI_MASTER(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
+                  __func__, addr, size);
+
+    if (addr + size > sizeof(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->regs[TO_REG(addr)];
+}
+
+static void fsi_master_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    FSIMasterState *s = FSI_MASTER(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
+                  "value=%"PRIx64"\n", __func__, addr, size, data);
+
+    if (addr + size > sizeof(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    switch (TO_REG(addr)) {
+    case FSI_MENP0:
+        s->regs[FSI_MENP0] = data;
+        break;
+    case FSI_MENP32:
+        s->regs[FSI_MENP32] = data;
+        break;
+    case FSI_MSENP0:
+        s->regs[FSI_MENP0] |= data;
+        break;
+    case FSI_MSENP32:
+        s->regs[FSI_MENP32] |= data;
+        break;
+    case FSI_MCENP0:
+        s->regs[FSI_MENP0] &= ~data;
+        break;
+    case FSI_MCENP32:
+        s->regs[FSI_MENP32] &= ~data;
+        break;
+    case FSI_MRESP0:
+        /* Perform necessary resets leave register 0 to indicate no errors */
+        break;
+    case FSI_MRESB0:
+        if (data & FSI_MRESB0_RESET_GENERAL) {
+            device_cold_reset(DEVICE(opaque));
+        }
+        if (data & FSI_MRESB0_RESET_ERROR) {
+            /* FIXME: this seems dubious */
+            device_cold_reset(DEVICE(opaque));
+        }
+        break;
+    default:
+        s->regs[TO_REG(addr)] = data;
+    }
+}
+
+static const struct MemoryRegionOps fsi_master_ops = {
+    .read = fsi_master_read,
+    .write = fsi_master_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_master_realize(DeviceState *dev, Error **errp)
+{
+    FSIMasterState *s = FSI_MASTER(dev);
+    Error *err = NULL;
+
+    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
+                          TYPE_FSI_MASTER, 0x10000000);
+    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000);
+
+    object_property_set_bool(OBJECT(&s->bus), "realized", true, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->opb2fsi, 0, &s->bus.slave.mr);
+}
+
+static void fsi_master_reset(DeviceState *dev)
+{
+    FSIMasterState *s = FSI_MASTER(dev);
+
+    /* ASPEED default */
+    s->regs[FSI_MVER] = 0xe0050101;
+}
+
+static void fsi_master_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_OP_BUS;
+    dc->desc = "FSI Master";
+    dc->realize = fsi_master_realize;
+    dc->reset = fsi_master_reset;
+}
+
+static const TypeInfo fsi_master_info = {
+    .name = TYPE_FSI_MASTER,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(FSIMasterState),
+    .class_init = fsi_master_class_init,
+};
+
+static void fsi_register_types(void)
+{
+    type_register_static(&fsi_master_info);
+}
+
+type_init(fsi_register_types);
diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
new file mode 100644
index 0000000000..43f889fee9
--- /dev/null
+++ b/hw/fsi/fsi.c
@@ -0,0 +1,54 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+
+#include "hw/fsi/fsi.h"
+#include "hw/fsi/cfam.h"
+
+static void fsi_bus_realize(BusState *bus, Error **errp)
+{
+    FSIBus *s = FSI_BUS(bus);
+    Error *err = NULL;
+
+    /* FIXME: Should be realised elsewhere and added to the bus */
+    object_property_set_bool(OBJECT(&s->slave), "realized", true, &err);
+    if (err) {
+        error_propagate(errp, err);
+    }
+}
+
+static void fsi_bus_init(Object *o)
+{
+    FSIBus *s = FSI_BUS(o);
+
+    /* FIXME: Move this elsewhere */
+    object_initialize_child(o, TYPE_CFAM, &s->slave, TYPE_CFAM);
+    qdev_set_parent_bus(DEVICE(&s->slave), BUS(o), &error_abort);
+}
+
+static void fsi_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *bc = BUS_CLASS(klass);
+    bc->realize = fsi_bus_realize;
+}
+
+static const TypeInfo fsi_bus_info = {
+    .name = TYPE_FSI_BUS,
+    .parent = TYPE_BUS,
+    .instance_init = fsi_bus_init,
+    .instance_size = sizeof(FSIBus),
+    .class_init = fsi_bus_class_init,
+};
+
+static void fsi_bus_register_types(void)
+{
+    type_register_static(&fsi_bus_info);
+}
+
+type_init(fsi_bus_register_types);
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index 5600502b33..ca80d11cb9 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,4 +1,4 @@
 system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
 system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
-system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
index af9f88cb22..49877a7220 100644
--- a/include/hw/fsi/cfam.h
+++ b/include/hw/fsi/cfam.h
@@ -12,14 +12,14 @@
 #include "hw/fsi/fsi-slave.h"
 #include "hw/fsi/lbus.h"
 
-#define TYPE_FSI_BUS "fsi.bus"
-
 #define TYPE_CFAM "cfam"
 #define CFAM(obj) OBJECT_CHECK(CFAMState, (obj), TYPE_CFAM)
 
 #define CFAM_NR_REGS ((0x2e0 >> 2) + 1)
 
 #define TYPE_CFAM_CONFIG "cfam.config"
+OBJECT_DECLARE_SIMPLE_TYPE(CFAMConfig, CFAM_CONFIG)
+
 #define CFAM_CONFIG(obj) \
     OBJECT_CHECK(CFAMConfig, (obj), TYPE_CFAM_CONFIG)
 /* P9-ism */
@@ -35,8 +35,8 @@ typedef struct CFAMConfig {
 } CFAMConfig;
 
 #define TYPE_CFAM_PEEK "cfam.peek"
-#define CFAM_PEEK(obj) \
-    OBJECT_CHECK(CFAMPeek, (obj), TYPE_CFAM_PEEK)
+OBJECT_DECLARE_SIMPLE_TYPE(CFAMPeek, CFAM_PEEK)
+
 #define CFAM_PEEK_NR_REGS ((0x130 >> 2) + 1)
 
 typedef struct CFAMPeek {
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
new file mode 100644
index 0000000000..847078919c
--- /dev/null
+++ b/include/hw/fsi/fsi-master.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2019 IBM Corp.
+ *
+ * IBM Flexible Service Interface Master
+ */
+#ifndef FSI_FSI_MASTER_H
+#define FSI_FSI_MASTER_H
+
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+#include "hw/fsi/fsi.h"
+
+#define TYPE_FSI_MASTER "fsi.master"
+OBJECT_DECLARE_SIMPLE_TYPE(FSIMasterState, FSI_MASTER)
+
+#define FSI_MASTER_NR_REGS ((0x2e0 >> 2) + 1)
+
+typedef struct FSIMasterState {
+    DeviceState parent;
+    MemoryRegion iomem;
+    MemoryRegion opb2fsi;
+
+    FSIBus bus;
+
+    uint32_t regs[FSI_MASTER_NR_REGS];
+} FSIMasterState;
+
+
+#endif /* FSI_FSI_H */
diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
index bff807ff20..f5f23f4457 100644
--- a/include/hw/fsi/fsi-slave.h
+++ b/include/hw/fsi/fsi-slave.h
@@ -15,8 +15,8 @@
 #include <stdint.h>
 
 #define TYPE_FSI_SLAVE "fsi.slave"
-#define FSI_SLAVE(obj) \
-    OBJECT_CHECK(FSISlaveState, (obj), TYPE_FSI_SLAVE)
+OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
+
 #define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
 
 typedef struct FSISlaveState {
diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
new file mode 100644
index 0000000000..9c8dbe884f
--- /dev/null
+++ b/include/hw/fsi/fsi.h
@@ -0,0 +1,31 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface
+ */
+#ifndef FSI_FSI_H
+#define FSI_FSI_H
+
+#include "hw/qdev-core.h"
+
+/*
+ * TODO: Maybe unwind this dependency with const links? Store a
+ * pointer in FSIBus?
+ */
+#include "hw/fsi/cfam.h"
+
+#define TYPE_FSI_BUS "fsi.bus"
+OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
+
+/* TODO: Figure out what's best with a point-to-point bus */
+typedef struct FSISlaveState FSISlaveState;
+
+typedef struct FSIBus {
+    BusState bus;
+
+    /* XXX: It's point-to-point, just instantiate the slave directly for now */
+    CFAMState slave;
+} FSIBus;
+
+#endif
-- 
2.39.2


