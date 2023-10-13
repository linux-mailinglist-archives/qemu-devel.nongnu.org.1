Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5197C7F19
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:58:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCww-00062U-A3; Fri, 13 Oct 2023 03:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwY-00059a-DG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwJ-0004fG-NV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so1506926f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183430; x=1697788230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9djH7zQVrJvkiBIZCqCucr8y77ZrMOZdmZV3OhtrmE=;
 b=JnZavVuk60Z5UD/Z9z0MSThEA9sCRW+okidfAHBd31nGCtujJUjo131Fk2lEcQTode
 9GB7Pq/t1ZCWL6HD3grOxXj0wTwnbLMddSeD3D88Ks2Qpc304LtzAU6gvi0QSIq9D6lE
 A1J7LzpsLAQYh/vJcceAeH8X5IkK2flbH4mdxkVJ+Az1YGtT6W3E4rJdQaAHF0hu1csE
 DfbUnKDicsiUTxQbqYIStqzXFtqnlY7XEvf1cXl+F9qoUccV0JQ+l0+yUl3bGFaZJOax
 INd6nbkuJDQEO9W6L60jCqE+c0jECpUAUKzWp71l4g+ZfRqj3ADUV+9QOkPkKuE+NgRy
 VhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183430; x=1697788230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9djH7zQVrJvkiBIZCqCucr8y77ZrMOZdmZV3OhtrmE=;
 b=vULIomnBol+Eb/RnmY2jKBYkCxCx7u8F5Ngjda+NlfeJaNCU3svdJ3LTmIxSL4o1lb
 8c9ZMkj4uLbUI/+qJmaCC9O92u1hjuUrdSRvzIuAQ+t5zdm0OH5xGxqQtw8ZLo39ek/f
 mA/JjBLHeUEEw+x7f1rzY8Kha9Ye+kQjYuZgUm4beoNTewQFRRoe7j9P8D3FHTrjJaLD
 x33NBk6fubX5ZnHjEEn9SlkxMaBRgR45J4HzR8i6pE5jeDr4CMYUpSBXQ9A/IhGIPJD2
 ni1Ke+5z28Q0go+AGnsuo3n5YvfxeS2utEFvywJ07f7I1GkbdlMHmeQP1epSOGlNZfgC
 pbrg==
X-Gm-Message-State: AOJu0YycyCl07ynvpGn758SJhpCLtb2iGfOXQy22X0nPrWgi6OB9ff2o
 akUwtkaSIhgwPHmF/qpZGHq8IDPEvkzHUsQQAdU=
X-Google-Smtp-Source: AGHT+IG4RJycD0uuxLjPMB101cWyf22b1Rua246iMaDJsr4kTkTPqleUFaIjJP+l6pLoqkUaKGXWoQ==
X-Received: by 2002:a5d:440f:0:b0:320:a4e:6b83 with SMTP id
 z15-20020a5d440f000000b003200a4e6b83mr23454720wrq.31.1697183429689; 
 Fri, 13 Oct 2023 00:50:29 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:29 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [RFC PATCH 22/78] target/ppc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:26 +0300
