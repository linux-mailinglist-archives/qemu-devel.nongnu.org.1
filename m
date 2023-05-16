Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F195704676
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp98-0004lD-BB; Tue, 16 May 2023 03:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8q-0004cY-3r; Tue, 16 May 2023 03:30:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8m-00008e-Az; Tue, 16 May 2023 03:30:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f4249b7badso96980135e9.3; 
 Tue, 16 May 2023 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684222230; x=1686814230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJ/BcrG/i5BOyNW/oxCq/Vp7ParvGO09swSrfI/gX/Y=;
 b=iQpeJZmC4j2Xr5MVJ0P+M1RiHjkAplwP4ms2CFPnP0JUSwEqQdjaiLQ34hjiRqTUpV
 wJmvG6Xya7jHSefcZ3BDkH+8wydYcDMeW5Jd6UOOo9M9PEiXvQhVfCyV0bsj6rf3wgHO
 JDT/dm+8fQdBv7Abrvn+4C+8LgPpNKfpcNgjCfhDiMcTZ5ix6j5GKqDBP6er/p/UaJFw
 mo+yN/cGMBBqmEy7KK5Jy5mtoY5HQQw05gmqv8eU+Ko2jHLiftjT3Cp09w73jlHQjPjo
 +5Lj0wISMiWHKaIXcaZMrziWdt2ru3vWfKiDYmCMeSQvVK+SBV9DHZOJLRLGH9VidOth
 SEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222230; x=1686814230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJ/BcrG/i5BOyNW/oxCq/Vp7ParvGO09swSrfI/gX/Y=;
 b=dJcqYbqmL2gArW7h9RTbWTteQo3wl6o5AD7ySAYUEKKA1H+CNIrAQGg+ljtcmXRrPU
 zJblVSfY0g6g2G/ztjSrUN/AkQhSHmBFliZpBYWskKIPe6otIARnkIwkmg/eil+LH5Dg
 NNtmoMhmIGuk0rpizNpXWhyJq8Nze4pDaQWQVNxhImLRiCQUa0Hp9xdhJOxywutEgqbg
 klJJhjD5YBPW7BEnn2QV2LImjZiglHOF9STBDZaN48avrG59Ueq2LUAqhW8k1FBsmxmG
 h/P0+5tSofpRGpVM6GnGa01Ncv+sX2/jlIXcYkt8vvAkLEquGvda4arEeb0DHByNvMIG
 q1mA==
X-Gm-Message-State: AC+VfDxkRHvf4ULV6KtBZDLJFKs5RZYjA+TXuVztndpACnT7z+4Utqcn
 vDgfbtCYffBZk877mqHCyNhvZx0iHuPKRA==
X-Google-Smtp-Source: ACHHUZ5B+55oa90FOqybYWR3Fn+NjgJW8tUn5nQRLTZwuFPsqPISd1f2ZqQAQQbJEVcWMS+wdG4pOw==
X-Received: by 2002:a5d:4f8c:0:b0:2f8:f3da:72cf with SMTP id
 d12-20020a5d4f8c000000b002f8f3da72cfmr26904225wru.18.1684222229697; 
 Tue, 16 May 2023 00:30:29 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 y12-20020a5d614c000000b003062c609115sm1559997wrt.21.2023.05.16.00.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:30:29 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PULL 4/8] tivac system control implementation
Date: Tue, 16 May 2023 10:29:55 +0300
Message-Id: <20230516072959.49994-5-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516072959.49994-1-m.elsayed4420@gmail.com>
References: <20230516072959.49994-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x32a.google.com
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
 hw/misc/tm4c123_sysctl.c         | 989 +++++++++++++++++++++++++++++++
 include/hw/misc/tm4c123_sysctl.h | 307 ++++++++++
 2 files changed, 1296 insertions(+)
 create mode 100644 hw/misc/tm4c123_sysctl.c
 create mode 100644 include/hw/misc/tm4c123_sysctl.h

