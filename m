Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91D704674
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp9D-0005Or-93; Tue, 16 May 2023 03:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8s-0004i6-RB; Tue, 16 May 2023 03:30:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8p-0000DD-T2; Tue, 16 May 2023 03:30:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3077d134028so8294082f8f.3; 
 Tue, 16 May 2023 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684222237; x=1686814237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pskLVLlHZjmAvPsJ8HW9vY9uOmUnfd/UbQ4KaVpfNzs=;
 b=TXb3ezrYbx4jNKdsqooEzQQtgufnTsrV2NUa6aao6XfXGe1C89hcZuO3CQyUdiyTWu
 JucshEAOYjnxIS+Z50j34B6VbJALGYmeJOlGzylbZ98YWXROyvRHZWRseGBvC+pbe1Ti
 kI24PBX8MyGoGPsaoykkCEQW6GSx0HuInqAliK6Yj8t6HifK/VFBSXM8A4RETE3kcx3p
 6e7XQZbR27lX2sfpc3L/L1iMYI4YBQ/xq/9ZziEZnGlJlXI+VFcbpUbr7gOxTbi0mWqq
 2qa6/4AWIit68JxXhgMqVfA0DXCl66C9QeezNZ+0WNkOv37uLDEpUGUrBqhOeLcpbC9t
 Yxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222237; x=1686814237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pskLVLlHZjmAvPsJ8HW9vY9uOmUnfd/UbQ4KaVpfNzs=;
 b=hpG4uP7PTkpU5HutdB9e9VFRqCy0sUJqYI/Q8cJKcU3Koh3k+foH4ukWCWYrRN9EEZ
 EwNPh3k6rTHo6svv/eJS+ZfKkb3CHMuiNZDmcu/r+av0B0y49LUTyQx3YU/iZgqn0QVu
 TH01ICmSOycAfAzSo1BKR3DRIYi8vAz1+UFWyk1ovmtU7lQQjz6DMEswJ1So+D3BxPlv
 HPBpJnpuxNrNJnNMoUe/vab16Ih+9smm3pKgR55YWukGuxY2Gte57r1MyU4Fw6VVoGp5
 0eqMDRYEUToB/tVoXmULIRwia5+VEHpUpkMh5XIEDdKN8X85xkOoQJasTgrJRm0Aa5zm
 gUCQ==
X-Gm-Message-State: AC+VfDwD8cCZeVrPp3dEiOkdTkVega8T/KaOgPqUUpUmeppigw0VPGqv
 +aJDb03yrn0BOY8MWLI3R+UHKztiRdQtqg==
X-Google-Smtp-Source: ACHHUZ5eWgx3RQfLzTaBIwDFPUoG6VzmZuGX4Zl8KW8kY67gm939++UpJwDoOMCkL5ENVhLLk8Otqw==
X-Received: by 2002:adf:ebc6:0:b0:306:2830:224f with SMTP id
 v6-20020adfebc6000000b003062830224fmr24231077wrn.23.1684222237421; 
 Tue, 16 May 2023 00:30:37 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 y12-20020a5d614c000000b003062c609115sm1559997wrt.21.2023.05.16.00.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:30:37 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PULL 8/8] code style fixes
Date: Tue, 16 May 2023 10:29:59 +0300
Message-Id: <20230516072959.49994-9-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516072959.49994-1-m.elsayed4420@gmail.com>
References: <20230516072959.49994-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wr1-x436.google.com
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
 hw/arm/tm4c123gh6pm_soc.c      |  14 ++--
 hw/char/tm4c123_usart.c        |  28 +++----
 hw/misc/tm4c123_sysctl.c       |   6 +-
 hw/timer/tm4c123_gptm.c        | 134 ++++++++++++---------------------
 hw/watchdog/tm4c123_watchdog.c |  25 +++---
 5 files changed, 85 insertions(+), 122 deletions(-)

