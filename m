Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A107E1AF5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta7-0005XF-Sx; Mon, 06 Nov 2023 01:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZi-0004g6-OI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:08 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZd-0001SG-Iw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:05 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc5916d578so37703495ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253939; x=1699858739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSVy4/ZYZ7jLOT2KGz2OEmSjPk8vKtDB4KfZzxa5Hqw=;
 b=Ft24IVHBhJ6UOICBQTUWAnj3A2P808icYHo4J+DklFUWba3dj1mFQ8Tv2YljQMgBQX
 BKlGxzXjZ45sVqgCtnxfxm5zMgJSgScsasf9rJ6ZpakwY069l7GpNdat0JCaI6w+f5Uq
 BIcIve+Vdq37RwwXtllCm6mBY+RHOfMMEmkFRgzkS7ORJv+vjbS06CtVGB0XXscle1pF
 B+ZxACQsjpS8jBwKodBtvU8p/o9lLaky2Hw+fg0YSFQLuMaNl+aq9fxzDk8midJZSeta
 9W4vd8BbLHhAgjBXKqQGrblnaki4qLXUYZtMODeS65w9JAEGo6enGVSfRyXNyNxt6Mlc
 5TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253939; x=1699858739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSVy4/ZYZ7jLOT2KGz2OEmSjPk8vKtDB4KfZzxa5Hqw=;
 b=MjJsgyiUmEaqGNZoPev33DFeD9TeIFREXKEmx1jBbbOPuV17H9iLNrjWIODEtTVd9m
 7yRle7jP8jfK5dKn+Df+pVZ/4VTSv1wboD56cP6iGa72RzM+sUv+gp8DFpGM1H5TnZAJ
 3ntav0ri6JfdvK3lbfxe5FO+06CHX/ySgo68rPGhQvyFXEyCjLWb74dOm4erqEneTHaY
 4jquiqIuGToS6Gnd4QHXAtXFsJZLbVj80rFLeowdcEDqLf9H996vAxP1U6nJEmOs9VZa
 +tJnNMlV4LmLaiGo9AsNbdRbFRBrVviNtoirgNTYNyf7eR+zkXMHHk74DntdgKpyxoiy
 VNaA==
X-Gm-Message-State: AOJu0YxGfrFFavPCMinfCESeZXicQAuclXI4frJCyYxnD82ovfOqp38o
 Qf1+oNP8YP6z5I8HfqWlQfqH6HPvAtQxJuhaEoQ=
X-Google-Smtp-Source: AGHT+IEsq7CN4WusareZ9uV/Jd4FKremY8Ln878AiaKlWzjYfFiu5LcVoTRP9+YlIcYqCeUMM2eXrA==
X-Received: by 2002:a17:902:ec91:b0:1cc:54fb:60f9 with SMTP id
 x17-20020a170902ec9100b001cc54fb60f9mr22891512plg.37.1699253939108; 
 Sun, 05 Nov 2023 22:58:59 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 34/71] hw/intc: Constify VMState
