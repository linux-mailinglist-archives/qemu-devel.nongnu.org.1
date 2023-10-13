Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC07C7F47
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4j-00028f-IE; Fri, 13 Oct 2023 03:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4W-0000yk-OR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4J-0006uw-V7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406619b53caso19396015e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183925; x=1697788725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5zVzhRvUudufy7nZftra7i6ofu4qIGu6PKB7Nb4ZsY=;
 b=seaN3gDHVpW9XnN5F477zFhNuC37lrQWZpXKdwQBdfecmYK9B+gDZggeknrO2lR3Wr
 BTQu73I5WSbXgAcO0CpmcHOiHtGV5GmRlj0935T9dFol81tVE2S0hjs/CJXK1malbx7S
 YIpfYuyOq7dSE7+kbO2IeAg+NLEkMtWHzZG3M4VYx7iKpSSj8O7kwM3h5CZeAdEeET+P
 k1t0z2KkfPpp0bdk8QXFUyYcHD41gP9O36XU8dD6p3uV32KdRSML9xBoQyWBBwvCUQlu
 q4QfySLt/BkrSzJEbKub3xs9m514uswECCzQvE8W24DNgW8xE0ydxJUgqF8dUHtL09qm
 W8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183925; x=1697788725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5zVzhRvUudufy7nZftra7i6ofu4qIGu6PKB7Nb4ZsY=;
 b=I7GK0fzUT67qijvCiaKFd7Ve8HfsAqjfw6hQ60VWJwjQMzGyap8vfHop3WcuVBB1CG
 BnsJAPJG1Kc0wQhOkxQE3MMRr/BUhLMb0JEOro3l4SRVJiVAK8BqLZq6vyvP5ZclwxNk
 OdRfHc4FfIUY0KUHzAJ2WYHzo8MImuKN7gbqbMU3atQ2TCAUHRCEMyrwSN3Vkp/DVNVG
 uPKXJqlJWYFLFI1sWZImyTw17LKMCa3/FJNrCeZYdigzzhFAJclxGwC2GVmgX10pPkAw
 /dslYy/U70q8xJHlJkHY0tl9iHpn/xZtgP0UZjeNZv8hND4k4+5DrHp0KmtQQ9JdRbDF
 E5Ow==
X-Gm-Message-State: AOJu0YzEhmGBbnwXBU/78xNQq10nSxpgzklQmxhoJuNIeiOX+ZxrSBlb
 4IsJgcryaf16ZIVeqoKb/S2uANLtTLj1jEs+eAo=
X-Google-Smtp-Source: AGHT+IErSbVeC7N9dJHeULljd1L7YMqXqqA6w1T0EF7Kd71KWF1bq/hhsBA8KO7yN9jOVszK3v6ENQ==
X-Received: by 2002:a05:600c:378d:b0:401:a0b1:aef6 with SMTP id
 o13-20020a05600c378d00b00401a0b1aef6mr23131440wmr.2.1697183924960; 
 Fri, 13 Oct 2023 00:58:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [RFC PATCH v2 26/78] target/s390x: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:53 +0300