diff --git a/hw/arm/tm4c123gh6pm_soc.c b/hw/arm/tm4c123gh6pm_soc.c
index da08eefc33..7afaa6653b 100644
--- a/hw/arm/tm4c123gh6pm_soc.c
+++ b/hw/arm/tm4c123gh6pm_soc.c
@@ -89,7 +89,8 @@ static void tm4c123gh6pm_soc_initfn(Object *obj)
     object_initialize_child(obj, "sysctl", &s->sysctl, TYPE_TM4C123_SYSCTL);
 
     for (i = 0; i < USART_COUNT; i++) {
-        object_initialize_child(obj, "usart[*]", &s->usart[i], TYPE_TM4C123_USART);
+        object_initialize_child(obj, "usart[*]",
+                                &s->usart[i], TYPE_TM4C123_USART);
     }
 
     for (i = 0; i < GPIO_COUNT; i++) {
@@ -97,7 +98,8 @@ static void tm4c123gh6pm_soc_initfn(Object *obj)
     }
 
     for (i = 0; i < WDT_COUNT; i++) {
-        object_initialize_child(obj, "watchdog-timer[*]", &s->wdt[i], TYPE_TM4C123_WATCHDOG);
+        object_initialize_child(obj, "watchdog-timer[*]",
+                                &s->wdt[i], TYPE_TM4C123_WATCHDOG);
     }
 
     for (i = 0; i < GPTM_COUNT; i++) {
@@ -115,14 +117,14 @@ static void tm4c123gh6pm_soc_realize(DeviceState *dev_soc, Error **errp)
 
     MemoryRegion *system_memory = get_system_memory();
 
-    //init flash memory
+    /* init flash memory */
     memory_region_init_rom(
             &s->flash, OBJECT(dev_soc),
             "TM4C123GH6PM.flash", FLASH_SIZE, &error_fatal
             );
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
 
-    //init sram and the sram alias region
+    /* init sram and the sram alias region */
     memory_region_init_ram(
             &s->sram, OBJECT(dev_soc),
             "TM4C123GH6PM.sram", SRAM_SIZE, &error_fatal);
@@ -181,7 +183,7 @@ static void tm4c123gh6pm_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* General purpose timers */
     int j = 0;
-    for (i = 0, j = 0; i < GPTM_COUNT; i++, j+=2) {
+    for (i = 0, j = 0; i < GPTM_COUNT; i++, j += 2) {
         dev = DEVICE(&(s->gptm[i]));
         s->gptm[i].sysctl = &s->sysctl;
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gptm[i]), errp)) {
@@ -190,7 +192,7 @@ static void tm4c123gh6pm_soc_realize(DeviceState *dev_soc, Error **errp)
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, gptm_addrs[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, gptm_irqs[j]));
-        sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(armv7m, gptm_irqs[j+1]));
+        sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(armv7m, gptm_irqs[j + 1]));
     }
 
     /* SYSCTL */