Message-Id: <7572c79bc63f4abc34ca319306dab2c40eadac98.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
 target/ppc/cpu_init.c    |  8 ++++----
 target/ppc/excp_helper.c |  6 +++---
 target/ppc/mmu-radix64.c |  6 +++---
 target/ppc/mmu_common.c  | 12 ++++++------
 target/ppc/translate.c   |  6 +++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a6c2..7a7bd4d824 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -840,84 +840,84 @@ static inline uint32_t register_tlbncfg(uint32_t assoc, uint32_t minsize,
 /* BookE 2.06 storage control registers */
 static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
                              uint32_t *tlbncfg, uint32_t mmucfg)
 {
 #if !defined(CONFIG_USER_ONLY)
     const char *mas_names[8] = {
         "MAS0", "MAS1", "MAS2", "MAS3", "MAS4", "MAS5", "MAS6", "MAS7",
     };
     int mas_sprn[8] = {
         SPR_BOOKE_MAS0, SPR_BOOKE_MAS1, SPR_BOOKE_MAS2, SPR_BOOKE_MAS3,
         SPR_BOOKE_MAS4, SPR_BOOKE_MAS5, SPR_BOOKE_MAS6, SPR_BOOKE_MAS7,
     };
     int i;
 
     /* TLB assist registers */
     for (i = 0; i < 8; i++) {
         if (mas_mask & (1 << i)) {
             spr_register(env, mas_sprn[i], mas_names[i],
                          SPR_NOACCESS, SPR_NOACCESS,
                          &spr_read_generic,
                          (i == 2 && (env->insns_flags & PPC_64B))
                          ? &spr_write_generic : &spr_write_generic32,
                          0x00000000);
         }
     }
     if (env->nb_pids > 1) {
         spr_register(env, SPR_BOOKE_PID1, "PID1",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_booke_pid,
                      0x00000000);
     }
     if (env->nb_pids > 2) {
         spr_register(env, SPR_BOOKE_PID2, "PID2",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_booke_pid,
                      0x00000000);
     }
 
     spr_register(env, SPR_BOOKE_EPLC, "EPLC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_eplc,
                  0x00000000);
     spr_register(env, SPR_BOOKE_EPSC, "EPSC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_epsc,
                  0x00000000);
 
     spr_register(env, SPR_MMUCFG, "MMUCFG",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, SPR_NOACCESS,
                  mmucfg);
     switch (env->nb_ways) {
     case 4:
         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
                      tlbncfg[3]);
-        /* Fallthru */
+        fallthrough;
     case 3:
         spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
                      tlbncfg[2]);
-        /* Fallthru */
+        fallthrough;
     case 2:
         spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
                      tlbncfg[1]);
-        /* Fallthru */
+        fallthrough;
     case 1:
         spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
                      tlbncfg[0]);
-        /* Fallthru */
+        fallthrough;
     case 0:
     default:
         break;
     }
 #endif
 }
 
 /* SPR specific to PowerPC 440 implementation */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7926114d5c..b8be34051c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1311,51 +1311,51 @@ static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
 static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
 
     if (!tcg_enabled()) {
         /*
          * This does not load instructions and set the prefix bit correctly
          * for injected interrupts with KVM. That may have to be discovered
          * and set by the KVM layer before injecting.
          */
         return false;
     }
 
     switch (excp) {
     case POWERPC_EXCP_HDSI:
         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
             (env->error_code == MMU_INST_FETCH)) {
             /*
              * Fetch failed due to partition scope translation, so prefix
              * indication is not relevant (and attempting to load the
              * instruction at NIP would cause recursive faults with the same
              * translation).
              */
             break;
         }
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_MCHECK:
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
     case POWERPC_EXCP_ALIGN:
     case POWERPC_EXCP_PROGRAM:
     case POWERPC_EXCP_FPU:
     case POWERPC_EXCP_TRACE:
     case POWERPC_EXCP_HV_EMU:
     case POWERPC_EXCP_VPU:
     case POWERPC_EXCP_VSXU:
     case POWERPC_EXCP_FU:
     case POWERPC_EXCP_HV_FU: {
         uint32_t insn = ppc_ldl_code(env, env->nip);
         if (is_prefix_insn(env, insn)) {
             return true;
         }
         break;
     }
     default:
         break;
     }
     return false;
 }
 #else
