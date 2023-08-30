Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83178D20D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAvM-0002n5-HK; Tue, 29 Aug 2023 22:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbAvE-0002dc-RJ; Tue, 29 Aug 2023 22:27:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbAv7-0002Eg-7x; Tue, 29 Aug 2023 22:27:06 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U1nFDN016762; Wed, 30 Aug 2023 02:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cZ0bLWxeIdXvI9cZqayy6lGqp382g4iie7k5RwBUeMM=;
 b=jL4htKolTiPC4OMA5t8k8ovOSFg238gZleDHxODN5/AmEZhbgxUCHnrU/Bp/Py/fA2/h
 HXnbSMxsTwT89cms+gbtfY0OkSBSMDhui0bMZszVuPMWm9qH/CysK8f9KQJAILn10+bi
 jJlSKI6jWwIss1mbhH5kFBxF2xGH3KuMbVQ5miPeLp9qAyueHA8eXXDW9goWAPrhNte5
 E/WqLb9094U9jsoRi9ReBq3rVveRTroHa+l2VY4ROm2Zl1OkFiX1szSKUSMvIbM7CV37
 Nv3jgiNdon/ESdcj6ww7UAmTCFazO54qgg4HwfCI6OgMxkRAwim41oiU1/YXU6hhuWtx sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssvb70y4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37U2GB7V003826;
 Wed, 30 Aug 2023 02:26:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssvb70y49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U2IM52020520; Wed, 30 Aug 2023 02:26:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3ygm79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37U2QjVa4391452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 02:26:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B80B58054;
 Wed, 30 Aug 2023 02:26:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7300A58050;
 Wed, 30 Aug 2023 02:26:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Aug 2023 02:26:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v3 3/8] hw/fsi: Introduce IBM's cfam,fsi-slave
Date: Tue, 29 Aug 2023 21:26:33 -0500
Message-Id: <20230830022638.4183766-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830022638.4183766-1-ninad@linux.ibm.com>
References: <20230830022638.4183766-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q1xjQwC0rfq0OKI82GTQbxsumCum6PtB
X-Proofpoint-GUID: 03FrxDRJYfp3LqPYNKfqytP8IlY04NNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300017
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

The Common FRU Access Macro (CFAM), an address space containing
various "engines" that drive accesses on busses internal and external
to the POWER chip. Examples include the SBEFIFO and I2C masters. The
engines hang off of an internal Local Bus (LBUS) which is described
by the CFAM configuration block.

The FSI slave: The slave is the terminal point of the FSI bus for
FSI symbols addressed to it. Slaves can be cascaded off of one
another. The slave's configuration registers appear in address space
of the CFAM to which it is attached.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
- Incorporated Joel's review comments.
v3:
- Incorporated Thomas Huth's review comments.
---
 hw/fsi/Kconfig             |   9 ++
 hw/fsi/cfam.c              | 241 +++++++++++++++++++++++++++++++++++++
 hw/fsi/fsi-slave.c         | 109 +++++++++++++++++
 hw/fsi/meson.build         |   2 +
 include/hw/fsi/cfam.h      |  61 ++++++++++
 include/hw/fsi/fsi-slave.h |  29 +++++
 6 files changed, 451 insertions(+)
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/fsi-slave.c
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/fsi-slave.h

diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index 2a9c49f2c9..087980be22 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,3 +1,12 @@
+config CFAM
+    bool
+    select FSI
+    select SCRATCHPAD
+    select LBUS
+
+config FSI
+    bool
+
 config SCRATCHPAD
     bool
     select LBUS
diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
new file mode 100644
index 0000000000..c91fbfbbaa
--- /dev/null
+++ b/hw/fsi/cfam.c
@@ -0,0 +1,241 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Common FRU Access Macro
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/fsi/bits.h"
+#include "hw/fsi/cfam.h"
+#include "hw/fsi/engine-scratchpad.h"
+
+#include "hw/qdev-properties.h"
+
+#define TO_REG(x)                          ((x) >> 2)
+
+#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
+
+#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
+#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
+#define   CFAM_CONFIG_CHIP_ID_BREAK        0xc0de0000
+
+static uint64_t cfam_config_read(void *opaque, hwaddr addr, unsigned size)
+{
+    CFAMConfig *config;
+    CFAMState *cfam;
+    LBusNode *node;
+    int i;
+
+    config = CFAM_CONFIG(opaque);
+    cfam = container_of(config, CFAMState, config);
+
+    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
+                  __func__, addr, size);
+
+    assert(size == 4);
+    assert(!(addr & 3));
+
+    switch (addr) {
+    case 0x00:
+        return CFAM_CONFIG_CHIP_ID_P9;
+    case 0x04:
+        return ENGINE_CONFIG_NEXT
+            | 0x00010000                    /* slots */
+            | 0x00001000                    /* version */
+            | ENGINE_CONFIG_TYPE_PEEK   /* type */
+            | 0x0000000c;                   /* crc */
+    case 0x08:
+        return ENGINE_CONFIG_NEXT
+            | 0x00010000                    /* slots */
+            | 0x00005000                    /* version */
+            | ENGINE_CONFIG_TYPE_FSI    /* type */
+            | 0x0000000a;                   /* crc */
+        break;
+    default:
+        /* FIXME: Improve this */
+        i = 0xc;
+        QLIST_FOREACH(node, &cfam->lbus.devices, next) {
+            if (i == addr) {
+                return LBUS_DEVICE_GET_CLASS(node->ldev)->config;
+            }
+            i += size;
+        }
+
+        if (i == addr) {
+            return 0;
+        }
+
+        /*
+         * As per FSI specification, This is a magic value at address 0 of
+         * given FSI port. This causes FSI master to send BREAK command for
+         * initialization and recovery.
+         */
+        return 0xc0de0000;
+    }
+}
+
+static void cfam_config_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    CFAMConfig *s = CFAM_CONFIG(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
+                  "value=%"PRIx64"\n", __func__, addr, size, data);
+
+    assert(size == 4);
+    assert(!(addr & 3));
+
+    switch (TO_REG(addr)) {
+    case CFAM_CONFIG_CHIP_ID:
+    case CFAM_CONFIG_CHIP_ID + 4:
+        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
+            bus_cold_reset(qdev_get_parent_bus(DEVICE(s)));
+        }
+    break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Not implemented: 0x%"
+                      HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+    }
+}
+
+static const struct MemoryRegionOps cfam_config_ops = {
+    .read = cfam_config_read,
+    .write = cfam_config_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void cfam_config_realize(DeviceState *dev, Error **errp)
+{
+    CFAMConfig *s = CFAM_CONFIG(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &cfam_config_ops, s,
+                          TYPE_CFAM_CONFIG, 0x400);
+}
+
+static void cfam_config_reset(DeviceState *dev)
+{
+    /* Config is read-only */
+}
+
+static void cfam_config_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->bus_type = TYPE_LBUS;
+    dc->realize = cfam_config_realize;
+    dc->reset = cfam_config_reset;
+}
+
+static const TypeInfo cfam_config_info = {
+    .name = TYPE_CFAM_CONFIG,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CFAMConfig),
+    .class_init = cfam_config_class_init,
+};
+
+static uint64_t cfam_unimplemented_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
+                  __func__, addr, size);
+
+    return 0;
+}
+
+static void cfam_unimplemented_write(void *opaque, hwaddr addr, uint64_t data,
+                                     unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
+                  "value=%"PRIx64"\n", __func__, addr, size, data);
+}
+
+static const struct MemoryRegionOps cfam_unimplemented_ops = {
+    .read = cfam_unimplemented_read,
+    .write = cfam_unimplemented_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void cfam_realize(DeviceState *dev, Error **errp)
+{
+    CFAMState *cfam = CFAM(dev);
+    FSISlaveState *slave = FSI_SLAVE(dev);
+    Error *err = NULL;
+
+    /* Each slave has a 2MiB address space */
+    memory_region_init_io(&cfam->mr, OBJECT(cfam), &cfam_unimplemented_ops,
+                          cfam, TYPE_CFAM, 2 * 1024 * 1024);
+    address_space_init(&cfam->as, &cfam->mr, TYPE_CFAM);
+
+    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_LBUS,
+                        DEVICE(cfam), NULL);
+
+    lbus_create_device(&cfam->lbus, TYPE_SCRATCHPAD, 0);
+
+    object_property_set_bool(OBJECT(&cfam->config), "realized", true, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(&cfam->config), BUS(&cfam->lbus), &error_abort);
+
+    object_property_set_bool(OBJECT(&cfam->lbus), "realized", true, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&cfam->mr, 0, &cfam->config.iomem);
+    /* memory_region_add_subregion(&cfam->mr, 0x800, &cfam->lbus.peek.iomem); */
+    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
+    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
+}
+
+static void cfam_reset(DeviceState *dev)
+{
+    /* TODO: Figure out how inherited reset works */
+    qemu_log_mask(LOG_UNIMP, "%s: Not implemented yet.\n", __func__);
+}
+
+static void cfam_init(Object *o)
+{
+    CFAMState *s = CFAM(o);
+
+    object_initialize_child(o, TYPE_CFAM_CONFIG, &s->config, TYPE_CFAM_CONFIG);
+}
+
+static void cfam_finalize(Object *o)
+{
+    CFAMState *s = CFAM(o);
+
+    address_space_destroy(&s->as);
+}
+
+static void cfam_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->bus_type = TYPE_FSI_BUS;
+    dc->realize = cfam_realize;
+    dc->reset = cfam_reset;
+}
+
+static const TypeInfo cfam_info = {
+    .name = TYPE_CFAM,
+    .parent = TYPE_FSI_SLAVE,
+    .instance_init = cfam_init,
+    .instance_finalize = cfam_finalize,
+    .instance_size = sizeof(CFAMState),
+    .class_init = cfam_class_init,
+};
+
+static void cfam_register_types(void)
+{
+    type_register_static(&cfam_config_info);
+    type_register_static(&cfam_info);
+}
+
+type_init(cfam_register_types);
diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
new file mode 100644
index 0000000000..10df5b243f
--- /dev/null
+++ b/hw/fsi/fsi-slave.c
@@ -0,0 +1,109 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface slave
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/bitops.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/fsi/fsi-slave.h"
+
+#define TO_REG(x)                               ((x) >> 2)
+
+#define FSI_SMODE               TO_REG(0x00)
+#define   FSI_SMODE_WSTART      BE_BIT(0)
+#define   FSI_SMODE_AUX_EN      BE_BIT(1)
+#define   FSI_SMODE_SLAVE_ID    BE_GENMASK(6, 7)
+#define   FSI_SMODE_ECHO_DELAY  BE_GENMASK(8, 11)
+#define   FSI_SMODE_SEND_DELAY  BE_GENMASK(12, 15)
+#define   FSI_SMODE_LBUS_DIV    BE_GENMASK(20, 23)
+#define   FSI_SMODE_BRIEF_LEFT  BE_GENMASK(24, 27)
+#define   FSI_SMODE_BRIEF_RIGHT BE_GENMASK(28, 31)
+
+#define FSI_SDMA                TO_REG(0x04)
+#define FSI_SISC                TO_REG(0x08)
+#define FSI_SCISC               TO_REG(0x08)
+#define FSI_SISM                TO_REG(0x0c)
+#define FSI_SISS                TO_REG(0x10)
+#define FSI_SSISM               TO_REG(0x10)
+#define FSI_SCISM               TO_REG(0x14)
+
+static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
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
+static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    FSISlaveState *s = FSI_SLAVE(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
+                  "value=%"PRIx64"\n", __func__, addr, size, data);
+
+    if (addr + size > sizeof(s->regs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    s->regs[TO_REG(addr)] = data;
+}
+
+static const struct MemoryRegionOps fsi_slave_ops = {
+    .read = fsi_slave_read,
+    .write = fsi_slave_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void fsi_slave_init(Object *o)
+{
+    FSISlaveState *s = FSI_SLAVE(o);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
+                          s, TYPE_FSI_SLAVE, 0x400);
+}
+
+static void fsi_slave_reset(DeviceState *dev)
+{
+    /* FIXME */
+}
+
+static void fsi_slave_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
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
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index f90e09ddab..5600502b33 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1,2 +1,4 @@
 system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
+system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
+system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
new file mode 100644
index 0000000000..af9f88cb22
--- /dev/null
+++ b/include/hw/fsi/cfam.h
@@ -0,0 +1,61 @@
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
+#define TYPE_FSI_BUS "fsi.bus"
+
+#define TYPE_CFAM "cfam"
+#define CFAM(obj) OBJECT_CHECK(CFAMState, (obj), TYPE_CFAM)
+
+#define CFAM_NR_REGS ((0x2e0 >> 2) + 1)
+
+#define TYPE_CFAM_CONFIG "cfam.config"
+#define CFAM_CONFIG(obj) \
+    OBJECT_CHECK(CFAMConfig, (obj), TYPE_CFAM_CONFIG)
+/* P9-ism */
+#define CFAM_CONFIG_NR_REGS 0x28
+
+typedef struct CFAMState CFAMState;
+
+/* TODO: Generalise this accommodate different CFAM configurations */
+typedef struct CFAMConfig {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+} CFAMConfig;
+
+#define TYPE_CFAM_PEEK "cfam.peek"
+#define CFAM_PEEK(obj) \
+    OBJECT_CHECK(CFAMPeek, (obj), TYPE_CFAM_PEEK)
+#define CFAM_PEEK_NR_REGS ((0x130 >> 2) + 1)
+
+typedef struct CFAMPeek {
+    DeviceState parent;
+
+    MemoryRegion iomem;
+} CFAMPeek;
+
+struct CFAMState {
+    /* < private > */
+    FSISlaveState parent;
+
+    MemoryRegion mr;
+    AddressSpace as;
+
+    CFAMConfig config;
+    CFAMPeek peek;
+
+    LBus lbus;
+};
+
+#endif /* FSI_CFAM_H */
diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
new file mode 100644
index 0000000000..bff807ff20
--- /dev/null
+++ b/include/hw/fsi/fsi-slave.h
@@ -0,0 +1,29 @@
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
+#include <stdint.h>
+
+#define TYPE_FSI_SLAVE "fsi.slave"
+#define FSI_SLAVE(obj) \
+    OBJECT_CHECK(FSISlaveState, (obj), TYPE_FSI_SLAVE)
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
-- 
2.39.2