Message-Id: <18070bd006c48fe9966502ef6877d12a489135f1.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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
 target/s390x/cpu.c                  |  4 ++--
 target/s390x/kvm/kvm.c              |  2 +-
 target/s390x/mmu_helper.c           |  6 +++---
 target/s390x/tcg/translate.c        | 18 +++++++++++-------
 target/s390x/tcg/translate_vx.c.inc |  2 +-
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4f7599d72c..01df983991 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -150,69 +150,69 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 /* S390CPUClass::reset() */
 static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
 {
     S390CPU *cpu = S390_CPU(s);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
     DeviceState *dev = DEVICE(s);
 
     scc->parent_reset(dev);
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     switch (type) {
     case S390_CPU_RESET_CLEAR:
         memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
-        /* fall through */
+        fallthrough;
     case S390_CPU_RESET_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
                offsetof(CPUS390XState, start_normal_reset_fields) -
                offsetof(CPUS390XState, start_initial_reset_fields));
 
         /* architectured initial value for Breaking-Event-Address register */
         env->gbea = 1;
 
         /* architectured initial values for CR 0 and 14 */
         env->cregs[0] = CR0_RESET;
         env->cregs[14] = CR14_RESET;
 
 #if defined(CONFIG_USER_ONLY)
         /* user mode should always be allowed to use the full FPU */
         env->cregs[0] |= CR0_AFP;
         if (s390_has_feat(S390_FEAT_VECTOR)) {
             env->cregs[0] |= CR0_VECTOR;
         }
 #endif
 
         /* tininess for underflow is detected before rounding */
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
-       /* fall through */
+        fallthrough;
     case S390_CPU_RESET_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
         memset(&env->start_normal_reset_fields, 0,
                offsetof(CPUS390XState, end_reset_fields) -
                offsetof(CPUS390XState, start_normal_reset_fields));
 
         env->pfault_token = -1UL;
         env->bpbc = false;
         break;
     default:
         g_assert_not_reached();
     }
 
     /* Reset state inside the kernel that we cannot access yet from QEMU. */
     if (kvm_enabled()) {
         switch (type) {
         case S390_CPU_RESET_CLEAR:
             kvm_s390_reset_vcpu_clear(cpu);
             break;
         case S390_CPU_RESET_INITIAL:
             kvm_s390_reset_vcpu_initial(cpu);
             break;
         case S390_CPU_RESET_NORMAL:
             kvm_s390_reset_vcpu_normal(cpu);
             break;
         }
     }
 }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bc5c56a305..11b2c05df6 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1080,48 +1080,48 @@ int kvm_arch_process_async_events(CPUState *cs)
 static int s390_kvm_irq_to_interrupt(struct kvm_s390_irq *irq,
                                      struct kvm_s390_interrupt *interrupt)
 {
     int r = 0;
 
     interrupt->type = irq->type;
     switch (irq->type) {
     case KVM_S390_INT_VIRTIO:
         interrupt->parm = irq->u.ext.ext_params;
-        /* fall through */
+        fallthrough;
     case KVM_S390_INT_PFAULT_INIT:
     case KVM_S390_INT_PFAULT_DONE:
         interrupt->parm64 = irq->u.ext.ext_params2;
         break;
     case KVM_S390_PROGRAM_INT:
         interrupt->parm = irq->u.pgm.code;
         break;
     case KVM_S390_SIGP_SET_PREFIX:
         interrupt->parm = irq->u.prefix.address;
         break;
     case KVM_S390_INT_SERVICE:
         interrupt->parm = irq->u.ext.ext_params;
         break;
     case KVM_S390_MCHK:
         interrupt->parm = irq->u.mchk.cr14;
         interrupt->parm64 = irq->u.mchk.mcic;
         break;
     case KVM_S390_INT_EXTERNAL_CALL:
         interrupt->parm = irq->u.extcall.code;
         break;
     case KVM_S390_INT_EMERGENCY:
         interrupt->parm = irq->u.emerg.code;
         break;
     case KVM_S390_SIGP_STOP:
     case KVM_S390_RESTART:
         break; /* These types have no parameters */
     case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
         interrupt->parm = irq->u.io.subchannel_id << 16;
         interrupt->parm |= irq->u.io.subchannel_nr;
         interrupt->parm64 = (uint64_t)irq->u.io.io_int_parm << 32;
         interrupt->parm64 |= irq->u.io.io_int_word;
         break;
     default:
         r = -EINVAL;
         break;
     }
     return r;
 }
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index fbb2f1b4d4..5833917552 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -126,173 +126,173 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
                               int *flags)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
     const bool edat2 = edat1 && s390_has_feat(S390_FEAT_EDAT_2);
     const bool iep = (env->cregs[0] & CR0_IEP) &&
                      s390_has_feat(S390_FEAT_INSTRUCTION_EXEC_PROT);
     const int asce_tl = asce & ASCE_TABLE_LENGTH;
     const int asce_p = asce & ASCE_PRIVATE_SPACE;
     hwaddr gaddr = asce & ASCE_ORIGIN;
     uint64_t entry;
 
     if (asce & ASCE_REAL_SPACE) {
         /* direct mapping */
         *raddr = vaddr;
         return 0;
     }
 
     switch (asce & ASCE_TYPE_MASK) {
     case ASCE_TYPE_REGION1:
         if (VADDR_REGION1_TL(vaddr) > asce_tl) {
             return PGM_REG_FIRST_TRANS;
         }
         gaddr += VADDR_REGION1_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION2:
         if (VADDR_REGION1_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
         if (VADDR_REGION2_TL(vaddr) > asce_tl) {
             return PGM_REG_SEC_TRANS;
         }
         gaddr += VADDR_REGION2_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_REGION3:
         if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
         if (VADDR_REGION3_TL(vaddr) > asce_tl) {
             return PGM_REG_THIRD_TRANS;
         }
         gaddr += VADDR_REGION3_TX(vaddr) * 8;
         break;
     case ASCE_TYPE_SEGMENT:
         if (VADDR_REGION1_TX(vaddr) || VADDR_REGION2_TX(vaddr) ||
             VADDR_REGION3_TX(vaddr)) {
             return PGM_ASCE_TYPE;
         }
         if (VADDR_SEGMENT_TL(vaddr) > asce_tl) {
             return PGM_SEGMENT_TRANS;
         }
         gaddr += VADDR_SEGMENT_TX(vaddr) * 8;
         break;
     }
 
     switch (asce & ASCE_TYPE_MASK) {
     case ASCE_TYPE_REGION1:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
         }
         if (entry & REGION_ENTRY_I) {
             return PGM_REG_FIRST_TRANS;
         }
         if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION1) {
             return PGM_TRANS_SPEC;
         }
         if (VADDR_REGION2_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
             VADDR_REGION2_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
             return PGM_REG_SEC_TRANS;
         }
         if (edat1 && (entry & REGION_ENTRY_P)) {
             *flags &= ~PAGE_WRITE;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION2_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_REGION2:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
         }
         if (entry & REGION_ENTRY_I) {
             return PGM_REG_SEC_TRANS;
         }
         if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION2) {
             return PGM_TRANS_SPEC;
         }
         if (VADDR_REGION3_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
             VADDR_REGION3_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
             return PGM_REG_THIRD_TRANS;
         }
         if (edat1 && (entry & REGION_ENTRY_P)) {
             *flags &= ~PAGE_WRITE;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_REGION3_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_REGION3:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
         }
         if (entry & REGION_ENTRY_I) {
             return PGM_REG_THIRD_TRANS;
         }
         if ((entry & REGION_ENTRY_TT) != REGION_ENTRY_TT_REGION3) {
             return PGM_TRANS_SPEC;
         }
         if (edat2 && (entry & REGION3_ENTRY_CR) && asce_p) {
             return PGM_TRANS_SPEC;
         }
         if (edat1 && (entry & REGION_ENTRY_P)) {
             *flags &= ~PAGE_WRITE;
         }
         if (edat2 && (entry & REGION3_ENTRY_FC)) {
             if (iep && (entry & REGION3_ENTRY_IEP)) {
                 *flags &= ~PAGE_EXEC;
             }
             *raddr = (entry & REGION3_ENTRY_RFAA) |
                      (vaddr & ~REGION3_ENTRY_RFAA);
             return 0;
         }
         if (VADDR_SEGMENT_TL(vaddr) < (entry & REGION_ENTRY_TF) >> 6 ||
             VADDR_SEGMENT_TL(vaddr) > (entry & REGION_ENTRY_TL)) {
             return PGM_SEGMENT_TRANS;
         }
         gaddr = (entry & REGION_ENTRY_ORIGIN) + VADDR_SEGMENT_TX(vaddr) * 8;
