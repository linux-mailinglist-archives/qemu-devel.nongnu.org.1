Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC0828FE8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:26:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNKVv-0006YS-Nj; Tue, 09 Jan 2024 17:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKVs-0006Vj-Tt; Tue, 09 Jan 2024 17:24:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKVq-0002C7-2A; Tue, 09 Jan 2024 17:24:00 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409MBO7Y028669; Tue, 9 Jan 2024 22:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GtnJ908+cyVOFxv3V6I52W+KIGYpUyX75PUB+rA4dJc=;
 b=BfaEexFkFqVFHEjapRWdgaJsrYjJrTWN/R9k4kntTo89OThWTEDZBhncDEQAs+Pnj+qW
 Ok/7/F9sDwoCKptSy211nKoq9uSVCaVaitcQLlPMyMlI+pLRsooWQp3NZP6XKB0E7Ddk
 AXtysaiTa5hqoTSXnOuBw/GFTTbwlw/0hWgj1qmYYrYSXlnubiHU0Q+U1ngC/3hIfHvF
 tsvun3jm0sgbOWjVkYe1OQCgy3BJ+eqPcJEKPrtUv5tsiQtWvFTpyL2A1bmSxeBnK8Ad
 TSg4bG9VZa+SvHEfTjz0YIAbtlF/wip0uXcZ5b5FV+FbJejDWSeEmv97+k0tRxgIsir2 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f90jfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:39 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409LerPk030759;
 Tue, 9 Jan 2024 22:23:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f90jeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409Ln9bA022819; Tue, 9 Jan 2024 22:23:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjyhpf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409MNbnn39059806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 22:23:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8510E5805A;
 Tue,  9 Jan 2024 22:23:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D7985805C;
 Tue,  9 Jan 2024 22:23:37 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 22:23:37 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v9 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave,scratchpad
Date: Tue,  9 Jan 2024 16:23:26 -0600
Message-Id: <20240109222333.1225031-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109222333.1225031-1-ninad@linux.ibm.com>
References: <20240109222333.1225031-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X2-rl9MwrxkJ5eOp33ewTT07llY8eqSS
X-Proofpoint-ORIG-GUID: 09ErRQiq7GB5cCZ9dKDZPu8JEMfu6azN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090179
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

The Common FRU Access Macro (CFAM), an address space containing
various "engines" that drive accesses on busses internal and external
to the POWER chip. Examples include the SBEFIFO and I2C masters. The
engines hang off of an internal Local Bus (LBUS) which is described
by the CFAM configuration block.

The FSI slave: The slave is the terminal point of the FSI bus for
FSI symbols addressed to it. Slaves can be cascaded off of one
another. The slave's configuration registers appear in address space
of the CFAM to which it is attached.

The scratchpad provides a set of non-functional registers. The firmware
is free to use them, hardware does not support any special management
support. The scratchpad registers can be read or written from LBUS
slave. The scratch pad is managed under FSI CFAM state.

[ clg: - moved object FSIScratchPad under FSICFAMState
       - moved FSIScratchPad code under cfam.c
       - introduced fsi_cfam_instance_init()
       - reworked fsi_cfam_realize() ]

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v9:
  - Added more registers to scratchpad
  - Removed unnecessary address space
  - Removed unnecessary header file
  - Defined macros for config values.
  - Cleaned up cfam config read.
---
 include/hw/fsi/cfam.h      |  46 +++++++
 include/hw/fsi/fsi-slave.h |  27 ++++
 include/hw/fsi/fsi.h       |   5 +
 hw/fsi/cfam.c              | 253 +++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi-slave.c         | 101 +++++++++++++++
 hw/fsi/Kconfig             |   8 ++
 hw/fsi/meson.build         |   3 +-
 hw/fsi/trace-events        |  10 +-
 8 files changed, 451 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/fsi-slave.h
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/fsi-slave.c

diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
new file mode 100644
index 0000000000..147bc13156
--- /dev/null
+++ b/include/hw/fsi/cfam.h
@@ -0,0 +1,46 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Common FRU Access Macro
+ */
+#ifndef FSI_CFAM_H
+#define FSI_CFAM_H
+
+#include "exec/memory.h"
+
+#include "hw/fsi/fsi-slave.h"
+#include "hw/fsi/lbus.h"
+
+
+#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
+#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
+
+#define FSI_SCRATCHPAD_NR_REGS 4
+
+typedef struct FSIScratchPad {
+        FSILBusDevice parent;
+
+        uint32_t reg[FSI_SCRATCHPAD_NR_REGS];
+} FSIScratchPad;
+
+#define TYPE_FSI_CFAM "cfam"
+#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
+
+/* P9-ism */
+#define CFAM_CONFIG_NR_REGS 0x28
+
+typedef struct FSICFAMState {
+    /* < private > */
+    FSISlaveState parent;
+
+    /* CFAM config address space */
+    MemoryRegion config_iomem;
+
+    MemoryRegion mr;
+
+    FSILBus lbus;
+    FSIScratchPad scratchpad;
+} FSICFAMState;
+
+#endif /* FSI_CFAM_H */
diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
new file mode 100644
index 0000000000..6fc15a15a0
--- /dev/null
+++ b/include/hw/fsi/fsi-slave.h
@@ -0,0 +1,27 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface slave
+ */
+#ifndef FSI_FSI_SLAVE_H
+#define FSI_FSI_SLAVE_H
+
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+
+#include "hw/fsi/lbus.h"
+
+#define TYPE_FSI_SLAVE "fsi.slave"
+OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
+
+#define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
+
+typedef struct FSISlaveState {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+    uint32_t regs[FSI_SLAVE_CONTROL_NR_REGS];
+} FSISlaveState;
+
+#endif /* FSI_FSI_H */
diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
index a75e3e5bdc..af39f9b4ad 100644
--- a/include/hw/fsi/fsi.h
+++ b/include/hw/fsi/fsi.h
@@ -8,6 +8,11 @@
 #define FSI_FSI_H
 
 #include "hw/qdev-core.h"
+#include "qemu/bitops.h"
+
+/* Bitwise operations at the word level. */
+#define BE_BIT(x)           BIT(31 - (x))
+#define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
 
 #define TYPE_FSI_BUS "fsi.bus"
 OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
