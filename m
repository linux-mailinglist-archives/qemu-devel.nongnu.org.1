Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF26A40E98
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Feb 2025 12:51:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmATG-0000xR-Mx; Sun, 23 Feb 2025 06:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASe-0000DW-RT; Sun, 23 Feb 2025 06:47:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASc-0005zc-GL; Sun, 23 Feb 2025 06:47:52 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e04f2b1685so5285332a12.0; 
 Sun, 23 Feb 2025 03:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311268; x=1740916068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHLW9bi455NoquuI4SwpkU2u6jPUeO18Llwn+dkq48U=;
 b=aPBig8gcyuGQlk1XaN3OU9+mdQLNcaIIFE48O3ZwqMrM9L6UI0x2pDXf0hxi0+amM5
 I+v4MYiNOBejAks2e3GwmqcEDm7rAv7TTTAl8NQnqKxFPCoDwmQdwAWMZ35487e/4r01
 U2izMfRMdqFVkS5IVCo28iDJWfIfEXnjL6RvAsYgbTUAfS1x7b5lUC0w3zwPCnHOKunG
 LutlxoZ7c/fHf3B8AnFZqBuwnzdRj1zm7HBndM8fbhCvGY7gqWJ4Uw7jE6ZIQbL18X5r
 EdTw2/z+o/o8p3UQvhQoLVwkX3QfHQLFA1UHmJ+ef7DrK0ggtu3VFfgczgLH+I34zmVU
 S+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311268; x=1740916068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHLW9bi455NoquuI4SwpkU2u6jPUeO18Llwn+dkq48U=;
 b=RWWRivVzr4hyt+f0Vfvm91gLjxu8n+rzvj8G4+g3ykgPD2n3t4Hz9SSDQsAIGQWd2V
 qU617xIMP74TWbZ92o3q9J3GlVLAt97LbQSkQJbwPAx3ExZNK3JiPKLxfz/3slf1sgac
 NlUnnZHL44zb3qCXGsPRYmB6HG9WV2pF1j8Am67KiBTLd5SVRkxlkghGnfssoDKA1fhR
 mU/G7/lOo2EazKC6GY6a+RKsovJyXwQXizWu2D5t7DkZmNTamAbs8yUom1OINHBMFdFu
 ++piZHSB1gNTu4ZFzjOI95cbnxA7QBPwIYU9CzmWyLPvU4klixhkQgvAQ6AHt71Urz74
 WYRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMSbtjLEe0nJhSoc1djU6NvJEMBsxpWW7PTefPvrQdgm80TjirRjfRT4MsOu51QaPu38yJntK2Xg==@nongnu.org
X-Gm-Message-State: AOJu0YzF5ywioUoCLwRt26JS6vIZ9Uj7b11HEeE7wJwKItKIEdSV4Zk6
 xkgC7jEIlTpZFWTxrF4UauLVxgn1qGeLf1EPebOuMBts00hicIh1KlaNsg==
X-Gm-Gg: ASbGncvab/rSwx2QNpVVxUFeg6xFOoe7K5B39WFCzySpXRhAgBUDe3raE/6PEaD8I+v
 c4zDA+oIWmes0YCqiB+3pg0T/ootbUUG4pL+rrD8IES3ISxUmmQfGwairRM42xOk7SBQnushflv
 J1+uvXbSjkNj8gR8IaPTPsEXXC9+VGriPDPWLWvp5qwMewMPk9WBMDXs1iRfV12xzRvOqvWTS2q
 BOef8LVMuyHTCr4foPfl3sEh+R6li9dyzKdOjrDP1cY9kRGxMcXz9KldRof7GUFbY1bb2ApAZy+
 DCNq2C/pMcL+m7c7t4sC2eU88O6f0nXafm/gZppLzRh7HymwwIDe4laUIFlu4dQGDvma62j9QCY
 wjEwel0+kYzWu
X-Google-Smtp-Source: AGHT+IEcd1PsdiSRDKR7eKb5G/zqaD2rh8ufUKS8hJqv6dtcO733H/ALnsv2OkhJnIwQp+IZwcG7pQ==
X-Received: by 2002:a05:6402:3593:b0:5dc:ea7e:8c56 with SMTP id
 4fb4d7f45d1cf-5e0b7252dc0mr22230243a12.22.1740311268113; 
 Sun, 23 Feb 2025 03:47:48 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:46 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
Date: Sun, 23 Feb 2025 12:47:08 +0100
Message-ID: <20250223114708.1780-19-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The implementation just allows Linux to determine date and time.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                |   2 +
 hw/rtc/rs5c372.c           | 236 +++++++++++++++++++++++++++++++++++++
 tests/qtest/rs5c372-test.c |  43 +++++++
 hw/rtc/Kconfig             |   5 +
 hw/rtc/meson.build         |   1 +
 hw/rtc/trace-events        |   4 +
 tests/qtest/meson.build    |   1 +
 7 files changed, 292 insertions(+)
 create mode 100644 hw/rtc/rs5c372.c
 create mode 100644 tests/qtest/rs5c372-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 489e426d85..2552cfd65c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -828,10 +828,12 @@ F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
 F: hw/misc/imx8mp_*.c
 F: hw/pci-host/fsl_imx8m_phy.c