-        /* fall through */
+        fallthrough;
     case ASCE_TYPE_SEGMENT:
         if (!read_table_entry(env, gaddr, &entry)) {
             return PGM_ADDRESSING;
         }
         if (entry & SEGMENT_ENTRY_I) {
             return PGM_SEGMENT_TRANS;
         }
         if ((entry & SEGMENT_ENTRY_TT) != SEGMENT_ENTRY_TT_SEGMENT) {
             return PGM_TRANS_SPEC;
         }
         if ((entry & SEGMENT_ENTRY_CS) && asce_p) {
             return PGM_TRANS_SPEC;
         }
         if (entry & SEGMENT_ENTRY_P) {
             *flags &= ~PAGE_WRITE;
         }
         if (edat1 && (entry & SEGMENT_ENTRY_FC)) {
             if (iep && (entry & SEGMENT_ENTRY_IEP)) {
                 *flags &= ~PAGE_EXEC;
             }
             *raddr = (entry & SEGMENT_ENTRY_SFAA) |
                      (vaddr & ~SEGMENT_ENTRY_SFAA);
             return 0;
         }
         gaddr = (entry & SEGMENT_ENTRY_ORIGIN) + VADDR_PAGE_TX(vaddr) * 8;
         break;
     }
 
     if (!read_table_entry(env, gaddr, &entry)) {
         return PGM_ADDRESSING;
     }
     if (entry & PAGE_ENTRY_I) {
         return PGM_PAGE_TRANS;
     }
     if (entry & PAGE_ENTRY_0) {
         return PGM_TRANS_SPEC;
     }
     if (entry & PAGE_ENTRY_P) {
         *flags &= ~PAGE_WRITE;
     }
     if (iep && (entry & PAGE_ENTRY_IEP)) {
         *flags &= ~PAGE_EXEC;
     }
 
     *raddr = entry & TARGET_PAGE_MASK;
     return 0;
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4bae1509f5..986d6433d2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -569,90 +569,91 @@ static void set_cc_static(DisasContext *s)
 /* calculates cc into cc_op */
 static void gen_op_calc_cc(DisasContext *s)
 {
     TCGv_i32 local_cc_op = NULL;
     TCGv_i64 dummy = NULL;
 
     switch (s->cc_op) {
     default:
         dummy = tcg_constant_i64(0);
         /* FALLTHRU */
+        fallthrough;
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
         local_cc_op = tcg_constant_i32(s->cc_op);
         break;
     case CC_OP_CONST0:
     case CC_OP_CONST1:
     case CC_OP_CONST2:
     case CC_OP_CONST3:
     case CC_OP_STATIC:
     case CC_OP_DYNAMIC:
         break;
     }
 
     switch (s->cc_op) {
     case CC_OP_CONST0:
     case CC_OP_CONST1:
     case CC_OP_CONST2:
     case CC_OP_CONST3:
         /* s->cc_op is the cc value */
         tcg_gen_movi_i32(cc_op, s->cc_op - CC_OP_CONST0);
         break;
     case CC_OP_STATIC:
         /* env->cc_op already is the cc value */
         break;
     case CC_OP_NZ:
         tcg_gen_setcondi_i64(TCG_COND_NE, cc_dst, cc_dst, 0);
         tcg_gen_extrl_i64_i32(cc_op, cc_dst);
         break;
     case CC_OP_ABS_64:
     case CC_OP_NABS_64:
     case CC_OP_ABS_32:
     case CC_OP_NABS_32:
     case CC_OP_LTGT0_32:
     case CC_OP_LTGT0_64:
     case CC_OP_COMP_32:
     case CC_OP_COMP_64:
     case CC_OP_NZ_F32:
     case CC_OP_NZ_F64:
     case CC_OP_FLOGR:
     case CC_OP_LCBB:
     case CC_OP_MULS_32:
         /* 1 argument */
         gen_helper_calc_cc(cc_op, tcg_env, local_cc_op, dummy, cc_dst, dummy);
         break;
     case CC_OP_ADDU:
     case CC_OP_ICM:
     case CC_OP_LTGT_32:
     case CC_OP_LTGT_64:
     case CC_OP_LTUGTU_32:
     case CC_OP_LTUGTU_64:
     case CC_OP_TM_32:
     case CC_OP_TM_64:
     case CC_OP_SLA:
     case CC_OP_SUBU:
     case CC_OP_NZ_F128:
     case CC_OP_VC:
     case CC_OP_MULS_64:
         /* 2 arguments */
         gen_helper_calc_cc(cc_op, tcg_env, local_cc_op, cc_src, cc_dst, dummy);
         break;
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
         /* 3 arguments */
         gen_helper_calc_cc(cc_op, tcg_env, local_cc_op, cc_src, cc_dst, cc_vr);
         break;
     case CC_OP_DYNAMIC:
         /* unknown operation - assume 3 arguments and cc_op in env */
         gen_helper_calc_cc(cc_op, tcg_env, cc_op, cc_src, cc_dst, cc_vr);
         break;
     default:
         g_assert_not_reached();
     }
 
     /* We now have cc in cc_op as constant */
     set_cc_static(s);
 }