Date: Sun,  5 Nov 2023 22:57:50 -0800
Message-Id: <20231106065827.543129-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/allwinner-a10-pic.c    |  2 +-
 hw/intc/apic_common.c          |  6 +++---
 hw/intc/arm_gic_common.c       |  8 ++++----
 hw/intc/arm_gicv3_common.c     | 16 ++++++++--------
 hw/intc/arm_gicv3_its_common.c |  2 +-
 hw/intc/armv7m_nvic.c          |  8 ++++----
 hw/intc/aspeed_vic.c           |  2 +-
 hw/intc/bcm2835_ic.c           |  2 +-
 hw/intc/bcm2836_control.c      |  2 +-
 hw/intc/exynos4210_combiner.c  |  4 ++--
 hw/intc/goldfish_pic.c         |  2 +-
 hw/intc/heathrow_pic.c         |  4 ++--
 hw/intc/i8259_common.c         |  6 +++---
 hw/intc/imx_avic.c             |  2 +-
 hw/intc/imx_gpcv2.c            |  2 +-
 hw/intc/ioapic_common.c        |  2 +-
 hw/intc/loongarch_extioi.c     |  2 +-
 hw/intc/loongarch_ipi.c        |  4 ++--
 hw/intc/loongarch_pch_pic.c    |  2 +-
 hw/intc/m68k_irqc.c            |  2 +-
 hw/intc/nios2_vic.c            |  2 +-
 hw/intc/ompic.c                |  4 ++--
 hw/intc/openpic.c              | 12 ++++++------
 hw/intc/pl190.c                |  2 +-
 hw/intc/ppc-uic.c              |  2 +-
 hw/intc/riscv_aclint.c         |  2 +-
 hw/intc/riscv_aplic.c          |  2 +-
 hw/intc/riscv_imsic.c          |  2 +-
 hw/intc/rx_icu.c               |  2 +-
 hw/intc/s390_flic.c            | 10 +++++-----
 hw/intc/s390_flic_kvm.c        |  8 ++++----
 hw/intc/sifive_plic.c          |  2 +-
 hw/intc/slavio_intctl.c        |  4 ++--
 hw/intc/spapr_xive.c           |  6 +++---
 hw/intc/xics.c                 |  6 +++---
 hw/intc/xive.c                 |  4 ++--
 hw/intc/xlnx-pmu-iomod-intc.c  |  2 +-
 hw/intc/xlnx-zynqmp-ipi.c      |  2 +-
 38 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index d0bf8d545b..cea559c39d 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -142,7 +142,7 @@ static const VMStateDescription vmstate_aw_a10_pic = {
     .name = "a10.pic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vector, AwA10PICState),
         VMSTATE_UINT32(base_addr, AwA10PICState),
         VMSTATE_UINT32(protect, AwA10PICState),
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bccb4241c2..6c100b48d6 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -349,7 +349,7 @@ static const VMStateDescription vmstate_apic_common_sipi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = apic_common_sipi_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(sipi_vector, APICCommonState),
         VMSTATE_INT32(wait_for_sipi, APICCommonState),
         VMSTATE_END_OF_LIST()
@@ -363,7 +363,7 @@ static const VMStateDescription vmstate_apic_common = {
     .pre_load = apic_pre_load,
     .pre_save = apic_dispatch_pre_save,
     .post_load = apic_dispatch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(apicbase, APICCommonState),
         VMSTATE_UINT8(id, APICCommonState),
         VMSTATE_UINT8(arb_id, APICCommonState),
@@ -386,7 +386,7 @@ static const VMStateDescription vmstate_apic_common = {
                       APICCommonState), /* open-coded timer state */
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_apic_common_sipi,
         NULL
     }
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 7c28504ace..94c173cb07 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -62,7 +62,7 @@ static const VMStateDescription vmstate_gic_irq_state = {
     .name = "arm_gic_irq_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(enabled, gic_irq_state),
         VMSTATE_UINT8(pending, gic_irq_state),
         VMSTATE_UINT8(active, gic_irq_state),
@@ -79,7 +79,7 @@ static const VMStateDescription vmstate_gic_virt_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = gic_virt_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Virtual interface */
         VMSTATE_UINT32_ARRAY(h_hcr, GICState, GIC_NCPU),
         VMSTATE_UINT32_ARRAY(h_misr, GICState, GIC_NCPU),
@@ -104,7 +104,7 @@ static const VMStateDescription vmstate_gic = {
     .minimum_version_id = 12,
     .pre_save = gic_pre_save,
     .post_load = gic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctlr, GICState),
         VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, 0, GIC_NCPU),
         VMSTATE_STRUCT_ARRAY(irq_state, GICState, GIC_MAXIRQ, 1,
@@ -122,7 +122,7 @@ static const VMStateDescription vmstate_gic = {
         VMSTATE_UINT32_2DARRAY(nsapr, GICState, GIC_NR_APRS, GIC_NCPU),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_gic_virt_state,
         NULL
     }
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2ebf880ead..cb55c72681 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -105,7 +105,7 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virt_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_2DARRAY(ich_apr, GICv3CPUState, 3, 4),
         VMSTATE_UINT64(ich_hcr_el2, GICv3CPUState),
         VMSTATE_UINT64_ARRAY(ich_lr_el2, GICv3CPUState, GICV3_LR_MAX),
@@ -139,7 +139,7 @@ const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = icc_sre_el1_reg_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
         VMSTATE_END_OF_LIST()
     }
@@ -157,7 +157,7 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = gicv4_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(gicr_vpropbaser, GICv3CPUState),
         VMSTATE_UINT64(gicr_vpendbaser, GICv3CPUState),
         VMSTATE_END_OF_LIST()
@@ -169,7 +169,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_load = vmstate_gicv3_cpu_pre_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, GICv3CPUState),
         VMSTATE_UINT32(gicr_ctlr, GICv3CPUState),
         VMSTATE_UINT32_ARRAY(gicr_statusr, GICv3CPUState, 2),
