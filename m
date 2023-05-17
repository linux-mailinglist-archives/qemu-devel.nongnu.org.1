Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD5706281
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCGu-0005yB-DT; Wed, 17 May 2023 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGp-0005sG-HM; Wed, 17 May 2023 04:12:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGm-0003NM-15; Wed, 17 May 2023 04:12:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f41d087b24so3116205e9.1; 
 Wed, 17 May 2023 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311142; x=1686903142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnZry/mZ+YqdIcfBo8MVTR0ygK8zmQY+tnNtARvrW+M=;
 b=TJgADLgrRx8HJNo5pLNjhGDYAxCTcR6GKOEPBVaFnScJ5vE0WFDtBGR6KxEQr4br2p
 jKukb2YLub/NDAtzSED/DbtUERBsFiRvfebNABd7RAEhpVrtAc9nAY/RYyTWZJc7f01v
 oLP+/RmNtYSGXB9Z1ftFeNKwcnBDz9hAYaUk7H6OBagy0i3Q83iBvZAdX5pK5lUxQy8O
 yBiCtNpgX3mcxmrHT1DaPW930NSbXL8lYuKvIzXD2TSo59sPcJ6ZDimi7pwt6iLGBz7Q
 Y0bD6nPmiEVnnaXh4QrDngv78Z9utTgPO0/gN1uZatKz1STMDyxfDWm+Gv2WykKZZFxc
 ZjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311142; x=1686903142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnZry/mZ+YqdIcfBo8MVTR0ygK8zmQY+tnNtARvrW+M=;
 b=KpHbZb7odgjRzzHsxPmoCdNcpeWamNkT/chIXbqaZ9Br5LcM73xd3QPekh6EN1u5ME
 0AaCeuWyCIM2ewLGEpmLmUBqOSv248hFt6WsabHXDdvKxvTKRWdNqn/qUm4zHQxg7arH
 dDQmUSII3oL2KyDJqq9mNTrr4i67p2URRV4Ec0Hniku15d8ayajgdFkx2fQhdDnJpaUu
 93orusaV6KeIbFaeFx8rEI2OIZgK9vrNTSh6eKNVAb4VSa/YZk1oi3DtLUUvla/zHxyT
 2Fj36nSMtPGcOwcL5KiFyMLiOx8r1+EytMTSPVVQhiInXycP/6iZ0Z1E+DEYxZ91nJrA
 qmNA==
X-Gm-Message-State: AC+VfDyWQvrhiDCMGkDyI4bnRM7vHbQFWG0ID8+MhvFutJZCSztuRkPM
 0xucEsk1X48FMZPpfX52KbEpgfEypQA=
X-Google-Smtp-Source: ACHHUZ4kkgyWi8+Mpg0VNiwZNeVTv9nuHtkZsoD0x0XlSSjYvuOZwAbNYfA64iW1G7nX2e59wsFAow==
X-Received: by 2002:a05:600c:2116:b0:3f4:294d:8524 with SMTP id
 u22-20020a05600c211600b003f4294d8524mr20909254wml.22.1684311141744; 
 Wed, 17 May 2023 01:12:21 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:21 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 6/8] tiva c general purpose timers implementation
Date: Wed, 17 May 2023 11:12:02 +0300
Message-Id: <20230517081204.30333-7-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517081204.30333-1-m.elsayed4420@gmail.com>
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x330.google.com
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
 hw/timer/tm4c123_gptm.c         | 495 ++++++++++++++++++++++++++++++++
 hw/timer/trace-events           |   5 +
 include/hw/timer/tm4c123_gptm.h | 131 +++++++++
 3 files changed, 631 insertions(+)
 create mode 100644 hw/timer/tm4c123_gptm.c
 create mode 100644 include/hw/timer/tm4c123_gptm.h