@@ -708,263 +709,264 @@ static const TCGCond nz_cond[16] = {
 /* Interpret MASK in terms of S->CC_OP, and fill in C with all the
    details required to generate a TCG comparison.  */
 static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
 {
     TCGCond cond;
     enum cc_op old_cc_op = s->cc_op;
 
     if (mask == 15 || mask == 0) {
         c->cond = (mask ? TCG_COND_ALWAYS : TCG_COND_NEVER);
         c->u.s32.a = cc_op;
         c->u.s32.b = cc_op;
         c->is_64 = false;
         return;
     }
 
     /* Find the TCG condition for the mask + cc op.  */
     switch (old_cc_op) {
     case CC_OP_LTGT0_32:
     case CC_OP_LTGT0_64:
     case CC_OP_LTGT_32:
     case CC_OP_LTGT_64:
         cond = ltgt_cond[mask];
         if (cond == TCG_COND_NEVER) {
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_LTUGTU_32:
     case CC_OP_LTUGTU_64:
         cond = tcg_unsigned_cond(ltgt_cond[mask]);
         if (cond == TCG_COND_NEVER) {
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_NZ:
         cond = nz_cond[mask];
         if (cond == TCG_COND_NEVER) {
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_TM_32:
     case CC_OP_TM_64:
         switch (mask) {
         case 8:
             cond = TCG_COND_EQ;
             break;
         case 4 | 2 | 1:
             cond = TCG_COND_NE;
             break;
         default:
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_ICM:
         switch (mask) {
         case 8:
             cond = TCG_COND_EQ;
             break;
         case 4 | 2 | 1:
         case 4 | 2:
             cond = TCG_COND_NE;
             break;
         default:
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_FLOGR:
         switch (mask & 0xa) {
         case 8: /* src == 0 -> no one bit found */
             cond = TCG_COND_EQ;
             break;
         case 2: /* src != 0 -> one bit found */
             cond = TCG_COND_NE;
             break;
         default:
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     case CC_OP_ADDU:
     case CC_OP_SUBU:
         switch (mask) {
         case 8 | 2: /* result == 0 */
             cond = TCG_COND_EQ;
             break;
         case 4 | 1: /* result != 0 */
             cond = TCG_COND_NE;
             break;
         case 8 | 4: /* !carry (borrow) */
             cond = old_cc_op == CC_OP_ADDU ? TCG_COND_EQ : TCG_COND_NE;
             break;
         case 2 | 1: /* carry (!borrow) */
             cond = old_cc_op == CC_OP_ADDU ? TCG_COND_NE : TCG_COND_EQ;
             break;
         default:
             goto do_dynamic;
         }
         account_inline_branch(s, old_cc_op);
         break;
 
     default:
     do_dynamic:
         /* Calculate cc value.  */
         gen_op_calc_cc(s);
         /* FALLTHRU */
+        fallthrough;
 
     case CC_OP_STATIC:
         /* Jump based on CC.  We'll load up the real cond below;
            the assignment here merely avoids a compiler warning.  */
         account_noninline_branch(s, old_cc_op);
         old_cc_op = CC_OP_STATIC;
         cond = TCG_COND_NEVER;
         break;
     }
 
     /* Load up the arguments of the comparison.  */
     c->is_64 = true;
     switch (old_cc_op) {
     case CC_OP_LTGT0_32:
         c->is_64 = false;
         c->u.s32.a = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(c->u.s32.a, cc_dst);
         c->u.s32.b = tcg_constant_i32(0);
         break;
     case CC_OP_LTGT_32:
     case CC_OP_LTUGTU_32:
         c->is_64 = false;
         c->u.s32.a = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(c->u.s32.a, cc_src);
         c->u.s32.b = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(c->u.s32.b, cc_dst);
         break;
 
     case CC_OP_LTGT0_64:
     case CC_OP_NZ:
     case CC_OP_FLOGR:
         c->u.s64.a = cc_dst;
         c->u.s64.b = tcg_constant_i64(0);
         break;
     case CC_OP_LTGT_64:
     case CC_OP_LTUGTU_64:
         c->u.s64.a = cc_src;
         c->u.s64.b = cc_dst;
         break;
 
     case CC_OP_TM_32:
     case CC_OP_TM_64:
     case CC_OP_ICM:
         c->u.s64.a = tcg_temp_new_i64();
         c->u.s64.b = tcg_constant_i64(0);
         tcg_gen_and_i64(c->u.s64.a, cc_src, cc_dst);
         break;
 
     case CC_OP_ADDU:
     case CC_OP_SUBU:
         c->is_64 = true;
         c->u.s64.b = tcg_constant_i64(0);
         switch (mask) {
         case 8 | 2:
         case 4 | 1: /* result */
             c->u.s64.a = cc_dst;
             break;
         case 8 | 4:
         case 2 | 1: /* carry */
             c->u.s64.a = cc_src;
             break;
         default:
             g_assert_not_reached();
         }
         break;
 
     case CC_OP_STATIC:
         c->is_64 = false;
         c->u.s32.a = cc_op;
         switch (mask) {
         case 0x8 | 0x4 | 0x2: /* cc != 3 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(3);
             break;
         case 0x8 | 0x4 | 0x1: /* cc != 2 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(2);
             break;
         case 0x8 | 0x2 | 0x1: /* cc != 1 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(1);
             break;
         case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
             cond = TCG_COND_EQ;
             c->u.s32.a = tcg_temp_new_i32();
             c->u.s32.b = tcg_constant_i32(0);
             tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
             break;
         case 0x8 | 0x4: /* cc < 2 */
             cond = TCG_COND_LTU;
             c->u.s32.b = tcg_constant_i32(2);
             break;
         case 0x8: /* cc == 0 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(0);
             break;
         case 0x4 | 0x2 | 0x1: /* cc != 0 */
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(0);
             break;
         case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
             cond = TCG_COND_NE;
             c->u.s32.a = tcg_temp_new_i32();
             c->u.s32.b = tcg_constant_i32(0);
             tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
             break;
         case 0x4: /* cc == 1 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(1);
             break;
         case 0x2 | 0x1: /* cc > 1 */
             cond = TCG_COND_GTU;
             c->u.s32.b = tcg_constant_i32(1);
             break;
         case 0x2: /* cc == 2 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(2);
             break;
         case 0x1: /* cc == 3 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(3);
             break;
         default:
             /* CC is masked by something else: (8 >> cc) & mask.  */
             cond = TCG_COND_NE;
             c->u.s32.a = tcg_temp_new_i32();
             c->u.s32.b = tcg_constant_i32(0);
             tcg_gen_shr_i32(c->u.s32.a, tcg_constant_i32(8), cc_op);
             tcg_gen_andi_i32(c->u.s32.a, c->u.s32.a, mask);
             break;
         }
         break;
 
     default:
         abort();
     }
     c->cond = cond;
 }
 
 /* ====================================================================== */
 /* Define the insn format enumeration.  */
 #define F0(N)                         FMT_##N,
 #define F1(N, X1)                     F0(N)
 #define F2(N, X1, X2)                 F0(N)
 #define F3(N, X1, X2, X3)             F0(N)
 #define F4(N, X1, X2, X3, X4)         F0(N)
 #define F5(N, X1, X2, X3, X4, X5)     F0(N)
 #define F6(N, X1, X2, X3, X4, X5, X6) F0(N)
@@ -1314,20 +1316,20 @@ static DisasJumpType op_addu64(DisasContext *s, DisasOps *o)
 /* Compute carry into cc_src. */
 static void compute_carry(DisasContext *s)
 {
     switch (s->cc_op) {
     case CC_OP_ADDU:
         /* The carry value is already in cc_src (1,0). */
         break;
     case CC_OP_SUBU:
         tcg_gen_addi_i64(cc_src, cc_src, 1);
         break;
     default:
         gen_op_calc_cc(s);
-        /* fall through */
+        fallthrough;
     case CC_OP_STATIC:
         /* The carry flag is the msb of CC; compute into cc_src. */
         tcg_gen_extu_i32_i64(cc_src, cc_op);
         tcg_gen_shri_i64(cc_src, cc_src, 1);
         break;
     }
 }
@@ -2602,53 +2604,53 @@ static DisasJumpType op_iske(DisasContext *s, DisasOps *o)
 static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
 {
     int r1 = have_field(s, r1) ? get_field(s, r1) : 0;
     int r2 = have_field(s, r2) ? get_field(s, r2) : 0;
     int r3 = have_field(s, r3) ? get_field(s, r3) : 0;
     TCGv_i32 t_r1, t_r2, t_r3, type;
 
     switch (s->insn->data) {
     case S390_FEAT_TYPE_KMA:
         if (r3 == r1 || r3 == r2) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_KMCTR:
         if (r3 & 1 || !r3) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMF:
     case S390_FEAT_TYPE_KMC:
     case S390_FEAT_TYPE_KMO:
     case S390_FEAT_TYPE_KM:
         if (r1 & 1 || !r1) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
         if (r2 & 1 || !r2) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        fallthrough;
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         break;
     default:
         g_assert_not_reached();
     };
 
     t_r1 = tcg_constant_i32(r1);
     t_r2 = tcg_constant_i32(r2);
     t_r3 = tcg_constant_i32(r3);
     type = tcg_constant_i32(s->insn->data);
     gen_helper_msa(cc_op, tcg_env, t_r1, t_r2, t_r3, type);
     set_cc_static(s);
     return DISAS_NEXT;
 }
@@ -4579,21 +4581,21 @@ static DisasJumpType op_subu64(DisasContext *s, DisasOps *o)
 /* Compute borrow (0, -1) into cc_src. */
 static void compute_borrow(DisasContext *s)
 {
     switch (s->cc_op) {
     case CC_OP_SUBU:
         /* The borrow value is already in cc_src (0,-1). */
         break;
     default:
         gen_op_calc_cc(s);
-        /* fall through */
+        fallthrough;
     case CC_OP_STATIC:
         /* The carry flag is the msb of CC; compute into cc_src. */
         tcg_gen_extu_i32_i64(cc_src, cc_op);
         tcg_gen_shri_i64(cc_src, cc_src, 1);
-        /* fall through */
+        fallthrough;
     case CC_OP_ADDU:
         /* Convert carry (1,0) to borrow (0,-1). */
         tcg_gen_subi_i64(cc_src, cc_src, 1);
         break;
     }
 }
@@ -6479,27 +6481,29 @@ static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     switch (dc->base.is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
         update_psw_addr(dc);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
         update_cc_op(dc);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
         if (dc->exit_to_mainloop) {
             tcg_gen_exit_tb(NULL, 0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
         break;
     default:
         g_assert_not_reached();
     }
 }
diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index e073e5ad3a..75463b4f5c 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -662,39 +662,39 @@ static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
 static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
 {
     uint8_t es = get_field(s, m3);
     uint8_t enr;
     TCGv_i64 t;
 
     switch (es) {
     /* rightmost sub-element of leftmost doubleword */
     case ES_8:
         enr = 7;
         break;
     case ES_16:
         enr = 3;
         break;
     case ES_32:
         enr = 1;
         break;
     case ES_64:
         enr = 0;
         break;
     /* leftmost sub-element of leftmost doubleword */
     case 6:
         if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
             es = ES_32;
             enr = 0;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
     t = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
     gen_gvec_dup_imm(es, get_field(s, v1), 0);
     write_vec_element_i64(t, get_field(s, v1), enr, es);
     return DISAS_NEXT;
 }
-- 
2.39.2


