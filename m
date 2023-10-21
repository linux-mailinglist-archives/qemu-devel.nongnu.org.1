Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44537D1FD1
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJR2-0007xZ-Pr; Sat, 21 Oct 2023 17:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQz-0007uW-0w; Sat, 21 Oct 2023 17:23:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQt-0006Or-HS; Sat, 21 Oct 2023 17:23:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LL9OXh022088; Sat, 21 Oct 2023 21:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V4HY4+uFqszc+0bukWQz8lg/3mNlkeL14aU4g4D1ljg=;
 b=EyV9h6LRnr9CRr1jiLGvDeylfSdXgRXHVz79dPYKCf10TNxeFROfiLr6VCKhsUXY1w5f
 Xh2s30zW3zmQtbg4MPkV+gzjcKFpZdbmik70FuyXcpC7qN+nCvOv9bQDVZ1APg+nBXZr
 JATYZZkVR9BKpO82xNGcmZ65+G7O6WgafPzUY9+j0b92FD199jMf2PHI6GVGzH2IH5Mz
 h9CAhMIOKR8mZRmrErdNuziwEQtuGCRbOzZDXsQ7f/ugs0OEtXJ73hxBh+/nsjLPAPR1
 R/rBVaEjtlq/uqLj6Hm4Mg1TNhl7AQKaIeeBAmCIGKUgtuhT+DOhq679+64hb7wiAu7q VA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpab066u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:26 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LL9scc023294;
 Sat, 21 Oct 2023 21:17:25 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpab066q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKPwUk002683; Sat, 21 Oct 2023 21:17:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc44ncub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHNXB13632048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCAF958067;
 Sat, 21 Oct 2023 21:17:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7316958056;
 Sat, 21 Oct 2023 21:17:23 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 21:17:23 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v6 02/10] hw/fsi: Introduce IBM's scratchpad
Date: Sat, 21 Oct 2023 16:17:11 -0500
Message-Id: <20231021211720.3571082-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021211720.3571082-1-ninad@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 91ceCeBHaEBD7BGjfLyHrFHCxs4-GfNo
X-Proofpoint-GUID: hn95Yw-SbPVJbuFXEC7N2A05igLPAfNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=901 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210195
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

This is a part of patchset where scratchpad is introduced.

The scratchpad provides a set of non-functional registers. The firmware
is free to use them, hardware does not support any special management
support. The scratchpad registers can be read or written from LBUS
slave.

In this model, The LBUS device is parent for the scratchpad.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
- Incorporated Joel's review comments.
v5:
- Incorporated review comments by Cedric.
v6:
- Incorporated review comments by Daniel.
---
 meson.build                        |  1 +
 hw/fsi/trace.h                     |  1 +
 include/hw/fsi/engine-scratchpad.h | 32 ++++++++++
 include/hw/fsi/fsi.h               | 16 +++++
 hw/fsi/engine-scratchpad.c         | 93 ++++++++++++++++++++++++++++++
 hw/fsi/Kconfig                     |  4 ++
 hw/fsi/meson.build                 |  1 +
 hw/fsi/trace-events                |  2 +
 8 files changed, 150 insertions(+)
 create mode 100644 hw/fsi/trace.h
 create mode 100644 include/hw/fsi/engine-scratchpad.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 hw/fsi/engine-scratchpad.c
 create mode 100644 hw/fsi/trace-events

diff --git a/meson.build b/meson.build
index 4961c82a6b..31078f0bb3 100644
--- a/meson.build
+++ b/meson.build
@@ -3256,6 +3256,7 @@ if have_system
     'hw/char',
     'hw/display',
     'hw/dma',
+    'hw/fsi',
     'hw/hyperv',
     'hw/i2c',
     'hw/i386',
diff --git a/hw/fsi/trace.h b/hw/fsi/trace.h
new file mode 100644
index 0000000000..ee67c7fb04
--- /dev/null
+++ b/hw/fsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_fsi.h"
diff --git a/include/hw/fsi/engine-scratchpad.h b/include/hw/fsi/engine-scratchpad.h
new file mode 100644
index 0000000000..959a8a6677
--- /dev/null
+++ b/include/hw/fsi/engine-scratchpad.h
@@ -0,0 +1,32 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM scratchpad engne
+ */
+#ifndef FSI_ENGINE_SCRATCHPAD_H
+#define FSI_ENGINE_SCRATCHPAD_H
+
+#include "hw/fsi/lbus.h"
+#include "hw/fsi/fsi.h"
+
+#define ENGINE_CONFIG_NEXT              BE_BIT(0)
+#define ENGINE_CONFIG_VPD               BE_BIT(1)
+#define ENGINE_CONFIG_SLOTS             BE_GENMASK(8, 15)
+#define ENGINE_CONFIG_VERSION           BE_GENMASK(16, 19)
+#define ENGINE_CONFIG_TYPE              BE_GENMASK(20, 27)
+#define   ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
+#define   ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
+#define   ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
+#define ENGINE_CONFIG_CRC              BE_GENMASK(28, 31)
+
+#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
+#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), TYPE_FSI_SCRATCHPAD)
+
+typedef struct FSIScratchPad {
+        FSILBusDevice parent;
+
+        uint32_t reg;
+} FSIScratchPad;
+
+#endif /* FSI_ENGINE_SCRATCHPAD_H */
diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
new file mode 100644
index 0000000000..e65f26f17b
--- /dev/null
+++ b/include/hw/fsi/fsi.h
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM Flexible Service Interface
+ */
+#ifndef FSI_FSI_H
+#define FSI_FSI_H
+
+/* Bitwise operations at the word level. */
+#define BE_BIT(x)                          BIT(31 - (x))
+#define GENMASK(t, b) \
+    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
+#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))
+
+#endif
diff --git a/hw/fsi/engine-scratchpad.c b/hw/fsi/engine-scratchpad.c
new file mode 100644
index 0000000000..a8887cd613
--- /dev/null
+++ b/hw/fsi/engine-scratchpad.c
@@ -0,0 +1,93 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM scratchpad engine
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+#include "hw/fsi/engine-scratchpad.h"
+
+static uint64_t fsi_scratchpad_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FSIScratchPad *s = SCRATCHPAD(opaque);
+
+    trace_fsi_scratchpad_read(addr, size);
+
+    if (addr) {
+        return 0;
+    }
+
+    return s->reg;
+}
+
+static void fsi_scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    FSIScratchPad *s = SCRATCHPAD(opaque);
+
+    trace_fsi_scratchpad_write(addr, size, data);
+
+    if (addr) {
+        return;
+    }
+
+    s->reg = data;
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
+
+    s->reg = 0;
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
+    ldc->config =
+          ENGINE_CONFIG_NEXT            | /* valid */
+          0x00010000                    | /* slots */
+          0x00001000                    | /* version */
+          ENGINE_CONFIG_TYPE_SCRATCHPAD | /* type */
+          0x00000007;                     /* crc */
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
+static void fsi_scratchpad_register_types(void)
+{
+    type_register_static(&fsi_scratchpad_info);
+}
+
+type_init(fsi_scratchpad_register_types);
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index e650c660f0..f7c7fd1b28 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,2 +1,6 @@
+config FSI_SCRATCHPAD
+    bool
+    select FSI_LBUS
+
 config FSI_LBUS
     bool
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index 4074d3a7d2..d45a98c223 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
+system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
new file mode 100644
index 0000000000..c5753e2791
--- /dev/null
+++ b/hw/fsi/trace-events
@@ -0,0 +1,2 @@
+fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
+fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
-- 
2.39.2