@@ -1368,324 +1368,324 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
 
     /*
      * new interrupt handler msr preserves existing HV and ME unless
      * explicitly overridden
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
 
     /* target registers */
     srr0 = SPR_SRR0;
     srr1 = SPR_SRR1;
 
     /*
      * check for special resume at 0x100 from doze/nap/sleep/winkle on
      * P7/P8/P9
      */
     if (env->resume_as_sreset) {
         excp = powerpc_reset_wakeup(env, excp, &msr);
     }
 
     /*
      * We don't want to generate a Hypervisor Emulation Assistance
      * Interrupt if we don't have HVB in msr_mask (PAPR mode),
      * unless running a nested-hv guest, in which case the L1
      * kernel wants the interrupt.
      */
     if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB) &&
             !books_vhyp_handles_hv_excp(cpu)) {
         excp = POWERPC_EXCP_PROGRAM;
     }
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
         cpu_abort(cs, "Raised an exception without defined vector %d\n",
                   excp);
     }
 
     vector |= env->excp_prefix;
 
     if (is_prefix_insn_excp(cpu, excp)) {
         msr |= PPC_BIT(34);
     }
 
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         powerpc_mcheck_checkstop(env);
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
              * clear (e.g., see FWNMI in PAPR).
              */
             new_msr |= (target_ulong)MSR_HVB;
         }
 
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
         msr |= env->error_code;
         break;
 
     case POWERPC_EXCP_DSI:       /* Data storage exception                   */
         trace_ppc_excp_dsi(env->spr[SPR_DSISR], env->spr[SPR_DAR]);
         break;
     case POWERPC_EXCP_ISI:       /* Instruction storage exception            */
         trace_ppc_excp_isi(msr, env->nip);
         msr |= env->error_code;
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
     {
         bool lpes0;
 
         /*
          * LPES0 is only taken into consideration if we support HV
          * mode for this CPU.
          */
         if (!env->has_hv_mode) {
             break;
         }
 
         lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
 
         if (!lpes0) {
             new_msr |= (target_ulong)MSR_HVB;
             new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
             srr0 = SPR_HSRR0;
             srr1 = SPR_HSRR1;
         }
 
         break;
     }
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
         /* Optional DSISR update was removed from ISA v3.0 */
         if (!(env->insns_flags2 & PPC2_ISA300)) {
             /* Get rS/rD and rA from faulting opcode */
             /*
              * Note: the opcode fields will not be set properly for a
              * direct store load/store, but nobody cares as nobody
              * actually uses direct store segments.
              */
             env->spr[SPR_DSISR] |= (env->error_code & 0x03FF0000) >> 16;
         }
         break;
     case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
         switch (env->error_code & ~0xF) {
         case POWERPC_EXCP_FP:
             if (!FIELD_EX64_FE(env->msr) || !FIELD_EX64(env->msr, MSR, FP)) {
                 trace_ppc_excp_fp_ignore();
                 powerpc_reset_excp_state(cpu);
                 return;
             }
 
             /*
              * FP exceptions always have NIP pointing to the faulting
              * instruction, so always use store_next and claim we are
              * precise in the MSR.
              */
             msr |= 0x00100000;
             break;
         case POWERPC_EXCP_INVAL:
             trace_ppc_excp_inval(env->nip);
             msr |= 0x00080000;
             break;
         case POWERPC_EXCP_PRIV:
             msr |= 0x00040000;
             break;
         case POWERPC_EXCP_TRAP:
             msr |= 0x00020000;
             break;
         default:
             /* Should never occur */
             cpu_abort(cs, "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         lev = env->error_code;
 
         if (lev == 1 && cpu->vhyp) {
             dump_hcall(env);
         } else {
             dump_syscall(env);
         }
 
         /*
          * We need to correct the NIP which in this case is supposed
          * to point to the next instruction
          */
         env->nip += 4;
 
         /* "PAPR mode" built-in hypercall emulation */
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
         if (env->insns_flags2 & PPC2_ISA310) {
             /* ISAv3.1 puts LEV into SRR1 */
             msr |= lev << 20;
         }
         if (lev == 1) {
             new_msr |= (target_ulong)MSR_HVB;
         }
         break;
     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
         lev = env->error_code;
         dump_syscall(env);
         env->nip += 4;
         new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
 
         vector += lev * 0x20;
 
         env->lr = env->nip;
         env->ctr = msr;
         break;
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
     case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         /* A power-saving exception sets ME, otherwise it is unchanged */
         if (FIELD_EX64(env->msr, MSR, POW)) {
             /* indicate that we resumed from power save mode */
             msr |= 0x10000;
             new_msr |= ((target_ulong)1 << MSR_ME);
         }
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
              * clear (e.g., see FWNMI in PAPR, NMI injection in QEMU).
              */
             new_msr |= (target_ulong)MSR_HVB;
         } else {
             if (FIELD_EX64(env->msr, MSR, POW)) {
                 cpu_abort(cs, "Trying to deliver power-saving system reset "
                           "exception %d with no HV support\n", excp);
             }
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
         msr |= env->error_code;
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
     case POWERPC_EXCP_PERFM:     /* Performance monitor interrupt            */
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception         */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception        */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt            */
     case POWERPC_EXCP_HVIRT:     /* Hypervisor virtualization                */
         srr0 = SPR_HSRR0;
         srr1 = SPR_HSRR1;
         new_msr |= (target_ulong)MSR_HVB;
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
         break;
 #ifdef CONFIG_TCG
     case POWERPC_EXCP_HV_EMU: {
         uint32_t insn = ppc_ldl_code(env, env->nip);
         env->spr[SPR_HEIR] = insn;
         if (is_prefix_insn(env, insn)) {
             uint32_t insn2 = ppc_ldl_code(env, env->nip + 4);
             env->spr[SPR_HEIR] <<= 32;
             env->spr[SPR_HEIR] |= insn2;
         }
         srr0 = SPR_HSRR0;
         srr1 = SPR_HSRR1;
         new_msr |= (target_ulong)MSR_HVB;
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
         break;
     }
 #endif
     case POWERPC_EXCP_VPU:       /* Vector unavailable exception             */
     case POWERPC_EXCP_VSXU:       /* VSX unavailable exception               */
     case POWERPC_EXCP_FU:         /* Facility unavailable exception          */
         env->spr[SPR_FSCR] |= ((target_ulong)env->error_code << 56);
         break;
     case POWERPC_EXCP_HV_FU:     /* Hypervisor Facility Unavailable Exception */
         env->spr[SPR_HFSCR] |= ((target_ulong)env->error_code << FSCR_IC_POS);
         srr0 = SPR_HSRR0;
         srr1 = SPR_HSRR1;
         new_msr |= (target_ulong)MSR_HVB;
         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
         break;
     case POWERPC_EXCP_PERFM_EBB:        /* Performance Monitor EBB Exception  */
     case POWERPC_EXCP_EXTERNAL_EBB:     /* External EBB Exception             */
         env->spr[SPR_BESCR] &= ~BESCR_GE;
 
         /*
          * Save NIP for rfebb insn in SPR_EBBRR. Next nip is
          * stored in the EBB Handler SPR_EBBHR.
          */
         env->spr[SPR_EBBRR] = env->nip;
         powerpc_set_excp_state(cpu, env->spr[SPR_EBBHR], env->msr);
 
         /*
          * This exception is handled in userspace. No need to proceed.
          */
         return;
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
         cpu_abort(cs, "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
         cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
         break;
     }
 
     /*
      * Sort out endianness of interrupt, this differs depending on the
      * CPU, the HV mode, etc...
      */
     if (ppc_interrupts_little_endian(cpu, !!(new_msr & MSR_HVB))) {
         new_msr |= (target_ulong)1 << MSR_LE;
     }
 
     new_msr |= (target_ulong)1 << MSR_SF;
 
     if (excp != POWERPC_EXCP_SYSCALL_VECTORED) {
         /* Save PC */
         env->spr[srr0] = env->nip;
 
         /* Save MSR */
         env->spr[srr1] = msr;
     }
 
     if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
         PPCVirtualHypervisorClass *vhc =
             PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
         vhc->deliver_hv_excp(cpu, excp);
 
         powerpc_reset_excp_state(cpu);
 
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
             cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
                       "no HV support\n", excp);
         }
 
         /* This can update new_msr and vector if AIL applies */
         ppc_excp_apply_ail(cpu, excp, msr, &new_msr, &vector);
 
         powerpc_set_excp_state(cpu, vector, new_msr);
     }
 }
 #else
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5823e039e6..a85bd614bf 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -111,30 +111,30 @@ static inline const char *access_str(MMUAccessType access_type)
 static void ppc_radix64_raise_si(PowerPCCPU *cpu, MMUAccessType access_type,
                                  vaddr eaddr, uint32_t cause)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx" cause %08x\n",
                   __func__, access_str(access_type),
                   eaddr, cause);
 
     switch (access_type) {
     case MMU_INST_FETCH:
         /* Instruction Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_ISI;
         env->error_code = cause;
         break;
     case MMU_DATA_STORE:
         cause |= DSISR_ISSTORE;
-        /* fall through */
+        fallthrough;
     case MMU_DATA_LOAD:
         /* Data Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_DSI;
         env->spr[SPR_DSISR] = cause;
         env->spr[SPR_DAR] = eaddr;
         env->error_code = 0;
         break;
     default:
         g_assert_not_reached();
     }
 }
@@ -142,39 +142,39 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, MMUAccessType access_type,
 static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, MMUAccessType access_type,
                                   vaddr eaddr, hwaddr g_raddr, uint32_t cause)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     env->error_code = 0;
     if (cause & DSISR_PRTABLE_FAULT) {
         /* HDSI PRTABLE_FAULT gets the originating access type in error_code */
         env->error_code = access_type;
         access_type = MMU_DATA_LOAD;
     }
 
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx" 0x%"
                   HWADDR_PRIx" cause %08x\n",
                   __func__, access_str(access_type),
                   eaddr, g_raddr, cause);
 
     switch (access_type) {
     case MMU_INST_FETCH:
         /* H Instruction Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_HISI;
         env->spr[SPR_ASDR] = g_raddr;
         env->error_code = cause;
         break;
     case MMU_DATA_STORE:
         cause |= DSISR_ISSTORE;
-        /* fall through */
+        fallthrough;
     case MMU_DATA_LOAD:
         /* H Data Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_HDSI;
         env->spr[SPR_HDSISR] = cause;
         env->spr[SPR_HDAR] = eaddr;
         env->spr[SPR_ASDR] = g_raddr;
         break;
     default:
         g_assert_not_reached();
     }
 }
@@ -222,20 +222,20 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
 static int ppc_radix64_check_rc(MMUAccessType access_type, uint64_t pte)
 {
     switch (access_type) {
     case MMU_DATA_STORE:
         if (!(pte & R_PTE_C)) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
         if (!(pte & R_PTE_R)) {
             break;
         }
 
         /* R/C bits are already set appropriately for this access */
         return 0;
     }
 
     return 1;
 }
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6ca5d12207..dd44befe6f 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -67,37 +67,37 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 static int pp_check(int key, int pp, int nx)
 {
     int access;
 
     /* Compute access rights */
     access = 0;
     if (key == 0) {
         switch (pp) {
         case 0x0:
         case 0x1:
         case 0x2:
             access |= PAGE_WRITE;
-            /* fall through */
+            fallthrough;
         case 0x3:
             access |= PAGE_READ;
             break;
         }
     } else {
         switch (pp) {
         case 0x0:
             access = 0;
             break;
         case 0x1:
         case 0x3:
             access = PAGE_READ;
             break;
         case 0x2:
             access = PAGE_READ | PAGE_WRITE;
             break;
         }
     }
     if (nx == 0) {
         access |= PAGE_EXEC;
     }
 
     return access;
 }