new file mode 100644
index 0000000000..2ad7087102
--- /dev/null
+++ b/hw/fsi/cfam.c
@@ -0,0 +1,253 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Common FRU Access Macro
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+
+#include "qapi/error.h"
+#include "trace.h"
+
+#include "hw/fsi/cfam.h"
+#include "hw/fsi/fsi.h"
+
+#include "hw/qdev-properties.h"
+
+#define ENGINE_CONFIG_NEXT            BE_BIT(0)
+#define ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
+#define ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
+#define ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
+
+/* Valid, slots, version, type, crc */
+#define CFAM_CONFIG_REG_PEEK               (ENGINE_CONFIG_NEXT       | \
+                                            0x00010000               | \
+                                            0x00001000               | \
+                                            ENGINE_CONFIG_TYPE_PEEK  | \
+                                            0x0000000c)
+
+/* Valid, slots, version, type, crc */
+#define CFAM_CONFIG_REG_FSI_SLAVE          (ENGINE_CONFIG_NEXT       | \
+                                            0x00010000               | \
+                                            0x00005000               | \
+                                            ENGINE_CONFIG_TYPE_FSI   | \
+                                            0x0000000a)
+
+/* Valid, slots, version, type, crc */
+#define CFAM_CONFIG_REG_SCRATCHPAD         (ENGINE_CONFIG_NEXT       | \
+                                            0x00010000               | \
+                                            0x00001000               | \
+                                            ENGINE_CONFIG_TYPE_SCRATCHPAD | \
+                                            0x00000007)
+
+#define TO_REG(x)                          ((x) >> 2)
+
+#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
+#define CFAM_CONFIG_PEEK_STATUS            TO_REG(0x04)
+#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
+#define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
+
+static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, unsigned size)
+{
+    trace_fsi_cfam_config_read(addr, size);
+
+    switch (addr) {
+    case 0x00:
+        return CFAM_CONFIG_CHIP_ID_P9;
+    case 0x04:
+        return CFAM_CONFIG_REG_PEEK;
+    case 0x08:
+        return CFAM_CONFIG_REG_FSI_SLAVE;
+    case 0xc:
+        return CFAM_CONFIG_REG_SCRATCHPAD;
+    default:
+        /*
+         * The config table contains different engines from 0xc onwards.
+         * The scratch pad is already added at address 0xc. We need to add
+         * future engines from address 0x10 onwards. Returning 0 as engine
+         * is not implemented.
+         */
+        return 0;
+    }
+}
+
+static void fsi_cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned size)
+{
+    FSICFAMState *cfam = FSI_CFAM(opaque);
+
+    trace_fsi_cfam_config_write(addr, size, data);
+
+    switch (TO_REG(addr)) {
+    case CFAM_CONFIG_CHIP_ID:
+    case CFAM_CONFIG_PEEK_STATUS:
+        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
+            bus_cold_reset(BUS(&cfam->lbus));
+        }
+        break;
+    default:
+        trace_fsi_cfam_config_write_noaddr(addr, size, data);
+    }
+}
+
+static const struct MemoryRegionOps cfam_config_ops = {
+    .read = fsi_cfam_config_read,
+    .write = fsi_cfam_config_write,
+    .valid.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .impl.min_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t fsi_cfam_unimplemented_read(void *opaque, hwaddr addr,
+                                            unsigned size)
+{
+    trace_fsi_cfam_unimplemented_read(addr, size);
+
+    return 0;
+}
+
+static void fsi_cfam_unimplemented_write(void *opaque, hwaddr addr,
+                                         uint64_t data, unsigned size)
+{
+    trace_fsi_cfam_unimplemented_write(addr, size, data);
+}
+
+static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
+    .read = fsi_cfam_unimplemented_read,
+    .write = fsi_cfam_unimplemented_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_cfam_instance_init(Object *obj)
+{
+    FSICFAMState *s = FSI_CFAM(obj);
+
+    object_initialize_child(obj, "scratchpad", &s->scratchpad,
+                            TYPE_FSI_SCRATCHPAD);
+}
+
+static void fsi_cfam_realize(DeviceState *dev, Error **errp)
+{
+    FSICFAMState *cfam = FSI_CFAM(dev);
+    FSISlaveState *slave = FSI_SLAVE(dev);
+
+    /* Each slave has a 2MiB address space */
+    memory_region_init_io(&cfam->mr, OBJECT(cfam), &fsi_cfam_unimplemented_ops,
+                          cfam, TYPE_FSI_CFAM, 2 * MiB);
+
+    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS, DEVICE(cfam),
+              NULL);
+
+    memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), &cfam_config_ops,
+                          cfam, TYPE_FSI_CFAM ".config", 0x400);
+
+    memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
+    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
+    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
+
+    /* Add scratchpad engine */
+    if (!qdev_realize(DEVICE(&cfam->scratchpad), BUS(&cfam->lbus),
+                                errp)) {
+        return;
+    }
+
+    FSILBusDevice *fsi_dev = FSI_LBUS_DEVICE(&cfam->scratchpad);
+    memory_region_add_subregion(&cfam->lbus.mr, 0, &fsi_dev->iomem);
+}
+
+static void fsi_cfam_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->bus_type = TYPE_FSI_BUS;
+    dc->realize = fsi_cfam_realize;
+}
+
+static const TypeInfo fsi_cfam_info = {
+    .name = TYPE_FSI_CFAM,
+    .parent = TYPE_FSI_SLAVE,
+    .instance_init = fsi_cfam_instance_init,
+    .instance_size = sizeof(FSICFAMState),
+    .class_init = fsi_cfam_class_init,
+};
+
+static uint64_t fsi_scratchpad_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSIScratchPad *s = SCRATCHPAD(opaque);
+
+    trace_fsi_scratchpad_read(addr, size);
+
+    if (addr & ~(FSI_SCRATCHPAD_NR_REGS - 1)) {
+        return 0;
+    }
+
+    return s->reg[addr];
+}
+
+static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    FSIScratchPad *s = SCRATCHPAD(opaque);
+
+    trace_fsi_scratchpad_write(addr, size, data);
+
+    if (addr & ~(FSI_SCRATCHPAD_NR_REGS - 1)) {
+        return;
+    }
+
+    s->reg[addr] = data;
+}
+
+static const struct MemoryRegionOps scratchpad_ops = {
+    .read = fsi_scratchpad_read,
+    .write = fsi_scratchpad_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_scratchpad_realize(DeviceState *dev, Error **errp)
+{
+    FSILBusDevice *ldev = FSI_LBUS_DEVICE(dev);
+
+    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
+                          ldev, TYPE_FSI_SCRATCHPAD, 0x400);
+}
+
+static void fsi_scratchpad_reset(DeviceState *dev)
+{
+    FSIScratchPad *s = SCRATCHPAD(dev);
+    int i;
+
+    for (i = 0; i < FSI_SCRATCHPAD_NR_REGS; i++) {
+        s->reg[i] = 0;
+    }
+}
+
+static void fsi_scratchpad_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    FSILBusDeviceClass *ldc = FSI_LBUS_DEVICE_CLASS(klass);
+
+    dc->realize = fsi_scratchpad_realize;
+    dc->reset = fsi_scratchpad_reset;
+
+    ldc->config = CFAM_CONFIG_REG_SCRATCHPAD;
+}
+
+static const TypeInfo fsi_scratchpad_info = {
+    .name = TYPE_FSI_SCRATCHPAD,
+    .parent = TYPE_FSI_LBUS_DEVICE,
+    .instance_size = sizeof(FSIScratchPad),
+    .class_init = fsi_scratchpad_class_init,
+    .class_size = sizeof(FSILBusDeviceClass),
+};
+
+static void fsi_cfam_register_types(void)
+{
+    type_register_static(&fsi_scratchpad_info);
+    type_register_static(&fsi_cfam_info);
+}
+
+type_init(fsi_cfam_register_types);
diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
new file mode 100644
index 0000000000..75dcf6240f
--- /dev/null
+++ b/hw/fsi/fsi-slave.c
@@ -0,0 +1,101 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface slave
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+#include "hw/fsi/fsi-slave.h"
+#include "hw/fsi/fsi.h"
+
+#define TO_REG(x)                               ((x) >> 2)
+
+static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
+    int reg = TO_REG(addr);
+
+    trace_fsi_slave_read(addr, size);
+
+    if (reg >= FSI_SLAVE_CONTROL_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->regs[reg];
+}
+
+static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
+    int reg = TO_REG(addr);
+
+    trace_fsi_slave_write(addr, size, data);
+
+    if (reg >= FSI_SLAVE_CONTROL_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    s->regs[reg] = data;
+}
+
+static const struct MemoryRegionOps fsi_slave_ops = {
+    .read = fsi_slave_read,
+    .write = fsi_slave_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_slave_reset(DeviceState *dev)
+{
+    FSISlaveState *s = FSI_SLAVE(dev);
+    int i;
+
+    /* Initialize registers */
+    for (i = 0; i < FSI_SLAVE_CONTROL_NR_REGS; i++) {
+        s->regs[i] = 0;
+    }
+}
+
+static void fsi_slave_init(Object *o)
+{
+    FSISlaveState *s = FSI_SLAVE(o);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
+                          s, TYPE_FSI_SLAVE, 0x400);
+}
+
+static void fsi_slave_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->bus_type = TYPE_FSI_BUS;
+    dc->desc = "FSI Slave";
+    dc->reset = fsi_slave_reset;
+}
+
+static const TypeInfo fsi_slave_info = {
+    .name = TYPE_FSI_SLAVE,
+    .parent = TYPE_DEVICE,
+    .instance_init = fsi_slave_init,
+    .instance_size = sizeof(FSISlaveState),
+    .class_init = fsi_slave_class_init,
+};
+
+static void fsi_slave_register_types(void)
+{
+    type_register_static(&fsi_slave_info);
+}
+
+type_init(fsi_slave_register_types);
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index f4869c209f..de1594a335 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,3 +1,11 @@
+config FSI_CFAM
+    bool
+    select FSI
+    select FSI_LBUS
+
+config FSI
+    bool
+
 config FSI
     bool
 
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index 487fb31cbc..cafd009c6d 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
-system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c'))
+system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-slave.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index 8b13789179..b57b2dcc86 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -1 +1,9 @@
-
+fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.39.2


