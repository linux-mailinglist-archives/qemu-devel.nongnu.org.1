Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23B7C7F69
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5p-0000hI-U9; Fri, 13 Oct 2023 04:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5K-0007jP-AH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:50 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5E-0007LT-6F
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:49 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bfea381255so22678631fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183982; x=1697788782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPBHMRmhH+p/ZhjjcFTEi2KRfzNW1fhjuE3qiEMv79Q=;
 b=ffqurNcvIjZ0Gx1denkvMuo1bj4sH935DYme1Bvn62zSHg/mRQJwCURyLhP7bjkm4n
 78q504ncKXXCiFauouoHy/ysQVmUePj+BGvbuS37hdDUpvFawJVeiM9lMxaEPyvyzoNf
 6RCRBnZ5BF4rjhdnD62P726o9uBV2sD9ePrrZ1uAlAs4aZBuYKhbAsYLJSPLqoKsq8Pj
 /1X1Wyn1NLic/6h00E7QLcs0mpDoPeyjYo5HeGLUr6jLKioAO/hOTDNoFddnc4XpjwuN
 yvH6wukrVRmNCPmhkpXsrc9GvDTyecp0+oUVLjjJQtyDwFNrPNKBzJMujd7IEaGdM4fg
 CleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183982; x=1697788782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPBHMRmhH+p/ZhjjcFTEi2KRfzNW1fhjuE3qiEMv79Q=;
 b=MtC5fdryAWT9xWwsZSZfwzIqGvRxOojJECubruVQh+M7WBprF/vuSTy/F69mlTR7g6
 Jw75fSWGQcS+SmqcTMfenEmCCBpK3qUia7Qe7pJYFZzdiNbHIOUpjKhVodMX63wXPsCO
 5KRIyWtDseSgWZGx371KTiNw/P1VQwA3uQQt0uw5iagryAG2BvdwnQnw+MKRvqgpQnQd
 HJpDXnDj9QZr+NwcJooXi9CpTwUBMY4K7RewY7zwNyVaqFl/ZCZVSyngjpY/LxzW91ZP
 yL1JDYPEDeWnEQAfFyKv+IRqJPeS8f7PsxUNdyNX3a6Q5le1Z5CSyx+ihrzgliII4JIM
 lbsA==
X-Gm-Message-State: AOJu0Yzp5UuNBohT9TqUtwiXxip6ZaROAwJK7uI6DCo0tnRlA7Oldced
 RdDXp5svHu2ZrD0xTRa0THi9QtbE9L2Dvht/5Xg=
X-Google-Smtp-Source: AGHT+IHRqUUIzh4W/MEOs8Cu1yTrQ0EbNAGJN+RzhABnAioo2gBRiD37jgjEycw65FGRxaD1SuA3ww==
X-Received: by 2002:a05:6512:68a:b0:503:26bc:b08f with SMTP id
 t10-20020a056512068a00b0050326bcb08fmr26929657lfe.24.1697183982053; 
 Fri, 13 Oct 2023 00:59:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:41 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH v2 59/78] hw/intc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:26 +0300