@@ -534,68 +534,68 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
 static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                                        target_ulong address,
                                        MMUAccessType access_type)
 {
     ppcemb_tlb_t *tlb;
     hwaddr raddr;
     int i, ret, zsel, zpr, pr;
 
     ret = -1;
     raddr = (hwaddr)-1ULL;
     pr = FIELD_EX64(env->msr, MSR, PR);
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         if (!ppcemb_tlb_check(env, tlb, &raddr, address,
                               env->spr[SPR_40x_PID], i)) {
             continue;
         }
         zsel = (tlb->attr >> 4) & 0xF;
         zpr = (env->spr[SPR_40x_ZPR] >> (30 - (2 * zsel))) & 0x3;
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: TLB %d zsel %d zpr %d ty %d attr %08x\n",
                       __func__, i, zsel, zpr, access_type, tlb->attr);
         /* Check execute enable bit */
         switch (zpr) {
         case 0x2:
             if (pr != 0) {
                 goto check_perms;
             }
-            /* fall through */
+            fallthrough;
         case 0x3:
             /* All accesses granted */
             ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             ret = 0;
             break;
         case 0x0:
             if (pr != 0) {
                 /* Raise Zone protection fault.  */
                 env->spr[SPR_40x_ESR] = 1 << 22;
                 ctx->prot = 0;
                 ret = -2;
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0x1:
         check_perms:
             /* Check from TLB entry */
             ctx->prot = tlb->prot;
             ret = check_prot(ctx->prot, access_type);
             if (ret == -2) {
                 env->spr[SPR_40x_ESR] = 0;
             }
             break;
         }
         if (ret >= 0) {
             ctx->raddr = raddr;
             qemu_log_mask(CPU_LOG_MMU, "%s: access granted " TARGET_FMT_lx
                           " => " HWADDR_FMT_plx
                           " %d %d\n", __func__, address, ctx->raddr, ctx->prot,
                           ret);
             return 0;
         }
     }
      qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
                    " => " HWADDR_FMT_plx
                    " %d %d\n", __func__, address, raddr, ctx->prot, ret);
 
     return ret;
 }
