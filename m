Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB8706287
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCH0-00068s-1b; Wed, 17 May 2023 04:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGq-0005uT-NF; Wed, 17 May 2023 04:12:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGk-0003Mj-Hk; Wed, 17 May 2023 04:12:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30796c0cbcaso421649f8f.1; 
 Wed, 17 May 2023 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311140; x=1686903140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pc+h22qrBgYh6YvkhQsj0ayYok4y4K6400dOTySuxLA=;
 b=siotNUOmOWflEPo740kwQAQir/z8pc/CuLL7nhbqHb2f/6+bcCWsqo4rItaa8TuOld
 7g4HjeSnHgzVQBe1lu4PPpkJaGvlKc7Cgs+laGou+v9gzSCJ6VlLpsOhli+7dk02hJXg
 5AF+HF6FzGQWeyqS1l7EA4B3v68Ln0tjD4Ls7m9/WjzE689ekoWYpKpPZh1kwOy0t/B1
 sMpcyd3//xOHHDUOvShytvtWbuFpIJ4tBADALKtDazPl22HpGxFudfOPOrOw9UWKjPaF
 tBY+66q1+aBOBTQffPPtqPZ3wu4ocwxFHTy0TENCBZ+hut8V/xg/jPfm7swjrFVw5EXl
 R25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311140; x=1686903140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pc+h22qrBgYh6YvkhQsj0ayYok4y4K6400dOTySuxLA=;
 b=U4JuJUUTSamqSM3oz3LAUVk6+vHzTEci+r/Npk4ZBtfQacU21Cf1QsVB19RkLfBZsL
 qO/Z11fAWN41BDaHtWmBGqEIU3fY6xDN28Ioj8vv7QxiKz94n9nMF+xtKtAfGS+UUtMk
 3FS44aZxOtuLcD4I6OtaS0pUx79kvvZv6PCM7c+idmUGPKq0nCQnSsaahmTUb7zwAMD5
 eBK86L9F/S3hp4MOon2GCvJhiegi0W+BUjiMQaWm2YxYz6KDt6XgrH4jD8efNMNUO6TA
 BHhmyU0eR1Nn0Nyv+Hj0qtxkKQ7l63R8IdXGvYcEHqbveUI9bukJ2Csz4bRo2oNvWYqE
 A3/A==
X-Gm-Message-State: AC+VfDwKe/euzCFxHUxVD0+Fx6ENC9Mj30Vtfo8gYSgwfXfXbvJq39Cn
 Tgobv1qH48eEFUrP3EhX/+x3VjjMIBg=
X-Google-Smtp-Source: ACHHUZ4wLYIT4COkjvV9E9twYE8XhDlk/jMO2wNfIjWr19wXdNFg8dPH2qZSGQBWcdDc5w9d7WjWHQ==
X-Received: by 2002:a5d:4c8c:0:b0:2f5:3dfd:f4d2 with SMTP id
 z12-20020a5d4c8c000000b002f53dfdf4d2mr29187143wrs.64.1684311140380; 
 Wed, 17 May 2023 01:12:20 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:20 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 5/8] tiva c watchdog timers implementation
Date: Wed, 17 May 2023 11:12:01 +0300
Message-Id: <20230517081204.30333-6-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517081204.30333-1-m.elsayed4420@gmail.com>
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
---
 hw/watchdog/tm4c123_watchdog.c         | 297 +++++++++++++++++++++++++
 hw/watchdog/trace-events               |   3 +
 include/hw/watchdog/tm4c123_watchdog.h |  97 ++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 hw/watchdog/tm4c123_watchdog.c
 create mode 100644 include/hw/watchdog/tm4c123_watchdog.h