Message-Id: <07a393781d95bd0dd7fb0825d07fd89c57eaa758.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
@@ -172,21 +172,21 @@ static void apic_local_deliver(APICCommonState *s, int vector)
 void apic_deliver_pic_intr(DeviceState *dev, int level)
 {
     APICCommonState *s = APIC(dev);
 
     if (level) {
         apic_local_deliver(s, APIC_LVT_LINT0);
     } else {
         uint32_t lvt = s->lvt[APIC_LVT_LINT0];
 
         switch ((lvt >> 8) & 7) {
         case APIC_DM_FIXED:
             if (!(lvt & APIC_LVT_LEVEL_TRIGGER))
                 break;
             apic_reset_bit(s->irr, lvt & 0xff);
-            /* fall through */
+            fallthrough;
         case APIC_DM_EXTINT:
             apic_update_irq(s);
             break;
         }
     }
 }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 72ad916d3d..782cef3390 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -323,186 +323,186 @@ static void kvm_arm_gicv3_check(GICv3State *s)
 static void kvm_arm_gicv3_put(GICv3State *s)
 {
     uint32_t regl, regh, reg;
     uint64_t reg64, redist_typer;
     int ncpu, i;
 
     kvm_arm_gicv3_check(s);
 
     kvm_gicr_access(s, GICR_TYPER, 0, &regl, false);
     kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
     redist_typer = ((uint64_t)regh << 32) | regl;
 
     reg = s->gicd_ctlr;
     kvm_gicd_access(s, GICD_CTLR, &reg, true);
 
     if (redist_typer & GICR_TYPER_PLPIS) {
         /*
          * Restore base addresses before LPIs are potentially enabled by
          * GICR_CTLR write
          */
         for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
             GICv3CPUState *c = &s->cpu[ncpu];
 
             reg64 = c->gicr_propbaser;
             regl = (uint32_t)reg64;
             kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, true);
             regh = (uint32_t)(reg64 >> 32);
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
 
             reg64 = c->gicr_pendbaser;
             regl = (uint32_t)reg64;
             kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, true);
             regh = (uint32_t)(reg64 >> 32);
             kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, true);
         }
     }
 
     /* Redistributor state (one per CPU) */
 
     for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
         GICv3CPUState *c = &s->cpu[ncpu];
 
         reg = c->gicr_ctlr;
         kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, true);
 
         reg = c->gicr_statusr[GICV3_NS];
         kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, true);
 
         reg = c->gicr_waker;
         kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, true);
 
         reg = c->gicr_igroupr0;
         kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, true);
 
         reg = ~0;
         kvm_gicr_access(s, GICR_ICENABLER0, ncpu, &reg, true);
         reg = c->gicr_ienabler0;
         kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, true);
 
         /* Restore config before pending so we treat level/edge correctly */
         reg = half_shuffle32(c->edge_trigger >> 16) << 1;
         kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, true);
 
         reg = c->level;
         kvm_gic_line_level_access(s, 0, ncpu, &reg, true);
 
         reg = ~0;
         kvm_gicr_access(s, GICR_ICPENDR0, ncpu, &reg, true);
         reg = c->gicr_ipendr0;
         kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, true);
 
         reg = ~0;
         kvm_gicr_access(s, GICR_ICACTIVER0, ncpu, &reg, true);
         reg = c->gicr_iactiver0;
         kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, true);
 
         for (i = 0; i < GIC_INTERNAL; i += 4) {
             reg = c->gicr_ipriorityr[i] |
                 (c->gicr_ipriorityr[i + 1] << 8) |
                 (c->gicr_ipriorityr[i + 2] << 16) |
                 (c->gicr_ipriorityr[i + 3] << 24);
             kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, true);
         }
     }
 
     /* Distributor state (shared between all CPUs */
     reg = s->gicd_statusr[GICV3_NS];
     kvm_gicd_access(s, GICD_STATUSR, &reg, true);
 
     /* s->enable bitmap -> GICD_ISENABLERn */
     kvm_dist_putbmp(s, GICD_ISENABLER, GICD_ICENABLER, s->enabled);
 
     /* s->group bitmap -> GICD_IGROUPRn */
     kvm_dist_putbmp(s, GICD_IGROUPR, 0, s->group);
 
     /* Restore targets before pending to ensure the pending state is set on
      * the appropriate CPU interfaces in the kernel
      */
 
     /* s->gicd_irouter[irq] -> GICD_IROUTERn
      * We can't use kvm_dist_put() here because the registers are 64-bit
      */
     for (i = GIC_INTERNAL; i < s->num_irq; i++) {
         uint32_t offset;
 
         offset = GICD_IROUTER + (sizeof(uint32_t) * i);
         reg = (uint32_t)s->gicd_irouter[i];
         kvm_gicd_access(s, offset, &reg, true);
 
         offset = GICD_IROUTER + (sizeof(uint32_t) * i) + 4;
         reg = (uint32_t)(s->gicd_irouter[i] >> 32);
         kvm_gicd_access(s, offset, &reg, true);
     }
 
     /* s->trigger bitmap -> GICD_ICFGRn
      * (restore configuration registers before pending IRQs so we treat
      * level/edge correctly)
      */
     kvm_dist_put_edge_trigger(s, GICD_ICFGR, s->edge_trigger);
 
     /* s->level bitmap ->  line_level */
     kvm_gic_put_line_level_bmp(s, s->level);
 
     /* s->pending bitmap -> GICD_ISPENDRn */
     kvm_dist_putbmp(s, GICD_ISPENDR, GICD_ICPENDR, s->pending);
 
     /* s->active bitmap -> GICD_ISACTIVERn */
     kvm_dist_putbmp(s, GICD_ISACTIVER, GICD_ICACTIVER, s->active);
 
     /* s->gicd_ipriority[] -> GICD_IPRIORITYRn */
     kvm_dist_put_priority(s, GICD_IPRIORITYR, s->gicd_ipriority);
 
     /* CPU Interface state (one per CPU) */
 
     for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
         kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
                         &c->icc_igrpen[GICV3_G0], true);
         kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
                         &c->icc_igrpen[GICV3_G1NS], true);
         kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, true);
         kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0], true);
         kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS], true);
 
         num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
                         ICC_CTLR_EL1_PRIBITS_MASK) >>
                         ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
 
         switch (num_pri_bits) {
         case 7:
             reg64 = c->icc_apr[GICV3_G0][3];
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
         }
 
         switch (num_pri_bits) {
         case 7:
             reg64 = c->icc_apr[GICV3_G1NS][3];
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
         }
     }
 }
