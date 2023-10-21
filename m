Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754647D1FC1
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJLz-0003sF-5Z; Sat, 21 Oct 2023 17:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJLx-0003rY-4A; Sat, 21 Oct 2023 17:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJLu-0005Tw-JW; Sat, 21 Oct 2023 17:17:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKlsU6012159; Sat, 21 Oct 2023 21:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lTYOyQLChs57Tv/Msiu3Bop/mtTq8obBnujclN2SpYw=;
 b=eRQ/wjTKE5z2LqDUZq+G0E24qtquY915uo5aHZ3i1tJ9A3+QAleeGv6RbtcaQ5vSUdbi
 FJKFsTCdoJjDVN5zS77akjcZoYmeZWgRJuU/IrsE0K4uFQqBbh8O6+kDQV5Sf98KMKZE
 y9SJ2FkMPsIvUciqRmzb0UdLOFWXLqijGuHAXRgRjkPXAxJTLoAut+K+GR7nVZAzXlKA
 +RzTggyz9AXeDERc1EtKUg/WQswwaux6xXCJkoLCAJzMwAStzipOo2tL+8unIk6/gd+r
 Zl2GLFJLieg+bH7Ypn2EFTrFtDWp4i+5VbRivs1rvrr9k57WGrdjfT08h+17hhKPKelm Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvp080g4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LLFCnu031909;
 Sat, 21 Oct 2023 21:17:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvp080g44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKK8PE019366; Sat, 21 Oct 2023 21:17:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc45dcev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHOBD33489254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B26C158065;
 Sat, 21 Oct 2023 21:17:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52A275805D;
 Sat, 21 Oct 2023 21:17:24 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 21:17:24 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v6 04/10] hw/fsi: Introduce IBM's FSI
Date: Sat, 21 Oct 2023 16:17:13 -0500
Message-Id: <20231021211720.3571082-5-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021211720.3571082-1-ninad@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I2x1eD5EVuW2s-rlA5VhwNwyystqK95x
X-Proofpoint-ORIG-GUID: ZIV8JejmwjQ8KsydokZZEK0Qp7eUOpcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210196
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

This commit models the FSI bus. CFAM is hanging out of FSI bus. The bus
is model such a way that it is embedded inside the FSI master which is a
bus controller.

The FSI master: A controller in the platform service processor (e.g.
BMC) driving CFAM engine accesses into the POWER chip. At the
hardware level FSI is a bit-based protocol supporting synchronous and
DMA-driven accesses of engines in a CFAM.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v2:
- Incorporated review comments by Joel
v5:
- Incorporated review comments by Cedric.
v6:
- Incorporated review comments by Cedric & Daniel
---
 include/hw/fsi/fsi-master.h |  30 ++++++
 hw/fsi/fsi-master.c         | 202 ++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi.c                |  25 +++++
 hw/fsi/meson.build          |   2 +-
 hw/fsi/trace-events         |   2 +
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi.c

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
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
new file mode 100644
index 0000000000..fa23af3de2
--- /dev/null
+++ b/hw/fsi/fsi-master.c
@@ -0,0 +1,202 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface master
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
+
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
+    trace_fsi_master_read(addr, size);
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
+    trace_fsi_master_write(addr, size, data);
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
+
+    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
+                          TYPE_FSI_MASTER, 0x10000000);
+    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000);
+
+    if (!object_property_set_bool(OBJECT(&s->bus), "realized", true, errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->opb2fsi, 0, &s->bus.slave.mr);
+
+    /* Let's add first CFAM */
+    object_initialize_child(OBJECT(BUS(&s->bus)), TYPE_FSI_CFAM, &s->bus.slave,
+                            TYPE_FSI_CFAM);
+    qdev_set_parent_bus(DEVICE(&s->bus.slave), BUS(&s->bus), &error_abort);
+    object_property_set_bool(OBJECT(&s->bus.slave), "realized", true, errp);
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
index 0000000000..180283746e
--- /dev/null
+++ b/hw/fsi/fsi.c
@@ -0,0 +1,25 @@
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
+static const TypeInfo fsi_bus_info = {
+    .name = TYPE_FSI_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(FSIBus),
+};
+
+static void fsi_bus_register_types(void)
+{
+    type_register_static(&fsi_bus_info);
+}
+
+type_init(fsi_bus_register_types);
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index a9e7cd4099..f617943b4a 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,4 +1,4 @@
 system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
 system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
-system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index b57b2dcc86..89d8cd62c8 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -7,3 +7,5 @@ fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%"
 fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.39.2