diff --git a/hw/watchdog/tm4c123_watchdog.c b/hw/watchdog/tm4c123_watchdog.c
new file mode 100644
index 0000000000..ea0a41f3c0
--- /dev/null
+++ b/hw/watchdog/tm4c123_watchdog.c
@@ -0,0 +1,297 @@
+/*
+ * TM4C123 Watchdog Timers
+ *
+ * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/watchdog/tm4c123_watchdog.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "sysemu/runstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/nmi.h"
+#include "trace.h"
+
+#define LOG(mask, fmt, args...) qemu_log_mask(mask, "%s: " fmt, __func__, ## args)
+#define READONLY LOG(LOG_GUEST_ERROR, "0x%"HWADDR_PRIx" is a readonly field\n.", addr)
+
+static bool locked;
+
+static void tm4c123_wdt_expired(void *opaque)
+{
+    TM4C123WatchdogState *s = opaque;
+    /*if this is the first timeout/the ris is not cleared */
+    if (!test_bit(0, (const unsigned long *)&s->wdt_mis)) {
+        set_bit(0, (unsigned long *)&s->wdt_mis);
+        nmi_monitor_handle(0, NULL);
+        qemu_irq_pulse(s->irq);
+    } else {
+        if (test_bit(1, (const unsigned long *)&s->wdt_ctl))
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        else {
+            nmi_monitor_handle(0, NULL);
+            qemu_irq_pulse(s->irq);
+        }
+    }
+}
+
+static bool wdt_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
+{
+    switch (addr) {
+        case WDT_0:
+            return s->sysctl_rcgcwd & (1 << 0);
+            break;
+        case WDT_1:
+            return s->sysctl_rcgcwd & (1 << 1);
+            break;
+    }
+    return false;
+}
+
+static void tm4c123_wdt_reset(DeviceState *dev)
+{
+    TM4C123WatchdogState *s = TM4C123_WATCHDOG(dev);
+
+    s->wdt_load = 0xFFFFFFFF;
+    s->wdt_value = 0xFFFFFFFF;
+    s->wdt_ctl = (s->mmio.addr == WDT_0 ? 0x00000000 : 0x80000000);
+    s->wdt_icr = 0x00000000;
+    s->wdt_ris = 0x00000000;
+    s->wdt_mis = 0x00000000;
+    s->wdt_test = 0x00000000;
+    s->wdt_lock = 0x00000000;
+    s->wdt_per_id4 = 0x00000000;
+    s->wdt_per_id5 = 0x00000000;
+    s->wdt_per_id6 = 0x00000000;
+    s->wdt_per_id7 = 0x00000000;
+    s->wdt_per_id0 = 0x00000005;
+    s->wdt_per_id1 = 0x00000018;
+    s->wdt_per_id2 = 0x00000018;
+    s->wdt_per_id3 = 0x00000001;
+    s->wdt_pcell_id0 = 0x0000000D;
+    s->wdt_pcell_id1 = 0x000000F0;
+    s->wdt_pcell_id2 = 0x00000006;
+    s->wdt_pcell_id3 = 0x000000B1;
+}
+
+static uint64_t tm4c123_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    TM4C123WatchdogState *s = opaque;
+
+    if (!wdt_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("Watchdog timer module clock is not enabled");
+    }
+
+    switch (addr) {
+        case WDT_LOAD:
+            return s->wdt_load;
+        case WDT_VALUE:
+            return ptimer_get_count(s->timer);
+        case WDT_CTL:
+            return s->wdt_ctl;
+        case WDT_ICR:
+            return s->wdt_icr;
+        case WDT_RIS:
+            return s->wdt_ris;
+        case WDT_MIS:
+            return s->wdt_mis;
+        case WDT_TEST:
+            return s->wdt_test;
+        case WDT_LOCK:
+            return s->wdt_lock;
+        case WDT_PER_ID4:
+            return s->wdt_per_id4;
+        case WDT_PER_ID5:
+            return s->wdt_per_id5;
+        case WDT_PER_ID6:
+            return s->wdt_per_id6;
+        case WDT_PER_ID7:
+            return s->wdt_per_id7;
+        case WDT_PER_ID0:
+            return s->wdt_per_id0;
+        case WDT_PER_ID1:
+            return s->wdt_per_id1;
+        case WDT_PER_ID2:
+            return s->wdt_per_id2;
+        case WDT_PER_ID3:
+            return s->wdt_per_id3;
+        case WDT_PCELL_ID0:
+            return s->wdt_pcell_id0;
+        case WDT_PCELL_ID1:
+            return s->wdt_pcell_id1;
+        case WDT_PCELL_ID2:
+            return s->wdt_pcell_id2;
+        case WDT_PCELL_ID3:
+            return s->wdt_pcell_id3;
+        default:
+            LOG(LOG_GUEST_ERROR, "Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+    return 0;
+}
+
+static void tm4c123_wdt_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
+{
+    TM4C123WatchdogState *s = opaque;
+    uint32_t val32 = val64;
+
+    trace_tm4c123_wdt_write(addr, val64);
+    if (!wdt_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("Watchdog module clock is not enabled");
+    }
+
+    switch (addr) {
+        case WDT_LOAD:
+            s->wdt_load = val32;
+            locked = true;
+            s->wdt_ctl |= WDT_CTL_INTEN;
+            ptimer_transaction_begin(s->timer);
+            ptimer_set_count(s->timer, s->wdt_load);
+            ptimer_set_limit(s->timer, s->wdt_load, 1);
+            ptimer_run(s->timer, 0);
+            ptimer_transaction_commit(s->timer);
+            break;
+        case WDT_VALUE:
+            READONLY;
+            break;
+        case WDT_CTL:
+            s->wdt_ctl = val32;
+            break;
+        case WDT_ICR:
+            ptimer_transaction_begin(s->timer);
+            ptimer_set_limit(s->timer, s->wdt_load, 1);
+            ptimer_transaction_commit(s->timer);
+            clear_bit(0, (unsigned long *)&s->wdt_ris);
+            clear_bit(0, (unsigned long *)&s->wdt_mis);
+            s->wdt_icr = val32;
+            break;
+        case WDT_RIS:
+            READONLY;
+            break;
+        case WDT_MIS:
+            READONLY;
+            break;
+        case WDT_TEST:
+            s->wdt_test = val32;
+            break;
+        case WDT_LOCK:
+            /* The actual hardware never locks the module */
+            if (val32 == UNLOCK_VALUE) {
+                locked = false;
+                s->wdt_lock = 0;
+            }
+            break;
+        case WDT_PER_ID4:
+            READONLY;
+            break;
+        case WDT_PER_ID5:
+            READONLY;
+            break;
+        case WDT_PER_ID6:
+            READONLY;
+            break;
+        case WDT_PER_ID7:
+            READONLY;
+            break;
+        case WDT_PER_ID0:
+            READONLY;
+            break;
+        case WDT_PER_ID1:
+            READONLY;
+            break;
+        case WDT_PER_ID2:
+            READONLY;
+            break;
+        case WDT_PER_ID3:
+            READONLY;
+            break;
+        case WDT_PCELL_ID0:
+            READONLY;
+            break;
+        case WDT_PCELL_ID1:
+            READONLY;
+            break;
+        case WDT_PCELL_ID2:
+            READONLY;
+            break;
+        case WDT_PCELL_ID3:
+            READONLY;
+            break;
+        default:
+            LOG(LOG_GUEST_ERROR, "Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+}
+
+const struct MemoryRegionOps tm4c123_wdt_ops = {
+    .read = tm4c123_wdt_read,
+    .write = tm4c123_wdt_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void tm4c123_wdt_init(Object *obj)
+{
+    TM4C123WatchdogState *s = TM4C123_WATCHDOG(obj);
+
+    s->wdt_clock = qdev_init_clock_in(DEVICE(s), "wdt_clock", NULL, NULL, 0);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    memory_region_init_io(&s->mmio, obj, &tm4c123_wdt_ops, s, TYPE_TM4C123_WATCHDOG, 0xFFF);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void tm4c123_wdt_realize(DeviceState *dev, Error **errp)
+{
+    TM4C123WatchdogState *s = TM4C123_WATCHDOG(dev);
+    qdev_connect_clock_in(dev, "wdt_clock", qdev_get_clock_out(DEVICE(s->sysctl), "outclk"));
+
+    s->timer = ptimer_init(tm4c123_wdt_expired, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_period_from_clock(s->timer, s->wdt_clock, 1);
+    ptimer_set_limit(s->timer, 0xFFFFFFFF, 0);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void tm4c123_wdt_class_init(ObjectClass *kclass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(kclass);
+    dc->realize = tm4c123_wdt_realize;
+    dc->reset = tm4c123_wdt_reset;
+}
+
+static const TypeInfo tm4c123_wdt_info = {
+    .name = TYPE_TM4C123_WATCHDOG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TM4C123WatchdogState),
+    .instance_init = tm4c123_wdt_init,
+    .class_init = tm4c123_wdt_class_init,
+};
+
+static void tm4c123_wdt_register_types(void)
+{
+    type_register_static(&tm4c123_wdt_info);
+}
+
+type_init(tm4c123_wdt_register_types)
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index 2739570652..802aed4a6f 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_wdt.c
+tm4c123_wdt_write(uint64_t offset, uint64_t data) "TM4C123-WDT Write: [ Offset 0x%" PRIx64 " - Data 0x%" PRIx64 "]"
+
 # allwinner-wdt.c
 allwinner_wdt_read(uint64_t offset, uint64_t data, unsigned size) "Allwinner watchdog read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 allwinner_wdt_write(uint64_t offset, uint64_t data, unsigned size) "Allwinner watchdog write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
diff --git a/include/hw/watchdog/tm4c123_watchdog.h b/include/hw/watchdog/tm4c123_watchdog.h
new file mode 100644
index 0000000000..2621b5d805
--- /dev/null
+++ b/include/hw/watchdog/tm4c123_watchdog.h
@@ -0,0 +1,97 @@
+/*
+ * TM4C123 Watchdog Timers
+ *
+ * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_ARM_TM4C123_WATCHDOG_H
+#define HW_ARM_TM4C123_WATCHDOG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "hw/misc/tm4c123_sysctl.h"
+#include "hw/ptimer.h"
+
+#define WDT_0 0x40000000
+#define WDT_1 0x40001000
+
+#define WDT_LOAD 0x000
+#define WDT_VALUE 0x004
+#define WDT_CTL 0x008
+#define WDT_ICR 0x00C
+#define WDT_RIS 0x010
+#define WDT_MIS 0x014
+#define WDT_TEST 0x418
+#define WDT_LOCK 0xC00
+#define WDT_PER_ID4 0xFD0
+#define WDT_PER_ID5 0xFD4
+#define WDT_PER_ID6 0xFD8
+#define WDT_PER_ID7 0xFDC
+#define WDT_PER_ID0 0xFE0
+#define WDT_PER_ID1 0xFE4
+#define WDT_PER_ID2 0xFE8
+#define WDT_PER_ID3 0xFEC
+#define WDT_PCELL_ID0 0xFF0
+#define WDT_PCELL_ID1 0xFF4
+#define WDT_PCELL_ID2 0xFF8
+#define WDT_PCELL_ID3 0xFFC
+
+#define UNLOCK_VALUE 0x1ACCE551
+
+#define WDT_CTL_INTEN (1 << 0)
+#define WDT_CTL_INTTYPE (1 << 2)
+
+#define TYPE_TM4C123_WATCHDOG "tm4c123-watchdog"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TM4C123WatchdogState, TM4C123_WATCHDOG)
+
+struct TM4C123WatchdogState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    qemu_irq irq;
+    struct ptimer_state *timer;
+    TM4C123SysCtlState* sysctl;
+
+    uint32_t wdt_load;
+    uint32_t wdt_value;
+    uint32_t wdt_ctl;
+    uint32_t wdt_icr;
+    uint32_t wdt_ris;
+    uint32_t wdt_mis;
+    uint32_t wdt_test;
+    uint32_t wdt_lock;
+    uint32_t wdt_per_id4;
+    uint32_t wdt_per_id5;
+    uint32_t wdt_per_id6;
+    uint32_t wdt_per_id7;
+    uint32_t wdt_per_id0;
+    uint32_t wdt_per_id1;
+    uint32_t wdt_per_id2;
+    uint32_t wdt_per_id3;
+    uint32_t wdt_pcell_id0;
+    uint32_t wdt_pcell_id1;
+    uint32_t wdt_pcell_id2;
+    uint32_t wdt_pcell_id3;
+
+    Clock* wdt_clock;
+};
+
+#endif
-- 
2.34.1


