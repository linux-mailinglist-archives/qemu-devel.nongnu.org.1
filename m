Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992C82EF56
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:03:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5i-0007II-Gx; Tue, 16 Jan 2024 08:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5b-0007Hf-Hg
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5Z-0006fz-O6
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e779f0253so16234295e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410163; x=1706014963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/0lc2j5hR8HEryMkQrRsxcG1taeSidf1qTHt5txf0Q=;
 b=XMd9fb4WVpGX/PX9qKgh4g0R4zpfO/78b9yxkjFY5tllbVOfV0Xni09nk9kIAQzJgf
 8Z217xx4sW0OpaecdksK6qeucFch1FlqztPALydx+LQIj7S8VqOIl1+LVzYtkBNce5/+
 rN4Xa8SxSTrva75A+BpdToIfjkEBcH4O9BdgATmA/XdjgfVo6VHsWgtqgxwD3SHOdIWP
 14ls+3PjV9sjOrT+Kq2gB2zF5sACc/N1OpSBJc34THmOVDScEWhPNB9hQ/M+Q7u4Sux6
 kskcJnXrOJ1K6ekvgMOYhOrYqG/YuYzvGqMAF6f4v35qz6Y0VWcxjyJYfNZqjCPw660y
 w07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410163; x=1706014963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/0lc2j5hR8HEryMkQrRsxcG1taeSidf1qTHt5txf0Q=;
 b=utMITRLccw3EfhidhO1ba3KXcydrZum7jvFcYrcTPyH18pgYIelgHjp9R9cpI584Ma
 5EudRpNH6lKePsuCGgAd4XgIRIYANT7xEqsZ2ej8VABSxCe8CqbZggGX4vicirVQ8+gN
 BU9pyuAH1MfdFIMkt9FS+bty/J1IPJIEdPCorKOeQ/swMwj2Vib+A9q2jzcTW6jd7/hi
 9j0q35GeMsLNn9FsDi3nKu13jS2Agwqc5ELedjhkiLqzRI5Me1FphbvJE1go+udfYR2p
 jine1fhV/Qjczt5MCJaNn9ldkYCxqPyUUHDL7pHGjQ+MEwsQ+34uZSQIdWsMypV9k4FE
 lunA==
X-Gm-Message-State: AOJu0YwYZJbvsRFxDpjav9dR1WpPYxkDt1zinZf2h0O4YPR4tC6AwdS8
 ArlDu969F7339bFj43u54GZYjSk8dH4RHxE2Yu+ug552Hg==
X-Google-Smtp-Source: AGHT+IHpVDDOFwICtkQ0xHC0ZW6PmJczxOsqTBx1XZZVo9hDrpI/4EyoTLO5CZxrnUDv/3Cw5vKyPA==
X-Received: by 2002:a05:600c:4511:b0:40e:72a8:278e with SMTP id
 t17-20020a05600c451100b0040e72a8278emr2463352wmo.42.1705410163562; 
 Tue, 16 Jan 2024 05:02:43 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:43 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v2 3/8] intc/grlib_irqmp: implements the multiprocessor status
 register
Date: Tue, 16 Jan 2024 14:02:08 +0100
Message-Id: <20240116130213.172358-4-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This implements the multiprocessor status register in grlib-irqmp and bind
it to a start signal, which will be later wired in leon3-generic to
start a cpu.

The EIRQ and BA bits are not implemented.

Based on https://gaisler.com/doc/gr712rc-usermanual.pdf, §8.3.5.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/intc/grlib_irqmp.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 744cd64c58..fa689e7a1f 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -52,6 +52,10 @@
 #define FORCE_OFFSET     0x80
 #define EXTENDED_OFFSET  0xC0
 
+/* Multiprocessor Status Register  */
+#define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
+#define MP_STATUS_NCPU_SHIFT      28
+
 #define MAX_PILS 16
 
 OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
@@ -65,6 +69,7 @@ struct IRQMP {
 
     unsigned int ncpus;
     IRQMPState *state;
+    qemu_irq start_signal[IRQMP_MAX_CPU];
     qemu_irq irq;
 };
 
@@ -72,6 +77,7 @@ struct IRQMPState {
     uint32_t level;
     uint32_t pending;
     uint32_t clear;
+    uint32_t mpstatus;
     uint32_t broadcast;
 
     uint32_t mask[IRQMP_MAX_CPU];
@@ -182,10 +188,12 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
         return state->force[0];
 
     case CLEAR_OFFSET:
-    case MP_STATUS_OFFSET:
         /* Always read as 0 */
         return 0;
 
+    case MP_STATUS_OFFSET:
+        return state->mpstatus;
+
     case BROADCAST_OFFSET:
         return state->broadcast;
 
@@ -224,8 +232,9 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
 static void grlib_irqmp_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
-    IRQMP      *irqmp = opaque;
+    IRQMP *irqmp = opaque;
     IRQMPState *state;
+    int i;
 
     assert(irqmp != NULL);
     state = irqmp->state;
@@ -258,7 +267,18 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
         return;
 
     case MP_STATUS_OFFSET:
-        /* Read Only (no SMP support) */
+        /*
+         * Writing and reading operations are reversed for the CPU status.
+         * Writing "1" will start the CPU, but reading "1" means that the CPU
+         * is power-down.
+         */
+        value &= MP_STATUS_CPU_STATUS_MASK;
+        for (i = 0; i < irqmp->ncpus; i++) {
+            if ((value >> i) & 1) {
+                qemu_set_irq(irqmp->start_signal[i], 1);
+                state->mpstatus &= ~(1 << i);
+            }
+        }
         return;
 
     case BROADCAST_OFFSET:
@@ -325,6 +345,8 @@ static void grlib_irqmp_reset(DeviceState *d)
 
     memset(irqmp->state, 0, sizeof *irqmp->state);
     irqmp->state->parent = irqmp;
+    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT)
+        | ((1 << irqmp->ncpus) - 2);
 }
 
 static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
@@ -338,6 +360,13 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+
+    /*
+     * Transitionning from 0 to 1 starts the CPUs. The opposite can't
+     * happen.
+     */
+    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
+                             IRQMP_MAX_CPU);
     qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
-- 
2.25.1


