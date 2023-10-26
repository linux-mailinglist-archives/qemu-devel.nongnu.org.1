Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD27D86F6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3Xh-0001Mr-UA; Thu, 26 Oct 2023 12:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3Wg-0000eS-Ry; Thu, 26 Oct 2023 12:48:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3Wb-0007oY-66; Thu, 26 Oct 2023 12:48:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QGlGrp022303; Thu, 26 Oct 2023 16:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qqXLKuSj6rrTC1OTVYXls/KBUZRI6hNC2ubRoMzkwCo=;
 b=jQ/9mt0jidd+kxT6zK7UBh/xXFjXjXWzFUspLWR8i9idzNwLjqpNHmBpM2PA6nDemtzS
 gmNq80dc3TSvVgQyrM2oDtWhcd0YzmQzedJvOLnsBpyt2eRBCZwJDR+HAEemxmcjliF6
 TkD1LEccIcvf1dNhpS87DzEoXS4wqkzLGyrl4QESIeKstH6EV7+U1J3lcbm/oJO7XvMf
 iJXEucuJuB1Jj6bPn+baWxqLgjLXItafM532Sjc/BR9FGyLR7WJU2M/gNa4fswapGd1V
 hckRPCxEfiXcRDqKfC+OK6oATGLsvGjg9B08mWD4kZI3/QPeRVBpfwFajjg5yFd11EpX mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyuhfrmvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QGln3j025457;
 Thu, 26 Oct 2023 16:47:49 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyuhfrmv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QEGV7t023834; Thu, 26 Oct 2023 16:47:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvrytfpt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QGlmLK1639042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 16:47:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4930258059;
 Thu, 26 Oct 2023 16:47:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75CB258043;
 Thu, 26 Oct 2023 16:47:47 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 16:47:47 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v7 04/10] hw/fsi: Introduce IBM's FSI
Date: Thu, 26 Oct 2023 11:47:35 -0500
Message-Id: <20231026164741.1184058-5-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026164741.1184058-1-ninad@linux.ibm.com>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YlEnymWB0qNS29yhK41Zesgh3dmxNab1
X-Proofpoint-GUID: wqmJ3oRRn6BWRa6C8MCBp6bT7t6s-fJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_15,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
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
v7:
- Cleaned up unused bits.
---
 include/hw/fsi/fsi-master.h |  30 +++++++
 hw/fsi/fsi-master.c         | 162 ++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi.c                |  25 ++++++
 hw/fsi/meson.build          |   2 +-
 hw/fsi/trace-events         |   2 +
 5 files changed, 220 insertions(+), 1 deletion(-)
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
index 0000000000..bb7a893003
--- /dev/null
+++ b/hw/fsi/fsi-master.c
@@ -0,0 +1,162 @@
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
+#define FSI_MVER                                TO_REG(0x074)
+#define FSI_MRESP0                              TO_REG(0x0d0)
+
+#define FSI_MRESB0                              TO_REG(0x1d0)
+#define   FSI_MRESB0_RESET_GENERAL              BE_BIT(0)
+#define   FSI_MRESB0_RESET_ERROR                BE_BIT(1)
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


