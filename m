Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5C73CC91
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 21:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD8uO-0006q8-EF; Sat, 24 Jun 2023 15:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD8uL-0006pV-VM
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 15:26:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD8uK-0006xx-3X
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 15:26:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa71db41b6so18930005e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687634810; x=1690226810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4AIWbYFItTc0Y4WESLPhw8b0uMpOLwnmSlOttj9Tyms=;
 b=fLlhBUOy9+XnJ9RXUIXsgNbPsfkYO75IuU//l8ux2ZZydwVwOjpDVqZ6d6mfqxTZcx
 xSo/GxUVFUMiYGc4pLG1wDt5+O64Jg0vlGxaWImvUoUjywTahU4QaqUeiC9V/seezQ+m
 prd88+d5W50Tj3loB9fUdmY37PB/5AnijWlhsUbhna67E708cuTJDmT0/X1iS+kxBD/R
 NAQ1C9kNBotJoKNTj01F7u/1rmBFsfiOhqnRZUzEY0p+D4dWNDgQh3FERqbhpB/jQug+
 p782nLcEtcQJ9ATQlGPFpoP7aCMR2ka03vy+/hbBkyGDA5FbT4YXy8M07Py7XZ3IItyz
 BvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687634810; x=1690226810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4AIWbYFItTc0Y4WESLPhw8b0uMpOLwnmSlOttj9Tyms=;
 b=ZzoPpS2U/eb4k7WzO5Rhihzmz1w12oSPRaz2Is6ixxMUzqrGbG7fI5z/SNEKzA+xOs
 NVasBJl4GpAsV8FuD1HxUA6pcUqEFCxLqjpT9zTGFVaAfpUJh3RFnZ0UbgjzCwor10Qq
 eZ6LBumGUyIYH1Zq92qtLhJWo4jmPd9wW6Y+bRLH8NhovWu2E3YdpF5yb/35ClW7CprR
 Le6FNt0lG30z9RbsumfbepnansJ5WJwRImYZwiEKERcuq7dQGuKhDzy56qzSHddJkPKD
 vHBN+x0RPEzeAdkfkMprkDFTFZ5Ag3mb5RhhRX54GqLa+BHUQUOqd5n92OIYXYrBM5uA
 jSiA==
X-Gm-Message-State: AC+VfDxKz35FEoHApf4z8GKvD8VNM3s7AlboYW1xepHWlKh4u/xcDILU
 75dAq76ooPaQwrpEPBfrrVVmRKcRp300Ods+0vI=
X-Google-Smtp-Source: ACHHUZ5w3ypjRjBy8R/EedmPSid3KCmCNGb407WEplSS487kzDJmIk/K2vOo/SgMf7/9BA3jHUZEPQ==
X-Received: by 2002:a05:600c:2288:b0:3fa:3188:5ee5 with SMTP id
 8-20020a05600c228800b003fa31885ee5mr5912687wmf.38.1687634809821; 
 Sat, 24 Jun 2023 12:26:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003f96d10eafbsm2929464wmg.12.2023.06.24.12.26.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 12:26:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/ppc: Restrict KVM-specific fields from ArchCPU
Date: Sat, 24 Jun 2023 21:26:45 +0200
Message-Id: <20230624192645.13680-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The 'kvm_sw_tlb' and 'tlb_dirty' fields introduced in commit
93dd5e852c ("kvm: ppc: booke206: use MMU API") are specific
to KVM and shouldn't be accessed when it is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Since v1 https://lore.kernel.org/qemu-devel/20230405160454.97436-9-philmd@linaro.org/:
- Restrict tlb_dirty field (Cédric, thus drop Daniel's R-b).
---
 target/ppc/cpu.h        | 2 ++
 hw/ppc/e500.c           | 2 ++
 hw/ppc/ppce500_spin.c   | 2 ++
 target/ppc/mmu_common.c | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ee2adc105..60b15bfbe7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1147,8 +1147,10 @@ struct CPUArchState {
     int nb_pids;     /* Number of available PID registers */
     int tlb_type;    /* Type of TLB we're dealing with */
     ppc_tlb_t tlb;   /* TLB is optional. Allocate them only if needed */
+#ifdef CONFIG_KVM
     bool tlb_dirty;  /* Set to non-zero when modifying TLB */
     bool kvm_sw_tlb; /* non-zero if KVM SW TLB API is active */
+#endif /* CONFIG_KVM */
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b6eb599751..67793a86f1 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -765,7 +765,9 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env)
     tlb->mas7_3 = 0;
     tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
 
+#ifdef CONFIG_KVM
     env->tlb_dirty = true;
+#endif
 }
 
 static void ppce500_cpu_reset_sec(void *opaque)
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index d57b199797..bbce63e8a4 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -83,7 +83,9 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env,
     tlb->mas2 = (va & TARGET_PAGE_MASK) | MAS2_M;
     tlb->mas7_3 = pa & TARGET_PAGE_MASK;
     tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
+#ifdef CONFIG_KVM
     env->tlb_dirty = true;
+#endif
 }
 
 static void spin_kick(CPUState *cs, run_on_cpu_data data)
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ae1db6e348..8c000e250d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -930,10 +930,12 @@ static void mmubooke_dump_mmu(CPUPPCState *env)
     ppcemb_tlb_t *entry;
     int i;
 
+#ifdef CONFIG_KVM
     if (kvm_enabled() && !env->kvm_sw_tlb) {
         qemu_printf("Cannot access KVM TLB\n");
         return;
     }
+#endif
 
     qemu_printf("\nTLB:\n");
     qemu_printf("Effective          Physical           Size PID   Prot     "
@@ -1021,10 +1023,12 @@ static void mmubooke206_dump_mmu(CPUPPCState *env)
     int offset = 0;
     int i;
 
+#ifdef CONFIG_KVM
     if (kvm_enabled() && !env->kvm_sw_tlb) {
         qemu_printf("Cannot access KVM TLB\n");
         return;
     }
+#endif
 
     for (i = 0; i < BOOKE206_MAX_TLBN; i++) {
         int size = booke206_tlb_size(env, i);
-- 
2.38.1


