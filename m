Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF18E7C810F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqK-0008OJ-Jy; Fri, 13 Oct 2023 04:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpu-0007hQ-BP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpr-0000qj-Mm
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40651a72807so19205215e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186871; x=1697791671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgxzBXysdiFUH0+B6WaKZdRAnzqSxH9o8jyo5jzNLXA=;
 b=kohlll1Ktejyr0VPahJ0Kd5yq0kpfnuipFUsdz04D4e+lE5a1pZOO969D/AchJR27m
 bFoqQvUZxdV7NHnxr4B1OfeTZAzO+V0XFVW2pftTp760aKRarQJTcbl1GQ5EKDrCvxeJ
 huSdgwT1dIgClY0hQieT6I8eZM2Ay4eTOeBRl7rDSc2ALN2uPFkLUwtJVLZVc8UjO0Yt
 z0l6THMmTuGNBPHys1VrQBWeDNMapSSODZzlg075qHRIsu/9X5Q7yOxZlO4sb6Lb4Nkc
 E+f+LuWWhhpeXAsKf2VNUbTPjMiFSDBvDL/Z7kEOQqHJnF34VnBVnfWquZQDgja6rKtX
 KBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186871; x=1697791671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgxzBXysdiFUH0+B6WaKZdRAnzqSxH9o8jyo5jzNLXA=;
 b=ht4ZUHQ6ytMvw1co3E6tqHVMGyfKbd3B/L/HUH4iHrL5PJwZQcmlqeaEchUuXmdSWx
 rdzwSAFSbAREceTgitZoi0dv2+OOpB8HakKldhbgvQmYuz5hG2YiL7xn/iZRJOuQYgJR
 21R/RfGvvpqk50soEtjOB/MULWeZeT/r2+SVo+v/qy+lkzsrzHJCMPOAXw3DSNMVJiaX
 T/wPWY+HmunXFlCG1SBQjs5yua8DoJHmkjr3kUjp0+3cO+sw9/9MffMwzNG+y1Uq4AFA
 SmvRXkRKFxE2MwudKkjVpb/HMP9SXHtyIYeU1geCEMGrgAYNATOTTCH7w0STws++DHT/
 DpVA==
X-Gm-Message-State: AOJu0YyINuRa6Bc5zpMczu5NuYgkRQc1MS1IEhK8dW+9pcFyBeXHGO9X
 gzK/D4wodW2HfHu3EqhrdBc2pl5OiKCtbYUsHgI=
X-Google-Smtp-Source: AGHT+IFO5r4sq3Pmjy2ujNe4pJYgttpBHf+80dPmnGmxeOfc1ALrYv4jkKc+CUWdhd1mQrIA3pew6Q==
X-Received: by 2002:adf:fcd2:0:b0:32d:8505:b9d7 with SMTP id
 f18-20020adffcd2000000b0032d8505b9d7mr6313598wrs.43.1697186871558; 
 Fri, 13 Oct 2023 01:47:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [RFC PATCH v3 22/78] target/ppc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:50 +0300
Message-Id: <ec0bed62e8c8d398843f754c018e2ab419e58350.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
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
@@ -894,25 +894,25 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
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
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7926114d5c..b8be34051c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1334,7 +1334,7 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
              */
             break;
         }
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_MCHECK:
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
@@ -1576,7 +1576,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
         msr |= env->error_code;
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_DSEG:      /* Data segment exception                   */
     case POWERPC_EXCP_ISEG:      /* Instruction segment exception            */
     case POWERPC_EXCP_SDOOR:     /* Doorbell interrupt                       */
@@ -1584,7 +1584,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exception */
         msr |= env->error_code;
-        /* fall through */
+        fallthrough;
     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception         */
     case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception        */
     case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt            */
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5823e039e6..a85bd614bf 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -126,7 +126,7 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, MMUAccessType access_type,
         break;
     case MMU_DATA_STORE:
         cause |= DSISR_ISSTORE;
-        /* fall through */
+        fallthrough;
     case MMU_DATA_LOAD:
         /* Data Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_DSI;
@@ -166,7 +166,7 @@ static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, MMUAccessType access_type,
         break;
     case MMU_DATA_STORE:
         cause |= DSISR_ISSTORE;
-        /* fall through */
+        fallthrough;
     case MMU_DATA_LOAD:
         /* H Data Storage Interrupt */
         cs->exception_index = POWERPC_EXCP_HDSI;
@@ -226,7 +226,7 @@ static int ppc_radix64_check_rc(MMUAccessType access_type, uint64_t pte)
         if (!(pte & R_PTE_C)) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
         if (!(pte & R_PTE_R)) {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6ca5d12207..dd44befe6f 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -76,7 +76,7 @@ static int pp_check(int key, int pp, int nx)
         case 0x1:
         case 0x2:
             access |= PAGE_WRITE;
-            /* fall through */
+            fallthrough;
         case 0x3:
             access |= PAGE_READ;
             break;
@@ -559,7 +559,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             if (pr != 0) {
                 goto check_perms;
             }
-            /* fall through */
+            fallthrough;
         case 0x3:
             /* All accesses granted */
             ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -573,7 +573,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                 ret = -2;
                 break;
             }
-            /* fall through */
+            fallthrough;
         case 0x1:
         check_perms:
             /* Check from TLB entry */
@@ -1349,7 +1349,7 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     break;
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
-                    /* fall through */
+                    fallthrough;
                 case POWERPC_MMU_BOOKE:
                     cs->exception_index = POWERPC_EXCP_ITLB;
                     env->error_code = 0;
@@ -1435,7 +1435,7 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
-                    /* fall through */
+                    fallthrough;
                 case POWERPC_MMU_BOOKE:
                     cs->exception_index = POWERPC_EXCP_DTLB;
                     env->error_code = 0;
@@ -1530,7 +1530,7 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
                                      psizep, protp, mmu_idx, guest_visible);
         }
-        /* fall through */
+        fallthrough;
     case POWERPC_MMU_64B:
     case POWERPC_MMU_2_03:
     case POWERPC_MMU_2_06:
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..a67b77258d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7472,10 +7472,10 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
@@ -7490,7 +7490,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     case DISAS_EXIT_UPDATE:
         gen_update_nip(ctx, nip);
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         pmu_count_insns(ctx);
         tcg_gen_exit_tb(NULL, 0);
-- 
2.39.2