@@ -1299,222 +1299,222 @@ static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                             MMUAccessType access_type,
                             hwaddr *raddrp, int *psizep, int *protp,
                             int mmu_idx, bool guest_visible)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     mmu_ctx_t ctx;
     int type;
     int ret;
 
     if (access_type == MMU_INST_FETCH) {
         /* code access */
         type = ACCESS_CODE;
     } else if (guest_visible) {
         /* data access */
         type = env->access_type;
     } else {
         type = ACCESS_INT;
     }
 
     ret = get_physical_address_wtlb(env, &ctx, eaddr, access_type,
                                     type, mmu_idx);
     if (ret == 0) {
         *raddrp = ctx.raddr;
         *protp = ctx.prot;
         *psizep = TARGET_PAGE_BITS;
         return true;
     }
 
     if (guest_visible) {
         log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
         if (type == ACCESS_CODE) {
             switch (ret) {
             case -1:
                 /* No matches in page tables or TLB */
                 switch (env->mmu_model) {
                 case POWERPC_MMU_SOFT_6xx:
                     cs->exception_index = POWERPC_EXCP_IFTLB;
                     env->error_code = 1 << 18;
                     env->spr[SPR_IMISS] = eaddr;
                     env->spr[SPR_ICMP] = 0x80000000 | ctx.ptem;
                     goto tlb_miss;
                 case POWERPC_MMU_SOFT_4xx:
                     cs->exception_index = POWERPC_EXCP_ITLB;
                     env->error_code = 0;
                     env->spr[SPR_40x_DEAR] = eaddr;
                     env->spr[SPR_40x_ESR] = 0x00000000;
                     break;
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
-                    /* fall through */
+                    fallthrough;
                 case POWERPC_MMU_BOOKE:
                     cs->exception_index = POWERPC_EXCP_ITLB;
                     env->error_code = 0;
                     env->spr[SPR_BOOKE_DEAR] = eaddr;
                     env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
                     break;
                 case POWERPC_MMU_MPC8xx:
                     cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_REAL:
                     cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
                 default:
                     cpu_abort(cs, "Unknown or invalid MMU model\n");
                 }
                 break;
             case -2:
                 /* Access rights violation */
                 cs->exception_index = POWERPC_EXCP_ISI;
                 if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
                     (env->mmu_model == POWERPC_MMU_BOOKE206)) {
                     env->error_code = 0;
                 } else {
                     env->error_code = 0x08000000;
                 }
                 break;
             case -3:
                 /* No execute protection violation */
                 if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
                     (env->mmu_model == POWERPC_MMU_BOOKE206)) {
                     env->spr[SPR_BOOKE_ESR] = 0x00000000;
                     env->error_code = 0;
                 } else {
                     env->error_code = 0x10000000;
                 }
                 cs->exception_index = POWERPC_EXCP_ISI;
                 break;
             case -4:
                 /* Direct store exception */
                 /* No code fetch is allowed in direct-store areas */
                 cs->exception_index = POWERPC_EXCP_ISI;
                 if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
                     (env->mmu_model == POWERPC_MMU_BOOKE206)) {
                     env->error_code = 0;
                 } else {
                     env->error_code = 0x10000000;
                 }
                 break;
             }
         } else {
             switch (ret) {
             case -1:
                 /* No matches in page tables or TLB */
                 switch (env->mmu_model) {
                 case POWERPC_MMU_SOFT_6xx:
                     if (access_type == MMU_DATA_STORE) {
                         cs->exception_index = POWERPC_EXCP_DSTLB;
                         env->error_code = 1 << 16;
                     } else {
                         cs->exception_index = POWERPC_EXCP_DLTLB;
                         env->error_code = 0;
                     }
                     env->spr[SPR_DMISS] = eaddr;
                     env->spr[SPR_DCMP] = 0x80000000 | ctx.ptem;
                 tlb_miss:
                     env->error_code |= ctx.key << 19;
                     env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
                         get_pteg_offset32(cpu, ctx.hash[0]);
                     env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
                         get_pteg_offset32(cpu, ctx.hash[1]);
                     break;
                 case POWERPC_MMU_SOFT_4xx:
                     cs->exception_index = POWERPC_EXCP_DTLB;
                     env->error_code = 0;
                     env->spr[SPR_40x_DEAR] = eaddr;
                     if (access_type == MMU_DATA_STORE) {
                         env->spr[SPR_40x_ESR] = 0x00800000;
                     } else {
                         env->spr[SPR_40x_ESR] = 0x00000000;
                     }
                     break;
                 case POWERPC_MMU_MPC8xx:
                     /* XXX: TODO */
                     cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                    /* fall through */
+                    fallthrough;
                 case POWERPC_MMU_BOOKE:
                     cs->exception_index = POWERPC_EXCP_DTLB;
                     env->error_code = 0;
                     env->spr[SPR_BOOKE_DEAR] = eaddr;
                     env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
                     break;
                 case POWERPC_MMU_REAL:
                     cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
                 default:
                     cpu_abort(cs, "Unknown or invalid MMU model\n");
                 }
                 break;
             case -2:
                 /* Access rights violation */
                 cs->exception_index = POWERPC_EXCP_DSI;
                 env->error_code = 0;
                 if (env->mmu_model == POWERPC_MMU_SOFT_4xx) {
                     env->spr[SPR_40x_DEAR] = eaddr;
                     if (access_type == MMU_DATA_STORE) {
                         env->spr[SPR_40x_ESR] |= 0x00800000;
                     }
                 } else if ((env->mmu_model == POWERPC_MMU_BOOKE) ||
                            (env->mmu_model == POWERPC_MMU_BOOKE206)) {
                     env->spr[SPR_BOOKE_DEAR] = eaddr;
                     env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
                 } else {
                     env->spr[SPR_DAR] = eaddr;
                     if (access_type == MMU_DATA_STORE) {
                         env->spr[SPR_DSISR] = 0x0A000000;
                     } else {
                         env->spr[SPR_DSISR] = 0x08000000;
                     }
                 }
                 break;
             case -4:
                 /* Direct store exception */
                 switch (type) {
                 case ACCESS_FLOAT:
                     /* Floating point load/store */
                     cs->exception_index = POWERPC_EXCP_ALIGN;
                     env->error_code = POWERPC_EXCP_ALIGN_FP;
                     env->spr[SPR_DAR] = eaddr;
                     break;
                 case ACCESS_RES:
                     /* lwarx, ldarx or stwcx. */
                     cs->exception_index = POWERPC_EXCP_DSI;
                     env->error_code = 0;
                     env->spr[SPR_DAR] = eaddr;
                     if (access_type == MMU_DATA_STORE) {
                         env->spr[SPR_DSISR] = 0x06000000;
                     } else {
                         env->spr[SPR_DSISR] = 0x04000000;
                     }
                     break;
                 case ACCESS_EXT:
                     /* eciwx or ecowx */
                     cs->exception_index = POWERPC_EXCP_DSI;
                     env->error_code = 0;
                     env->spr[SPR_DAR] = eaddr;
                     if (access_type == MMU_DATA_STORE) {
                         env->spr[SPR_DSISR] = 0x06100000;
                     } else {
                         env->spr[SPR_DSISR] = 0x04100000;
                     }
                     break;
                 default:
                     printf("DSI: invalid exception (%d)\n", ret);
                     cs->exception_index = POWERPC_EXCP_PROGRAM;
                     env->error_code =
                         POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL;
                     env->spr[SPR_DAR] = eaddr;
                     break;
                 }
                 break;
             }
         }
     }
     return false;
 }
 
 /*****************************************************************************/
