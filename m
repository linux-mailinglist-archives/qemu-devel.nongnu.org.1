Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B977F038B
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 00:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4UUt-00044M-Kl; Sat, 18 Nov 2023 18:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4UUr-000447-QS; Sat, 18 Nov 2023 18:13:05 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4UUp-0005M9-RL; Sat, 18 Nov 2023 18:13:05 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so27703295ad.0; 
 Sat, 18 Nov 2023 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700349182; x=1700953982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEmsomaixITNUTHH/qjXH5kdBBxKKgywepAHlF49OfU=;
 b=ZiD9G0awLZKUsEHhWwof0mgQ9Irj5Ieb25v+RXl52Ikry9bJQrZX51bAp5WGas4nE8
 lDFVCBV7AwOSrhFquhR0/7Y5expA8YAi9IgnZtjoLKdlKNREqKHdedU0SHMKwbUh8CRW
 XDIiJCAa122/TZjcBZUu5Tgu/wYOb8TW8GOo38f6VA/rEkiZ+Q8LBrF8aaFIgMyEE18M
 fr1+vT+2xiNyT7zN9XsEShL7dkURf/A48TVN8aUNGndKtb8JaWnWbfb+9hb/Paa1uATF
 8/ApDi9OkykL8mBQFuY4vdOFkvMfwM4mXbrjGsW3s4lJs7qp0AJo5crzfuG2IiGUgw6F
 uNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700349182; x=1700953982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZEmsomaixITNUTHH/qjXH5kdBBxKKgywepAHlF49OfU=;
 b=Qf1bpHqtxCn37UNSpJt6VwXeBJdLD0kduFb79Qpyr3OXLScpqu+Fb3PC00WUYMttYt
 fZsKs5dj2Iain3cUZI5upnAMn25gA24HzDMLHeWxIrCI7A6egUASGdVPvuYSQ1jRXjRw
 Z3mhv17NnSAifWJtSxoplQtHfxB0G+hXwp2krqbEqyYY1Hy8hdOTuJr2SS/c0WRH+UIU
 9100YEetF6aMdiLH2CYZOWAnQsVxXMx3Q/MFQmk85e0kNlx2HxrclTS9tJtuiMMweFFC
 egcnqJt1IO5aoz84loevVf0LsUgk4hPDLpU4L5Q3tocxNTgVJpBGi5DFF1tswHlHRugc
 /RYw==
X-Gm-Message-State: AOJu0Yw14VYKPkCN8JIrK3r4pxeQj6vy6t+fSNqyXVWiuxBxF3pNExnA
 zdwNXk55vdDJpTK9O6FlGCDHcwHtw8A=
X-Google-Smtp-Source: AGHT+IEmiP7wbKqHuD4rK43Y6wln0EqpVlZy/xJybOcMApAT1ie04chwrs7S0yPkjIAdVXNxymcrbA==
X-Received: by 2002:a17:902:f54e:b0:1cc:bf63:929 with SMTP id
 h14-20020a170902f54e00b001ccbf630929mr4428316plf.64.1700349181179; 
 Sat, 18 Nov 2023 15:13:01 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:7761:abec:4d36:7df4])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a170902ed4c00b001cc256ce1besm3462356plb.138.2023.11.18.15.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 15:13:00 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/timer/hpet: Convert DPRINTF to trace events
Date: Sat, 18 Nov 2023 15:11:29 -0800
Message-Id: <20231118231129.2840388-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dhoff749@gmail.com; helo=mail-pl1-x62d.google.com
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

This conversion is pretty straight-forward. Standardized some formatting
so the +0 and +4 offset cases can recycle the same message.

Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
---
 hw/timer/hpet.c       | 55 +++++++++++++++++--------------------------
 hw/timer/trace-events | 16 +++++++++++++
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 6998094233a..f9d248b4cf7 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -39,13 +39,7 @@
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "qom/object.h"
-
-//#define HPET_DEBUG
-#ifdef HPET_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
+#include "trace.h"
 
 #define HPET_MSI_SUPPORT        0
 
@@ -431,7 +425,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t cur_tick, index;
 
-    DPRINTF("qemu: Enter hpet_ram_readl at %" PRIx64 "\n", addr);
+    trace_hpet_ram_read(addr);
     index = addr;
     /*address range of all TN regs*/
     if (index >= 0x100 && index <= 0x3ff) {
@@ -439,7 +433,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
         HPETTimer *timer = &s->timer[timer_id];
 
         if (timer_id > s->num_timers) {
-            DPRINTF("qemu: timer id out of range\n");
+            trace_hpet_timer_id_out_of_range(timer_id);
             return 0;
         }
 
@@ -457,7 +451,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
         case HPET_TN_ROUTE + 4:
             return timer->fsb >> 32;
         default:
-            DPRINTF("qemu: invalid hpet_ram_readl\n");
+            trace_hpet_ram_read_invalid();
             break;
         }
     } else {
@@ -469,7 +463,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
         case HPET_CFG:
             return s->config;
         case HPET_CFG + 4:
-            DPRINTF("qemu: invalid HPET_CFG + 4 hpet_ram_readl\n");
+            trace_hpet_invalid_hpet_cfg(4);
             return 0;
         case HPET_COUNTER:
             if (hpet_enabled(s)) {
@@ -477,7 +471,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             } else {
                 cur_tick = s->hpet_counter;
             }
-            DPRINTF("qemu: reading counter  = %" PRIx64 "\n", cur_tick);
+            trace_hpet_ram_read_reading_counter(0, cur_tick);
             return cur_tick;
         case HPET_COUNTER + 4:
             if (hpet_enabled(s)) {
@@ -485,12 +479,12 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             } else {
                 cur_tick = s->hpet_counter;
             }
-            DPRINTF("qemu: reading counter + 4  = %" PRIx64 "\n", cur_tick);
+            trace_hpet_ram_read_reading_counter(4, cur_tick);
             return cur_tick >> 32;
         case HPET_STATUS:
             return s->isr;
         default:
-            DPRINTF("qemu: invalid hpet_ram_readl\n");
+            trace_hpet_ram_read_invalid();
             break;
         }
     }