+F: hw/rtc/rs5c372.c
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: pc-bios/imx8mp*
+F: tests/qtest/rs5c372-test.c
 F: docs/system/arm/imx8mp-evk.rst
 
 MPS2 / MPS3
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
new file mode 100644
index 0000000000..5542f74085
--- /dev/null
+++ b/hw/rtc/rs5c372.c
@@ -0,0 +1,236 @@
+/*
+ * Ricoh RS5C372, R222x I2C RTC
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * Based on hw/rtc/ds1338.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
+#include "hw/resettable.h"
+#include "migration/vmstate.h"
+#include "qemu/bcd.h"
+#include "qom/object.h"
+#include "system/rtc.h"
+#include "trace.h"
+
+#define NVRAM_SIZE 0x10
+
+/* Flags definitions */
+#define SECONDS_CH 0x80
+#define HOURS_PM   0x20
+#define CTRL2_24   0x20
+
+#define TYPE_RS5C372 "rs5c372"
+OBJECT_DECLARE_SIMPLE_TYPE(RS5C372State, RS5C372)
+
+struct RS5C372State {
+    I2CSlave parent_obj;
+
+    int64_t offset;
+    uint8_t wday_offset;
+    uint8_t nvram[NVRAM_SIZE];
+    uint8_t ptr;
+    uint8_t tx_format;
+    bool addr_byte;
+};
+
+static void capture_current_time(RS5C372State *s)
+{
+    /*
+     * Capture the current time into the secondary registers which will be
+     * actually read by the data transfer operation.
+     */
+    struct tm now;
+    qemu_get_timedate(&now, s->offset);
+    s->nvram[0] = to_bcd(now.tm_sec);
+    s->nvram[1] = to_bcd(now.tm_min);
+    if (s->nvram[0xf] & CTRL2_24) {
+        s->nvram[2] = to_bcd(now.tm_hour);
+    } else {
+        int tmp = now.tm_hour;
+        if (tmp % 12 == 0) {
+            tmp += 12;
+        }
+        if (tmp <= 12) {
+            s->nvram[2] = to_bcd(tmp);
+        } else {
+            s->nvram[2] = HOURS_PM | to_bcd(tmp - 12);
+        }
+    }
+    s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
+    s->nvram[4] = to_bcd(now.tm_mday);
+    s->nvram[5] = to_bcd(now.tm_mon + 1);
+    s->nvram[6] = to_bcd(now.tm_year - 100);
+}
+
+static void inc_regptr(RS5C372State *s)
+{
+    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
+}
+
+static int rs5c372_event(I2CSlave *i2c, enum i2c_event event)
+{
+    RS5C372State *s = RS5C372(i2c);
+
+    switch (event) {
+    case I2C_START_RECV:
+        /*
+         * In h/w, capture happens on any START condition, not just a
+         * START_RECV, but there is no need to actually capture on
+         * START_SEND, because the guest can't get at that data
+         * without going through a START_RECV which would overwrite it.
+         */
+        capture_current_time(s);
+        s->ptr = 0xf;
+        break;
+    case I2C_START_SEND:
+        s->addr_byte = true;
+        break;
+    default:
+        break;
+    }
+
+    return 0;
+}
+
+static uint8_t rs5c372_recv(I2CSlave *i2c)
+{
+    RS5C372State *s = RS5C372(i2c);
+    uint8_t res;
+
+    res  = s->nvram[s->ptr];
+
+    trace_rs5c372_recv(s->ptr, res);
+
+    inc_regptr(s);
+    return res;
+}
+
+static int rs5c372_send(I2CSlave *i2c, uint8_t data)
+{
+    RS5C372State *s = RS5C372(i2c);
+
+    if (s->addr_byte) {
+        s->ptr = data >> 4;
+        s->tx_format = data & 0xf;
+        s->addr_byte = false;
+        return 0;
+    }
+
+    trace_rs5c372_send(s->ptr, data);
+
+    if (s->ptr < 7) {
+        /* Time register. */
+        struct tm now;
+        qemu_get_timedate(&now, s->offset);
+        switch (s->ptr) {
+        case 0:
+            now.tm_sec = from_bcd(data & 0x7f);
+            break;
+        case 1:
+            now.tm_min = from_bcd(data & 0x7f);
+            break;
+        case 2:
+            if (s->nvram[0xf] & CTRL2_24) {
+                now.tm_hour = from_bcd(data & 0x3f);
+            } else {
+                int tmp = from_bcd(data & (HOURS_PM - 1));
+                if (data & HOURS_PM) {
+                    tmp += 12;
+                }
+                if (tmp % 12 == 0) {
+                    tmp -= 12;
+                }
+                now.tm_hour = tmp;
+            }
+            break;
+        case 3:
+            {
+                /*
+                 * The day field is supposed to contain a value in the range
+                 * 1-7. Otherwise behavior is undefined.
+                 */
+                int user_wday = (data & 7) - 1;
+                s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
+            }
+            break;
+        case 4:
+            now.tm_mday = from_bcd(data & 0x3f);
+            break;
+        case 5:
+            now.tm_mon = from_bcd(data & 0x1f) - 1;
+            break;
+        case 6:
+            now.tm_year = from_bcd(data) + 100;
+            break;
+        }
+        s->offset = qemu_timedate_diff(&now);
+    } else {
+        s->nvram[s->ptr] = data;
+    }
+    inc_regptr(s);
+    return 0;
+}
+
+static void rs5c372_reset_hold(Object *obj, ResetType type)
+{
+    RS5C372State *s = RS5C372(obj);
+
+    /* The clock is running and synchronized with the host */
+    s->offset = 0;
+    s->wday_offset = 0;
+    memset(s->nvram, 0, NVRAM_SIZE);
+    s->ptr = 0;
+    s->addr_byte = false;
+}
+
+static const VMStateDescription rs5c372_vmstate = {
+    .name = "rs5c372",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, RS5C372State),
+        VMSTATE_INT64(offset, RS5C372State),
+        VMSTATE_UINT8_V(wday_offset, RS5C372State, 2),
+        VMSTATE_UINT8_ARRAY(nvram, RS5C372State, NVRAM_SIZE),
+        VMSTATE_UINT8(ptr, RS5C372State),
+        VMSTATE_UINT8(tx_format, RS5C372State),
+        VMSTATE_BOOL(addr_byte, RS5C372State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rs5c372_init(Object *obj)
+{
+    qdev_prop_set_uint8(DEVICE(obj), "address", 0x32);
+}
+
+static void rs5c372_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    k->event = rs5c372_event;
+    k->recv = rs5c372_recv;
+    k->send = rs5c372_send;
+    dc->vmsd = &rs5c372_vmstate;
+    rc->phases.hold = rs5c372_reset_hold;
+}
+
+static const TypeInfo rs5c372_types[] = {
+    {
+        .name          = TYPE_RS5C372,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(RS5C372State),
+        .instance_init = rs5c372_init,
+        .class_init    = rs5c372_class_init,
+    },
+};
+
+DEFINE_TYPES(rs5c372_types)
diff --git a/tests/qtest/rs5c372-test.c b/tests/qtest/rs5c372-test.c
new file mode 100644
index 0000000000..0f6a9b68b9
--- /dev/null
+++ b/tests/qtest/rs5c372-test.c
@@ -0,0 +1,43 @@
+/*
+ * QTest testcase for the RS5C372 RTC
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * Based on ds1338-test.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bcd.h"
+#include "libqos/i2c.h"
+
+#define RS5C372_ADDR 0x32
+
+static void rs5c372_read_date(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = obj;
+
+    uint8_t resp[0x10];
+    time_t now = time(NULL);
+    struct tm *utc = gmtime(&now);
+
+    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
+
+    /* check retrieved time against local time */
+    g_assert_cmpuint(from_bcd(resp[5]), == , utc->tm_mday);
+    g_assert_cmpuint(from_bcd(resp[6]), == , 1 + utc->tm_mon);
+    g_assert_cmpuint(2000 + from_bcd(resp[7]), == , 1900 + utc->tm_year);
+}
+
+static void rs5c372_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = { };
+    add_qi2c_address(&opts, &(QI2CAddress) { RS5C372_ADDR });
+
+    qos_node_create_driver("rs5c372", i2c_device_create);
+    qos_node_consumes("rs5c372", "i2c-bus", &opts);
+    qos_add_test("read_date", "rs5c372", rs5c372_read_date, NULL);
+}
+
+libqos_init(rs5c372_register_nodes);
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 2fe04ec1d0..315b0e4ecc 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -26,3 +26,8 @@ config GOLDFISH_RTC
 
 config LS7A_RTC
     bool
+
+config RS5C372_RTC
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 8ecc2d792c..6c87864dc0 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
 system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c372.c'))
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 8012afe102..b9f2852d35 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -35,3 +35,7 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x val
 # goldfish_rtc.c
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+
+# rs5c372.c
+rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
+rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8a6243382a..9e5380ba7a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -298,6 +298,7 @@ qos_test_ss.add(
   'pca9552-test.c',
   'pci-test.c',
   'pcnet-test.c',
+  'rs5c372-test.c',
   'sdhci-test.c',
   'spapr-phb-test.c',
   'tmp105-test.c',
-- 
2.48.1