@@ -1522,29 +1522,29 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible)
 {
     switch (cpu->env.mmu_model) {
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_3_00:
         if (ppc64_v3_radix(cpu)) {
             return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
                                      psizep, protp, mmu_idx, guest_visible);
         }
-        /* fall through */
+        fallthrough;
     case POWERPC_MMU_64B:
     case POWERPC_MMU_2_03:
     case POWERPC_MMU_2_06:
     case POWERPC_MMU_2_07:
         return ppc_hash64_xlate(cpu, eaddr, access_type,
                                 raddrp, psizep, protp, mmu_idx, guest_visible);
 #endif
 
     case POWERPC_MMU_32B:
         return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
 
     default:
         return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
     }
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..a67b77258d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7427,76 +7427,76 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = ctx->base.is_jmp;
     target_ulong nip = ctx->base.pc_next;
 
     if (is_jmp == DISAS_NORETURN) {
         /* We have already exited the TB. */
         return;
     }
 
     /* Honor single stepping. */
     if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
         bool rfi_type = false;
 
         switch (is_jmp) {
         case DISAS_TOO_MANY:
         case DISAS_EXIT_UPDATE:
         case DISAS_CHAIN_UPDATE:
             gen_update_nip(ctx, nip);
             break;
         case DISAS_EXIT:
         case DISAS_CHAIN:
             /*
              * This is a heuristic, to put it kindly. The rfi class of
              * instructions are among the few outside branches that change
              * NIP without taking an interrupt. Single step trace interrupts
              * do not fire on completion of these instructions.
              */
             rfi_type = true;
             break;
         default:
             g_assert_not_reached();
         }
 
         gen_debug_exception(ctx, rfi_type);
         return;
     }
 
     switch (is_jmp) {
     case DISAS_TOO_MANY:
         if (use_goto_tb(ctx, nip)) {
             pmu_count_insns(ctx);
             tcg_gen_goto_tb(0);
             gen_update_nip(ctx, nip);
             tcg_gen_exit_tb(ctx->base.tb, 0);
             break;
         }
-        /* fall through */
+        fallthrough;
     case DISAS_CHAIN_UPDATE:
         gen_update_nip(ctx, nip);
-        /* fall through */
+        fallthrough;
     case DISAS_CHAIN:
         /*
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
         if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
         tcg_gen_lookup_and_goto_ptr();
         break;
 
     case DISAS_EXIT_UPDATE:
         gen_update_nip(ctx, nip);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         pmu_count_insns(ctx);
         tcg_gen_exit_tb(NULL, 0);
         break;
 
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


