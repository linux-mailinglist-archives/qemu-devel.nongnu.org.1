Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC07415DE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWw-0003Hc-QI; Wed, 28 Jun 2023 11:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWU-0002on-7j
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWD-0001oo-HL
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so7297354f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967744; x=1690559744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM8fq3NUI8RLScHcRL3tzhQ3mex7XVAOJnNOqHES0No=;
 b=kHsljvTODBeCkqoAi6ggej0MI8o9aYKoOkBUdKOps1J6MM7pOAVoAgOVQTdehv3JH6
 2aFwIZq8UCQA5zMRa3Vl9mhhXQYplSM0EVjbzfLiIWzmmvaORFqoV5HduIjeY2df6or6
 OhTrotk5r0FTo7sTIuL/LnDoZpEDCIceKgEYGNtxKejTTKxt5PLWzizXQI6pqXkuMnKU
 MzVw5nlD+SqSRbff8nW68baUNcUIxMlX3N/5TW86zDWsN+4B9sys5lDOIMvc7BpNUCAa
 Pj2UBnKEI+z2ubjBlOtOMGA7nr3dq19Zs9QDVCaBOPyxwiKnJye916B63Yzrqoop5p36
 4j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967744; x=1690559744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PM8fq3NUI8RLScHcRL3tzhQ3mex7XVAOJnNOqHES0No=;
 b=XIkvsQPW1YVPOwn6gyLmkg/YPMGWJPGelDxcK/MdH/R0LpChy/HnuoS1vQH9yxe87U
 MWZawcbarUSXohb3wmLsux/XD7vaFLIjyCozICUOrtaJwIHEFlFzzBh5CMclHM8ROoj0
 n+cxF/f0aezKmdiwNAI0rnJ9k2TLNKNG/X4nrK++1CZCg4cihuGXA4zJQpspZOSmClYq
 EcxpgOV0403zlcdgEF9inx1ez6jKGjWqKnuoOTyi+HVISudOn4TcaBUgKmoe3YZ+peYv
 b583IOkCYxKJ/9tOB18xQ39Kks1gG+k7Y1HPzbFmgdNeHWqYQqWMDVSGJYONgzDOOjAJ
 jBpw==
X-Gm-Message-State: ABy/qLbGZo1kuI0vbT+I3RVxgxBZbBHe+sU0kBR/7nS2C80JIhYDu+pw
 hJFlzqvE4kJmDH/L490frhwTmi5QZbNOHt4TYP4=
X-Google-Smtp-Source: APBJJlGe7s/0T3AGr1VOhmClS/8OQqxlkUfWfwpGg6yOlQh3Z+EvZdipVeRI3UoDGnCiGXa6PVVp8g==
X-Received: by 2002:adf:f210:0:b0:314:111a:e121 with SMTP id
 p16-20020adff210000000b00314111ae121mr873583wro.30.1687967743772; 
 Wed, 28 Jun 2023 08:55:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 cx16-20020a056000093000b00301a351a8d6sm13782187wrb.84.2023.06.28.08.55.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 25/30] target/ppc: Restrict KVM-specific fields from ArchCPU
Date: Wed, 28 Jun 2023 17:53:08 +0200
Message-Id: <20230628155313.71594-26-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230624192645.13680-1-philmd@linaro.org>
---
 target/ppc/cpu.h        | 2 ++
 hw/ppc/e500.c           | 2 ++
 hw/ppc/ppce500_spin.c   | 2 ++
 target/ppc/mmu_common.c | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 94497aa115..af12c93ebc 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1149,8 +1149,10 @@ struct CPUArchState {
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


