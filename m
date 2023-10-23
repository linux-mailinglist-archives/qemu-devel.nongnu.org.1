Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29237D3EA5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMY-0005RM-AM; Mon, 23 Oct 2023 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com>)
 id 1quzMU-0005OW-3m
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:10 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com>)
 id 1quzMR-0006yu-OD
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:09 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a7ba10cb90so51181177b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084547; x=1698689347; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pMUhOWgIv4TqxALDqvCHn+orcFHtyhFj1Pqo7bh95SQ=;
 b=bkpgKwKfIKTptYeWzam4PN1XgALNFwz5i4rRkGWaL1qnV+ZeO2Mc/Vot6wOGGgnFMH
 tQ5g0fh6heLyfclpl+zV27irgkTRQZbZ8lW++7vfbCtruX6GYe2AlzugSm+Y2XKEcxAo
 Dz+/c1Z6gv7/YrHJpSUcxfZU6kdWeh/QMAQlo4CCRIW/jWZugJhr3BrRUyDmLupNoZF7
 OKeIrpee18MfwWW/DTxeMfa8UEnpp7gV7qquDpaeCPpKg22Rjt3z3KjBE6ur8Shk/gza
 vm2KIdPqCyFbe+/grOLxsln2mccAU4B6ryHLUh2YKXT6HrtDJHOc78VKCnKLUSwTbOvP
 pPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084547; x=1698689347;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMUhOWgIv4TqxALDqvCHn+orcFHtyhFj1Pqo7bh95SQ=;
 b=fbmA95iO/j/KiKf91zeN3D9VtXF/FQvnvirGDOultfRloCnE+PA6JvjVfKDNehmcWl
 Z383nglmDyE+FjXXrjWZ0n0NIb/sEV6LypStcl5aOkWrblwMBtZCtnsZHAzK2QoLWoLK
 lJXXJtAsUAW4AWbGjUgoGP3kXQNf+vpnGfQ0yns0kBCKUDim98Gn1w0p5UB4nuz8XpwL
 D+Ode6enhekbox7FEioy5jzMiYbR7XhCQRDcjQnsxtwXMDE71PRM5Y8JeoLff/QTTPbj
 f0zZ3LEz/0R7svbBcdFL1M/aYoKV42a2dbn2PzNZHRGxQVsJXLSKllO0D/tzMU8Cn5RX
 FF4Q==
X-Gm-Message-State: AOJu0Yy4KnhYISzGG55tdVMoRecuFzqV4xQ2Rod9AoCBF2NPAsRaZZgd
 wSUXwVvBnKCS2z+rtxxMCrIZiMkWkxg=
X-Google-Smtp-Source: AGHT+IGVlaY7xs2tJuht82zxHJntTHYJn+VFBxv/FgdCTTigwAL+ZmHLtCYdJv+Wm/xaGruy0A3NVzlltdo=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:d685:0:b0:5a1:d0cf:b65d with SMTP id
 y127-20020a0dd685000000b005a1d0cfb65dmr243883ywd.5.1698084546945; Mon, 23 Oct
 2023 11:09:06 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:34 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-6-titusr@google.com>
Subject: [PATCH v3 5/8] hw/sensor: add ADM1266 device model
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

  The ADM1266 is a cascadable super sequencer with margin control and
  fault recording.
  This commit adds basic support for its PMBus commands and models
  the identification registers that can be modified in a firmware
  update.

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/arm/Kconfig        |   1 +
 hw/sensor/Kconfig     |   5 +
 hw/sensor/adm1266.c   | 254 ++++++++++++++++++++++++++++++++++++++++++
 hw/sensor/meson.build |   1 +
 4 files changed, 261 insertions(+)
 create mode 100644 hw/sensor/adm1266.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e68348440..b1e8c0e2ac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -488,6 +488,7 @@ config NPCM7XX
     default y
     depends on TCG && ARM
     select A9MPCORE
+    select ADM1266
     select ADM1272
     select ARM_GIC
     select SMBUS
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index e03bd09b50..bc6331b4ab 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -22,6 +22,11 @@ config ADM1272
     bool
     depends on I2C
 