diff --git a/hw/char/tm4c123_usart.c b/hw/char/tm4c123_usart.c
index cafca02b97..ed20eedb4c 100644
--- a/hw/char/tm4c123_usart.c
+++ b/hw/char/tm4c123_usart.c
@@ -36,42 +36,41 @@
 
 static bool usart_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
 {
-    switch(addr) {
+    switch (addr) {
         case USART_0:
-            return (s->sysctl_rcgcuart & (1 << 0));
+            return s->sysctl_rcgcuart & (1 << 0);
             break;
         case USART_1:
-            return (s->sysctl_rcgcuart & (1 << 1));
+            return s->sysctl_rcgcuart & (1 << 1);
             break;
         case USART_2:
-            return (s->sysctl_rcgcuart & (1 << 2));
+            return s->sysctl_rcgcuart & (1 << 2);
             break;
         case USART_3:
-            return (s->sysctl_rcgcuart & (1 << 3));
+            return s->sysctl_rcgcuart & (1 << 3);
             break;
         case USART_4:
-            return (s->sysctl_rcgcuart & (1 << 4));
+            return s->sysctl_rcgcuart & (1 << 4);
             break;
         case USART_5:
-            return (s->sysctl_rcgcuart & (1 << 5));
+            return s->sysctl_rcgcuart & (1 << 5);
             break;
         case USART_6:
-            return (s->sysctl_rcgcuart & (1 << 6));
+            return s->sysctl_rcgcuart & (1 << 6);
             break;
         case USART_7:
-            return (s->sysctl_rcgcuart & (1 << 7));
+            return s->sysctl_rcgcuart & (1 << 7);
             break;
     }
     return false;
 }
 
 
-static int tm4c123_usart_can_receive(void* opaque)
+static int tm4c123_usart_can_receive(void *opaque)
 {
     TM4C123USARTState *s = opaque;
 
     if (!(s->usart_fr & USART_FR_RXFF)) {
-        //the module can receive data.
         return 1;
     }
     return 0;
@@ -82,7 +81,6 @@ static void tm4c123_usart_receive(void *opaque, const uint8_t *buf, int size)
     TM4C123USARTState *s = opaque;
 
     if (!(s->usart_ctl & USART_CR_EN && s->usart_ctl & USART_CR_RXE)) {
-        //the module is not enabled
         LOG("The module is not enbled\n");
         return;
     }
@@ -93,8 +91,6 @@ static void tm4c123_usart_receive(void *opaque, const uint8_t *buf, int size)
     if (s->usart_im & USART_IM_RXIM) {
         qemu_set_irq(s->irq, 1);
     }
-
-    LOG("Receiving: %c\n", s->usart_dr);
 }
 
 static void tm4c123_usart_reset(DeviceState *dev)
@@ -145,7 +141,7 @@ static uint64_t tm4c123_usart_read(void *opaque, hwaddr addr, unsigned int size)
 
     trace_tm4c123_usart_read(addr);
 
-    switch(addr) {
+    switch (addr) {
         case USART_DR:
             return s->usart_dr;
         case USART_RSR:
@@ -227,7 +223,7 @@ static void tm4c123_usart_write(void *opaque, hwaddr addr, uint64_t val64, unsig
 
     trace_tm4c123_usart_write(addr, val32);
 
-    switch(addr) {
+    switch (addr) {
         case USART_DR:
             s->usart_dr = val32;
             if (val32 < 0xF000) {
diff --git a/hw/misc/tm4c123_sysctl.c b/hw/misc/tm4c123_sysctl.c
index 9bce30eb73..c07c734df5 100644
--- a/hw/misc/tm4c123_sysctl.c
+++ b/hw/misc/tm4c123_sysctl.c
@@ -282,7 +282,7 @@ static void tm4c123_sysctl_write(void *opaque, hwaddr addr, uint64_t val64, unsi
 
     trace_tm4c123_sysctl_write(addr, val32);
 
-    switch(addr) {
+    switch (addr) {
         case SYSCTL_DID0:
             READONLY;
             break;
@@ -690,7 +690,7 @@ static uint64_t tm4c123_sysctl_read(void *opaque, hwaddr addr, unsigned int size
 
     trace_tm4c123_sysctl_read(addr);
 
-    switch(addr) {
+    switch (addr) {
         case SYSCTL_DID0:
             return s->sysctl_did0;
         case SYSCTL_DID1:
@@ -951,7 +951,7 @@ static void tm4c123_sysctl_init(Object *obj)
     TM4C123SysCtlState *s = TM4C123_SYSCTL(obj);
 
     s->mainclk = clock_new(OBJECT(s), "main-clk");
-    clock_set_hz(s->mainclk, 1000*1000);
+    clock_set_hz(s->mainclk, 1000 * 1000);
     s->outclk = qdev_init_clock_out(DEVICE(s), "outclk");
     clock_set_source(s->outclk, s->mainclk);
 
diff --git a/hw/timer/tm4c123_gptm.c b/hw/timer/tm4c123_gptm.c
index 69f84ee0ec..b1a8600d80 100644
--- a/hw/timer/tm4c123_gptm.c
+++ b/hw/timer/tm4c123_gptm.c
@@ -44,23 +44,13 @@ static unsigned long ticks_to_time_ns(void *opaque, uint64_t ticks, uint32_t pre
 {
     TM4C123GPTMState *s = opaque;
     uint32_t freq = clock_get_hz(s->clk) / prescaler;
-    return (((float)ticks / (float)freq) * NANOSECONDS_PER_SECOND);
-}
-
-static void log_message(const char *message)
-{
-    uint64_t ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    time_t seconds = ns / 1000000000;
-    struct tm *timeinfo = localtime(&seconds);
-    char buffer[80];
-    strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", timeinfo);
-    LOG("[%s] %s\n", buffer, message);
+    return ((float)ticks / (float)freq) * NANOSECONDS_PER_SECOND;
 }
 
 static uint16_t get_timer_width(void *opaque)
 {
     TM4C123GPTMState *s = opaque;
-    switch(s->mmio.addr) {
+    switch (s->mmio.addr) {
         case TIMER0_32...TIMER5_32:
             return TIMER_WIDTH_32;
         case TIMER0_64...TIMER5_64:
@@ -79,8 +69,7 @@ static uint64_t build_interval_value(void *opaque)
         uint16_t upper16 = extract32(s->gptm_talir, 16, 16);
         uint16_t lower16 = extract32(s->gptm_tblir, 0, 16);
         interval_value = ((uint32_t)lower16 << 16) + upper16;
-    }
-    else if (timer_width == TIMER_WIDTH_64) {
+    } else if (timer_width == TIMER_WIDTH_64) {
         interval_value = ((uint64_t)s->gptm_talir << 32) + s->gptm_tblir;
     }
 
@@ -102,43 +91,31 @@ static void set_timers(void *opaque)
                 interval_value = extract32(s->gptm_talir, 0, 16);
                 /* Start the timer? */
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/16 is running\n");
-            }
-            else if (s->gptm_cfg == 0x1) {
+            } else if (s->gptm_cfg == 0x1) {
                 /* 32 bit mode rtc */
                 interval_value = build_interval_value(s);
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/32 RTC is running\n");
-            }
-            else if (s->gptm_cfg == 0x0) {
+            } else if (s->gptm_cfg == 0x0) {
                 /* 32 bit mode rtc */
                 interval_value = build_interval_value(s);
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/32 is running\n");
             }
-        }
-        else if (timer_width == TIMER_WIDTH_64) {
+        } else if (timer_width == TIMER_WIDTH_64) {
             /* What is the mode of the timer? 32/64 */
             if (s->gptm_cfg == 0) {
                 /* 64 bit mode */
                 interval_value = build_interval_value(s);
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/64 is running\n");
-            }
-            else if (s->gptm_cfg == 0x1) {
+            } else if (s->gptm_cfg == 0x1) {
                 /* 64 bit mode */
                 interval_value = build_interval_value(s);
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/64 RTC is running\n");
-            }
-            else if (s->gptm_cfg == 0x4) {
+            } else if (s->gptm_cfg == 0x4) {
                 interval_value = s->gptm_talir;
                 timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
-                LOG("Timer A/32 RTC is running\n");
             }
         }
-    }
-    else if (s->gptm_ctl & GPTM_TBCTL_EN) {
+    } else if (s->gptm_ctl & GPTM_TBCTL_EN) {
         timer_width = get_timer_width(s);
         if (timer_width == TIMER_WIDTH_32) {
             /* What is the mode of the timer? 16/32 */
@@ -147,39 +124,33 @@ static void set_timers(void *opaque)
                 interval_value = extract32(s->gptm_tblir, 0, 16);
                 /* Start the timer? */
                 timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer B/16 is running\n");
-            }
-            else if (s->gptm_cfg == 0x01) {
+            } else if (s->gptm_cfg == 0x01) {
                 /* 32 bit mode rtc */
                 interval_value = build_interval_value(s);
-                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer B/32 RTC is running\n");
-            }
-            else if (s->gptm_cfg == 0x00) {
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x00) {
                 /* 32 bit mode rtc */
                 interval_value = build_interval_value(s);
-                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer B/32 RTC is running\n");
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
             }
-        }
-        else if (timer_width == TIMER_WIDTH_64) {
+        } else if (timer_width == TIMER_WIDTH_64) {
             /* What is the mode of the timer? 32/64 */
             if (s->gptm_cfg == 0) {
                 /* 64 bit mode */
                 interval_value = build_interval_value(s);
-                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer A/64 is running\n");
-            }
-            else if (s->gptm_cfg == 0x1) {
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x1) {
                 /* 64 bit mode */
                 interval_value = build_interval_value(s);
-                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer A/64 RTC is running\n");
-            }
-            else if (s->gptm_cfg == 0x4) {
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x4) {
                 interval_value = s->gptm_tblir;
-                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
-                LOG("Timer A/32 RTC is running\n");
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
             }
         }
     }
@@ -187,48 +158,48 @@ static void set_timers(void *opaque)
 
 static bool gptm_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
 {
-    switch(addr) {
+    switch (addr) {
         case TIMER0_32:
-            return test_bit(0, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(0, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER1_32:
-            return test_bit(1, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(1, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER2_32:
-            return test_bit(2, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(2, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER3_32:
-            return test_bit(3, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(3, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER4_32:
-            return test_bit(4, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(4, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER5_32:
-            return test_bit(5, (const unsigned long*)&s->sysctl_rcgctimer);
+            return test_bit(5, (const unsigned long *)&s->sysctl_rcgctimer);
             break;
         case TIMER0_64:
-            return test_bit(0, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(0, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
         case TIMER1_64:
-            return test_bit(1, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(1, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
         case TIMER2_64:
-            return test_bit(2, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(2, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
         case TIMER3_64:
-            return test_bit(3, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(3, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
         case TIMER4_64:
-            return test_bit(4, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(4, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
         case TIMER5_64:
-            return test_bit(5, (const unsigned long*)&s->sysctl_rcgcwtimer);
+            return test_bit(5, (const unsigned long *)&s->sysctl_rcgcwtimer);
             break;
     }
     return false;
 }
 
-static void tm4c123_gptm_reset(DeviceState* dev)
+static void tm4c123_gptm_reset(DeviceState *dev)
 {
     TM4C123GPTMState *s = TM4C123_GPTM(dev);
 
@@ -271,7 +242,7 @@ static uint64_t tm4c123_gptm_read(void *opaque, hwaddr addr, unsigned int size)
 
     trace_tm4c123_gptm_read(addr);
 
-    switch(addr) {
+    switch (addr) {
         case GPTM_CFG:
             return s->gptm_cfg;
         case GPTM_AMR:
@@ -315,8 +286,7 @@ static uint64_t tm4c123_gptm_read(void *opaque, hwaddr addr, unsigned int size)
                 return extract64(
                         ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr),
                         0, 31);
-            }
-            else {
+            } else {
                 return ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr);
             }
         case GPTM_TBV:
@@ -324,9 +294,8 @@ static uint64_t tm4c123_gptm_read(void *opaque, hwaddr addr, unsigned int size)
                 return extract64(
                         ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr),
                         32, 64);
-            }
-            else {
-                return ns_to_ticks(s, s->b->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tabr);
+            } else {
+                return ns_to_ticks(s, s->b->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr);
             }
         case GPTM_RTCPD:
             return s->gptm_rtcpd;
@@ -358,7 +327,7 @@ static void tm4c123_gptm_write(void *opaque, hwaddr addr, uint64_t val64, unsign
 
     trace_tm4c123_gptm_write(addr, val32);
 
-    switch(addr) {
+    switch (addr) {
         case GPTM_CFG:
             s->gptm_cfg = val32;
             break;
@@ -457,13 +426,11 @@ static void timer_a_callback(void *opaque)
 {
     TM4C123GPTMState *s = opaque;
 
-    log_message("timer A\n");
-
-    if (test_bit(0, (unsigned long*)&s->gptm_imr)) {
+    if (test_bit(0, (unsigned long *)&s->gptm_imr)) {
         qemu_irq_pulse(s->irq_a);
-        set_bit(0, (unsigned long*)&s->gptm_mis);
+        set_bit(0, (unsigned long *)&s->gptm_mis);
     }
-    set_bit(0, (unsigned long*)&s->gptm_ris);
+    set_bit(0, (unsigned long *)&s->gptm_ris);
     if ((s->gptm_amr & 0x0000000F) == 0x2) {
         set_timers(s);
     }
@@ -472,13 +439,12 @@ static void timer_a_callback(void *opaque)
 static void timer_b_callback(void *opaque)
 {
     TM4C123GPTMState *s = opaque;
-    log_message("timer B\n");
 
-    if (test_bit(8, (unsigned long*)&s->gptm_imr)) {
+    if (test_bit(8, (unsigned long *)&s->gptm_imr)) {
         qemu_irq_pulse(s->irq_b);
-        set_bit(8, (unsigned long*)&s->gptm_mis);
+        set_bit(8, (unsigned long *)&s->gptm_mis);
     }
-    set_bit(8, (unsigned long*)&s->gptm_ris);
+    set_bit(8, (unsigned long *)&s->gptm_ris);
     if ((s->gptm_bmr & 0x0000000F) == 0x2) {
         set_timers(s);
     }
@@ -486,7 +452,7 @@ static void timer_b_callback(void *opaque)
 
 static void tm4c123_gptm_init(Object *obj)
 {
-    TM4C123GPTMState*s = TM4C123_GPTM(obj);
+    TM4C123GPTMState *s = TM4C123_GPTM(obj);
     s->clk = qdev_init_clock_in(DEVICE(s), "gptm_clock", NULL, NULL, 0);
     s->a = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_a_callback, s);
     s->b = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_b_callback, s);
diff --git a/hw/watchdog/tm4c123_watchdog.c b/hw/watchdog/tm4c123_watchdog.c
index cd064c5343..50fd08318f 100644
--- a/hw/watchdog/tm4c123_watchdog.c
+++ b/hw/watchdog/tm4c123_watchdog.c
@@ -36,19 +36,18 @@
 #define READONLY LOG("0x%"HWADDR_PRIx" is a readonly field\n.", addr)
 #define LOG(fmt, args...) qemu_log("%s: " fmt, __func__, ## args)
 
-static bool locked = false;
+static bool locked;
 
 static void tm4c123_wdt_expired(void *opaque)
 {
     TM4C123WatchdogState *s = opaque;
     /*if this is the first timeout/the ris is not cleared */
-    if (!test_bit(0, (const unsigned long*)&s->wdt_mis)) {
-        set_bit(0, (unsigned long*)&s->wdt_mis);
+    if (!test_bit(0, (const unsigned long *)&s->wdt_mis)) {
+        set_bit(0, (unsigned long *)&s->wdt_mis);
         nmi_monitor_handle(0, NULL);
         qemu_irq_pulse(s->irq);
-    }
-    else {
-        if (test_bit(1, (const unsigned long*)&s->wdt_ctl))
+    } else {
+        if (test_bit(1, (const unsigned long *)&s->wdt_ctl))
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         else {
             nmi_monitor_handle(0, NULL);
@@ -59,12 +58,12 @@ static void tm4c123_wdt_expired(void *opaque)
 
 static bool wdt_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
 {
-    switch(addr) {
+    switch (addr) {
         case WDT_0:
-            return (s->sysctl_rcgcwd & (1 << 0));
+            return s->sysctl_rcgcwd & (1 << 0);
             break;
         case WDT_1:
-            return (s->sysctl_rcgcwd & (1 << 1));
+            return s->sysctl_rcgcwd & (1 << 1);
             break;
     }
     return false;
@@ -104,7 +103,7 @@ static uint64_t tm4c123_wdt_read(void *opaque, hwaddr addr, unsigned int size)
         hw_error("Watchdog timer module clock is not enabled");
     }
 
-    switch(addr) {
+    switch (addr) {
         case WDT_LOAD:
             return s->wdt_load;
         case WDT_VALUE:
@@ -161,7 +160,7 @@ static void tm4c123_wdt_write(void *opaque, hwaddr addr, uint64_t val64, unsigne
         hw_error("Watchdog module clock is not enabled");
     }
 
-    switch(addr) {
+    switch (addr) {
         case WDT_LOAD:
             s->wdt_load = val32;
             locked = true;
@@ -182,8 +181,8 @@ static void tm4c123_wdt_write(void *opaque, hwaddr addr, uint64_t val64, unsigne
             ptimer_transaction_begin(s->timer);
             ptimer_set_limit(s->timer, s->wdt_load, 1);
             ptimer_transaction_commit(s->timer);
-            clear_bit(0, (unsigned long*)&s->wdt_ris);
-            clear_bit(0, (unsigned long*)&s->wdt_mis);
+            clear_bit(0, (unsigned long *)&s->wdt_ris);
+            clear_bit(0, (unsigned long *)&s->wdt_mis);
             s->wdt_icr = val32;
             break;
         case WDT_RIS:
-- 
2.34.1


