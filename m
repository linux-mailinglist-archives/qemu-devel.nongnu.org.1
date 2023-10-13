Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF67C80E6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtF-00086j-5t; Fri, 13 Oct 2023 04:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsV-0006h0-NL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsJ-0001Xw-6d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1762394f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187025; x=1697791825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU4oXAs73J7Ai79H+UCs0GR5SNw80dbp8l/zhDvtrMM=;
 b=x/nhuQ8d1rkyNNloWKI60Bpd4BkExmQ3R84iuasOw/2axCV3K5bCA270mwlcEy5+6Q
 SdtJbzcp+X0GJCz0/004yZbZ/a3tjcy3G4NJdUZfKQ0KSyCSCG4zv22/6Rzm9W79gE9I
 CMEiikV7y/9csMsViA062S8uCuBzjv9bWWDlsqW44t6YtDOSw/RTFi04YQVbUzRPlzE9
 d4AjKc6p4MAktDUPNnE00djFjzCv4q1Dj9fBxH5285VHxQknW6yGFjcTQ0GhkOW0VzJ/
 nMp5RXu/b+O0LRHb0K4XfMeeEOIP+IFmcYNE9SYGG6w476AJlus3VfXxoa4FzkZHSGIB
 YXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187025; x=1697791825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xU4oXAs73J7Ai79H+UCs0GR5SNw80dbp8l/zhDvtrMM=;
 b=rQCkcmYs5xYWQdkPIuBDZ7Yngru+z/yNzCXVH7KrtTDTjn0sy+uwjVT9OCbBV1DgTM
 R3Q4+M+mbLnG751vIrmbmVL1VH7uU/c5ae1TP0YrRAvjgA8l+cEZQ9mhW9abtlM5SSky
 VTjknXSzJXF9AtJQbjon2ZSDj8opaKSLmsfA5pG5wCAf4KW9xLfVsJ2qKPSGIbFF9tSJ
 2YFuS6G3vxb9QAkDiADlNK4l7EN1bfoEaizCDD9VEbjJkyiwyXNPnZskv10S/JAweDqF
 x5FgEoYSk1/FAtdN4Py6hqGkbbBkxJjDBWZIo/I4m2pZUV5Mrh2TP132OY3avf51pVd7
 BGRA==
X-Gm-Message-State: AOJu0YyKdCDR351ChM23gPCAPtMyfq9+aTutmZVl8dOytnGmgUZQCIM3
 Of/Lil84JkuuUltTUjkebEuJh6goCTop2hMKYVA=
X-Google-Smtp-Source: AGHT+IHyJmOI6LhbIEdaRZvw+7kO7XZouWj9o8Fj1RCrd+tVu/P8HK1UdtMSfwJSY91PYQS+kMd9PQ==
X-Received: by 2002:a05:6000:1d96:b0:32d:4b6b:6ba with SMTP id
 bk22-20020a0560001d9600b0032d4b6b06bamr7206251wrb.48.1697187025477; 
 Fri, 13 Oct 2023 01:50:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:24 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH v3 59/78] hw/intc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:27 +0300
Message-Id: <8886379aabaa8f02fa7b3b4c57828bd0e4795535.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/intc/apic.c          |  2 +-
 hw/intc/arm_gicv3_kvm.c | 16 ++++++++--------
 hw/intc/armv7m_nvic.c   | 12 ++++++------
 hw/intc/xilinx_intc.c   |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ac3d47d231..30f341c722 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -183,7 +183,7 @@ void apic_deliver_pic_intr(DeviceState *dev, int level)
             if (!(lvt & APIC_LVT_LEVEL_TRIGGER))
                 break;
             apic_reset_bit(s->irr, lvt & 0xff);
-            /* fall through */
+            fallthrough;
         case APIC_DM_EXTINT:
             apic_update_irq(s);
             break;
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 72ad916d3d..782cef3390 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -479,11 +479,11 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, true);
             reg64 = c->icc_apr[GICV3_G0][2];
             kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, true);
-            /* fall through */
+            fallthrough;
         case 6:
             reg64 = c->icc_apr[GICV3_G0][1];
             kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
-            /* fall through */
+            fallthrough;
         default:
             reg64 = c->icc_apr[GICV3_G0][0];
             kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, true);
@@ -495,11 +495,11 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, true);
             reg64 = c->icc_apr[GICV3_G1NS][2];
             kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
-            /* fall through */
+            fallthrough;
         case 6:
             reg64 = c->icc_apr[GICV3_G1NS][1];
             kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
-            /* fall through */
+            fallthrough;
         default:
             reg64 = c->icc_apr[GICV3_G1NS][0];
             kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, true);
@@ -636,11 +636,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
             c->icc_apr[GICV3_G0][3] = reg64;
             kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][2] = reg64;
-            /* fall through */
+            fallthrough;
         case 6:
             kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][1] = reg64;
-            /* fall through */
+            fallthrough;
         default:
             kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, false);
             c->icc_apr[GICV3_G0][0] = reg64;
@@ -652,11 +652,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
             c->icc_apr[GICV3_G1NS][3] = reg64;
             kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][2] = reg64;
-            /* fall through */
+            fallthrough;
         case 6:
             kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][1] = reg64;
-            /* fall through */
+            fallthrough;
         default:
             kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, false);
             c->icc_apr[GICV3_G1NS][0] = reg64;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 03b6b8c986..72d3ae985e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2224,7 +2224,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
     /* reads of set and clear both return the status */
     case 0x100 ... 0x13f: /* NVIC Set enable */
         offset += 0x80;
-        /* fall through */
+        fallthrough;
     case 0x180 ... 0x1bf: /* NVIC Clear enable */
         val = 0;
         startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector # */
@@ -2238,7 +2238,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         break;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         offset += 0x80;
-        /* fall through */
+        fallthrough;
     case 0x280 ... 0x2bf: /* NVIC Clear pend */
         val = 0;
         startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
@@ -2280,7 +2280,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             val = 0;
             break;
         }
-        /* fall through */
+        fallthrough;
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         val = 0;
         for (i = 0; i < size; i++) {
@@ -2355,7 +2355,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
     case 0x100 ... 0x13f: /* NVIC Set enable */
         offset += 0x80;
         setval = 1;
-        /* fall through */
+        fallthrough;
     case 0x180 ... 0x1bf: /* NVIC Clear enable */
         startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ;
 
@@ -2373,7 +2373,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
          */
         offset += 0x80;
         setval = 1;
-        /* fall through */
+        fallthrough;
     case 0x280 ... 0x2bf: /* NVIC Clear pend */
         startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
 
@@ -2408,7 +2408,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             goto exit_ok;
         }
-        /* fall through */
+        fallthrough;
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..245f452898 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -131,7 +131,7 @@ static void pic_write(void *opaque, hwaddr addr,
             if ((p->regs[R_MER] & 2)) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             if (addr < ARRAY_SIZE(p->regs))
                 p->regs[addr] = value;
-- 
2.39.2