@@ -504,8 +498,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;
 
-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = 0x%" PRIx64 "\n",
-            addr, value);
+    trace_hpet_ram_write(addr, value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -515,14 +508,14 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
-        DPRINTF("qemu: hpet_ram_writel timer_id = 0x%x\n", timer_id);
+        trace_hpet_ram_write_timer_id(timer_id);
         if (timer_id > s->num_timers) {
-            DPRINTF("qemu: timer id out of range\n");
+            trace_hpet_timer_id_out_of_range(timer_id);
             return;
         }
         switch ((addr - 0x100) % 0x20) {
         case HPET_TN_CFG:
-            DPRINTF("qemu: hpet_ram_writel HPET_TN_CFG\n");
+            trace_hpet_ram_write_tn_cfg();
             if (activating_bit(old_val, new_val, HPET_TN_FSB_ENABLE)) {
                 update_irq(timer, 0);
             }
@@ -540,10 +533,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             break;
         case HPET_TN_CFG + 4: // Interrupt capabilities
-            DPRINTF("qemu: invalid HPET_TN_CFG+4 write\n");
+            trace_hpet_ram_write_invalid_tn_cfg(4);
             break;
         case HPET_TN_CMP: // comparator register
-            DPRINTF("qemu: hpet_ram_writel HPET_TN_CMP\n");
+            trace_hpet_ram_write_tn_cmp(0);
             if (timer->config & HPET_TN_32BIT) {
                 new_val = (uint32_t)new_val;
             }
@@ -566,7 +559,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             break;
         case HPET_TN_CMP + 4: // comparator register high order
-            DPRINTF("qemu: hpet_ram_writel HPET_TN_CMP + 4\n");
+            trace_hpet_ram_write_tn_cmp(4);
             if (!timer_is_periodic(timer)
                 || (timer->config & HPET_TN_SETVAL)) {
                 timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
@@ -591,7 +584,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             timer->fsb = (new_val << 32) | (timer->fsb & 0xffffffff);
             break;
         default:
-            DPRINTF("qemu: invalid hpet_ram_writel\n");
+            trace_hpet_ram_write_invalid();
             break;
         }
         return;
@@ -631,7 +624,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             break;
         case HPET_CFG + 4:
-            DPRINTF("qemu: invalid HPET_CFG+4 write\n");
+            trace_hpet_invalid_hpet_cfg(4);
             break;
         case HPET_STATUS:
             val = new_val & s->isr;
@@ -643,24 +636,20 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             break;
         case HPET_COUNTER:
             if (hpet_enabled(s)) {
-                DPRINTF("qemu: Writing counter while HPET enabled!\n");
+                trace_hpet_ram_write_counter_write_while_enabled();
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = 0x%" PRIx64 " -> "
-                    "%" PRIx64 "\n", value, s->hpet_counter);
+            trace_hpet_ram_write_counter_written(0, value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
-            if (hpet_enabled(s)) {
-                DPRINTF("qemu: Writing counter while HPET enabled!\n");
-            }
+            trace_hpet_ram_write_counter_write_while_enabled();
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = 0x%" PRIx64 " -> "
-                    "%" PRIx64 "\n", value, s->hpet_counter);
+            trace_hpet_ram_write_counter_written(4, value, s->hpet_counter);
             break;
         default:
-            DPRINTF("qemu: invalid hpet_ram_writel\n");
+            trace_hpet_ram_write_invalid();
             break;
         }
     }
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 3eccef83858..474831a8c3b 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -99,3 +99,19 @@ sifive_pwm_write(uint64_t data, uint64_t offset) "Write 0x%" PRIx64 " at address
 sh_timer_start_stop(int enable, int current) "%d (%d)"
 sh_timer_read(uint64_t offset) "tmu012_read 0x%" PRIx64
 sh_timer_write(uint64_t offset, uint64_t value) "tmu012_write 0x%" PRIx64 " 0x%08" PRIx64
+
+# hpet.c
+hpet_timer_id_out_of_range(uint8_t timer_id) "timer id out of range: 0x%" PRIx8
+hpet_invalid_hpet_cfg(uint8_t reg_off) "invalid HPET_CFG + 0x%x" PRIx8
+hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
+hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "reading counter + 0x%" PRIx8 " = 0x%" PRIx64
+hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
+hpet_ram_write(uint64_t addr, uint64_t value) "enter hpet_ram_writel at 0x%" PRIx64 " = 0x%" PRIx64
+hpet_ram_write_timer_id(uint64_t timer_id) "hpet_ram_writel timer_id = 0x%" PRIx64
+hpet_ram_write_tn_cfg(void) "hpet_ram_writel HPET_TN_CFG"
+hpet_ram_write_invalid_tn_cfg(uint8_t reg_off) "invalid HPET_TN_CFG + %" PRIx8 " write"
+hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIx8
+hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
+hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
+hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t counter) "HPET counter + %" PRIx8 "written. crt = 0x%" PRIx64 " -> 0x%" PRIx64
+
-- 
2.40.1