diff --git a/hw/timer/tm4c123_gptm.c b/hw/timer/tm4c123_gptm.c
new file mode 100644
index 0000000000..bdbaff776c
--- /dev/null
+++ b/hw/timer/tm4c123_gptm.c
@@ -0,0 +1,495 @@
+/*
+ * TM4C123 General purpose timers
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
+#include "hw/timer/tm4c123_gptm.h"
+#include "hw/irq.h"
+#include "trace.h"
+#include "qemu/timer.h"
+#include <time.h>
+
+#define LOG(mask, fmt, args...) qemu_log_mask(mask, "%s: " fmt, __func__, ## args)
+#define READONLY LOG(LOG_GUEST_ERROR, "0x%"HWADDR_PRIx" is a readonly field\n.", addr)
+
+static uint64_t ns_to_ticks(void *opaque, uint64_t ns, uint32_t prescaler)
+{
+    TM4C123GPTMState *s = opaque;
+
+    uint32_t freq = clock_get_hz(s->clk) / prescaler;
+    float sec = (float)ns / (float)NANOSECONDS_PER_SECOND;
+    return sec * freq;
+}
+
+static unsigned long ticks_to_time_ns(void *opaque, uint64_t ticks, uint32_t prescaler)
+{
+    TM4C123GPTMState *s = opaque;
+    uint32_t freq = clock_get_hz(s->clk) / prescaler;
+    return ((float)ticks / (float)freq) * NANOSECONDS_PER_SECOND;
+}
+
+static uint16_t get_timer_width(void *opaque)
+{
+    TM4C123GPTMState *s = opaque;
+    switch (s->mmio.addr) {
+        case TIMER0_32...TIMER5_32:
+            return TIMER_WIDTH_32;
+        case TIMER0_64...TIMER5_64:
+            return TIMER_WIDTH_64;
+    }
+    return 0;
+}
+
+static uint64_t build_interval_value(void *opaque)
+{
+    TM4C123GPTMState *s = opaque;
+    uint16_t timer_width = get_timer_width(s);
+    uint64_t interval_value = 0;
+    if (timer_width == TIMER_WIDTH_32) {
+        /* timer is in 32 bit mode or 32bit rtc*/
+        uint16_t upper16 = extract32(s->gptm_talir, 16, 16);
+        uint16_t lower16 = extract32(s->gptm_tblir, 0, 16);
+        interval_value = ((uint32_t)lower16 << 16) + upper16;
+    } else if (timer_width == TIMER_WIDTH_64) {
+        interval_value = ((uint64_t)s->gptm_talir << 32) + s->gptm_tblir;
+    }
+
+    trace_tm4c123_gptm_build_interval_value(s->gptm_talir, s->gptm_tblir, interval_value);
+    return interval_value;
+}
+
+static void set_timers(void *opaque)
+{
+    TM4C123GPTMState *s = opaque;
+    uint64_t interval_value;
+    uint16_t timer_width;
+    if (s->gptm_ctl & GPTM_TACTL_EN) {
+        timer_width = get_timer_width(s);
+        if (timer_width == TIMER_WIDTH_32) {
+            /* What is the mode of the timer? 16/32 */
+            if (s->gptm_cfg == 0x4) {
+                /* 16 bit mode */
+                interval_value = extract32(s->gptm_talir, 0, 16);
+                /* Start the timer? */
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            } else if (s->gptm_cfg == 0x1) {
+                /* 32 bit mode rtc */
+                interval_value = build_interval_value(s);
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            } else if (s->gptm_cfg == 0x0) {
+                /* 32 bit mode rtc */
+                interval_value = build_interval_value(s);
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            }
+        } else if (timer_width == TIMER_WIDTH_64) {
+            /* What is the mode of the timer? 32/64 */
+            if (s->gptm_cfg == 0) {
+                /* 64 bit mode */
+                interval_value = build_interval_value(s);
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            } else if (s->gptm_cfg == 0x1) {
+                /* 64 bit mode */
+                interval_value = build_interval_value(s);
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            } else if (s->gptm_cfg == 0x4) {
+                interval_value = s->gptm_talir;
+                timer_mod(s->a, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tapr));
+            }
+        }
+    } else if (s->gptm_ctl & GPTM_TBCTL_EN) {
+        timer_width = get_timer_width(s);
+        if (timer_width == TIMER_WIDTH_32) {
+            /* What is the mode of the timer? 16/32 */
+            if (s->gptm_cfg == 0x4) {
+                /* 16 bit mode */
+                interval_value = extract32(s->gptm_tblir, 0, 16);
+                /* Start the timer? */
+                timer_mod(s->b, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x01) {
+                /* 32 bit mode rtc */
+                interval_value = build_interval_value(s);
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x00) {
+                /* 32 bit mode rtc */
+                interval_value = build_interval_value(s);
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            }
+        } else if (timer_width == TIMER_WIDTH_64) {
+            /* What is the mode of the timer? 32/64 */
+            if (s->gptm_cfg == 0) {
+                /* 64 bit mode */
+                interval_value = build_interval_value(s);
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x1) {
+                /* 64 bit mode */
+                interval_value = build_interval_value(s);
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            } else if (s->gptm_cfg == 0x4) {
+                interval_value = s->gptm_tblir;
+                timer_mod(s->b,
+                        qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ticks_to_time_ns(s, interval_value, s->gptm_tbpr));
+            }
+        }
+    }
+}
+
+static bool gptm_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
+{
+    switch (addr) {
+        case TIMER0_32:
+            return test_bit(0, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER1_32:
+            return test_bit(1, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER2_32:
+            return test_bit(2, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER3_32:
+            return test_bit(3, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER4_32:
+            return test_bit(4, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER5_32:
+            return test_bit(5, (const unsigned long *)&s->sysctl_rcgctimer);
+            break;
+        case TIMER0_64:
+            return test_bit(0, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+        case TIMER1_64:
+            return test_bit(1, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+        case TIMER2_64:
+            return test_bit(2, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+        case TIMER3_64:
+            return test_bit(3, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+        case TIMER4_64:
+            return test_bit(4, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+        case TIMER5_64:
+            return test_bit(5, (const unsigned long *)&s->sysctl_rcgcwtimer);
+            break;
+    }
+    return false;
+}
+
+static void tm4c123_gptm_reset(DeviceState *dev)
+{
+    TM4C123GPTMState *s = TM4C123_GPTM(dev);
+
+    s->gptm_cfg = 0x00000000;
+    s->gptm_amr = 0x00000000;
+    s->gptm_bmr = 0x00000000;
+    s->gptm_ctl = 0x00000000;
+    s->gptm_sync = 0x00000000;
+    s->gptm_imr = 0x00000000;
+    s->gptm_ris = 0x00000000;
+    s->gptm_mis = 0x00000000;
+    s->gptm_icr = 0x00000000;
+    s->gptm_talir = 0xFFFFFFFF;
+    s->gptm_tblir = 0x00000000;
+    s->gptm_tamatchr = 0xFFFFFFFF;
+    s->gptm_tbmatchr = 0x00000000;
+    s->gptm_tapr = 0x00000000;
+    s->gptm_tbpr = 0x00000000;
+    s->gptm_tapmr = 0x00000000;
+    s->gptm_tbpmr = 0x00000000;
+    s->gptm_tar = 0xFFFFFFFF;
+    s->gptm_tbr = 0x00000000;
+    s->gptm_tav = 0xFFFFFFFF;
+    s->gptm_tbv = 0x00000000;
+    s->gptm_rtcpd = 0x00007FFF;
+    s->gptm_taps = 0x00000000;
+    s->gptm_tbps = 0x00000000;
+    s->gptm_tapv = 0x00000000;
+    s->gptm_tbpv = 0x00000000;
+    s->gptm_pp = 0x00000000;
+}
+
+static uint64_t tm4c123_gptm_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    TM4C123GPTMState *s = opaque;
+
+    if (!gptm_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("GPTM module clock is not enabled");
+    }
+
+    trace_tm4c123_gptm_read(addr);
+
+    switch (addr) {
+        case GPTM_CFG:
+            return s->gptm_cfg;
+        case GPTM_AMR:
+            return s->gptm_amr;
+        case GPTM_BMR:
+            return s->gptm_bmr;
+        case GPTM_CTL:
+            return s->gptm_ctl;
+        case GPTM_SYNC:
+            return s->gptm_sync;
+        case GPTM_IMR:
+            return s->gptm_imr;
+        case GPTM_RIS:
+            return s->gptm_ris;
+        case GPTM_MIS:
+            return s->gptm_mis;
+        case GPTM_ICR:
+            return s->gptm_icr;
+        case GPTM_TALIR:
+            return s->gptm_talir;
+        case GPTM_TBLIR:
+            return s->gptm_tblir;
+        case GPTM_TAMATCHR:
+            return s->gptm_tamatchr;
+        case GPTM_TBMATCHR:
+            return s->gptm_tbmatchr;
+        case GPTM_TAPR:
+            return s->gptm_tapr;
+        case GPTM_TBPR:
+            return s->gptm_tbpr;
+        case GPTM_TAPMR:
+            return s->gptm_tapmr;
+        case GPTM_TBPMR:
+            return s->gptm_tbpmr;
+        case GPTM_TAR:
+            return s->gptm_tar;
+        case GPTM_TBR:
+            return s->gptm_tbr;
+        case GPTM_TAV:
+            if (get_timer_width(s) == TIMER_WIDTH_64 && s->gptm_cfg == 0) {
+                return extract64(
+                        ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr),
+                        0, 31);
+            } else {
+                return ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr);
+            }
+        case GPTM_TBV:
+            if (get_timer_width(s) == TIMER_WIDTH_64 && s->gptm_cfg == 0) {
+                return extract64(
+                        ns_to_ticks(s, s->a->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr),
+                        32, 64);
+            } else {
+                return ns_to_ticks(s, s->b->expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), s->gptm_tapr);
+            }
+        case GPTM_RTCPD:
+            return s->gptm_rtcpd;
+        case GPTM_TAPS:
+            return s->gptm_taps;
+        case GPTM_TBPS:
+            return s->gptm_tbps;
+        case GPTM_TAPV:
+            return s->gptm_tapv;
+        case GPTM_TBPV:
+            return s->gptm_tbpv;
+        case GPTM_PP:
+            return s->gptm_pp;
+        default:
+            LOG(LOG_GUEST_ERROR, "Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+
+    return 0;
+}
+
+static void tm4c123_gptm_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
+{
+    TM4C123GPTMState *s = opaque;
+    uint32_t val32 = val64;
+
+    if (!gptm_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("GPTM module clock is not enabled");
+    }
+
+    trace_tm4c123_gptm_write(addr, val32);
+
+    switch (addr) {
+        case GPTM_CFG:
+            s->gptm_cfg = val32;
+            break;
+        case GPTM_AMR:
+            s->gptm_amr = val32;
+            break;
+        case GPTM_BMR:
+            s->gptm_bmr = val32;
+            break;
+        case GPTM_CTL:
+            s->gptm_ctl = val32;
+            set_timers(s);
+            break;
+        case GPTM_SYNC:
+            s->gptm_sync = val32;
+            break;
+        case GPTM_IMR:
+            s->gptm_imr = val32;
+            break;
+        case GPTM_RIS:
+            READONLY;
+            break;
+        case GPTM_MIS:
+            s->gptm_mis = val32;
+            break;
+        case GPTM_ICR:
+            s->gptm_ris &= ~val32;
+            s->gptm_mis &= ~val32;
+            break;
+        case GPTM_TALIR:
+            s->gptm_talir = val32;
+            break;
+        case GPTM_TBLIR:
+            s->gptm_tblir = val32;
+            break;
+        case GPTM_TAMATCHR:
+            s->gptm_tamatchr = val32;
+            break;
+        case GPTM_TBMATCHR:
+            s->gptm_tbmatchr = val32;
+            break;
+        case GPTM_TAPR:
+            s->gptm_tapr = val32;
+            break;
+        case GPTM_TBPR:
+            s->gptm_tbpr = val32;
+            break;
+        case GPTM_TAPMR:
+            s->gptm_tapmr = val32;
+            break;
+        case GPTM_TBPMR:
+            s->gptm_tbpmr = val32;
+            break;
+        case GPTM_TAR:
+            READONLY;
+            break;
+        case GPTM_TBR:
+            READONLY;
+            break;
+        case GPTM_TAV:
+            s->gptm_tav = val32;
+            break;
+        case GPTM_TBV:
+            s->gptm_tbv = val32;
+            break;
+        case GPTM_RTCPD:
+            READONLY;
+            break;
+        case GPTM_TAPS:
+            READONLY;
+            break;
+        case GPTM_TBPS:
+            READONLY;
+            break;
+        case GPTM_TAPV:
+            READONLY;
+            break;
+        case GPTM_TBPV:
+            READONLY;
+            break;
+        case GPTM_PP:
+            READONLY;
+            break;
+        default:
+            LOG(LOG_GUEST_ERROR, "Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+}
+
+static const MemoryRegionOps tm4c123_gptm_ops = {
+    .read = tm4c123_gptm_read,
+    .write = tm4c123_gptm_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void timer_a_callback(void *opaque)
+{
+    TM4C123GPTMState *s = opaque;
+
+    if (test_bit(0, (unsigned long *)&s->gptm_imr)) {
+        qemu_irq_pulse(s->irq_a);
+        set_bit(0, (unsigned long *)&s->gptm_mis);
+    }
+    set_bit(0, (unsigned long *)&s->gptm_ris);
+    if ((s->gptm_amr & 0x0000000F) == 0x2) {
+        set_timers(s);
+    }
+}
+
+static void timer_b_callback(void *opaque)
+{
+    TM4C123GPTMState *s = opaque;
+
+    if (test_bit(8, (unsigned long *)&s->gptm_imr)) {
+        qemu_irq_pulse(s->irq_b);
+        set_bit(8, (unsigned long *)&s->gptm_mis);
+    }
+    set_bit(8, (unsigned long *)&s->gptm_ris);
+    if ((s->gptm_bmr & 0x0000000F) == 0x2) {
+        set_timers(s);
+    }
+}
+
+static void tm4c123_gptm_init(Object *obj)
+{
+    TM4C123GPTMState *s = TM4C123_GPTM(obj);
+    s->clk = qdev_init_clock_in(DEVICE(s), "gptm_clock", NULL, NULL, 0);
+    s->a = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_a_callback, s);
+    s->b = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_b_callback, s);
+    timer_init_ns(s->a, QEMU_CLOCK_VIRTUAL, timer_a_callback, s);
+    timer_init_ns(s->b, QEMU_CLOCK_VIRTUAL, timer_b_callback, s);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_a);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_b);
+    memory_region_init_io(&s->mmio, obj, &tm4c123_gptm_ops, s, TYPE_TM4C123_GPTM, 0xFFF);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void tm4c123_gptm_realize(DeviceState *dev, Error **errp)
+{
+    TM4C123GPTMState *s = TM4C123_GPTM(dev);
+    qdev_connect_clock_in(dev, "gptm_clock", qdev_get_clock_out(DEVICE(s->sysctl), "outclk"));
+
+}
+
+static void tm4c123_gptm_class_init(ObjectClass *kclass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(kclass);
+    dc->reset = tm4c123_gptm_reset;
+    dc->realize = tm4c123_gptm_realize;
+}
+
+static const TypeInfo tm4c123_gptm_info = {
+    .name = TYPE_TM4C123_GPTM,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TM4C123GPTMState),
+    .instance_init = tm4c123_gptm_init,
+    .class_init = tm4c123_gptm_class_init,
+};
+
+static void tm4c123_gptm_register_types(void)
+{
+    type_register_static(&tm4c123_gptm_info);
+}
+
+type_init(tm4c123_gptm_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 3eccef8385..e40b445630 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_gptm.c
+tm4c123_gptm_read(uint32_t offset) "offset: 0x%"PRIx32
+tm4c123_gptm_write(uint32_t offset, uint32_t value) "offset: 0x%"PRIx32" - value: 0x%"PRIx32
+tm4c123_gptm_build_interval_value(uint32_t talir, uint32_t tblir, uint64_t result) "TALIR: 0x%"PRIx32" - TBLIR: 0x%"PRIx32" - value: 0x%"PRIx64
+
 # slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
diff --git a/include/hw/timer/tm4c123_gptm.h b/include/hw/timer/tm4c123_gptm.h
new file mode 100644
index 0000000000..e86049f5c1
--- /dev/null
+++ b/include/hw/timer/tm4c123_gptm.h
@@ -0,0 +1,131 @@
+/*
+ * TM4C123 General purpose timers
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
+#ifndef HW_ARM_TM4C123_GPTM_H
+#define HW_ARM_TM4C123_GPTM_H
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/tm4c123_sysctl.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "qom/object.h"
+
+#define TIMER_WIDTH_32 0x32B
+#define TIMER_WIDTH_64 0x64B
+
+#define TIMER0_32 0x40030000
+#define TIMER1_32 0x40031000
+#define TIMER2_32 0x40032000
+#define TIMER3_32 0x40033000
+#define TIMER4_32 0x40034000
+#define TIMER5_32 0x40035000
+
+#define TIMER0_64 0x40036000
+#define TIMER1_64 0x40037000
+#define TIMER2_64 0x4003C000
+#define TIMER3_64 0x4003D000
+#define TIMER4_64 0x4003E000
+#define TIMER5_64 0x4003F000
+
+#define GPTM_CFG 0x000
+#define GPTM_AMR 0x004
+#define GPTM_BMR 0x008
+#define GPTM_CTL 0x00C
+#define GPTM_SYNC 0x010
+#define GPTM_IMR 0x018
+#define GPTM_RIS 0x01C
+#define GPTM_MIS 0x020
+#define GPTM_ICR 0x024
+#define GPTM_TALIR 0x028
+#define GPTM_TBLIR 0x02C
+#define GPTM_TAMATCHR 0x030
+#define GPTM_TBMATCHR 0x034
+#define GPTM_TAPR 0x038
+#define GPTM_TBPR 0x03C
+#define GPTM_TAPMR 0x040
+#define GPTM_TBPMR 0x044
+#define GPTM_TAR 0x048
+#define GPTM_TBR 0x04C
+#define GPTM_TAV 0x050
+#define GPTM_TBV 0x054
+#define GPTM_RTCPD 0x058
+#define GPTM_TAPS 0x05C
+#define GPTM_TBPS 0x060
+#define GPTM_TAPV 0x064
+#define GPTM_TBPV 0x068
+#define GPTM_PP 0xFC0
+
+#define GPTM_TACTL_EN (1 << 0)
+#define GPTM_TBCTL_EN (1 << 8)
+#define GPTM_TAM_CD   (1 << 4)
+#define GPTM_TAM_MODE_ONESHOT (1 << 1)
+#define GPTM_TAM_PERIODIC (1 << 2)
+
+#define TYPE_TM4C123_GPTM "tm4c123-gptm"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TM4C123GPTMState, TM4C123_GPTM)
+
+struct TM4C123GPTMState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    qemu_irq irq_a;
+    qemu_irq irq_b;
+    TM4C123SysCtlState *sysctl;
+
+    uint32_t gptm_cfg;
+    uint32_t gptm_amr;
+    uint32_t gptm_bmr;
+    uint32_t gptm_ctl;
+    uint32_t gptm_sync;
+    uint32_t gptm_imr;
+    uint32_t gptm_ris;
+    uint32_t gptm_mis;
+    uint32_t gptm_icr;
+    uint32_t gptm_talir;
+    uint32_t gptm_tblir;
+    uint32_t gptm_tamatchr;
+    uint32_t gptm_tbmatchr;
+    uint32_t gptm_tapr;
+    uint32_t gptm_tbpr;
+    uint32_t gptm_tapmr;
+    uint32_t gptm_tbpmr;
+    uint32_t gptm_tar;
+    uint32_t gptm_tbr;
+    uint32_t gptm_tav;
+    uint32_t gptm_tbv;
+    uint32_t gptm_rtcpd;
+    uint32_t gptm_taps;
+    uint32_t gptm_tbps;
+    uint32_t gptm_tapv;
+    uint32_t gptm_tbpv;
+    uint32_t gptm_pp;
+    QEMUTimer *a;
+    QEMUTimer *b;
+    Clock* clk;
+};
+
+#endif
-- 
2.34.1