@@ -510,156 +510,156 @@ static void kvm_arm_gicv3_put(GICv3State *s)
 static void kvm_arm_gicv3_get(GICv3State *s)
 {
     uint32_t regl, regh, reg;
     uint64_t reg64, redist_typer;
     int ncpu, i;
 
     kvm_arm_gicv3_check(s);
 
     kvm_gicr_access(s, GICR_TYPER, 0, &regl, false);
     kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
     redist_typer = ((uint64_t)regh << 32) | regl;
 
     kvm_gicd_access(s, GICD_CTLR, &reg, false);
     s->gicd_ctlr = reg;
 
     /* Redistributor state (one per CPU) */
 
     for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
         GICv3CPUState *c = &s->cpu[ncpu];
 
         kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, false);
         c->gicr_ctlr = reg;
 
         kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, false);
         c->gicr_statusr[GICV3_NS] = reg;
 
         kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, false);
         c->gicr_waker = reg;
 
         kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, false);
         c->gicr_igroupr0 = reg;
         kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, false);
         c->gicr_ienabler0 = reg;
         kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, false);
         c->edge_trigger = half_unshuffle32(reg >> 1) << 16;
         kvm_gic_line_level_access(s, 0, ncpu, &reg, false);
         c->level = reg;
         kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, false);
         c->gicr_ipendr0 = reg;
         kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, false);
         c->gicr_iactiver0 = reg;
 
         for (i = 0; i < GIC_INTERNAL; i += 4) {
             kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, false);
             c->gicr_ipriorityr[i] = extract32(reg, 0, 8);
             c->gicr_ipriorityr[i + 1] = extract32(reg, 8, 8);
             c->gicr_ipriorityr[i + 2] = extract32(reg, 16, 8);
             c->gicr_ipriorityr[i + 3] = extract32(reg, 24, 8);
         }
     }
 
     if (redist_typer & GICR_TYPER_PLPIS) {
         for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
             GICv3CPUState *c = &s->cpu[ncpu];
 
             kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, false);
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, false);
             c->gicr_propbaser = ((uint64_t)regh << 32) | regl;
 
             kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, false);
             kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, false);
             c->gicr_pendbaser = ((uint64_t)regh << 32) | regl;
         }
     }
 
     /* Distributor state (shared between all CPUs */
 
     kvm_gicd_access(s, GICD_STATUSR, &reg, false);
     s->gicd_statusr[GICV3_NS] = reg;
 
     /* GICD_IGROUPRn -> s->group bitmap */
     kvm_dist_getbmp(s, GICD_IGROUPR, s->group);
 
     /* GICD_ISENABLERn -> s->enabled bitmap */
     kvm_dist_getbmp(s, GICD_ISENABLER, s->enabled);
 
     /* Line level of irq */
     kvm_gic_get_line_level_bmp(s, s->level);
     /* GICD_ISPENDRn -> s->pending bitmap */
     kvm_dist_getbmp(s, GICD_ISPENDR, s->pending);
 
     /* GICD_ISACTIVERn -> s->active bitmap */
     kvm_dist_getbmp(s, GICD_ISACTIVER, s->active);
 
     /* GICD_ICFGRn -> s->trigger bitmap */
     kvm_dist_get_edge_trigger(s, GICD_ICFGR, s->edge_trigger);
 
     /* GICD_IPRIORITYRn -> s->gicd_ipriority[] */
     kvm_dist_get_priority(s, GICD_IPRIORITYR, s->gicd_ipriority);
 
     /* GICD_IROUTERn -> s->gicd_irouter[irq] */
     for (i = GIC_INTERNAL; i < s->num_irq; i++) {
         uint32_t offset;
 
         offset = GICD_IROUTER + (sizeof(uint32_t) * i);
         kvm_gicd_access(s, offset, &regl, false);
         offset = GICD_IROUTER + (sizeof(uint32_t) * i) + 4;
         kvm_gicd_access(s, offset, &regh, false);
         s->gicd_irouter[i] = ((uint64_t)regh << 32) | regl;
     }
 
     /*****************************************************************
      * CPU Interface(s) State
      */
 
     for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], false);
         kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
                         &c->icc_igrpen[GICV3_G0], false);
         kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
                         &c->icc_igrpen[GICV3_G1NS], false);
         kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, false);
         kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0], false);
         kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS], false);
         num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
                         ICC_CTLR_EL1_PRIBITS_MASK) >>
                         ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
 
         switch (num_pri_bits) {
         case 7:
             kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, false);
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
         }
 
         switch (num_pri_bits) {
         case 7:
             kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, false);
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
         }
     }
 }
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 03b6b8c986..72d3ae985e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2209,128 +2209,128 @@ static int shpr_bank(NVICState *s, int exc, MemTxAttrs attrs)
 static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
                                     uint64_t *data, unsigned size,
                                     MemTxAttrs attrs)
 {
     NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
     unsigned i, startvec, end;
     uint32_t val;
 
     if (attrs.user && !nvic_user_access_ok(s, addr, attrs)) {
         /* Generate BusFault for unprivileged accesses */
         return MEMTX_ERROR;
     }
 
     switch (offset) {
     /* reads of set and clear both return the status */
     case 0x100 ... 0x13f: /* NVIC Set enable */
         offset += 0x80;
-        /* fall through */
+        fallthrough;
     case 0x180 ... 0x1bf: /* NVIC Clear enable */
         val = 0;
         startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].enabled &&
                 (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
         break;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         offset += 0x80;
-        /* fall through */
+        fallthrough;
     case 0x280 ... 0x2bf: /* NVIC Clear pend */
         val = 0;
         startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].pending &&
                 (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
         break;
     case 0x300 ... 0x33f: /* NVIC Active */
         val = 0;
 
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
             break;
         }
 
         startvec = 8 * (offset - 0x300) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (s->vectors[startvec + i].active &&
                 (attrs.secure || s->itns[startvec + i])) {
                 val |= (1 << i);
             }
         }
         break;
     case 0x400 ... 0x5ef: /* NVIC Priority */
         val = 0;
         startvec = offset - 0x400 + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
             if (attrs.secure || s->itns[startvec + i]) {
                 val |= s->vectors[startvec + i].prio << (8 * i);
             }
         }
         break;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             val = 0;
             break;
         }