diff --git a/hw/misc/tm4c123_sysctl.c b/hw/misc/tm4c123_sysctl.c
new file mode 100644
index 0000000000..9bce30eb73
--- /dev/null
+++ b/hw/misc/tm4c123_sysctl.c
@@ -0,0 +1,989 @@
+/*
+ * TM4C123 SYSCTL
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
+#include "hw/misc/tm4c123_sysctl.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+#define LOG(fmt, args...) qemu_log("%s: " fmt, __func__, ## args)
+#define READONLY LOG("0x%"HWADDR_PRIx" is a readonly field\n.", addr)
+
+static void tm4c123_sysctl_update_system_clock(void *opaque)
+{
+    TM4C123SysCtlState *s = opaque;
+
+    uint32_t RCC_Val = s->sysctl_rcc;
+    uint32_t RCC2_Val = s->sysctl_rcc2;
+
+    uint32_t __CORE_CLK_PRE;
+    uint32_t __CORE_CLK;
+
+    if (RCC2_Val & (1UL << 31)) {  /* is rcc2 used? */
+        if (RCC2_Val & (1UL << 11)) {  /* check BYPASS */
+            if (((RCC2_Val >> 4) & 0x07) == 0x0) {
+                if (((RCC_Val >> 6) & 0x1F) == 0x0) {
+                    __CORE_CLK_PRE = 1000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x1) {
+                    __CORE_CLK_PRE = 1843200UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x2) {
+                    __CORE_CLK_PRE = 2000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x3) {
+                    __CORE_CLK_PRE = 2457600UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x4) {
+                    __CORE_CLK_PRE = 3579545UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x5) {
+                    __CORE_CLK_PRE = 3686400UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x6) {
+                    __CORE_CLK_PRE = 4000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x7) {
+                    __CORE_CLK_PRE = 4096000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x8) {
+                    __CORE_CLK_PRE = 4915200UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x9) {
+                    __CORE_CLK_PRE = 5000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xA) {
+                    __CORE_CLK_PRE = 5120000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xB) {
+                    __CORE_CLK_PRE = 6000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xC) {
+                    __CORE_CLK_PRE = 6144000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xD) {
+                    __CORE_CLK_PRE = 7372800UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xE) {
+                    __CORE_CLK_PRE = 8000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0xF) {
+                    __CORE_CLK_PRE = 8192000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x10) {
+                    __CORE_CLK_PRE = 10000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x11) {
+                    __CORE_CLK_PRE = 12000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x12) {
+                    __CORE_CLK_PRE = 12288000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x13) {
+                    __CORE_CLK_PRE = 13560000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x14) {
+                    __CORE_CLK_PRE = 14318180UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x15) {
+                    __CORE_CLK_PRE = 16000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x16) {
+                    __CORE_CLK_PRE = 16384000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x17) {
+                    __CORE_CLK_PRE = 18000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x18) {
+                    __CORE_CLK_PRE = 20000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x19) {
+                    __CORE_CLK_PRE = 24000000UL;
+                } else if (((RCC_Val >> 6) & 0x1F) == 0x1A) {
+                    __CORE_CLK_PRE = 25000000UL;
+                } else {
+                    __CORE_CLK_PRE = 0UL;
+                }
+                __CORE_CLK = __CORE_CLK_PRE / 2UL;  /* divide by 2 since BYPASS is set */
+            } else {  /* PLL is used */
+                uint32_t __PLL_MULT = ((RCC2_Val >> 4) & 0x1F) + 2;
+                uint32_t __PLL_DIV = ((RCC2_Val >> 0) & 0x3F) + 1;
+                uint32_t __PLL_SOURCE = ((RCC2_Val >> 13) & 0x01);
+                if (__PLL_SOURCE == 0) {  /* source is XTAL */
+                    __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
+                } else {  /* source is internal oscillator */
+                    __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
+                }
+                __CORE_CLK = __CORE_CLK_PRE / 2UL;  /* divide by 2 since BYPASS is set */
+            }
+        } else {  /* BYPASS is not set */
+            uint32_t __SYS_DIV = ((RCC2_Val >> 22) & 0x7F) + 1;
+            uint32_t __PLL_MULT = ((RCC2_Val >> 4) & 0x1F) + 2;
+            uint32_t __PLL_DIV = ((RCC2_Val >> 0) & 0x3F) + 1;
+            uint32_t __PLL_SOURCE = ((RCC2_Val >> 13) & 0x01);
+            if (__PLL_SOURCE == 0) {  /* source is XTAL */
+                __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
+            } else {  /* source is internal oscillator */
+                __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
+            }
+            __CORE_CLK = __CORE_CLK_PRE / __SYS_DIV;
+        }
+    } else {  /* rcc2 is not used */
+        if (((RCC_Val >> 16) & 0x01) == 0x01) {  /* check USESYSCLK */
+            if (((RCC_Val >> 23) & 0x01) == 0x01) {  /* check BYPASS */
+                __CORE_CLK_PRE = XTALI;
+            } else {  /* PLL is used */
+                uint32_t __PLL_MULT = ((RCC_Val >> 18) & 0x1F) + 2;
+                uint32_t __PLL_DIV = ((RCC_Val >> 12) & 0x3F) + 1;
+                uint32_t __PLL_SOURCE = ((RCC_Val >> 16) & 0x01);
+                if (__PLL_SOURCE == 0) {  /* source is XTAL */
+                    __CORE_CLK_PRE = (XTALI * __PLL_MULT) / __PLL_DIV;
+                } else {  /* source is internal oscillator */
+                    __CORE_CLK_PRE = (16000000UL * __PLL_MULT) / __PLL_DIV;  /* internal oscillator frequency is 16MHz */
+                }
+            }
+        } else {  /* USESYSCLK bit is not set */
+            __CORE_CLK_PRE = 16000000UL;  /* default to internal oscillator frequency */
+        }
+        __CORE_CLK = __CORE_CLK_PRE / 1UL;  /* no division needed since BYPASS is not set */
+    }
+    trace_tm4c123_sysctl_update_system_clock(__CORE_CLK);
+    clock_update_hz(s->mainclk, __CORE_CLK);
+}
+
+static void tm4c123_sysctl_reset(DeviceState *dev)
+{
+    TM4C123SysCtlState *s = TM4C123_SYSCTL(dev);
+
+    s->sysctl_did0 = 0x00000000;
+    s->sysctl_did1 = 0x10A1606E;
+    s->sysctl_pborctl = 0x00000000;
+    s->sysctl_ris = 0x00000000;
+    s->sysctl_imc = 0x00000000;
+    s->sysctl_misc = 0x00000000;
+    s->sysctl_resc = 0x00000000;
+    s->sysctl_rcc = 0x078E3AD1;
+    s->sysctl_gpiohbctl = 0x00007E00;
+    s->sysctl_rcc2 = 0x07C06810;
+    s->sysctl_moscctl = 0x00000000;
+    s->sysctl_dslpclkcfg = 0x07800000;
+    s->sysctl_sysprop = 0x00001D31;
+    s->sysctl_piosccal = 0x00000000;
+    s->sysctl_pioscstat = 0x00000040;
+    s->sysctl_pllfreq0 = 0x00000032;
+    s->sysctl_pllfreq1 = 0x00000001;
+    s->sysctl_pllstat = 0x00000000;
+    s->sysctl_slppwrcfg = 0x00000000;
+    s->sysctl_dslppwrcfg = 0x00000000;
+    s->sysctl_ldospctl = 0x00000018;
+    s->sysctl_ldospcal = 0x00001818;
+    s->sysctl_ldodpctl = 0x00000012;
+    s->sysctl_ldodpcal = 0x00001212;
+    s->sysctl_sdpmst = 0x00000000;
+    s->sysctl_ppwd = 0x00000003;
+    s->sysctl_pptimer = 0x0000003F;
+    s->sysctl_ppgpio = 0x0000003F;
+    s->sysctl_ppdma = 0x00000001;
+    s->sysctl_pphib = 0x00000001;
+    s->sysctl_ppuart = 0x000000FF;
+    s->sysctl_ppsi = 0x0000000F;
+    s->sysctl_ppi2c = 0x0000000F;
+    s->sysctl_ppusb = 0x00000001;
+    s->sysctl_ppcan = 0x00000003;
+    s->sysctl_ppadc = 0x00000003;
+    s->sysctl_ppacmp = 0x00000001;
+    s->sysctl_pppwm = 0x00000003;
+    s->sysctl_ppqei = 0x00000003;
+    s->sysctl_ppeeprom = 0x00000001;
+    s->sysctl_ppwtimer = 0x0000003F;
+    s->sysctl_srwd = 0x00000000;
+    s->sysctl_srtimer = 0x00000000;
+    s->sysctl_srgpio = 0x00000000;
+    s->sysctl_srdma = 0x00000000;
+    s->sysctl_srhib = 0x00000000;
+    s->sysctl_sruart = 0x00000000;
+    s->sysctl_srssi = 0x00000000;
+    s->sysctl_sri2c = 0x00000000;
+    s->sysctl_srusb = 0x00000000;
+    s->sysctl_srcan = 0x00000000;
+    s->sysctl_sradc = 0x00000000;
+    s->sysctl_sracmp = 0x00000000;
+    s->sysctl_srpwm = 0x00000000;
+    s->sysctl_srqei = 0x00000000;
+    s->sysctl_sreeprom = 0x00000000;
+    s->sysctl_srwtimer = 0x00000000;
+    s->sysctl_rcgcwd = 0x00000000;
+    s->sysctl_rcgctimer = 0x00000000;
+    s->sysctl_rcgcgpio = 0x00000000;
+    s->sysctl_rcgcdma = 0x00000000;
+    s->sysctl_rcgchib = 0x00000001;
+    s->sysctl_rcgcuart = 0x00000000;
+    s->sysctl_rcgcssi = 0x00000000;
+    s->sysctl_rcgci2c = 0x00000000;
+    s->sysctl_rcgcusb = 0x00000000;
+    s->sysctl_rcgccan = 0x00000000;
+    s->sysctl_rcgcadc = 0x00000000;
+    s->sysctl_rcgcacmp = 0x00000000;
+    s->sysctl_rcgcpwm = 0x00000000;
+    s->sysctl_rcgcqei = 0x00000000;
+    s->sysctl_rcgceeprom = 0x00000000;
+    s->sysctl_rcgcwtimer = 0x00000000;
+    s->sysctl_scgcwd = 0x00000000;
+    s->sysctl_scgctimer = 0x00000000;
+    s->sysctl_scgcgpio = 0x00000000;
+    s->sysctl_scgcdma = 0x00000000;
+    s->sysctl_scgchib = 0x00000001;
+    s->sysctl_scgcuart = 0x00000000;
+    s->sysctl_scgcssi = 0x00000000;
+    s->sysctl_scgci2c = 0x00000000;
+    s->sysctl_scgcusb = 0x00000000;
+    s->sysctl_scgccan = 0x00000000;
+    s->sysctl_scgcadc = 0x00000000;
+    s->sysctl_scgcacmp = 0x00000000;
+    s->sysctl_scgcpwm = 0x00000000;
+    s->sysctl_scgcqei = 0x00000000;
+    s->sysctl_scgceeprom = 0x00000000;
+    s->sysctl_scgcwtimer = 0x00000000;
+    s->sysctl_dcgcwd = 0x00000000;
+    s->sysctl_dcgctimer = 0x00000000;
+    s->sysctl_dcgcgpio = 0x00000000;
+    s->sysctl_dcgcdma = 0x00000000;
+    s->sysctl_dcgchib = 0x00000001;
+    s->sysctl_dcgcuart = 0x00000000;
+    s->sysctl_dcgcssi = 0x00000000;
+    s->sysctl_dcgci2c = 0x00000000;
+    s->sysctl_dcgcusb = 0x00000000;
+    s->sysctl_dcgccan = 0x00000000;
+    s->sysctl_dcgcadc = 0x00000000;
+    s->sysctl_dcgcacmp = 0x00000000;
+    s->sysctl_dcgcpwm = 0x00000000;
+    s->sysctl_dcgcqei = 0x00000000;
+    s->sysctl_dcgceeprom = 0x00000000;
+    s->sysctl_dcgcwtime = 0x00000000;
+    s->sysctl_prwd = 0x00000000;
+    s->sysctl_prtimer = 0x00000000;
+    s->sysctl_prgpio = 0x00000000;
+    s->sysctl_prdma = 0x00000000;
+    s->sysctl_prhib = 0x00000001;
+    s->sysctl_pruart = 0x00000000;
+    s->sysctl_prssi = 0x00000000;
+    s->sysctl_pri2c = 0x00000000;
+    s->sysctl_prusb = 0x00000000;
+    s->sysctl_prcan = 0x00000000;
+    s->sysctl_pradc = 0x00000000;
+    s->sysctl_pracmp = 0x00000000;
+    s->sysctl_prpwm = 0x00000000;
+    s->sysctl_prqei = 0x00000000;
+    s->sysctl_preeprom = 0x00000000;
+    s->sysctl_prwtimer = 0x00000000;
+}
+
+static void tm4c123_sysctl_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
+{
+    TM4C123SysCtlState *s = opaque;
+    uint32_t val32 = val64;
+
+    trace_tm4c123_sysctl_write(addr, val32);
+
+    switch(addr) {
+        case SYSCTL_DID0:
+            READONLY;
+            break;
+        case SYSCTL_DID1:
+            READONLY;
+            break;
+        case SYSCTL_PBORCTL:
+            s->sysctl_pborctl = val32;
+            break;
+        case SYSCTL_RIS:
+            READONLY;
+            break;
+        case SYSCTL_IMC:
+            s->sysctl_imc = val32;
+            /*
+             * setting the MISC
+             */
+            s->sysctl_misc = val32;
+            break;
+        case SYSCTL_MISC:
+            s->sysctl_misc = val32;
+            break;
+        case SYSCTL_RESC:
+            s->sysctl_resc = val32;
+            break;
+        case SYSCTL_RCC:
+            s->sysctl_rcc = val32;
+            /*
+             * Setting the SYSCTL_RIS manually for now.
+             */
+            if (s->sysctl_rcc & SYSCTL_RCC_PWRDN && !(s->sysctl_rcc2 & SYSCTL_RCC2_USERCC2)) {
+                s->sysctl_ris |= SYSCTL_RIS_PLLRIS;
+            }
+            tm4c123_sysctl_update_system_clock(s);
+            break;
+        case SYSCTL_GPIOHBCTL:
+            s->sysctl_gpiohbctl = val32;
+            break;
+        case SYSCTL_RCC2:
+            s->sysctl_rcc2 = val32;
+            /*
+             * Setting the SYSCTL_RIS manually for now.
+             */
+            if (s->sysctl_rcc2 & SYSCTL_RCC2_USERCC2 && !(s->sysctl_rcc2 & SYSCTL_RCC2_PWRDN2)) {
+                s->sysctl_ris |= SYSCTL_RIS_PLLRIS;
+            }
+            tm4c123_sysctl_update_system_clock(s);
+            break;
+        case SYSCTL_MOSCCTL:
+            s->sysctl_moscctl = val32;
+            break;
+        case SYSCTL_DSLPCLKCFG:
+            s->sysctl_dslpclkcfg = val32;
+            break;
+        case SYSCTL_SYSPROP:
+            READONLY;
+            break;
+        case SYSCTL_PIOSCCAL:
+            s->sysctl_piosccal = val32;
+            break;
+        case SYSCTL_PIOSCSTAT:
+            READONLY;
+            break;
+        case SYSCTL_PLLFREQ0:
+            READONLY;
+            break;
+        case SYSCTL_PLLFREQ1:
+            READONLY;
+            break;
+        case SYSCTL_PLLSTAT:
+            READONLY;
+            break;
+        case SYSCTL_SLPPWRCFG:
+            s->sysctl_slppwrcfg = val32;
+            break;
+        case SYSCTL_DSLPPWRCFG:
+            s->sysctl_dslppwrcfg = val32;
+            break;
+        case SYSCTL_LDOSPCTL:
+            s->sysctl_ldospctl = val32;
+            break;
+        case SYSCTL_LDOSPCAL:
+            READONLY;
+            break;
+        case SYSCTL_LDODPCTL:
+            s->sysctl_ldodpctl = val32;
+            break;
+        case SYSCTL_LDODPCAL:
+            READONLY;
+            break;
+        case SYSCTL_SDPMST:
+            s->sysctl_sdpmst = val32;
+            break;
+        case SYSCTL_PPWD:
+            READONLY;
+            break;
+        case SYSCTL_PPTIMER:
+            READONLY;
+            break;
+        case SYSCTL_PPGPIO:
+            READONLY;
+            break;
+        case SYSCTL_PPDMA:
+            READONLY;
+            break;
+        case SYSCTL_PPHIB:
+            READONLY;
+            break;
+        case SYSCTL_PPUART:
+            READONLY;
+            break;
+        case SYSCTL_PPSI:
+            READONLY;
+            break;
+        case SYSCTL_PPI2C:
+            READONLY;
+            break;
+        case SYSCTL_PPUSB:
+            READONLY;
+            break;
+        case SYSCTL_PPCAN:
+            READONLY;
+            break;
+        case SYSCTL_PPADC:
+            READONLY;
+            break;
+        case SYSCTL_PPACMP:
+            READONLY;
+            break;
+        case SYSCTL_PPPWM:
+            READONLY;
+            break;
+        case SYSCTL_PPQEI:
+            READONLY;
+            break;
+        case SYSCTL_PPEEPROM:
+            READONLY;
+            break;
+        case SYSCTL_PPWTIMER:
+            READONLY;
+            break;
+        case SYSCTL_SRWD:
+            s->sysctl_srwd = val32;
+            break;
+        case SYSCTL_SRTIMER:
+            s->sysctl_srtimer = val32;
+            break;
+        case SYSCTL_SRGPIO:
+            s->sysctl_srgpio = val32;
+            break;
+        case SYSCTL_SRDMA:
+            s->sysctl_srdma = val32;
+            break;
+        case SYSCTL_SRHIB:
+            s->sysctl_srhib = val32;
+            break;
+        case SYSCTL_SRUART:
+            s->sysctl_sruart = val32;
+            break;
+        case SYSCTL_SRSSI:
+            s->sysctl_srssi = val32;
+            break;
+        case SYSCTL_SRI2C:
+            s->sysctl_sri2c = val32;
+            break;
+        case SYSCTL_SRUSB:
+            s->sysctl_srusb = val32;
+            break;
+        case SYSCTL_SRCAN:
+            s->sysctl_srcan = val32;
+            break;
+        case SYSCTL_SRADC:
+            s->sysctl_sradc = val32;
+            break;
+        case SYSCTL_SRACMP:
+            s->sysctl_sracmp = val32;
+            break;
+        case SYSCTL_SRPWM:
+            s->sysctl_srpwm = val32;
+            break;
+        case SYSCTL_SRQEI:
+            s->sysctl_srqei = val32;
+            break;
+        case SYSCTL_SREEPROM:
+            s->sysctl_sreeprom = val32;
+            break;
+        case SYSCTL_SRWTIMER:
+            s->sysctl_srwtimer = val32;
+            break;
+        case SYSCTL_RCGCWD:
+            s->sysctl_rcgcwd = val32;
+            break;
+        case SYSCTL_RCGCTIMER:
+            s->sysctl_rcgctimer = val32;
+            break;
+        case SYSCTL_RCGCGPIO:
+            s->sysctl_rcgcgpio = val32;
+            s->sysctl_prgpio = val32;
+            break;
+        case SYSCTL_RCGCDMA:
+            s->sysctl_rcgcdma = val32;
+            s->sysctl_prdma = val32;
+            break;
+        case SYSCTL_RCGCHIB:
+            s->sysctl_rcgchib = val32;
+            s->sysctl_prhib = val32;
+            break;
+        case SYSCTL_RCGCUART:
+            s->sysctl_rcgcuart = val32;
+            s->sysctl_pruart = val32;
+            break;
+        case SYSCTL_RCGCSSI:
+            s->sysctl_rcgcssi = val32;
+            s->sysctl_prssi = val32;
+            break;
+        case SYSCTL_RCGCI2C:
+            s->sysctl_rcgci2c = val32;
+            s->sysctl_pri2c = val32;
+            break;
+        case SYSCTL_RCGCUSB:
+            s->sysctl_rcgcusb = val32;
+            s->sysctl_prusb = val32;
+            break;
+        case SYSCTL_RCGCCAN:
+            s->sysctl_rcgccan = val32;
+            s->sysctl_prcan = val32;
+            break;
+        case SYSCTL_RCGCADC:
+            s->sysctl_rcgcadc = val32;
+            s->sysctl_pradc = val32;
+            break;
+        case SYSCTL_RCGCACMP:
+            s->sysctl_rcgcacmp = val32;
+            s->sysctl_pracmp = val32;
+            break;
+        case SYSCTL_RCGCPWM:
+            s->sysctl_rcgcpwm = val32;
+            s->sysctl_prpwm = val32;
+            break;
+        case SYSCTL_RCGCQEI:
+            s->sysctl_rcgcqei = val32;
+            s->sysctl_prqei = val32;
+            break;
+        case SYSCTL_RCGCEEPROM:
+            s->sysctl_rcgceeprom = val32;
+            s->sysctl_preeprom = val32;
+            break;
+        case SYSCTL_RCGCWTIMER:
+            s->sysctl_rcgcwtimer = val32;
+            s->sysctl_prwtimer = val32;
+            break;
+        case SYSCTL_SCGCWD:
+            s->sysctl_scgcwd = val32;
+            break;
+        case SYSCTL_SCGCTIMER:
+            s->sysctl_scgctimer = val32;
+            break;
+        case SYSCTL_SCGCGPIO:
+            s->sysctl_scgcgpio = val32;
+            break;
+        case SYSCTL_SCGCDMA:
+            s->sysctl_scgcdma = val32;
+            break;
+        case SYSCTL_SCGCHIB:
+            s->sysctl_scgchib = val32;
+            break;
+        case SYSCTL_SCGCUART:
+            s->sysctl_scgcuart = val32;
+            break;
+        case SYSCTL_SCGCSSI:
+            s->sysctl_scgcssi = val32;
+            break;
+        case SYSCTL_SCGCI2C:
+            s->sysctl_scgci2c = val32;
+            break;
+        case SYSCTL_SCGCUSB:
+            s->sysctl_scgcusb = val32;
+            break;
+        case SYSCTL_SCGCCAN:
+            s->sysctl_scgccan = val32;
+            break;
+        case SYSCTL_SCGCADC:
+            s->sysctl_scgcadc = val32;
+            break;
+        case SYSCTL_SCGCACMP:
+            s->sysctl_scgcacmp = val32;
+            break;
+        case SYSCTL_SCGCPWM:
+            s->sysctl_scgcpwm = val32;
+            break;
+        case SYSCTL_SCGCQEI:
+            s->sysctl_scgcqei = val32;
+            break;
+        case SYSCTL_SCGCEEPROM:
+            s->sysctl_scgceeprom = val32;
+            break;
+        case SYSCTL_SCGCWTIMER:
+            s->sysctl_scgcwtimer = val32;
+            break;
+        case SYSCTL_DCGCWD:
+            s->sysctl_dcgcwd = val32;
+            break;
+        case SYSCTL_DCGCTIMER:
+            s->sysctl_dcgctimer = val32;
+            break;
+        case SYSCTL_DCGCGPIO:
+            s->sysctl_dcgcgpio = val32;
+            break;
+        case SYSCTL_DCGCDMA:
+            s->sysctl_dcgcdma = val32;
+            break;
+        case SYSCTL_DCGCHIB:
+            s->sysctl_dcgchib = val32;
+            break;
+        case SYSCTL_DCGCUART:
+            s->sysctl_dcgcuart = val32;
+            break;
+        case SYSCTL_DCGCSSI:
+            s->sysctl_dcgcssi = val32;
+            break;
+        case SYSCTL_DCGCI2C:
+            s->sysctl_dcgci2c = val32;
+            break;
+        case SYSCTL_DCGCUSB:
+            s->sysctl_dcgcusb = val32;
+            break;
+        case SYSCTL_DCGCCAN:
+            s->sysctl_dcgccan = val32;
+            break;
+        case SYSCTL_DCGCADC:
+            s->sysctl_dcgcadc = val32;
+            break;
+        case SYSCTL_DCGCACMP:
+            s->sysctl_dcgcacmp = val32;
+            break;
+        case SYSCTL_DCGCPWM:
+            s->sysctl_dcgcpwm = val32;
+            break;
+        case SYSCTL_DCGCQEI:
+            s->sysctl_dcgcqei = val32;
+            break;
+        case SYSCTL_DCGCEEPROM:
+            s->sysctl_dcgceeprom = val32;
+            break;
+        case SYSCTL_DCGCWTIME:
+            s->sysctl_dcgcwtime = val32;
+            break;
+        case SYSCTL_PRWD:
+            READONLY;
+            break;
+        case SYSCTL_PRTIMER:
+            READONLY;
+            break;
+        case SYSCTL_PRGPIO:
+            READONLY;
+            break;
+        case SYSCTL_PRDMA:
+            READONLY;
+            break;
+        case SYSCTL_PRHIB:
+            READONLY;
+            break;
+        case SYSCTL_PRUART:
+            READONLY;
+            break;
+        case SYSCTL_PRSSI:
+            READONLY;
+            break;
+        case SYSCTL_PRI2C:
+            READONLY;
+            break;
+        case SYSCTL_PRUSB:
+            READONLY;
+            break;
+        case SYSCTL_PRCAN:
+            READONLY;
+            break;
+        case SYSCTL_PRADC:
+            READONLY;
+            break;
+        case SYSCTL_PRACMP:
+            READONLY;
+            break;
+        case SYSCTL_PRPWM:
+            READONLY;
+            break;
+        case SYSCTL_PRQEI:
+            READONLY;
+            break;
+        case SYSCTL_PREEPROM:
+            READONLY;
+            break;
+        case SYSCTL_PRWTIMER:
+            READONLY;
+            break;
+        default:
+            LOG("Bad address 0x%"HWADDR_PRIx"\n", addr);
+            break;
+    }
+}
+
+static uint64_t tm4c123_sysctl_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    TM4C123SysCtlState *s = opaque;
+
+    trace_tm4c123_sysctl_read(addr);
+
+    switch(addr) {
+        case SYSCTL_DID0:
+            return s->sysctl_did0;
+        case SYSCTL_DID1:
+            return s->sysctl_did1;
+        case SYSCTL_PBORCTL:
+            return s->sysctl_pborctl;
+        case SYSCTL_RIS:
+            return s->sysctl_ris;
+        case SYSCTL_IMC:
+            return s->sysctl_imc;
+        case SYSCTL_MISC:
+            return s->sysctl_misc;
+        case SYSCTL_RESC:
+            return s->sysctl_resc;
+        case SYSCTL_RCC:
+            return s->sysctl_rcc;
+        case SYSCTL_GPIOHBCTL:
+            return s->sysctl_gpiohbctl;
+        case SYSCTL_RCC2:
+            return s->sysctl_rcc2;
+        case SYSCTL_MOSCCTL:
+            return s->sysctl_moscctl;
+        case SYSCTL_DSLPCLKCFG:
+            return s->sysctl_dslpclkcfg;
+        case SYSCTL_SYSPROP:
+            return s->sysctl_sysprop;
+        case SYSCTL_PIOSCCAL:
+            return s->sysctl_piosccal;
+        case SYSCTL_PIOSCSTAT:
+            return s->sysctl_pioscstat;
+        case SYSCTL_PLLFREQ0:
+            return s->sysctl_pllfreq0;
+        case SYSCTL_PLLFREQ1:
+            return s->sysctl_pllfreq1;
+        case SYSCTL_PLLSTAT:
+            return s->sysctl_pllstat;
+        case SYSCTL_SLPPWRCFG:
+            return s->sysctl_slppwrcfg;
+        case SYSCTL_DSLPPWRCFG:
+            return s->sysctl_dslppwrcfg;
+        case SYSCTL_LDOSPCTL:
+            return s->sysctl_ldospctl;
+        case SYSCTL_LDOSPCAL:
+            return s->sysctl_ldospcal;
+        case SYSCTL_LDODPCTL:
+            return s->sysctl_ldodpctl;
+        case SYSCTL_LDODPCAL:
+            return s->sysctl_ldodpcal;
+        case SYSCTL_SDPMST:
+            return s->sysctl_sdpmst;
+        case SYSCTL_PPWD:
+            return s->sysctl_ppwd;
+        case SYSCTL_PPTIMER:
+            return s->sysctl_pptimer;
+        case SYSCTL_PPGPIO:
+            return s->sysctl_ppgpio;
+        case SYSCTL_PPDMA:
+            return s->sysctl_ppdma;
+        case SYSCTL_PPHIB:
+            return s->sysctl_pphib;
+        case SYSCTL_PPUART:
+            return s->sysctl_ppuart;
+        case SYSCTL_PPSI:
+            return s->sysctl_ppsi;
+        case SYSCTL_PPI2C:
+            return s->sysctl_ppi2c;
+        case SYSCTL_PPUSB:
+            return s->sysctl_ppusb;
+        case SYSCTL_PPCAN:
+            return s->sysctl_ppcan;
+        case SYSCTL_PPADC:
+            return s->sysctl_ppadc;
+        case SYSCTL_PPACMP:
+            return s->sysctl_ppacmp;
+        case SYSCTL_PPPWM:
+            return s->sysctl_pppwm;
+        case SYSCTL_PPQEI:
+            return s->sysctl_ppqei;
+        case SYSCTL_PPEEPROM:
+            return s->sysctl_ppeeprom;
+        case SYSCTL_PPWTIMER:
+            return s->sysctl_ppwtimer;
+        case SYSCTL_SRWD:
+            return s->sysctl_srwd;
+        case SYSCTL_SRTIMER:
+            return s->sysctl_srtimer;
+        case SYSCTL_SRGPIO:
+            return s->sysctl_srgpio;
+        case SYSCTL_SRDMA:
+            return s->sysctl_srdma;
+        case SYSCTL_SRHIB:
+            return s->sysctl_srhib;
+        case SYSCTL_SRUART:
+            return s->sysctl_sruart;
+        case SYSCTL_SRSSI:
+            return s->sysctl_srssi;
+        case SYSCTL_SRI2C:
+            return s->sysctl_sri2c;
+        case SYSCTL_SRUSB:
+            return s->sysctl_srusb;
+        case SYSCTL_SRCAN:
+            return s->sysctl_srcan;
+        case SYSCTL_SRADC:
+            return s->sysctl_sradc;
+        case SYSCTL_SRACMP:
+            return s->sysctl_sracmp;
+        case SYSCTL_SRPWM:
+            return s->sysctl_srpwm;
+        case SYSCTL_SRQEI:
+            return s->sysctl_srqei;
+        case SYSCTL_SREEPROM:
+            return s->sysctl_sreeprom;
+        case SYSCTL_SRWTIMER:
+            return s->sysctl_srwtimer;
+        case SYSCTL_RCGCWD:
+            return s->sysctl_rcgcwd;
+        case SYSCTL_RCGCTIMER:
+            return s->sysctl_rcgctimer;
+        case SYSCTL_RCGCGPIO:
+            return s->sysctl_rcgcgpio;
+        case SYSCTL_RCGCDMA:
+            return s->sysctl_rcgcdma;
+        case SYSCTL_RCGCHIB:
+            return s->sysctl_rcgchib;
+        case SYSCTL_RCGCUART:
+            return s->sysctl_rcgcuart;
+        case SYSCTL_RCGCSSI:
+            return s->sysctl_rcgcssi;
+        case SYSCTL_RCGCI2C:
+            return s->sysctl_rcgci2c;
+        case SYSCTL_RCGCUSB:
+            return s->sysctl_rcgcusb;
+        case SYSCTL_RCGCCAN:
+            return s->sysctl_rcgccan;
+        case SYSCTL_RCGCADC:
+            return s->sysctl_rcgcadc;
+        case SYSCTL_RCGCACMP:
+            return s->sysctl_rcgcacmp;
+        case SYSCTL_RCGCPWM:
+            return s->sysctl_rcgcpwm;
+        case SYSCTL_RCGCQEI:
+            return s->sysctl_rcgcqei;
+        case SYSCTL_RCGCEEPROM:
+            return s->sysctl_rcgceeprom;
+        case SYSCTL_RCGCWTIMER:
+            return s->sysctl_rcgcwtimer;
+        case SYSCTL_SCGCWD:
+            return s->sysctl_scgcwd;
+        case SYSCTL_SCGCTIMER:
+            return s->sysctl_scgctimer;
+        case SYSCTL_SCGCGPIO:
+            return s->sysctl_scgcgpio;
+        case SYSCTL_SCGCDMA:
+            return s->sysctl_scgcdma;
+        case SYSCTL_SCGCHIB:
+            return s->sysctl_scgchib;
+        case SYSCTL_SCGCUART:
+            return s->sysctl_scgcuart;
+        case SYSCTL_SCGCSSI:
+            return s->sysctl_scgcssi;
+        case SYSCTL_SCGCI2C:
+            return s->sysctl_scgci2c;
+        case SYSCTL_SCGCUSB:
+            return s->sysctl_scgcusb;
+        case SYSCTL_SCGCCAN:
+            return s->sysctl_scgccan;
+        case SYSCTL_SCGCADC:
+            return s->sysctl_scgcadc;
+        case SYSCTL_SCGCACMP:
+            return s->sysctl_scgcacmp;
+        case SYSCTL_SCGCPWM:
+            return s->sysctl_scgcpwm;
+        case SYSCTL_SCGCQEI:
+            return s->sysctl_scgcqei;
+        case SYSCTL_SCGCEEPROM:
+            return s->sysctl_scgceeprom;
+        case SYSCTL_SCGCWTIMER:
+            return s->sysctl_scgcwtimer;
+        case SYSCTL_DCGCWD:
+            return s->sysctl_dcgcwd;
+        case SYSCTL_DCGCTIMER:
+            return s->sysctl_dcgctimer;
+        case SYSCTL_DCGCGPIO:
+            return s->sysctl_dcgcgpio;
+        case SYSCTL_DCGCDMA:
+            return s->sysctl_dcgcdma;
+        case SYSCTL_DCGCHIB:
+            return s->sysctl_dcgchib;
+        case SYSCTL_DCGCUART:
+            return s->sysctl_dcgcuart;
+        case SYSCTL_DCGCSSI:
+            return s->sysctl_dcgcssi;
+        case SYSCTL_DCGCI2C:
+            return s->sysctl_dcgci2c;
+        case SYSCTL_DCGCUSB:
+            return s->sysctl_dcgcusb;
+        case SYSCTL_DCGCCAN:
+            return s->sysctl_dcgccan;
+        case SYSCTL_DCGCADC:
+            return s->sysctl_dcgcadc;
+        case SYSCTL_DCGCACMP:
+            return s->sysctl_dcgcacmp;
+        case SYSCTL_DCGCPWM:
+            return s->sysctl_dcgcpwm;
+        case SYSCTL_DCGCQEI:
+            return s->sysctl_dcgcqei;
+        case SYSCTL_DCGCEEPROM:
+            return s->sysctl_dcgceeprom;
+        case SYSCTL_DCGCWTIME:
+            return s->sysctl_dcgcwtime;
+        case SYSCTL_PRWD:
+            return s->sysctl_prwd;
+        case SYSCTL_PRTIMER:
+            return s->sysctl_prtimer;
+        case SYSCTL_PRGPIO:
+            return s->sysctl_prgpio;
+        case SYSCTL_PRDMA:
+            return s->sysctl_prdma;
+        case SYSCTL_PRHIB:
+            return s->sysctl_prhib;
+        case SYSCTL_PRUART:
+            return s->sysctl_pruart;
+        case SYSCTL_PRSSI:
+            return s->sysctl_prssi;
+        case SYSCTL_PRI2C:
+            return s->sysctl_pri2c;
+        case SYSCTL_PRUSB:
+            return s->sysctl_prusb;
+        case SYSCTL_PRCAN:
+            return s->sysctl_prcan;
+        case SYSCTL_PRADC:
+            return s->sysctl_pradc;
+        case SYSCTL_PRACMP:
+            return s->sysctl_pracmp;
+        case SYSCTL_PRPWM:
+            return s->sysctl_prpwm;
+        case SYSCTL_PRQEI:
+            return s->sysctl_prqei;
+        case SYSCTL_PREEPROM:
+            return s->sysctl_preeprom;
+        case SYSCTL_PRWTIMER:
+            return s->sysctl_prwtimer;
+        default:
+            LOG("Bad address 0x%"HWADDR_PRIx"\n", addr);
+            break;
+    }
+    return 0;
+}
+
+static const MemoryRegionOps tm4c123_sysctl_ops = {
+    .read = tm4c123_sysctl_read,
+    .write = tm4c123_sysctl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void tm4c123_sysctl_init(Object *obj)
+{
+    TM4C123SysCtlState *s = TM4C123_SYSCTL(obj);
+
+    s->mainclk = clock_new(OBJECT(s), "main-clk");
+    clock_set_hz(s->mainclk, 1000*1000);
+    s->outclk = qdev_init_clock_out(DEVICE(s), "outclk");
+    clock_set_source(s->outclk, s->mainclk);
+
+    memory_region_init_io(&s->mmio, obj, &tm4c123_sysctl_ops, s, TYPE_TM4C123_SYSCTL, 0xFFF);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void tm4c123_sysctl_realize(DeviceState *dev, Error **errp)
+{
+    TM4C123SysCtlState *s = TM4C123_SYSCTL(dev);
+    tm4c123_sysctl_update_system_clock(s);
+
+}
+
+static void tm4c123_sysctl_class_init(ObjectClass *kclass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(kclass);
+    dc->reset = tm4c123_sysctl_reset;
+    dc->realize = tm4c123_sysctl_realize;
+}
+
+static const TypeInfo tm4c123_sysctl_info = {
+    .name = TYPE_TM4C123_SYSCTL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TM4C123SysCtlState),
+    .instance_init = tm4c123_sysctl_init,
+    .class_init = tm4c123_sysctl_class_init,
+};
+
+static void tm4c123_sysctl_register_types(void)
+{
+    type_register_static(&tm4c123_sysctl_info);
+}
+
+type_init(tm4c123_sysctl_register_types)
diff --git a/include/hw/misc/tm4c123_sysctl.h b/include/hw/misc/tm4c123_sysctl.h
new file mode 100644
index 0000000000..a8219a8693
--- /dev/null
+++ b/include/hw/misc/tm4c123_sysctl.h
@@ -0,0 +1,307 @@
+/*
+ * TM4C123 SYSCTL
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
+#ifndef HW_ARM_TM4C123_SYSCTL_H
+#define HW_ARM_TM4C123_SYSCTL_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "qapi/error.h"
+
+#define XTALM       (16000000UL)            /* Main         oscillator freq */
+#define XTALI       (16000000UL)            /* Internal     oscillator freq */
+#define XTAL30K     (   30000UL)            /* Internal 30K oscillator freq */
+#define XTAL32K     (   32768UL)            /* external 32K oscillator freq */
+
+#define PLL_CLK    (400000000UL)
+#define ADC_CLK     (PLL_CLK/25)
+#define CAN_CLK     (PLL_CLK/50)
+
+#define SYSCTL_DID0 0x000
+#define SYSCTL_DID1 0x004
+#define SYSCTL_PBORCTL 0x030
+#define SYSCTL_RIS 0x050
+#define SYSCTL_IMC 0x054
+#define SYSCTL_MISC 0x058
+#define SYSCTL_RESC 0x05C
+#define SYSCTL_RCC 0x060
+#define SYSCTL_GPIOHBCTL 0x06C
+#define SYSCTL_RCC2 0x070
+#define SYSCTL_MOSCCTL 0x07C
+#define SYSCTL_DSLPCLKCFG 0x144
+#define SYSCTL_SYSPROP 0x14C
+#define SYSCTL_PIOSCCAL 0x150
+#define SYSCTL_PIOSCSTAT 0x154
+#define SYSCTL_PLLFREQ0 0x160
+#define SYSCTL_PLLFREQ1 0x164
+#define SYSCTL_PLLSTAT 0x168
+#define SYSCTL_SLPPWRCFG 0x188
+#define SYSCTL_DSLPPWRCFG 0x18C
+#define SYSCTL_LDOSPCTL 0x1B4
+#define SYSCTL_LDOSPCAL 0x1B8
+#define SYSCTL_LDODPCTL 0x1Bc
+#define SYSCTL_LDODPCAL 0x1C0
+#define SYSCTL_SDPMST 0x1CC
+#define SYSCTL_PPWD 0x300
+#define SYSCTL_PPTIMER 0x304
+#define SYSCTL_PPGPIO 0x308
+#define SYSCTL_PPDMA 0x30C
+#define SYSCTL_PPHIB 0x314
+#define SYSCTL_PPUART 0x318
+#define SYSCTL_PPSI 0x31C
+#define SYSCTL_PPI2C 0x320
+#define SYSCTL_PPUSB 0x328
+#define SYSCTL_PPCAN 0x334
+#define SYSCTL_PPADC 0x338
+#define SYSCTL_PPACMP 0x33C
+#define SYSCTL_PPPWM 0x340
+#define SYSCTL_PPQEI 0x344
+#define SYSCTL_PPEEPROM 0x358
+#define SYSCTL_PPWTIMER 0x35C
+#define SYSCTL_SRWD 0x500
+#define SYSCTL_SRTIMER 0x504
+#define SYSCTL_SRGPIO 0x508
+#define SYSCTL_SRDMA 0x50C
+#define SYSCTL_SRHIB 0x514
+#define SYSCTL_SRUART 0x518
+#define SYSCTL_SRSSI 0x51C
+#define SYSCTL_SRI2C 0x520
+#define SYSCTL_SRUSB 0x528
+#define SYSCTL_SRCAN 0x534
+#define SYSCTL_SRADC 0x538
+#define SYSCTL_SRACMP 0x53C
+#define SYSCTL_SRPWM 0x540
+#define SYSCTL_SRQEI 0x544
+#define SYSCTL_SREEPROM 0x558
+#define SYSCTL_SRWTIMER 0x55C
+#define SYSCTL_RCGCWD 0x600
+#define SYSCTL_RCGCTIMER 0x604
+#define SYSCTL_RCGCGPIO 0x608
+#define SYSCTL_RCGCDMA 0x60C
+#define SYSCTL_RCGCHIB 0x614
+#define SYSCTL_RCGCUART 0x618
+#define SYSCTL_RCGCSSI 0x61C
+#define SYSCTL_RCGCI2C 0x620
+#define SYSCTL_RCGCUSB 0x628
+#define SYSCTL_RCGCCAN 0x634
+#define SYSCTL_RCGCADC 0x638
+#define SYSCTL_RCGCACMP 0x63C
+#define SYSCTL_RCGCPWM 0x640
+#define SYSCTL_RCGCQEI 0x644
+#define SYSCTL_RCGCEEPROM 0x658
+#define SYSCTL_RCGCWTIMER 0x65C
+#define SYSCTL_SCGCWD 0x700
+#define SYSCTL_SCGCTIMER 0x704
+#define SYSCTL_SCGCGPIO 0x708
+#define SYSCTL_SCGCDMA 0x70C
+#define SYSCTL_SCGCHIB 0x714
+#define SYSCTL_SCGCUART 0x718
+#define SYSCTL_SCGCSSI 0x71C
+#define SYSCTL_SCGCI2C 0x720
+#define SYSCTL_SCGCUSB 0x728
+#define SYSCTL_SCGCCAN 0x734
+#define SYSCTL_SCGCADC 0x738
+#define SYSCTL_SCGCACMP 0x73C
+#define SYSCTL_SCGCPWM 0x740
+#define SYSCTL_SCGCQEI 0x744
+#define SYSCTL_SCGCEEPROM 0x758
+#define SYSCTL_SCGCWTIMER 0x75C
+#define SYSCTL_DCGCWD 0x800
+#define SYSCTL_DCGCTIMER 0x804
+#define SYSCTL_DCGCGPIO 0x808
+#define SYSCTL_DCGCDMA 0x80C
+#define SYSCTL_DCGCHIB 0x814
+#define SYSCTL_DCGCUART 0x818
+#define SYSCTL_DCGCSSI 0x81C
+#define SYSCTL_DCGCI2C 0x820
+#define SYSCTL_DCGCUSB 0x828
+#define SYSCTL_DCGCCAN 0x834
+#define SYSCTL_DCGCADC 0x838
+#define SYSCTL_DCGCACMP 0x83C
+#define SYSCTL_DCGCPWM 0x840
+#define SYSCTL_DCGCQEI 0x844
+#define SYSCTL_DCGCEEPROM 0x858
+#define SYSCTL_DCGCWTIME 0x85C
+#define SYSCTL_PRWD 0xA00
+#define SYSCTL_PRTIMER 0xA04
+#define SYSCTL_PRGPIO 0xA08
+#define SYSCTL_PRDMA 0xA0C
+#define SYSCTL_PRHIB 0xA14
+#define SYSCTL_PRUART 0xA18
+#define SYSCTL_PRSSI 0xA1C
+#define SYSCTL_PRI2C 0xA20
+#define SYSCTL_PRUSB 0xA28
+#define SYSCTL_PRCAN 0xA34
+#define SYSCTL_PRADC 0xA38
+#define SYSCTL_PRACMP 0xA3C
+#define SYSCTL_PRPWM 0xA40
+#define SYSCTL_PRQEI 0xA44
+#define SYSCTL_PREEPROM 0xA58
+#define SYSCTL_PRWTIMER 0xA5C
+
+
+#define SYSCTL_RCC_PWRDN (1 << 13)
+#define SYSCTL_RCC2_PWRDN2 (1 << 13)
+#define SYSCTL_RCC2_USERCC2 (1 << 31)
+#define SYSCTL_RIS_PLLRIS (1 << 6)
+
+#define TYPE_TM4C123_SYSCTL "tm4c123-sysctl"
+OBJECT_DECLARE_SIMPLE_TYPE(TM4C123SysCtlState, TM4C123_SYSCTL)
+
+struct TM4C123SysCtlState {
+
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    uint32_t sysctl_did0;
+    uint32_t sysctl_did1;
+    uint32_t sysctl_pborctl;
+    uint32_t sysctl_ris;
+    uint32_t sysctl_imc;
+    uint32_t sysctl_misc;
+    uint32_t sysctl_resc;
+    uint32_t sysctl_rcc;
+    uint32_t sysctl_gpiohbctl;
+    uint32_t sysctl_rcc2;
+    uint32_t sysctl_moscctl;
+    uint32_t sysctl_dslpclkcfg;
+    uint32_t sysctl_sysprop;
+    uint32_t sysctl_piosccal;
+    uint32_t sysctl_pioscstat;
+    uint32_t sysctl_pllfreq0;
+    uint32_t sysctl_pllfreq1;
+    uint32_t sysctl_pllstat;
+    uint32_t sysctl_slppwrcfg;
+    uint32_t sysctl_dslppwrcfg;
+    uint32_t sysctl_ldospctl;
+    uint32_t sysctl_ldospcal;
+    uint32_t sysctl_ldodpctl;
+    uint32_t sysctl_ldodpcal;
+    uint32_t sysctl_sdpmst;
+    uint32_t sysctl_ppwd;
+    uint32_t sysctl_pptimer;
+    uint32_t sysctl_ppgpio;
+    uint32_t sysctl_ppdma;
+    uint32_t sysctl_pphib;
+    uint32_t sysctl_ppuart;
+    uint32_t sysctl_ppsi;
+    uint32_t sysctl_ppi2c;
+    uint32_t sysctl_ppusb;
+    uint32_t sysctl_ppcan;
+    uint32_t sysctl_ppadc;
+    uint32_t sysctl_ppacmp;
+    uint32_t sysctl_pppwm;
+    uint32_t sysctl_ppqei;
+    uint32_t sysctl_ppeeprom;
+    uint32_t sysctl_ppwtimer;
+    uint32_t sysctl_srwd;
+    uint32_t sysctl_srtimer;
+    uint32_t sysctl_srgpio;
+    uint32_t sysctl_srdma;
+    uint32_t sysctl_srhib;
+    uint32_t sysctl_sruart;
+    uint32_t sysctl_srssi;
+    uint32_t sysctl_sri2c;
+    uint32_t sysctl_srusb;
+    uint32_t sysctl_srcan;
+    uint32_t sysctl_sradc;
+    uint32_t sysctl_sracmp;
+    uint32_t sysctl_srpwm;
+    uint32_t sysctl_srqei;
+    uint32_t sysctl_sreeprom;
+    uint32_t sysctl_srwtimer;
+    uint32_t sysctl_rcgcwd;
+    uint32_t sysctl_rcgctimer;
+    uint32_t sysctl_rcgcgpio;
+    uint32_t sysctl_rcgcdma;
+    uint32_t sysctl_rcgchib;
+    uint32_t sysctl_rcgcuart;
+    uint32_t sysctl_rcgcssi;
+    uint32_t sysctl_rcgci2c;
+    uint32_t sysctl_rcgcusb;
+    uint32_t sysctl_rcgccan;
+    uint32_t sysctl_rcgcadc;
+    uint32_t sysctl_rcgcacmp;
+    uint32_t sysctl_rcgcpwm;
+    uint32_t sysctl_rcgcqei;
+    uint32_t sysctl_rcgceeprom;
+    uint32_t sysctl_rcgcwtimer;
+    uint32_t sysctl_scgcwd;
+    uint32_t sysctl_scgctimer;
+    uint32_t sysctl_scgcgpio;
+    uint32_t sysctl_scgcdma;
+    uint32_t sysctl_scgchib;
+    uint32_t sysctl_scgcuart;
+    uint32_t sysctl_scgcssi;
+    uint32_t sysctl_scgci2c;
+    uint32_t sysctl_scgcusb;
+    uint32_t sysctl_scgccan;
+    uint32_t sysctl_scgcadc;
+    uint32_t sysctl_scgcacmp;
+    uint32_t sysctl_scgcpwm;
+    uint32_t sysctl_scgcqei;
+    uint32_t sysctl_scgceeprom;
+    uint32_t sysctl_scgcwtimer;
+    uint32_t sysctl_dcgcwd;
+    uint32_t sysctl_dcgctimer;
+    uint32_t sysctl_dcgcgpio;
+    uint32_t sysctl_dcgcdma;
+    uint32_t sysctl_dcgchib;
+    uint32_t sysctl_dcgcuart;
+    uint32_t sysctl_dcgcssi;
+    uint32_t sysctl_dcgci2c;
+    uint32_t sysctl_dcgcusb;
+    uint32_t sysctl_dcgccan;
+    uint32_t sysctl_dcgcadc;
+    uint32_t sysctl_dcgcacmp;
+    uint32_t sysctl_dcgcpwm;
+    uint32_t sysctl_dcgcqei;
+    uint32_t sysctl_dcgceeprom;
+    uint32_t sysctl_dcgcwtime;
+    uint32_t sysctl_prwd;
+    uint32_t sysctl_prtimer;
+    uint32_t sysctl_prgpio;
+    uint32_t sysctl_prdma;
+    uint32_t sysctl_prhib;
+    uint32_t sysctl_pruart;
+    uint32_t sysctl_prssi;
+    uint32_t sysctl_pri2c;
+    uint32_t sysctl_prusb;
+    uint32_t sysctl_prcan;
+    uint32_t sysctl_pradc;
+    uint32_t sysctl_pracmp;
+    uint32_t sysctl_prpwm;
+    uint32_t sysctl_prqei;
+    uint32_t sysctl_preeprom;
+    uint32_t sysctl_prwtimer;
+
+    Clock* mainclk;
+    Clock* outclk;
+
+};
+
+#endif
-- 
2.34.1


