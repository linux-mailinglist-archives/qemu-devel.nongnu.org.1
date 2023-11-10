Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C257E7E1C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:25:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VEp-00056k-0X; Fri, 10 Nov 2023 12:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VEc-0004oF-IW; Fri, 10 Nov 2023 12:23:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VEa-0001PA-8k; Fri, 10 Nov 2023 12:23:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHNJUc032195; Fri, 10 Nov 2023 17:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=tj7I4ec8I8Ze2Zk76Lm53NvLFrItO+Oqlp6beORrikM=;
 b=Eyt4qyD2SQ7uO/F/WUXhYY3rh/6hF5hFQY2wzJCG/Ag09RFBF1IaGTNrEPCQMam4o4/1
 vcnukG/nrDJ84dKjY8ATLhXjkOJUVbMwpnBVWuLw++oV+3kZSD9OeSA7kPv4vX9ffXsc
 BpV/62LYUpeD3dfnjWI8V6yJW9W+bXPctCofodTbSB3OXcHI3t//19+1giE4mz3bx4Zb
 GO1K9hORC+ktn5S+IvOyVUnjy4AXNTQTOe602DO2UTXBeSuvQqbtr1Kc7J7WWl4MdzXZ
 yRwuBaROF/0Fbc3vCjICWuzzH4lW6L0gZBDjUxMA3LDzeAMeAAGRzFV0omMK8B0FiMIt ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rjegg0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHNkJV003030;
 Fri, 10 Nov 2023 17:23:46 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rjegg0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAFvWsv004132; Fri, 10 Nov 2023 17:23:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21cb52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHNjdX19333700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:23:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 395CF58045;
 Fri, 10 Nov 2023 17:23:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA8FA58052;
 Fri, 10 Nov 2023 17:23:44 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:23:44 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 6/8] misc: Add a pca9554 GPIO device model
Date: Fri, 10 Nov 2023 11:22:46 -0600
Message-Id: <20231110172248.3885194-7-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
References: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h6GDgFgCCZVInICDebmGpTJeU0Xm7A3r
X-Proofpoint-ORIG-GUID: Tzrly73Z_BZApVklUcbxwMq3icwznI5z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100144
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Specs are available here:

    https://www.nxp.com/docs/en/data-sheet/PCA9554_9554A.pdf

This is a simple model supporting the basic registers for GPIO
mode.  The device also supports an interrupt output line but the
model does not yet support this.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 MAINTAINERS                    |   2 +
 hw/misc/pca9554.c              | 328 +++++++++++++++++++++++++++++++++
 include/hw/misc/pca9554.h      |  36 ++++
 include/hw/misc/pca9554_regs.h |  19 ++
 4 files changed, 385 insertions(+)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e73a3ff544..209080e1a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1504,8 +1504,10 @@ F: hw/ppc/pnv*
 F: hw/intc/pnv*
 F: hw/intc/xics_pnv.c
 F: hw/pci-host/pnv*
+F: hw/misc/pca9554.c
 F: include/hw/ppc/pnv*
 F: include/hw/pci-host/pnv*
+F: include/hw/misc/pca9554*.h
 F: pc-bios/skiboot.lid
 F: tests/qtest/pnv*
 
diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
new file mode 100644
index 0000000000..778b32e443
--- /dev/null
+++ b/hw/misc/pca9554.c
@@ -0,0 +1,328 @@
+/*
+ * PCA9554 I/O port
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/bitops.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/pca9554.h"
+#include "hw/misc/pca9554_regs.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "trace.h"
+#include "qom/object.h"
+
+struct PCA9554Class {
+    /*< private >*/
+    I2CSlaveClass parent_class;
+    /*< public >*/
+};
+typedef struct PCA9554Class PCA9554Class;
+
+DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
+                       TYPE_PCA9554)
+
+#define PCA9554_PIN_LOW  0x0
+#define PCA9554_PIN_HIZ  0x1
+
+static const char *pin_state[] = {"low", "high"};
+
+static void pca9554_update_pin_input(PCA9554State *s)
+{
+    int i;
+    uint8_t config = s->regs[PCA9554_CONFIG];
+    uint8_t output = s->regs[PCA9554_OUTPUT];
+    uint8_t internal_state = config | output;
+
+    for (i = 0; i < PCA9554_PIN_COUNT; i++) {
+        uint8_t bit_mask = 1 << i;
+        uint8_t internal_pin_state = (internal_state >> i) & 0x1;
+        uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
+        uint8_t new_value;
+
+        switch (internal_pin_state) {
+        case PCA9554_PIN_LOW:
+            s->regs[PCA9554_INPUT] &= ~bit_mask;
+            break;
+        case PCA9554_PIN_HIZ:
+            /*
+             * pullup sets it to a logical 1 unless
+             * external device drives it low.
+             */
+            if (s->ext_state[i] == PCA9554_PIN_LOW) {
+                s->regs[PCA9554_INPUT] &= ~bit_mask;
+            } else {
+                s->regs[PCA9554_INPUT] |=  bit_mask;
+            }
+            break;
+        default:
+            break;
+        }
+
+        /* update irq state only if pin state changed */
+        new_value = s->regs[PCA9554_INPUT] & bit_mask;
+        if (new_value != old_value) {
+            if (new_value) {
+                /* changed from 0 to 1 */
+                qemu_set_irq(s->gpio_out[i], 1);
+            } else {
+                /* changed from 1 to 0 */
+                qemu_set_irq(s->gpio_out[i], 0);
+            }
+        }
+    }
+}
+
+static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
+{
+    switch (reg) {
+    case PCA9554_INPUT:
+        return s->regs[PCA9554_INPUT] ^ s->regs[PCA9554_POLARITY];
+    case PCA9554_OUTPUT:
+    case PCA9554_POLARITY:
+    case PCA9554_CONFIG:
+        return s->regs[reg];
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register %d\n",
+                      __func__, reg);
+        return 0xFF;
+    }
+}
+
+static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
+{
+    switch (reg) {
+    case PCA9554_OUTPUT:
+    case PCA9554_CONFIG:
+        s->regs[reg] = data;
+        pca9554_update_pin_input(s);
+        break;
+    case PCA9554_POLARITY:
+        s->regs[reg] = data;
+        break;
+    case PCA9554_INPUT:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register %d\n",
+                      __func__, reg);
+    }
+}
+
+static uint8_t pca9554_recv(I2CSlave *i2c)
+{
+    PCA9554State *s = PCA9554(i2c);
+    uint8_t ret;
+
+    ret = pca9554_read(s, s->pointer & 0x3);
+
+    return ret;
+}
+
+static int pca9554_send(I2CSlave *i2c, uint8_t data)
+{
+    PCA9554State *s = PCA9554(i2c);
+
+    /* First byte sent by is the register address */
+    if (s->len == 0) {
+        s->pointer = data;
+        s->len++;
+    } else {
+        pca9554_write(s, s->pointer & 0x3, data);
+    }
+
+    return 0;
+}
+
+static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PCA9554State *s = PCA9554(i2c);
+
+    s->len = 0;
+    return 0;
+}
+
+static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9554State *s = PCA9554(obj);
+    int pin, rc;
+    uint8_t state;
+
+    rc = sscanf(name, "pin%2d", &pin);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+        error_setg(errp, "%s invalid pin %s", __func__, name);
+        return;
+    }
+
+    state = pca9554_read(s, PCA9554_CONFIG);
+    state |= pca9554_read(s, PCA9554_OUTPUT);
+    state = (state >> pin) & 0x1;
+    visit_type_str(v, name, (char **)&pin_state[state], errp);
+}
+
+static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9554State *s = PCA9554(obj);
+    int pin, rc, val;
+    uint8_t state, mask;
+    char *state_str;
+
+    if (!visit_type_str(v, name, &state_str, errp)) {
+        return;
+    }
+    rc = sscanf(name, "pin%2d", &pin);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+        error_setg(errp, "%s invalid pin %s", __func__, name);
+        return;
+    }
+
+    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
+        if (!strcmp(state_str, pin_state[state])) {
+            break;
+        }
+    }
+    if (state >= ARRAY_SIZE(pin_state)) {
+        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
+        return;
+    }
+
+    /* First, modify the output register bit */
+    val = pca9554_read(s, PCA9554_OUTPUT);
+    mask = 0x1 << pin;
+    if (state == PCA9554_PIN_LOW) {
+        val &= ~(mask);
+    } else {
+        val |= mask;
+    }
+    pca9554_write(s, PCA9554_OUTPUT, val);
+
+    /* Then, clear the config register bit for output mode */
+    val = pca9554_read(s, PCA9554_CONFIG);
+    val &= ~mask;
+    pca9554_write(s, PCA9554_CONFIG, val);
+}
+
+static const VMStateDescription pca9554_vmstate = {
+    .name = "PCA9554",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(len, PCA9554State),
+        VMSTATE_UINT8(pointer, PCA9554State),
+        VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
+        VMSTATE_UINT8_ARRAY(ext_state, PCA9554State, PCA9554_PIN_COUNT),
+        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pca9554_reset(DeviceState *dev)
+{
+    PCA9554State *s = PCA9554(dev);
+
+    s->regs[PCA9554_INPUT] = 0xFF;
+    s->regs[PCA9554_OUTPUT] = 0xFF;
+    s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
+    s->regs[PCA9554_CONFIG] = 0xFF; /* All pins are inputs */
+
+    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
+    pca9554_update_pin_input(s);
+
+    s->pointer = 0x0;
+    s->len = 0;
+}
+
+static void pca9554_initfn(Object *obj)
+{
+    int pin;
+
+    for (pin = 0; pin < PCA9554_PIN_COUNT; pin++) {
+        char *name;
+
+        name = g_strdup_printf("pin%d", pin);
+        object_property_add(obj, name, "bool", pca9554_get_pin, pca9554_set_pin,
+                            NULL, NULL);
+        g_free(name);
+    }
+}
+
+static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
+{
+    if (s->ext_state[pin] != level) {
+        s->ext_state[pin] = level;
+        pca9554_update_pin_input(s);
+    }
+}
+
+static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
+{
+
+    PCA9554State *s = PCA9554(opaque);
+
+    assert((pin >= 0) && (pin < PCA9554_PIN_COUNT));
+    pca9554_set_ext_state(s, pin, level);
+}
+
+static void pca9554_realize(DeviceState *dev, Error **errp)
+{
+    PCA9554State *s = PCA9554(dev);
+
+    if (!s->description) {
+        s->description = g_strdup("pca9554");
+    }
+
+    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
+    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT);
+}
+
+static Property pca9554_properties[] = {
+    DEFINE_PROP_STRING("description", PCA9554State, description),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pca9554_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = pca9554_event;
+    k->recv = pca9554_recv;
+    k->send = pca9554_send;
+    dc->realize = pca9554_realize;
+    dc->reset = pca9554_reset;
+    dc->vmsd = &pca9554_vmstate;
+    device_class_set_props(dc, pca9554_properties);
+}
+
+static const TypeInfo pca9554_info = {
+    .name          = TYPE_PCA9554,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_init = pca9554_initfn,
+    .instance_size = sizeof(PCA9554State),
+    .class_init    = pca9554_class_init,
+    .class_size    = sizeof(PCA9554Class),
+    .abstract      = false,
+};
+
+static void pca9554_register_types(void)
+{
+    type_register_static(&pca9554_info);
+}
+
+type_init(pca9554_register_types)
diff --git a/include/hw/misc/pca9554.h b/include/hw/misc/pca9554.h
new file mode 100644
index 0000000000..54bfc4c4c7
--- /dev/null
+++ b/include/hw/misc/pca9554.h
@@ -0,0 +1,36 @@
+/*
+ * PCA9554 I/O port
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PCA9554_H
+#define PCA9554_H
+
+#include "hw/i2c/i2c.h"
+#include "qom/object.h"
+
+#define TYPE_PCA9554 "pca9554"
+typedef struct PCA9554State PCA9554State;
+DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
+                         TYPE_PCA9554)
+
+#define PCA9554_NR_REGS 4
+#define PCA9554_PIN_COUNT 8
+
+struct PCA9554State {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t pointer;
+
+    uint8_t regs[PCA9554_NR_REGS];
+    qemu_irq gpio_out[PCA9554_PIN_COUNT];
+    uint8_t ext_state[PCA9554_PIN_COUNT];
+    char *description; /* For debugging purpose only */
+};
+
+#endif
diff --git a/include/hw/misc/pca9554_regs.h b/include/hw/misc/pca9554_regs.h
new file mode 100644
index 0000000000..602c4a90e0
--- /dev/null
+++ b/include/hw/misc/pca9554_regs.h
@@ -0,0 +1,19 @@
+/*
+ * PCA9554 I/O port registers
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef PCA9554_REGS_H
+#define PCA9554_REGS_H
+
+/*
+ * Bits [0:1] are used to address a specific register.
+ */
+#define PCA9554_INPUT       0 /* read only input register */
+#define PCA9554_OUTPUT      1 /* read/write pin output state */
+#define PCA9554_POLARITY    2 /* Set polarity of input register */
+#define PCA9554_CONFIG      3 /* Set pins as inputs our ouputs */
+
+#endif
-- 
2.31.1