-        /* fall through */
+        fallthrough;
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         val = 0;
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
             int sbank = shpr_bank(s, hdlidx, attrs);
 
             if (sbank < 0) {
                 continue;
             }
             val = deposit32(val, i * 8, 8, get_prio(s, hdlidx, sbank));
         }
         break;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             val = 0;
             break;
         };
         /*
          * The BFSR bits [15:8] are shared between security states
          * and we store them in the NS copy. They are RAZ/WI for
          * NS code if AIRCR.BFHFNMINS is 0.
          */
         val = s->cpu->env.v7m.cfsr[attrs.secure];
         if (!attrs.secure &&
             !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
             val &= ~R_V7M_CFSR_BFSR_MASK;
         } else {
             val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
         }
         val = extract32(val, (offset - 0xd28) * 8, size * 8);
         break;
     case 0xfe0 ... 0xfff: /* ID.  */
         if (offset & 3) {
             val = 0;
         } else {
             val = nvic_id[(offset - 0xfe0) >> 2];
         }
         break;
     default:
         if (size == 4) {
             val = nvic_readl(s, offset, attrs);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "NVIC: Bad read of size %d at offset 0x%x\n",
                           size, offset);
             val = 0;
         }
     }
 
     trace_nvic_sysreg_read(addr, val, size);
     *data = val;
     return MEMTX_OK;
 }