@@ -192,7 +192,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         VMSTATE_UINT64(icc_ctlr_el3, GICv3CPUState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_cpu_virt,
         &vmstate_gicv3_cpu_sre_el1,
         &vmstate_gicv3_gicv4,
@@ -232,7 +232,7 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = needed_always,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
         VMSTATE_END_OF_LIST()
     }
@@ -246,7 +246,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .pre_save = gicv3_pre_save,
     .post_load = gicv3_post_load,
     .priority = MIG_PRI_GICV3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(gicd_ctlr, GICv3State),
         VMSTATE_UINT32_ARRAY(gicd_statusr, GICv3State, 2),
         VMSTATE_UINT32_ARRAY(group, GICv3State, GICV3_BMP_SIZE),
@@ -264,7 +264,7 @@ static const VMStateDescription vmstate_gicv3 = {
                                              vmstate_gicv3_cpu, GICv3CPUState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_gicd_no_migration_shift_bug,
         NULL
     }
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index fddd6d490c..331d6b93cc 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -54,7 +54,7 @@ static const VMStateDescription vmstate_its = {
     .pre_save = gicv3_its_pre_save,
     .post_load = gicv3_its_post_load,
     .priority = MIG_PRI_GICV3_ITS,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctlr, GICv3ITSState),
         VMSTATE_UINT32(iidr, GICv3ITSState),
         VMSTATE_UINT64(cbaser, GICv3ITSState),
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 942be7bd11..50f9a973a2 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2498,7 +2498,7 @@ static const VMStateDescription vmstate_VecInfo = {
     .name = "armv7m_nvic_info",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT16(prio, VecInfo),
         VMSTATE_UINT8(enabled, VecInfo),
         VMSTATE_UINT8(pending, VecInfo),
@@ -2543,7 +2543,7 @@ static const VMStateDescription vmstate_nvic_security = {
     .minimum_version_id = 1,
     .needed = nvic_security_needed,
     .post_load = &nvic_security_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(sec_vectors, NVICState, NVIC_INTERNAL_VECTORS, 1,
                              vmstate_VecInfo, VecInfo),
         VMSTATE_UINT32(prigroup[M_REG_S], NVICState),
@@ -2557,13 +2557,13 @@ static const VMStateDescription vmstate_nvic = {
     .version_id = 4,
     .minimum_version_id = 4,
     .post_load = &nvic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(vectors, NVICState, NVIC_MAX_VECTORS, 1,
                              vmstate_VecInfo, VecInfo),
         VMSTATE_UINT32(prigroup[M_REG_NS], NVICState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_nvic_security,
         NULL
     }
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 5ba06c5262..ba1d953c2c 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -326,7 +326,7 @@ static const VMStateDescription vmstate_aspeed_vic = {
     .name = "aspeed.new-vic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(level, AspeedVICState),
         VMSTATE_UINT64(raw, AspeedVICState),
         VMSTATE_UINT64(select, AspeedVICState),
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 4513fad16f..2c2e2b1822 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -208,7 +208,7 @@ static const VMStateDescription vmstate_bcm2835_ic = {
     .name = TYPE_BCM2835_IC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(gpu_irq_level, BCM2835ICState),
         VMSTATE_UINT64(gpu_irq_enable, BCM2835ICState),
         VMSTATE_UINT8(arm_irq_level, BCM2835ICState),
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index b0589df188..81faf032b0 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -369,7 +369,7 @@ static const VMStateDescription vmstate_bcm2836_control = {
     .name = TYPE_BCM2836_CONTROL,
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mailboxes, BCM2836ControlState,
                              BCM2836_NCORES * BCM2836_MBPERCORE),
         VMSTATE_UINT8(route_gpu_irq, BCM2836ControlState),
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 4ba448fdb1..f0d310a0eb 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -54,7 +54,7 @@ static const VMStateDescription vmstate_exynos4210_combiner_group_state = {
     .name = "exynos4210.combiner.groupstate",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(src_mask, CombinerGroupState),
         VMSTATE_UINT8(src_pending, CombinerGroupState),
         VMSTATE_END_OF_LIST()
@@ -65,7 +65,7 @@ static const VMStateDescription vmstate_exynos4210_combiner = {
     .name = "exynos4210.combiner",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(group, Exynos4210CombinerState, IIC_NGRP, 0,
                 vmstate_exynos4210_combiner_group_state, CombinerGroupState),
         VMSTATE_UINT32_ARRAY(reg_set, Exynos4210CombinerState,
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index dfd53275f6..d662dfeb99 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -161,7 +161,7 @@ static const VMStateDescription vmstate_goldfish_pic = {
     .name = "goldfish_pic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pending, GoldfishPICState),
         VMSTATE_UINT32(enabled, GoldfishPICState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 13048a2735..c2946ba1ad 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -141,7 +141,7 @@ static const VMStateDescription vmstate_heathrow_pic_one = {
     .name = "heathrow_pic_one",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(events, HeathrowPICState),
         VMSTATE_UINT32(mask, HeathrowPICState),
         VMSTATE_UINT32(levels, HeathrowPICState),
@@ -154,7 +154,7 @@ static const VMStateDescription vmstate_heathrow = {
     .name = "heathrow_pic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(pics, HeathrowState, 2, 1,
                              vmstate_heathrow_pic_one, HeathrowPICState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c931dc2d07..ee0041115c 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -156,7 +156,7 @@ static const VMStateDescription vmstate_pic_ltim = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ltim_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ltim, PICCommonState),
         VMSTATE_END_OF_LIST()
     }
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_pic_common = {
     .minimum_version_id = 1,
     .pre_save = pic_dispatch_pre_save,
     .post_load = pic_dispatch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(last_irr, PICCommonState),
         VMSTATE_UINT8(irr, PICCommonState),
         VMSTATE_UINT8(imr, PICCommonState),
@@ -187,7 +187,7 @@ static const VMStateDescription vmstate_pic_common = {
         VMSTATE_UINT8(elcr, PICCommonState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pic_ltim,
         NULL
     }
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 63fc602a1a..aedc708bed 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -38,7 +38,7 @@ static const VMStateDescription vmstate_imx_avic = {
     .name = TYPE_IMX_AVIC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(pending, IMXAVICState),
         VMSTATE_UINT64(enabled, IMXAVICState),
         VMSTATE_UINT64(is_fiq, IMXAVICState),
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index 237d5f97eb..af45e5194c 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -96,7 +96,7 @@ static const VMStateDescription vmstate_imx_gpcv2 = {
     .name = TYPE_IMX_GPCV2,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IMXGPCv2State, GPC_NUM),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index b05f436dac..cb9bf62146 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -182,7 +182,7 @@ static const VMStateDescription vmstate_ioapic_common = {
     .minimum_version_id = 1,
     .pre_save = ioapic_dispatch_pre_save,
     .post_load = ioapic_dispatch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(id, IOAPICCommonState),
         VMSTATE_UINT8(ioregsel, IOAPICCommonState),
         VMSTATE_UNUSED_V(2, 8), /* to account for qemu-kvm's v2 format */
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 24fb3af8cc..4fa97f05bd 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_loongarch_extioi = {
     .name = TYPE_LOONGARCH_EXTIOI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
         VMSTATE_UINT32_2DARRAY(coreisr, LoongArchExtIOI, EXTIOI_CPUS,
                                EXTIOI_IRQS_GROUP_COUNT),
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 67858b521c..a155c16509 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -270,7 +270,7 @@ static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(status, IPICore),
         VMSTATE_UINT32(en, IPICore),
         VMSTATE_UINT32(set, IPICore),
@@ -284,7 +284,7 @@ static const VMStateDescription vmstate_loongarch_ipi = {
     .name = TYPE_LOONGARCH_IPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ipi_core, LoongArchIPI, 0, vmstate_ipi_core, IPICore),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 6aa4cadfa4..2d5e65abff 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -420,7 +420,7 @@ static const VMStateDescription vmstate_loongarch_pch_pic = {
     .name = TYPE_LOONGARCH_PCH_PIC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(int_mask, LoongArchPCHPIC),
         VMSTATE_UINT64(htmsi_en, LoongArchPCHPIC),
         VMSTATE_UINT64(intedge, LoongArchPCHPIC),
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index e09705eeaf..4b11fb9f72 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -80,7 +80,7 @@ static const VMStateDescription vmstate_m68k_irqc = {
     .name = "m68k-irqc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ipr, M68KIRQCState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/intc/nios2_vic.c b/hw/intc/nios2_vic.c
index cf63212a88..7e2d9d6327 100644
--- a/hw/intc/nios2_vic.c
+++ b/hw/intc/nios2_vic.c
@@ -275,7 +275,7 @@ static const VMStateDescription nios2_vic_vmstate = {
     .name = "nios2-vic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32_ARRAY(int_config, Nios2VIC, 32),
         VMSTATE_UINT32(vic_config, Nios2VIC),
         VMSTATE_UINT32(int_raw_status, Nios2VIC),
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 1f10314807..99032ea7f7 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -137,7 +137,7 @@ static const VMStateDescription vmstate_or1k_ompic_cpu = {
     .name = "or1k_ompic_cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
          VMSTATE_UINT32(status, OR1KOMPICCPUState),
          VMSTATE_UINT32(control, OR1KOMPICCPUState),
          VMSTATE_END_OF_LIST()
@@ -148,7 +148,7 @@ static const VMStateDescription vmstate_or1k_ompic = {
     .name = TYPE_OR1K_OMPIC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
          VMSTATE_STRUCT_ARRAY(cpus, OR1KOMPICState, OMPIC_MAX_CPUS, 1,
              vmstate_or1k_ompic_cpu, OR1KOMPICCPUState),
          VMSTATE_UINT32(num_cpus, OR1KOMPICState),
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index a6f91d4bcd..9792a11224 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1391,7 +1391,7 @@ static const VMStateDescription vmstate_openpic_irq_queue = {
     .name = "openpic_irq_queue",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BITMAP(queue, IRQQueue, 0, queue_size),
         VMSTATE_INT32(next, IRQQueue),
         VMSTATE_INT32(priority, IRQQueue),
@@ -1403,7 +1403,7 @@ static const VMStateDescription vmstate_openpic_irqdest = {
     .name = "openpic_irqdest",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(ctpr, IRQDest),
         VMSTATE_STRUCT(raised, IRQDest, 0, vmstate_openpic_irq_queue,
                        IRQQueue),
@@ -1418,7 +1418,7 @@ static const VMStateDescription vmstate_openpic_irqsource = {
     .name = "openpic_irqsource",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ivpr, IRQSource),
         VMSTATE_UINT32(idr, IRQSource),
         VMSTATE_UINT32(destmask, IRQSource),
@@ -1432,7 +1432,7 @@ static const VMStateDescription vmstate_openpic_timer = {
     .name = "openpic_timer",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tccr, OpenPICTimer),
         VMSTATE_UINT32(tbcr, OpenPICTimer),
         VMSTATE_END_OF_LIST()
@@ -1443,7 +1443,7 @@ static const VMStateDescription vmstate_openpic_msi = {
     .name = "openpic_msi",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(msir, OpenPICMSI),
         VMSTATE_END_OF_LIST()
     }
@@ -1468,7 +1468,7 @@ static const VMStateDescription vmstate_openpic = {
     .version_id = 3,
     .minimum_version_id = 3,
     .post_load = openpic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(gcr, OpenPICState),
         VMSTATE_UINT32(vir, OpenPICState),
         VMSTATE_UINT32(pir, OpenPICState),
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index cd88443601..d79e5d8076 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -258,7 +258,7 @@ static const VMStateDescription vmstate_pl190 = {
     .name = "pl190",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, PL190State),
         VMSTATE_UINT32(soft_level, PL190State),
         VMSTATE_UINT32(irq_enable, PL190State),
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index dcf5de5d43..9a67f7f651 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -269,7 +269,7 @@ static const VMStateDescription ppc_uic_vmstate = {
     .name = "ppc-uic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, PPCUIC),
         VMSTATE_UINT32(uicsr, PPCUIC),
         VMSTATE_UINT32(uicer, PPCUIC),
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index ab1a0b4b3a..e9f0536b1c 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -321,7 +321,7 @@ static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index c677b5cfbb..e98e258deb 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -878,7 +878,7 @@ static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index b31d07980c..b90f0d731d 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -386,7 +386,7 @@ static const VMStateDescription vmstate_riscv_imsic = {
     .name = "riscv_imsic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
                                   num_pages, 0,
                                   vmstate_info_uint32, uint32_t),
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index e5c01807b9..b2d4338f61 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -345,7 +345,7 @@ static const VMStateDescription vmstate_rxicu = {
     .name = "rx-icu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(ir, RXICUState, NR_IRQS),
         VMSTATE_UINT8_ARRAY(dtcer, RXICUState, NR_IRQS),
         VMSTATE_UINT8_ARRAY(ier, RXICUState, NR_IRQS / 8),
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 74e02858d4..212f268581 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -366,7 +366,7 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ais_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(simm, QEMUS390FLICState),
         VMSTATE_UINT8(nimm, QEMUS390FLICState),
         VMSTATE_END_OF_LIST()
@@ -465,7 +465,7 @@ const VMStateDescription vmstate_adapter_info_so = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = adapter_info_so_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(summary_offset, AdapterInfo),
         VMSTATE_END_OF_LIST()
     }
@@ -475,7 +475,7 @@ const VMStateDescription vmstate_adapter_info = {
     .name = "s390_adapter_info",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ind_offset, AdapterInfo),
         /*
          * We do not have to migrate neither the id nor the addresses.
@@ -484,7 +484,7 @@ const VMStateDescription vmstate_adapter_info = {
          */
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_adapter_info_so,
         NULL
     }
@@ -495,7 +495,7 @@ const VMStateDescription vmstate_adapter_routes = {
     .name = "s390_adapter_routes",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(adapter, AdapterRoutes, 1, vmstate_adapter_info,
                        AdapterInfo),
         VMSTATE_END_OF_LIST()
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 28364b22d6..4d5cbb2a2f 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -525,7 +525,7 @@ static const VMStateDescription kvm_s390_flic_ais_tmp = {
     .name = "s390-flic-ais-tmp",
     .pre_save = kvm_flic_ais_pre_save,
     .post_load = kvm_flic_ais_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(simm, KVMS390FLICStateMigTmp),
         VMSTATE_UINT8(nimm, KVMS390FLICStateMigTmp),
         VMSTATE_END_OF_LIST()
@@ -537,7 +537,7 @@ static const VMStateDescription kvm_s390_flic_vmstate_ais = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ais_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(KVMS390FLICState, KVMS390FLICStateMigTmp,
                          kvm_s390_flic_ais_tmp),
         VMSTATE_END_OF_LIST()
@@ -550,7 +550,7 @@ static const VMStateDescription kvm_s390_flic_vmstate = {
     .name = "s390-flic",
     .version_id = FLIC_SAVEVM_VERSION,
     .minimum_version_id = FLIC_SAVEVM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name = "irqs",
             .info = &(const VMStateInfo) {
@@ -562,7 +562,7 @@ static const VMStateDescription kvm_s390_flic_vmstate = {
         },
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &kvm_s390_flic_vmstate_ais,
         NULL
     }
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 5522ede2cf..e559f11805 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -406,7 +406,7 @@ static const VMStateDescription vmstate_sifive_plic = {
     .name = "riscv_sifive_plic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(source_priority, SiFivePLICState,
                                   num_sources, 0,
                                   vmstate_info_uint32, uint32_t),
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index f7e59ba643..36b4a12f60 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -353,7 +353,7 @@ static const VMStateDescription vmstate_intctl_cpu = {
     .name ="slavio_intctl_cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intreg_pending, SLAVIO_CPUINTCTLState),
         VMSTATE_END_OF_LIST()
     }
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_intctl = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = vmstate_intctl_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(slaves, SLAVIO_INTCTLState, MAX_CPUS, 1,
                              vmstate_intctl_cpu, SLAVIO_CPUINTCTLState),
         VMSTATE_UINT32(intregm_pending, SLAVIO_INTCTLState),
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 199c261b07..d7e56bfb20 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -522,7 +522,7 @@ static const VMStateDescription vmstate_spapr_xive_end = {
     .name = TYPE_SPAPR_XIVE "/end",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT32(w0, XiveEND),
         VMSTATE_UINT32(w1, XiveEND),
         VMSTATE_UINT32(w2, XiveEND),
@@ -539,7 +539,7 @@ static const VMStateDescription vmstate_spapr_xive_eas = {
     .name = TYPE_SPAPR_XIVE "/eas",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT64(w, XiveEAS),
         VMSTATE_END_OF_LIST()
     },
@@ -577,7 +577,7 @@ static const VMStateDescription vmstate_spapr_xive = {
     .minimum_version_id = 1,
     .pre_save = vmstate_spapr_xive_pre_save,
     .post_load = NULL, /* handled at the machine level */
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, SpaprXive, nr_irqs,
                                      vmstate_spapr_xive_eas, XiveEAS),
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c77e986136..8b25787227 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -273,7 +273,7 @@ static const VMStateDescription vmstate_icp_server = {
     .minimum_version_id = 1,
     .pre_save = icp_pre_save,
     .post_load = icp_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32(xirr, ICPState),
         VMSTATE_UINT8(pending_priority, ICPState),
@@ -665,7 +665,7 @@ static const VMStateDescription vmstate_ics_irq = {
     .name = "ics/irq",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(server, ICSIRQState),
         VMSTATE_UINT8(priority, ICSIRQState),
         VMSTATE_UINT8(saved_priority, ICSIRQState),
@@ -681,7 +681,7 @@ static const VMStateDescription vmstate_ics = {
     .minimum_version_id = 1,
     .pre_save = ics_pre_save,
     .post_load = ics_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a3585593d8..057b308ae9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -798,7 +798,7 @@ static const VMStateDescription vmstate_xive_tctx = {
     .minimum_version_id = 1,
     .pre_save = vmstate_xive_tctx_pre_save,
     .post_load = vmstate_xive_tctx_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveTCTX),
         VMSTATE_END_OF_LIST()
     },
@@ -1271,7 +1271,7 @@ static const VMStateDescription vmstate_xive_source = {
     .name = TYPE_XIVE_SOURCE,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
         VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
         VMSTATE_END_OF_LIST()
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index acaa1c3e6f..12bd1a3fff 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -526,7 +526,7 @@ static const VMStateDescription vmstate_xlnx_pmu_io_intc = {
     .name = TYPE_XLNX_PMU_IO_INTC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxPMUIOIntc, XLNXPMUIOINTC_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index adc1179014..509ee799cc 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -349,7 +349,7 @@ static const VMStateDescription vmstate_zynqmp_pmu_ipi = {
     .name = TYPE_XLNX_ZYNQMP_IPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPIPI, R_XLNX_ZYNQMP_IPI_MAX),
         VMSTATE_END_OF_LIST(),
     }
-- 
2.34.1


