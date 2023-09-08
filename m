Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C699799246
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 00:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qejyl-0001dB-4N; Fri, 08 Sep 2023 18:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qejyi-0001bC-60; Fri, 08 Sep 2023 18:29:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qejye-0003F0-IH; Fri, 08 Sep 2023 18:29:27 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388M7LU1022571; Fri, 8 Sep 2023 22:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=UxNaDgMrqTxRDdabXe2ADM5wu1MC/WhedZWCORt64dM=;
 b=W5pLSYEv2RN4xA9ouOKVybSgltJ+oe2w9+gJNuN/3TdHCHGPb++JU26eBfZ1s3+SbGDl
 Ex5yiQb+k65dqGPqK1YpTyt9rhQlNegL90pcWz89GdKOZBZhaG5Q26pkX5aIP2O+BCeL
 4F9Y0ndQpXXnd8AYmnuvT7dtub0VffCRou7o8KPkd0HIwPotEUXDizMIkdU5CkOqmG6U
 qKZbyrlMzWbweGTliVfLn337BL6G3e4asqvbJWdAgDjaxxA2B2eqZEfuxicDS1BK7AO+
 42B001jFzrFe449gh1sal3rGCcrMTdcbEzaBlJj12/Wa2pXRCVU0gjPOpudEAzzc8qYv 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0bv59121-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:10 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388MGpal011654;
 Fri, 8 Sep 2023 22:29:10 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t0bv5911k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388LtkpT001603; Fri, 8 Sep 2023 22:29:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctfjkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 22:29:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388MT9Lh28377788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 22:29:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D38758061;
 Fri,  8 Sep 2023 22:29:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B887758056;
 Fri,  8 Sep 2023 22:29:08 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 22:29:08 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 02/10] hw/fsi: Introduce IBM's scratchpad
Date: Fri,  8 Sep 2023 17:28:51 -0500
Message-Id: <20230908222859.3381003-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908222859.3381003-1-ninad@linux.ibm.com>
References: <20230908222859.3381003-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f16cN7ymirf5UTRId_CJk60Vhbs8_w4u
X-Proofpoint-ORIG-GUID: 1kS2CZEZI4USipq5TgBFSEfIFk4ivVV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=700
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The LBUS device is embeded inside the scratchpad. The scratchpad
provides a non-functional registers. There is a 1-1 relation between
scratchpad and LBUS devices. Each LBUS device has 1K memory mapped in
the LBUS.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v2:
- Incorporated Joel's review comments.
---
 hw/fsi/Kconfig                     |   4 ++
 hw/fsi/engine-scratchpad.c         | 100 +++++++++++++++++++++++++++++
 hw/fsi/meson.build                 |   1 +
 include/hw/fsi/engine-scratchpad.h |  33 ++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 hw/fsi/engine-scratchpad.c
 create mode 100644 include/hw/fsi/engine-scratchpad.h

diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index 687449e14e..2a9c49f2c9 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,2 +1,6 @@
+config SCRATCHPAD
+    bool
+    select LBUS
+
 config LBUS
     bool
diff --git a/hw/fsi/engine-scratchpad.c b/hw/fsi/engine-scratchpad.c
new file mode 100644
index 0000000000..15a8f8cc66
--- /dev/null
+++ b/hw/fsi/engine-scratchpad.c
@@ -0,0 +1,100 @@
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
+
+#include "hw/fsi/engine-scratchpad.h"
+
+static uint64_t scratchpad_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ScratchPad *s = SCRATCHPAD(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: read @0x%" HWADDR_PRIx " size=%d\n",
+                  __func__, addr, size);
+
+    if (addr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return 0;
+    }
+
+    return s->reg;
+}
+
+static void scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
+                                 unsigned size)
+{
+    ScratchPad *s = SCRATCHPAD(opaque);
+
+    qemu_log_mask(LOG_UNIMP, "%s: write @0x%" HWADDR_PRIx " size=%d "
+                  "value=%"PRIx64"\n", __func__, addr, size, data);
+
+    if (addr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
+                      __func__, addr, size);
+        return;
+    }
+
+    s->reg = data;
+}
+
+static const struct MemoryRegionOps scratchpad_ops = {
+    .read = scratchpad_read,
+    .write = scratchpad_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void scratchpad_realize(DeviceState *dev, Error **errp)
+{
+    LBusDevice *ldev = LBUS_DEVICE(dev);
+
+    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
+                          ldev, TYPE_SCRATCHPAD, 0x400);
+}
+
+static void scratchpad_reset(DeviceState *dev)
+{
+    ScratchPad *s = SCRATCHPAD(dev);
+
+    s->reg = 0;
+}
+
+static void scratchpad_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LBusDeviceClass *ldc = LBUS_DEVICE_CLASS(klass);
+
+    dc->realize = scratchpad_realize;
+    dc->reset = scratchpad_reset;
+
+    ldc->config =
+          ENGINE_CONFIG_NEXT            /* valid */
+        | 0x00010000                    /* slots */
+        | 0x00001000                    /* version */
+        | ENGINE_CONFIG_TYPE_SCRATCHPAD /* type */
+        | 0x00000007;                   /* crc */
+}
+
+static const TypeInfo scratchpad_info = {
+    .name = TYPE_SCRATCHPAD,
+    .parent = TYPE_LBUS_DEVICE,
+    .instance_size = sizeof(ScratchPad),
+    .class_init = scratchpad_class_init,
+    .class_size = sizeof(LBusDeviceClass),
+};
+
+static void scratchpad_register_types(void)
+{
+    type_register_static(&scratchpad_info);
+}
+
+type_init(scratchpad_register_types);
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index e1007d5fea..f90e09ddab 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
+system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
diff --git a/include/hw/fsi/engine-scratchpad.h b/include/hw/fsi/engine-scratchpad.h
new file mode 100644
index 0000000000..63bf89ac5a
--- /dev/null
+++ b/include/hw/fsi/engine-scratchpad.h
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM scratchpad engne
+ */
+#ifndef FSI_ENGINE_SCRATCHPAD_H
+#define FSI_ENGINE_SCRATCHPAD_H
+
+#include "qemu/bitops.h"
+
+#include "hw/fsi/lbus.h"
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
+#define TYPE_SCRATCHPAD "scratchpad"
+#define SCRATCHPAD(obj) OBJECT_CHECK(ScratchPad, (obj), TYPE_SCRATCHPAD)
+
+typedef struct ScratchPad {
+        LBusDevice parent;
+
+        uint32_t reg;
+} ScratchPad;
+
+#endif /* FSI_ENGINE_SCRATCHPAD_H */
-- 
2.39.2


