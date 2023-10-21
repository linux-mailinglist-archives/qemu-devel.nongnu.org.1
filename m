Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936A17D1FC2
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJLt-0003o3-UB; Sat, 21 Oct 2023 17:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJLr-0003mY-Am; Sat, 21 Oct 2023 17:17:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJLo-0005Sx-8s; Sat, 21 Oct 2023 17:17:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LLAkmV015280; Sat, 21 Oct 2023 21:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ML9GCWfKkWkDp9qiSvPP/zc54/fAzmFtFR+NkD8lI30=;
 b=hQIYUneMaZPdvwJxQ8bAqgjO1/tApd3h12BFj5SG2rl6iIzy2/6WiYDHIjfdt8+0zv1t
 t/bFT950nqsqEUCxDqupTL06SHgfqb878lq0xk73A/LwU5wVhlk1JiLyQIAZjNdmeZP/
 x5NE0CIfaaTGR/ccQ3A6wwXiZFEeJkBIhdiCtcfcylRZURQJCQciiTWbX6V+KE3Uygq6
 BrkiJ0oxNLXaZ32gWiDnhaGAsJAprccurRigc3UN+4RPP0+oNgWSnWL3syUqashORctz
 4fpgjaX9CVE3Aa5OM9k+Ovq0DyW8AkaIg4KwOT/OuTscF791GEmul+loAryhvWj2Gy5Q EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvny1ghsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LLAw43015881;
 Sat, 21 Oct 2023 21:17:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvny1ghsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKMT5B019458; Sat, 21 Oct 2023 21:17:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc45dcew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:25 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHPp821299824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E42758052;
 Sat, 21 Oct 2023 21:17:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFDD458056;
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
Subject: [PATCH v6 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Date: Sat, 21 Oct 2023 16:17:14 -0500
Message-Id: <20231021211720.3571082-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021211720.3571082-1-ninad@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: laqBV07KHXtOeFqSX6QfxCDBrXFuG562
X-Proofpoint-GUID: knSsVA1x16odMV3ddkImNYu1u2r8lq9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=995 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
POWER processors. This now makes an appearance in the ASPEED SoC due
to tight integration of the FSI master IP with the OPB, mainly the
existence of an MMIO-mapping of the CFAM address straight onto a
sub-region of the OPB address space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v2:
- Incorporated review comment by Joel.
v5:
- Incorporated review comments by Cedric.
v6:
- Incorporated review comments by Cedric & Daniel
---
 include/hw/fsi/opb.h |  43 ++++++++++++
 hw/fsi/fsi-master.c  |   3 +-
 hw/fsi/opb.c         | 164 +++++++++++++++++++++++++++++++++++++++++++
 hw/fsi/Kconfig       |   4 ++
 hw/fsi/meson.build   |   1 +
 hw/fsi/trace-events  |   8 +++
 6 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/fsi/opb.h
 create mode 100644 hw/fsi/opb.c

diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
new file mode 100644
index 0000000000..9b143564ae
--- /dev/null
+++ b/include/hw/fsi/opb.h
@@ -0,0 +1,43 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-Chip Peripheral Bus
+ */
+#ifndef FSI_OPB_H
+#define FSI_OPB_H
+
+#include "exec/memory.h"
+#include "hw/fsi/fsi-master.h"
+
+#define TYPE_OP_BUS "opb"
+OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
+
+typedef struct OPBus {
+        /*< private >*/
+        BusState bus;
+
+        /*< public >*/
+        MemoryRegion mr;
+        AddressSpace as;
+
+        /* Model OPB as dumb enough just to provide an address-space */
+        /* TODO: Maybe don't store device state in the bus? */
+        FSIMasterState fsi;
+} OPBus;
+
+typedef struct OPBusClass {
+        BusClass parent_class;
+} OPBusClass;
+
+uint8_t fsi_opb_read8(OPBus *opb, hwaddr addr);
+uint16_t fsi_opb_read16(OPBus *opb, hwaddr addr);
+uint32_t fsi_opb_read32(OPBus *opb, hwaddr addr);
+void fsi_opb_write8(OPBus *opb, hwaddr addr, uint8_t data);
+void fsi_opb_write16(OPBus *opb, hwaddr addr, uint16_t data);
+void fsi_opb_write32(OPBus *opb, hwaddr addr, uint32_t data);
+
+void fsi_opb_fsi_master_address(OPBus *opb, hwaddr addr);
+void fsi_opb_opb2fsi_address(OPBus *opb, hwaddr addr);
+
+#endif /* FSI_OPB_H */
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index fa23af3de2..91d1a57c4e 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -11,8 +11,7 @@
 #include "trace.h"
 
 #include "hw/fsi/fsi-master.h"
-
-#define TYPE_OP_BUS "opb"
+#include "hw/fsi/opb.h"
 
 #define TO_REG(x)                               ((x) >> 2)
 
diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
new file mode 100644
index 0000000000..087e233701
--- /dev/null
+++ b/hw/fsi/opb.c
@@ -0,0 +1,164 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-chip Peripheral Bus
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+#include "hw/fsi/opb.h"
+
+uint8_t fsi_opb_read8(OPBus *opb, hwaddr addr)
+{
+    MemTxResult tx;
+    uint8_t data;
+
+    tx = address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                            sizeof(data));
+    if (tx) {
+        trace_fsi_opb_read8(addr, sizeof(data));
+    }
+
+    return data;
+}
+
+uint16_t fsi_opb_read16(OPBus *opb, hwaddr addr)
+{
+    MemTxResult tx;
+    uint16_t data;
+
+    tx = address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                            sizeof(data));
+    if (tx) {
+        trace_fsi_opb_read16(addr, sizeof(data));
+    }
+
+    return data;
+}
+
+uint32_t fsi_opb_read32(OPBus *opb, hwaddr addr)
+{
+    MemTxResult tx;
+    uint32_t data;
+
+    tx = address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                            sizeof(data));
+    if (tx) {
+        trace_fsi_opb_read32(addr, sizeof(data));
+    }
+
+    return data;
+}
+
+void fsi_opb_write8(OPBus *opb, hwaddr addr, uint8_t data)
+{
+    MemTxResult tx;
+
+    tx = address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                             sizeof(data));
+    if (tx) {
+        trace_fsi_opb_write8(addr, sizeof(data));
+    }
+}
+
+void fsi_opb_write16(OPBus *opb, hwaddr addr, uint16_t data)
+{
+    MemTxResult tx;
+
+    tx = address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                             sizeof(data));
+    if (tx) {
+        trace_fsi_opb_write16(addr, sizeof(data));
+    }
+}
+
+void fsi_opb_write32(OPBus *opb, hwaddr addr, uint32_t data)
+{
+    MemTxResult tx;
+
+    tx = address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, &data,
+                             sizeof(data));
+    if (tx) {
+        trace_fsi_opb_write32(addr, sizeof(data));
+    }
+}
+
+void fsi_opb_fsi_master_address(OPBus *opb, hwaddr addr)
+{
+    memory_region_transaction_begin();
+    memory_region_set_address(&opb->fsi.iomem, addr);
+    memory_region_transaction_commit();
+}
+
+void fsi_opb_opb2fsi_address(OPBus *opb, hwaddr addr)
+{
+    memory_region_transaction_begin();
+    memory_region_set_address(&opb->fsi.opb2fsi, addr);
+    memory_region_transaction_commit();
+}
+
+static void fsi_opb_realize(BusState *bus, Error **errp)
+{
+    OPBus *opb = OP_BUS(bus);
+
+    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
+                          NULL, UINT32_MAX);
+    address_space_init(&opb->as, &opb->mr, "opb");
+
+    if (!object_property_set_bool(OBJECT(&opb->fsi), "realized", true, errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
+
+    /* OPB2FSI region */
+    /*
+     * Avoid endianness issues by mapping each slave's memory region directly.
+     * Manually bridging multiple address-spaces causes endian swapping
+     * headaches as memory_region_dispatch_read() and
+     * memory_region_dispatch_write() correct the endianness based on the
+     * target machine endianness and not relative to the device endianness on
+     * either side of the bridge.
+     */
+    /*
+     * XXX: This is a bit hairy and will need to be fixed when I sort out the
+     * bus/slave relationship and any changes to the CFAM modelling (multiple
+     * slaves, LBUS)
+     */
+    memory_region_add_subregion(&opb->mr, 0xa0000000, &opb->fsi.opb2fsi);
+}
+
+static void fsi_opb_init(Object *o)
+{
+    OPBus *opb = OP_BUS(o);
+
+    object_initialize_child(o, "fsi-master", &opb->fsi, TYPE_FSI_MASTER);
+    qdev_set_parent_bus(DEVICE(&opb->fsi), BUS(o), &error_abort);
+}
+
+static void fsi_opb_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *bc = BUS_CLASS(klass);
+    bc->realize = fsi_opb_realize;
+}
+
+static const TypeInfo opb_info = {
+    .name = TYPE_OP_BUS,
+    .parent = TYPE_BUS,
+    .instance_init = fsi_opb_init,
+    .instance_size = sizeof(OPBus),
+    .class_init = fsi_opb_class_init,
+    .class_size = sizeof(OPBusClass),
+};
+
+static void fsi_opb_register_types(void)
+{
+    type_register_static(&opb_info);
+}
+
+type_init(fsi_opb_register_types);
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index 8d712e77ed..0f6e6d331a 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,3 +1,7 @@
+config FSI_OPB
+    bool
+    select FSI_CFAM
+
 config FSI_CFAM
     bool
     select FSI
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index f617943b4a..407b8c2775 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
 system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
 system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
index 89d8cd62c8..13b211a815 100644
--- a/hw/fsi/trace-events
+++ b/hw/fsi/trace-events
@@ -9,3 +9,11 @@ fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
+fsi_opb_read8(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_read16(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_read32(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_write8(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_write16(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_write32(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_opb_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.39.2