@@ -2338,126 +2338,126 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
 static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size,
                                      MemTxAttrs attrs)
 {
     NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
     unsigned i, startvec, end;
     unsigned setval = 0;
 
     trace_nvic_sysreg_write(addr, value, size);
 
     if (attrs.user && !nvic_user_access_ok(s, addr, attrs)) {
         /* Generate BusFault for unprivileged accesses */
         return MEMTX_ERROR;
     }
 
     switch (offset) {
     case 0x100 ... 0x13f: /* NVIC Set enable */
         offset += 0x80;
         setval = 1;
-        /* fall through */
+        fallthrough;
     case 0x180 ... 0x1bf: /* NVIC Clear enable */
         startvec = 8 * (offset - 0x180) + NVIC_FIRST_IRQ;
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             if (value & (1 << i) &&
                 (attrs.secure || s->itns[startvec + i])) {
                 s->vectors[startvec + i].enabled = setval;
             }
         }
         nvic_irq_update(s);
         goto exit_ok;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         /* the special logic in armv7m_nvic_set_pending()
          * is not needed since IRQs are never escalated
          */
         offset += 0x80;
         setval = 1;
-        /* fall through */
+        fallthrough;
     case 0x280 ... 0x2bf: /* NVIC Clear pend */
         startvec = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0, end = size * 8; i < end && startvec + i < s->num_irq; i++) {
             /*
              * Note that if the input line is still held high and the interrupt
              * is not active then rule R_CVJS requires that the Pending state
              * remains set; in that case we mustn't let it be cleared.
              */
             if (value & (1 << i) &&
                 (attrs.secure || s->itns[startvec + i]) &&
                 !(setval == 0 && s->vectors[startvec + i].level &&
                   !s->vectors[startvec + i].active)) {
                 s->vectors[startvec + i].pending = setval;
             }
         }
         nvic_irq_update(s);
         goto exit_ok;
     case 0x300 ... 0x33f: /* NVIC Active */
         goto exit_ok; /* R/O */
     case 0x400 ... 0x5ef: /* NVIC Priority */
         startvec = (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
         for (i = 0; i < size && startvec + i < s->num_irq; i++) {
             if (attrs.secure || s->itns[startvec + i]) {
                 set_prio(s, startvec + i, false, (value >> (i * 8)) & 0xff);
             }
         }
         nvic_irq_update(s);
         goto exit_ok;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             goto exit_ok;
         }
-        /* fall through */
+        fallthrough;
     case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
             int newprio = extract32(value, i * 8, 8);
             int sbank = shpr_bank(s, hdlidx, attrs);
 
             if (sbank < 0) {
                 continue;
             }
             set_prio(s, hdlidx, sbank, newprio);
         }
         nvic_irq_update(s);
         goto exit_ok;
     case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             goto exit_ok;
         }
         /* All bits are W1C, so construct 32 bit value with 0s in
          * the parts not written by the access size
          */
         value <<= ((offset - 0xd28) * 8);
 
         if (!attrs.secure &&
             !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
             /* BFSR bits are RAZ/WI for NS if BFHFNMINS is set */
             value &= ~R_V7M_CFSR_BFSR_MASK;
         }
 
         s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
         if (attrs.secure) {
             /* The BFSR bits [15:8] are shared between security states
              * and we store them in the NS copy.
              */
             s->cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
         }
         goto exit_ok;
     }
     if (size == 4) {
         nvic_writel(s, offset, value, attrs);
         goto exit_ok;
     }
     qemu_log_mask(LOG_GUEST_ERROR,
                   "NVIC: Bad write of size %d at offset 0x%x\n", size, offset);
     /* This is UNPREDICTABLE; treat as RAZ/WI */
 
  exit_ok:
     if (tcg_enabled()) {
         /* Ensure any changes made are reflected in the cached hflags. */
         arm_rebuild_hflags(&s->cpu->env);
     }
     return MEMTX_OK;
 }
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..245f452898 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -108,34 +108,34 @@ static uint64_t pic_read(void *opaque, hwaddr addr, unsigned int size)
 static void pic_write(void *opaque, hwaddr addr,
                       uint64_t val64, unsigned int size)
 {
     XpsIntc *p = opaque;
     uint32_t value = val64;
 
     addr >>= 2;
     D(qemu_log("%s addr=%x val=%x\n", __func__, addr * 4, value));
     switch (addr) 
     {
         case R_IAR:
             p->regs[R_ISR] &= ~value; /* ACK.  */
             break;
         case R_SIE:
             p->regs[R_IER] |= value;  /* Atomic set ie.  */
             break;
         case R_CIE:
             p->regs[R_IER] &= ~value; /* Atomic clear ie.  */
             break;
         case R_MER:
             p->regs[R_MER] = value & 0x3;
             break;
         case R_ISR:
             if ((p->regs[R_MER] & 2)) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             if (addr < ARRAY_SIZE(p->regs))
                 p->regs[addr] = value;
             break;
     }
     update_irq(p);
 }
-- 
2.39.2


