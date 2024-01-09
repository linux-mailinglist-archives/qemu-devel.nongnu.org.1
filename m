Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E92828FE0
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNKVt-0006Vh-Er; Tue, 09 Jan 2024 17:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKVq-0006UB-Vn; Tue, 09 Jan 2024 17:23:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKVo-0002Ay-VZ; Tue, 09 Jan 2024 17:23:58 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409M4A7t022981; Tue, 9 Jan 2024 22:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=mJB/EdVjuIj+Cfm1wNhEC5AdlwtsZnYknJZ7X543E5w=;
 b=YP1W8n2oVXfOvE81TmEi4oplqcLviscYt3WanxVza5nSjcSbnkpbzRpdWeM6wV9yKo5J
 JL/4pLncgw0VuJkwKeN93EwNf3N1JYoiWte/bPoqgcCe2Qbz8iIJ5GSPDV8ZA0oB7Xen
 KhSSb+1schR/OBFVUJ7USs9R3aemPDXpByTPiZkFHJwfTrgbZbS2FkwB3qnc9xV8v2Bk
 ADuU/r9bz1w0A6dYNJ5DYylIb9SovrghaHJ3/RXqzXN+6WiZ/NuIo9/as/XJWsgJZ9dS
 ocpHBHXoFX6g96bDeIe4f282gFd8zu8G0BlP9JmGVce97uqA41/TJ02h2DmfkQL7+4pO UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhd1stfu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409MKrGa002189;
 Tue, 9 Jan 2024 22:23:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhd1stfta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409KKc8W000906; Tue, 9 Jan 2024 22:23:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdk96te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:23:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409MNcHu14942862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 22:23:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6011D58051;
 Tue,  9 Jan 2024 22:23:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02BD85805E;
 Tue,  9 Jan 2024 22:23:38 +0000 (GMT)
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
Subject: [PATCH v9 05/10] hw/fsi: Introduce IBM's FSI master
Date: Tue,  9 Jan 2024 16:23:28 -0600
Message-Id: <20240109222333.1225031-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109222333.1225031-1-ninad@linux.ibm.com>
References: <20240109222333.1225031-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OlLQvsfBhIdM9RFNbVP4aHPgDI5lHH8q
X-Proofpoint-GUID: 1afJ0X0zQXZHvANAeI_RXxBHfT8YrqJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=954
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This commit models the FSI master. CFAM is hanging out of FSI master which is a bus controller.

The FSI master: A controller in the platform service processor (e.g.
BMC) driving CFAM engine accesses into the POWER chip. At the
hardware level FSI is a bit-based protocol supporting synchronous and
DMA-driven accesses of engines in a CFAM.

[ clg: - move FSICFAMState object under FSIMasterState
       - introduced fsi_master_init()
       - reworked fsi_master_realize()
       - dropped FSIBus definition ]

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v9:
  - Initialized registers.
  - Fixed the address check.
---
 include/hw/fsi/fsi-master.h |  32 +++++++
 hw/fsi/fsi-master.c         | 173 ++++++++++++++++++++++++++++++++++++
 hw/fsi/meson.build          |   2 +-
 hw/fsi/trace-events         |   2 +
 4 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 hw/fsi/fsi-master.c

diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
new file mode 100644
index 0000000000..3830869877
--- /dev/null
+++ b/include/hw/fsi/fsi-master.h
@@ -0,0 +1,32 @@
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
+#include "hw/fsi/cfam.h"
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
+    FSICFAMState cfam;
+} FSIMasterState;
+
+
+#endif /* FSI_FSI_H */
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
new file mode 100644
index 0000000000..939de5927f
--- /dev/null
+++ b/hw/fsi/fsi-master.c
@@ -0,0 +1,173 @@
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
+    int reg = TO_REG(addr);
+
+    trace_fsi_master_read(addr, size);
+
+    if (reg >= FSI_MASTER_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->regs[reg];
+}
+
+static void fsi_master_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    FSIMasterState *s = FSI_MASTER(opaque);
+    int reg = TO_REG(addr);
+
+    trace_fsi_master_write(addr, size, data);
+
+    if (reg >= FSI_MASTER_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    switch (reg) {
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
+        s->regs[reg] = data;
+    }
+}
+
+static const struct MemoryRegionOps fsi_master_ops = {
+    .read = fsi_master_read,
+    .write = fsi_master_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_master_init(Object *o)
+{
+    FSIMasterState *s = FSI_MASTER(o);
+
+    object_initialize_child(o, "cfam", &s->cfam, TYPE_FSI_CFAM);
+
+    qbus_init(&s->bus, sizeof(s->bus), TYPE_FSI_BUS, DEVICE(s), NULL);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_master_ops, s,
+                          TYPE_FSI_MASTER, 0x10000000);
+    memory_region_init(&s->opb2fsi, OBJECT(s), "fsi.opb2fsi", 0x10000000);
+}
+
+static void fsi_master_realize(DeviceState *dev, Error **errp)
+{
+    FSIMasterState *s = FSI_MASTER(dev);
+
+    if (!qdev_realize(DEVICE(&s->cfam), BUS(&s->bus), errp)) {
+        return;
+    }
+
+    /* address ? */
+    memory_region_add_subregion(&s->opb2fsi, 0, &s->cfam.mr);
+}
+
+static void fsi_master_reset(DeviceState *dev)
+{
+    FSIMasterState *s = FSI_MASTER(dev);
+    int i;
+
+    /* Initialize registers */
+    for (i = 0; i < FSI_MASTER_NR_REGS; i++) {
+        s->regs[i] = 0;
+    }
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
+    .instance_init = fsi_master_init,
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
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index ba92881370..038c4468ee 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,4 +1,4 @@
 system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
-system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
 system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
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