+config ADM1266
+    bool
+    depends on PMBUS
+    default y if PMBUS
+
 config MAX34451
     bool
     depends on I2C
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
new file mode 100644
index 0000000000..5ae4f82ba1
--- /dev/null
+++ b/hw/sensor/adm1266.c
@@ -0,0 +1,254 @@
+/*
+ * Analog Devices ADM1266 Cascadable Super Sequencer with Margin Control and
+ * Fault Recording with PMBus
+ *
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/adm1266.pdf
+ *
+ * Copyright 2023 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/pmbus_device.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define TYPE_ADM1266 "adm1266"
+OBJECT_DECLARE_SIMPLE_TYPE(ADM1266State, ADM1266)
+
+#define ADM1266_BLACKBOX_CONFIG                 0xD3
+#define ADM1266_PDIO_CONFIG                     0xD4
+#define ADM1266_READ_STATE                      0xD9
+#define ADM1266_READ_BLACKBOX                   0xDE
+#define ADM1266_SET_RTC                         0xDF
+#define ADM1266_GPIO_SYNC_CONFIGURATION         0xE1
+#define ADM1266_BLACKBOX_INFORMATION            0xE6
+#define ADM1266_PDIO_STATUS                     0xE9
+#define ADM1266_GPIO_STATUS                     0xEA
+
+/* Defaults */
+#define ADM1266_OPERATION_DEFAULT               0x80
+#define ADM1266_CAPABILITY_DEFAULT              0xA0
+#define ADM1266_CAPABILITY_NO_PEC               0x20
+#define ADM1266_PMBUS_REVISION_DEFAULT          0x22
+#define ADM1266_MFR_ID_DEFAULT                  "ADI"
+#define ADM1266_MFR_ID_DEFAULT_LEN              32
+#define ADM1266_MFR_MODEL_DEFAULT               "ADM1266-A1"
+#define ADM1266_MFR_MODEL_DEFAULT_LEN           32
+#define ADM1266_MFR_REVISION_DEFAULT            "25"
+#define ADM1266_MFR_REVISION_DEFAULT_LEN        8
+
+#define ADM1266_NUM_PAGES               17
+/**
+ * PAGE Index
+ * Page 0 VH1.
+ * Page 1 VH2.
+ * Page 2 VH3.
+ * Page 3 VH4.
+ * Page 4 VP1.
+ * Page 5 VP2.
+ * Page 6 VP3.
+ * Page 7 VP4.
+ * Page 8 VP5.
+ * Page 9 VP6.
+ * Page 10 VP7.
+ * Page 11 VP8.
+ * Page 12 VP9.
+ * Page 13 VP10.
+ * Page 14 VP11.
+ * Page 15 VP12.
+ * Page 16 VP13.
+ */
+typedef struct ADM1266State {
+    PMBusDevice parent;
+
+    char mfr_id[32];
+    char mfr_model[32];
+    char mfr_rev[8];
+} ADM1266State;
+
+static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
+static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
+                                                0x0, 0x07, 0x41, 0x30};
+
+static void adm1266_exit_reset(Object *obj)
+{
+    ADM1266State *s = ADM1266(obj);
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+
+    pmdev->page = 0;
+    pmdev->capability = ADM1266_CAPABILITY_NO_PEC;
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        pmdev->pages[i].operation = ADM1266_OPERATION_DEFAULT;
+        pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
+        pmdev->pages[i].vout_mode = 0;
+        pmdev->pages[i].read_vout = pmbus_data2linear_mode(12, 0);
+        pmdev->pages[i].vout_margin_high = pmbus_data2linear_mode(15, 0);
+        pmdev->pages[i].vout_margin_low = pmbus_data2linear_mode(3, 0);
+        pmdev->pages[i].vout_ov_fault_limit = pmbus_data2linear_mode(16, 0);
+        pmdev->pages[i].revision = ADM1266_PMBUS_REVISION_DEFAULT;
+    }
+
+    strncpy(s->mfr_id, ADM1266_MFR_ID_DEFAULT, 4);
+    strncpy(s->mfr_model, ADM1266_MFR_MODEL_DEFAULT, 11);
+    strncpy(s->mfr_rev, ADM1266_MFR_REVISION_DEFAULT, 3);
+}
+
+static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
+{
+    ADM1266State *s = ADM1266(pmdev);
+
+    switch (pmdev->code) {
+    case PMBUS_MFR_ID:                    /* R/W block */
+        pmbus_send_string(pmdev, s->mfr_id);
+        break;
+
+    case PMBUS_MFR_MODEL:                 /* R/W block */
+        pmbus_send_string(pmdev, s->mfr_model);
+        break;
+
+    case PMBUS_MFR_REVISION:              /* R/W block */
+        pmbus_send_string(pmdev, s->mfr_rev);
+        break;
+
+    case PMBUS_IC_DEVICE_ID:
+        pmbus_send(pmdev, adm1266_ic_device_id, sizeof(adm1266_ic_device_id));
+        break;
+
+    case PMBUS_IC_DEVICE_REV:
+        pmbus_send(pmdev, adm1266_ic_device_rev, sizeof(adm1266_ic_device_rev));
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: reading from unimplemented register: 0x%02x\n",
+                      __func__, pmdev->code);
+        return 0xFF;
+    }
+
+    return 0;
+}
+
+static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
+                              uint8_t len)
+{
+    ADM1266State *s = ADM1266(pmdev);
+
+    switch (pmdev->code) {
+    case PMBUS_MFR_ID:                    /* R/W block */
+        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_id, sizeof(s->mfr_id));
+        break;
+
+    case PMBUS_MFR_MODEL:                 /* R/W block */
+        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_model,
+                            sizeof(s->mfr_model));
+        break;
+
+    case PMBUS_MFR_REVISION:               /* R/W block*/
+        pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
+        break;
+
+    case ADM1266_SET_RTC:   /* do nothing */
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: writing to unimplemented register: 0x%02x\n",
+                      __func__, pmdev->code);
+        break;
+    }
+    return 0;
+}
+
+static void adm1266_get(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    uint16_t value;
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
+
+    if (strcmp(name, "vout") == 0) {
+        value = pmbus_linear_mode2data(*(uint16_t *)opaque, mode->exp);
+    } else {
+        value = *(uint16_t *)opaque;
+    }
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static void adm1266_set(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    uint16_t *internal = opaque;
+    uint16_t value;
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    *internal = pmbus_data2linear_mode(value, mode->exp);
+    pmbus_check_limits(pmdev);
+}
+
+static const VMStateDescription vmstate_adm1266 = {
+    .name = "ADM1266",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]){
+        VMSTATE_PMBUS_DEVICE(parent, ADM1266State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void adm1266_init(Object *obj)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    uint64_t flags = PB_HAS_VOUT_MODE | PB_HAS_VOUT | PB_HAS_VOUT_MARGIN |
+                     PB_HAS_VOUT_RATING | PB_HAS_STATUS_MFR_SPECIFIC;
+
+    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
+        pmbus_page_config(pmdev, i, flags);
+
+        object_property_add(obj, "vout[*]", "uint16",
+                            adm1266_get,
+                            adm1266_set, NULL, &pmdev->pages[i].read_vout);
+    }
+}
+
+static void adm1266_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
+
+    dc->desc = "Analog Devices ADM1266 Hot Swap controller";
+    dc->vmsd = &vmstate_adm1266;
+    k->write_data = adm1266_write_data;
+    k->receive_byte = adm1266_read_byte;
+    k->device_num_pages = 17;
+
+    rc->phases.exit = adm1266_exit_reset;
+}
+
+static const TypeInfo adm1266_info = {
+    .name = TYPE_ADM1266,
+    .parent = TYPE_PMBUS_DEVICE,
+    .instance_size = sizeof(ADM1266State),
+    .instance_init = adm1266_init,
+    .class_init = adm1266_class_init,
+};
+
+static void adm1266_register_types(void)
+{
+    type_register_static(&adm1266_info);
+}
+
+type_init(adm1266_register_types)
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 30e20e27b8..420fdc3359 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
 system_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
 system_ss.add(when: 'CONFIG_DPS310', if_true: files('dps310.c'))
 system_ss.add(when: 'CONFIG_EMC141X', if_true: files('emc141x.c'))
+system_ss.add(when: 'CONFIG_ADM1266', if_true: files('adm1266.c'))
 system_ss.add(when: 'CONFIG_ADM1272', if_true: files('adm1272.c'))
 system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
-- 
2.42.0.758.gaed0368e0e-goog


