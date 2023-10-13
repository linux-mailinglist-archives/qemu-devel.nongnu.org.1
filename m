Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC397C8000
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4e-0001W0-OS; Fri, 13 Oct 2023 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4G-0000oT-JQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD48-0006st-C6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-406618d080eso19283275e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183915; x=1697788715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWjJCyJvjNsFpQShtsIY71lI6GpCk63I5QIoGb8T8cM=;
 b=pmmYXQ+sbhlP3BypTLO9VEIr3RK6Ej5na7SnX2HcJ8UQ/b1s26LV8qg9SymTsb5UKh
 zQ/2XMbGej03EY02xMbCFbS8Sl3Ul5xTyi2T237dx8/Ns/b0lIK3tvbm8VM9XvBRm2bC
 iWUs/TeoA6Q+qsf8Rtwnt68zczJ8iwBj7r0Nc8uiwZYvog8t+DLzWputEju6AG7y9zNE
 mkPcqdSqzROblOrAv3lJ5Z/3np7JfudGmUbhBPvcrrBRMXPZd0aXBY0d2E0ayBcH3XpU
 SyFGWBIpw07hC/J4n60aFfy8IqTQXiNmCsIdX6w2iDt3uiJ3ZRn9VBUn+JkSYbOtndAE
 1/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183915; x=1697788715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWjJCyJvjNsFpQShtsIY71lI6GpCk63I5QIoGb8T8cM=;
 b=Wm46+G8x09kx8zDphTyZwLi68i1O8deA5MHcSkuaPSw22CGwq7x0uQgsNjxFPvGX+4
 aHqOOB0G2MSHWiV7fF7la15pL8oSmFe8PW/IFbwv+kjjFk1ktsu3rPnDN9UbmJ5xVv0j
 ZPtJGK0uX/lUxuFXZ2/p+onmV8Ivekt0EcCoq1DCSPB2R+M9crdad2KjtingGYxVW1ly
 f+JwSrT4Zhp60Axi0Y4F9GfHXlojIc8FQhpS42YOalSMisU/iNTohkvU+SzUuJ1lFXW8
 5zeoDgx3VvcqB8NlA2aRpmcHwmHP85jOU7VZ6EtJmPgS/jnMdmfo5+0730p79jCHgZtm
 gV4g==
X-Gm-Message-State: AOJu0YxfSDYKUNUCvlX4EbOfGw8oDQXD0nGhfLm7bXUZ+0NCtCuakIj8
 HI88zOtoz/w3TFt6hK/K5wr1uJDW0B0lEp5IYEI=
X-Google-Smtp-Source: AGHT+IFSpmoj7nRBci/utdfPEiUl/a22l17mZNrPgQBzIXLlZO5MFnv74TS8Zq/xCpn57edxW4NgJA==
X-Received: by 2002:a05:600c:220b:b0:406:4242:e7df with SMTP id
 z11-20020a05600c220b00b004064242e7dfmr23836731wml.35.1697183914394; 
 Fri, 13 Oct 2023 00:58:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:33 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v2 21/78] target/sparc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:48 +0300
Message-Id: <3eae7d9bab03b7f50f60bba2fb44614cf32e0f22.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
 target/sparc/ldst_helper.c | 4 ++--
 target/sparc/mmu_helper.c  | 6 +++---
 target/sparc/translate.c   | 3 ++-
 target/sparc/win_helper.c  | 1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 78b03308ae..b233e40da5 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1296,294 +1296,294 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
                        int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
     int sign = memop & MO_SIGN;
     CPUState *cs = env_cpu(env);
     uint64_t ret = 0;
 #if defined(DEBUG_ASI)
     target_ulong last_addr = addr;
 #endif
 
     asi &= 0xff;
 
     do_check_asi(env, asi, GETPC());
     do_check_align(env, addr, size - 1, GETPC());
     addr = asi_address_mask(env, asi, addr);
 
     switch (asi) {
     case ASI_PNF:
     case ASI_PNFL:
     case ASI_SNF:
     case ASI_SNFL:
         {
             MemOpIdx oi;
             int idx = (env->pstate & PS_PRIV
                        ? (asi & 1 ? MMU_KERNEL_SECONDARY_IDX : MMU_KERNEL_IDX)
                        : (asi & 1 ? MMU_USER_SECONDARY_IDX : MMU_USER_IDX));
 
             if (cpu_get_phys_page_nofault(env, addr, idx) == -1ULL) {
 #ifdef DEBUG_ASI
                 dump_asi("read ", last_addr, asi, size, ret);
 #endif
                 /* exception_index is set in get_physical_address_data. */
                 cpu_raise_exception_ra(env, cs->exception_index, GETPC());
             }
             oi = make_memop_idx(memop, idx);
             switch (size) {
             case 1:
                 ret = cpu_ldb_mmu(env, addr, oi, GETPC());
                 break;
             case 2:
                 ret = cpu_ldw_mmu(env, addr, oi, GETPC());
                 break;
             case 4:
                 ret = cpu_ldl_mmu(env, addr, oi, GETPC());
                 break;
             case 8:
                 ret = cpu_ldq_mmu(env, addr, oi, GETPC());
                 break;
             default:
                 g_assert_not_reached();
             }
         }
         break;
 
     case ASI_AIUP:  /* As if user primary */
     case ASI_AIUS:  /* As if user secondary */
     case ASI_AIUPL: /* As if user primary LE */
     case ASI_AIUSL: /* As if user secondary LE */
     case ASI_P:  /* Primary */
     case ASI_S:  /* Secondary */
     case ASI_PL: /* Primary LE */
     case ASI_SL: /* Secondary LE */
     case ASI_REAL:      /* Bypass */
     case ASI_REAL_IO:   /* Bypass, non-cacheable */
     case ASI_REAL_L:    /* Bypass LE */
     case ASI_REAL_IO_L: /* Bypass, non-cacheable LE */
     case ASI_N:  /* Nucleus */
     case ASI_NL: /* Nucleus Little Endian (LE) */
     case ASI_NUCLEUS_QUAD_LDD:   /* Nucleus quad LDD 128 bit atomic */
     case ASI_NUCLEUS_QUAD_LDD_L: /* Nucleus quad LDD 128 bit atomic LE */
     case ASI_TWINX_AIUP:   /* As if user primary, twinx */
     case ASI_TWINX_AIUS:   /* As if user secondary, twinx */
     case ASI_TWINX_REAL:   /* Real address, twinx */
     case ASI_TWINX_AIUP_L: /* As if user primary, twinx, LE */
     case ASI_TWINX_AIUS_L: /* As if user secondary, twinx, LE */
     case ASI_TWINX_REAL_L: /* Real address, twinx, LE */
     case ASI_TWINX_N:  /* Nucleus, twinx */
     case ASI_TWINX_NL: /* Nucleus, twinx, LE */
     /* ??? From the UA2011 document; overlaps BLK_INIT_QUAD_LDD_* */
     case ASI_TWINX_P:  /* Primary, twinx */
     case ASI_TWINX_PL: /* Primary, twinx, LE */
     case ASI_TWINX_S:  /* Secondary, twinx */
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
         /* These are always handled inline.  */
         g_assert_not_reached();
 
     case ASI_UPA_CONFIG: /* UPA config */
         /* XXX */
         break;
     case ASI_LSU_CONTROL: /* LSU */
         ret = env->lsu;
         break;
     case ASI_IMMU: /* I-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
             switch (reg) {
             case 0:
                 /* 0x00 I-TSB Tag Target register */
                 ret = ultrasparc_tag_target(env->immu.tag_access);
                 break;
             case 3: /* SFSR */
                 ret = env->immu.sfsr;
                 break;
             case 5: /* TSB access */
                 ret = env->immu.tsb;
                 break;
             case 6:
                 /* 0x30 I-TSB Tag Access register */
                 ret = env->immu.tag_access;
                 break;
             default:
                 sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
                 ret = 0;
             }
             break;
         }
     case ASI_IMMU_TSB_8KB_PTR: /* I-MMU 8k TSB pointer */
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
             ret = ultrasparc_tsb_pointer(env, &env->immu, 0);
             break;
         }
     case ASI_IMMU_TSB_64KB_PTR: /* I-MMU 64k TSB pointer */
         {
             /* env->immuregs[5] holds I-MMU TSB register value
                env->immuregs[6] holds I-MMU Tag Access register value */
             ret = ultrasparc_tsb_pointer(env, &env->immu, 1);
             break;
         }
     case ASI_ITLB_DATA_ACCESS: /* I-MMU data access */
         {
             int reg = (addr >> 3) & 0x3f;
 
             ret = env->itlb[reg].tte;
             break;
         }
     case ASI_ITLB_TAG_READ: /* I-MMU tag read */
         {
             int reg = (addr >> 3) & 0x3f;
 
             ret = env->itlb[reg].tag;
             break;
         }
     case ASI_DMMU: /* D-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
             switch (reg) {
             case 0:
                 /* 0x00 D-TSB Tag Target register */
                 ret = ultrasparc_tag_target(env->dmmu.tag_access);
                 break;
             case 1: /* 0x08 Primary Context */
                 ret = env->dmmu.mmu_primary_context;
                 break;
             case 2: /* 0x10 Secondary Context */
                 ret = env->dmmu.mmu_secondary_context;
                 break;
             case 3: /* SFSR */
                 ret = env->dmmu.sfsr;
                 break;
             case 4: /* 0x20 SFAR */
                 ret = env->dmmu.sfar;
                 break;
             case 5: /* 0x28 TSB access */
                 ret = env->dmmu.tsb;
                 break;
             case 6: /* 0x30 D-TSB Tag Access register */
                 ret = env->dmmu.tag_access;
                 break;
             case 7:
                 ret = env->dmmu.virtual_watchpoint;
                 break;
             case 8:
                 ret = env->dmmu.physical_watchpoint;
                 break;
             default:
                 sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
                 ret = 0;
             }
             break;
         }
     case ASI_DMMU_TSB_8KB_PTR: /* D-MMU 8k TSB pointer */
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
             ret = ultrasparc_tsb_pointer(env, &env->dmmu, 0);
             break;
         }
     case ASI_DMMU_TSB_64KB_PTR: /* D-MMU 64k TSB pointer */
         {
             /* env->dmmuregs[5] holds D-MMU TSB register value
                env->dmmuregs[6] holds D-MMU Tag Access register value */
             ret = ultrasparc_tsb_pointer(env, &env->dmmu, 1);
             break;
         }
     case ASI_DTLB_DATA_ACCESS: /* D-MMU data access */
         {
             int reg = (addr >> 3) & 0x3f;
 
             ret = env->dtlb[reg].tte;
             break;
         }
     case ASI_DTLB_TAG_READ: /* D-MMU tag read */
         {
             int reg = (addr >> 3) & 0x3f;
 
             ret = env->dtlb[reg].tag;
             break;
         }
     case ASI_INTR_DISPATCH_STAT: /* Interrupt dispatch, RO */
         break;
     case ASI_INTR_RECEIVE: /* Interrupt data receive */
         ret = env->ivec_status;
         break;
     case ASI_INTR_R: /* Incoming interrupt vector, RO */
         {
             int reg = (addr >> 4) & 0x3;
             if (reg < 3) {
                 ret = env->ivec_data[reg];
             }
             break;
         }
     case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
         if (unlikely((addr >= 0x20) && (addr < 0x30))) {
             /* Hyperprivileged access only */
             sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
         }
-        /* fall through */
+        fallthrough;
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
         {
             unsigned int i = (addr >> 3) & 0x7;
             ret = env->scratch[i];
             break;
         }
     case ASI_MMU: /* UA2005 Context ID registers */
         switch ((addr >> 3) & 0x3) {
         case 1:
             ret = env->dmmu.mmu_primary_context;
             break;
         case 2:
             ret = env->dmmu.mmu_secondary_context;
             break;
         default:
           sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         }
         break;
     case ASI_DCACHE_DATA:     /* D-cache data */
     case ASI_DCACHE_TAG:      /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
     case ASI_AFSR:            /* E-cache asynchronous fault status */
     case ASI_AFAR:            /* E-cache asynchronous fault address */
     case ASI_EC_TAG_DATA:     /* E-cache tag data */
     case ASI_IC_INSTR:        /* I-cache instruction access */
     case ASI_IC_TAG:          /* I-cache tag access */
     case ASI_IC_PRE_DECODE:   /* I-cache predecode */
     case ASI_IC_NEXT_FIELD:   /* I-cache LRU etc. */
     case ASI_EC_W:            /* E-cache tag */
     case ASI_EC_R:            /* E-cache tag */
         break;
     case ASI_DMMU_TSB_DIRECT_PTR: /* D-MMU data pointer */
     case ASI_ITLB_DATA_IN:        /* I-MMU data in, WO */
     case ASI_IMMU_DEMAP:          /* I-MMU demap, WO */
     case ASI_DTLB_DATA_IN:        /* D-MMU data in, WO */
     case ASI_DMMU_DEMAP:          /* D-MMU demap, WO */
     case ASI_INTR_W:              /* Interrupt vector, WO */
     default:
         sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
         ret = 0;
         break;
     }
 
     /* Convert to signed number */
     if (sign) {
         switch (size) {
         case 1:
             ret = (int8_t) ret;
             break;
         case 2:
             ret = (int16_t) ret;
             break;
         case 4:
             ret = (int32_t) ret;
             break;
         default:
             break;
         }
     }
 #ifdef DEBUG_ASI
     dump_asi("read ", last_addr, asi, size, ret);
 #endif
     return ret;
 }
@@ -1591,341 +1591,341 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
     CPUState *cs = env_cpu(env);
 
 #ifdef DEBUG_ASI
     dump_asi("write", addr, asi, size, val);
 #endif
 
     asi &= 0xff;
 
     do_check_asi(env, asi, GETPC());
     do_check_align(env, addr, size - 1, GETPC());
     addr = asi_address_mask(env, asi, addr);
 
     switch (asi) {
     case ASI_AIUP:  /* As if user primary */
     case ASI_AIUS:  /* As if user secondary */
     case ASI_AIUPL: /* As if user primary LE */
     case ASI_AIUSL: /* As if user secondary LE */
     case ASI_P:  /* Primary */
     case ASI_S:  /* Secondary */
     case ASI_PL: /* Primary LE */
     case ASI_SL: /* Secondary LE */
     case ASI_REAL:      /* Bypass */
     case ASI_REAL_IO:   /* Bypass, non-cacheable */
     case ASI_REAL_L:    /* Bypass LE */
     case ASI_REAL_IO_L: /* Bypass, non-cacheable LE */
     case ASI_N:  /* Nucleus */
     case ASI_NL: /* Nucleus Little Endian (LE) */
     case ASI_NUCLEUS_QUAD_LDD:   /* Nucleus quad LDD 128 bit atomic */
     case ASI_NUCLEUS_QUAD_LDD_L: /* Nucleus quad LDD 128 bit atomic LE */
     case ASI_TWINX_AIUP:   /* As if user primary, twinx */
     case ASI_TWINX_AIUS:   /* As if user secondary, twinx */
     case ASI_TWINX_REAL:   /* Real address, twinx */
     case ASI_TWINX_AIUP_L: /* As if user primary, twinx, LE */
     case ASI_TWINX_AIUS_L: /* As if user secondary, twinx, LE */
     case ASI_TWINX_REAL_L: /* Real address, twinx, LE */
     case ASI_TWINX_N:  /* Nucleus, twinx */
     case ASI_TWINX_NL: /* Nucleus, twinx, LE */
     /* ??? From the UA2011 document; overlaps BLK_INIT_QUAD_LDD_* */
     case ASI_TWINX_P:  /* Primary, twinx */
     case ASI_TWINX_PL: /* Primary, twinx, LE */
     case ASI_TWINX_S:  /* Secondary, twinx */
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
         /* These are always handled inline.  */
         g_assert_not_reached();
     /* these ASIs have different functions on UltraSPARC-IIIi
      * and UA2005 CPUs. Use the explicit numbers to avoid confusion
      */
     case 0x31:
     case 0x32:
     case 0x39:
     case 0x3a:
         if (cpu_has_hypervisor(env)) {
             /* UA2005
              * ASI_DMMU_CTX_ZERO_TSB_BASE_PS0
              * ASI_DMMU_CTX_ZERO_TSB_BASE_PS1
              * ASI_DMMU_CTX_NONZERO_TSB_BASE_PS0
              * ASI_DMMU_CTX_NONZERO_TSB_BASE_PS1
              */
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->dmmu.sun4v_tsb_pointers[idx] = val;
         } else {
             helper_raise_exception(env, TT_ILL_INSN);
         }
         break;
     case 0x33:
     case 0x3b:
         if (cpu_has_hypervisor(env)) {
             /* UA2005
              * ASI_DMMU_CTX_ZERO_CONFIG
              * ASI_DMMU_CTX_NONZERO_CONFIG
              */
             env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
             helper_raise_exception(env, TT_ILL_INSN);
         }
         break;
     case 0x35:
     case 0x36:
     case 0x3d:
     case 0x3e:
         if (cpu_has_hypervisor(env)) {
             /* UA2005
              * ASI_IMMU_CTX_ZERO_TSB_BASE_PS0
              * ASI_IMMU_CTX_ZERO_TSB_BASE_PS1
              * ASI_IMMU_CTX_NONZERO_TSB_BASE_PS0
              * ASI_IMMU_CTX_NONZERO_TSB_BASE_PS1
              */
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->immu.sun4v_tsb_pointers[idx] = val;
         } else {
             helper_raise_exception(env, TT_ILL_INSN);
         }
       break;
     case 0x37:
     case 0x3f:
         if (cpu_has_hypervisor(env)) {
             /* UA2005
              * ASI_IMMU_CTX_ZERO_CONFIG
              * ASI_IMMU_CTX_NONZERO_CONFIG
              */
             env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
           helper_raise_exception(env, TT_ILL_INSN);
         }
         break;
     case ASI_UPA_CONFIG: /* UPA config */
         /* XXX */
         return;
     case ASI_LSU_CONTROL: /* LSU */
         env->lsu = val & (DMMU_E | IMMU_E);
         return;
     case ASI_IMMU: /* I-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
             uint64_t oldreg;
 
             oldreg = env->immu.mmuregs[reg];
             switch (reg) {
             case 0: /* RO */
                 return;
             case 1: /* Not in I-MMU */
             case 2:
                 return;
             case 3: /* SFSR */
                 if ((val & 1) == 0) {
                     val = 0; /* Clear SFSR */
                 }
                 env->immu.sfsr = val;
                 break;
             case 4: /* RO */
                 return;
             case 5: /* TSB access */
                 DPRINTF_MMU("immu TSB write: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", env->immu.tsb, val);
                 env->immu.tsb = val;
                 break;
             case 6: /* Tag access */
                 env->immu.tag_access = val;
                 break;
             case 7:
             case 8:
                 return;
             default:
                 sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
                 break;
             }
 
             if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(env);
 #endif
             return;
         }
     case ASI_ITLB_DATA_IN: /* I-MMU data in */
         /* ignore real translation entries */
         if (!(addr & TLB_UST1_IS_REAL_BIT)) {
             replace_tlb_1bit_lru(env->itlb, env->immu.tag_access,
                                  val, "immu", env, addr);
         }
         return;
     case ASI_ITLB_DATA_ACCESS: /* I-MMU data access */
         {
             /* TODO: auto demap */
 
             unsigned int i = (addr >> 3) & 0x3f;
 
             /* ignore real translation entries */
             if (!(addr & TLB_UST1_IS_REAL_BIT)) {
                 replace_tlb_entry(&env->itlb[i], env->immu.tag_access,
                                   sun4v_tte_to_sun4u(env, addr, val), env);
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("immu data access replaced entry [%i]\n", i);
             dump_mmu(env);
 #endif
             return;
         }
     case ASI_IMMU_DEMAP: /* I-MMU demap */
         demap_tlb(env->itlb, addr, "immu", env);
         return;
     case ASI_DMMU: /* D-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
             uint64_t oldreg;
 
             oldreg = env->dmmu.mmuregs[reg];
             switch (reg) {
             case 0: /* RO */
             case 4:
                 return;
             case 3: /* SFSR */
                 if ((val & 1) == 0) {
                     val = 0; /* Clear SFSR, Fault address */
                     env->dmmu.sfar = 0;
                 }
                 env->dmmu.sfsr = val;
                 break;
             case 1: /* Primary context */
                 env->dmmu.mmu_primary_context = val;
                 /* can be optimized to only flush MMU_USER_IDX
                    and MMU_KERNEL_IDX entries */
                 tlb_flush(cs);
                 break;
             case 2: /* Secondary context */
                 env->dmmu.mmu_secondary_context = val;
                 /* can be optimized to only flush MMU_USER_SECONDARY_IDX
                    and MMU_KERNEL_SECONDARY_IDX entries */
                 tlb_flush(cs);
                 break;
             case 5: /* TSB access */
                 DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", env->dmmu.tsb, val);
                 env->dmmu.tsb = val;
                 break;
             case 6: /* Tag access */
                 env->dmmu.tag_access = val;
                 break;
             case 7: /* Virtual Watchpoint */
                 env->dmmu.virtual_watchpoint = val;
                 break;
             case 8: /* Physical Watchpoint */
                 env->dmmu.physical_watchpoint = val;
                 break;
             default:
                 sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
                 break;
             }
 
             if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(env);
 #endif
             return;
         }
     case ASI_DTLB_DATA_IN: /* D-MMU data in */
       /* ignore real translation entries */
       if (!(addr & TLB_UST1_IS_REAL_BIT)) {
           replace_tlb_1bit_lru(env->dtlb, env->dmmu.tag_access,
                                val, "dmmu", env, addr);
       }
       return;
     case ASI_DTLB_DATA_ACCESS: /* D-MMU data access */
         {
             unsigned int i = (addr >> 3) & 0x3f;
 
             /* ignore real translation entries */
             if (!(addr & TLB_UST1_IS_REAL_BIT)) {
                 replace_tlb_entry(&env->dtlb[i], env->dmmu.tag_access,
                                   sun4v_tte_to_sun4u(env, addr, val), env);
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("dmmu data access replaced entry [%i]\n", i);
             dump_mmu(env);
 #endif
             return;
         }
     case ASI_DMMU_DEMAP: /* D-MMU demap */
         demap_tlb(env->dtlb, addr, "dmmu", env);
         return;
     case ASI_INTR_RECEIVE: /* Interrupt data receive */
         env->ivec_status = val & 0x20;
         return;
     case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
         if (unlikely((addr >= 0x20) && (addr < 0x30))) {
             /* Hyperprivileged access only */
             sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         }
-        /* fall through */
+        fallthrough;
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
         {
             unsigned int i = (addr >> 3) & 0x7;
             env->scratch[i] = val;
             return;
         }
     case ASI_MMU: /* UA2005 Context ID registers */
         {
           switch ((addr >> 3) & 0x3) {
           case 1:
               env->dmmu.mmu_primary_context = val;
               env->immu.mmu_primary_context = val;
               tlb_flush_by_mmuidx(cs,
                                   (1 << MMU_USER_IDX) | (1 << MMU_KERNEL_IDX));
               break;
           case 2:
               env->dmmu.mmu_secondary_context = val;
               env->immu.mmu_secondary_context = val;
               tlb_flush_by_mmuidx(cs,
                                   (1 << MMU_USER_SECONDARY_IDX) |
                                   (1 << MMU_KERNEL_SECONDARY_IDX));
               break;
           default:
               sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
           }
         }
         return;
     case ASI_QUEUE: /* UA2005 CPU mondo queue */
     case ASI_DCACHE_DATA: /* D-cache data */
     case ASI_DCACHE_TAG: /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
     case ASI_AFSR: /* E-cache asynchronous fault status */
     case ASI_AFAR: /* E-cache asynchronous fault address */
     case ASI_EC_TAG_DATA: /* E-cache tag data */
     case ASI_IC_INSTR: /* I-cache instruction access */
     case ASI_IC_TAG: /* I-cache tag access */
     case ASI_IC_PRE_DECODE: /* I-cache predecode */
     case ASI_IC_NEXT_FIELD: /* I-cache LRU etc. */
     case ASI_EC_W: /* E-cache tag */
     case ASI_EC_R: /* E-cache tag */
         return;
     case ASI_IMMU_TSB_8KB_PTR: /* I-MMU 8k TSB pointer, RO */
     case ASI_IMMU_TSB_64KB_PTR: /* I-MMU 64k TSB pointer, RO */
     case ASI_ITLB_TAG_READ: /* I-MMU tag read, RO */
     case ASI_DMMU_TSB_8KB_PTR: /* D-MMU 8k TSB pointer, RO */
     case ASI_DMMU_TSB_64KB_PTR: /* D-MMU 64k TSB pointer, RO */
     case ASI_DMMU_TSB_DIRECT_PTR: /* D-MMU data pointer, RO */
     case ASI_DTLB_TAG_READ: /* D-MMU tag read, RO */
     case ASI_INTR_DISPATCH_STAT: /* Interrupt dispatch, RO */
     case ASI_INTR_R: /* Incoming interrupt vector, RO */
     case ASI_PNF: /* Primary no-fault, RO */
     case ASI_SNF: /* Secondary no-fault, RO */
     case ASI_PNFL: /* Primary no-fault LE, RO */
     case ASI_SNFL: /* Secondary no-fault LE, RO */
     default:
         sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
     }
 }
 #endif /* CONFIG_USER_ONLY */
 #endif /* TARGET_SPARC64 */
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 453498c670..13f0430c5d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -545,99 +545,99 @@ static uint64_t build_sfsr(CPUSPARCState *env, int mmu_idx, int rw)
 static int get_physical_address_data(CPUSPARCState *env, CPUTLBEntryFull *full,
                                      target_ulong address, int rw, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     unsigned int i;
     uint64_t sfsr;
     uint64_t context;
     bool is_user = false;
 
     sfsr = build_sfsr(env, mmu_idx, rw);
 
     switch (mmu_idx) {
     case MMU_PHYS_IDX:
         g_assert_not_reached();
     case MMU_USER_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_IDX:
         context = env->dmmu.mmu_primary_context & 0x1fff;
         break;
     case MMU_USER_SECONDARY_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_SECONDARY_IDX:
         context = env->dmmu.mmu_secondary_context & 0x1fff;
         break;
     default:
         context = 0;
         break;
     }
 
     for (i = 0; i < 64; i++) {
         /* ctx match, vaddr match, valid? */
         if (ultrasparc_tag_match(&env->dtlb[i], address, context,
                                  &full->phys_addr)) {
             int do_fault = 0;
 
             if (TTE_IS_IE(env->dtlb[i].tte)) {
                 full->attrs.byte_swap = true;
             }
 
             /* access ok? */
             /* multiple bits in SFSR.FT may be set on TT_DFAULT */
             if (TTE_IS_PRIV(env->dtlb[i].tte) && is_user) {
                 do_fault = 1;
                 sfsr |= SFSR_FT_PRIV_BIT; /* privilege violation */
                 trace_mmu_helper_dfault(address, context, mmu_idx, env->tl);
             }
             if (rw == 4) {
                 if (TTE_IS_SIDEEFFECT(env->dtlb[i].tte)) {
                     do_fault = 1;
                     sfsr |= SFSR_FT_NF_E_BIT;
                 }
             } else {
                 if (TTE_IS_NFO(env->dtlb[i].tte)) {
                     do_fault = 1;
                     sfsr |= SFSR_FT_NFO_BIT;
                 }
             }
 
             if (do_fault) {
                 /* faults above are reported with TT_DFAULT. */
                 cs->exception_index = TT_DFAULT;
             } else if (!TTE_IS_W_OK(env->dtlb[i].tte) && (rw == 1)) {
                 do_fault = 1;
                 cs->exception_index = TT_DPROT;
 
                 trace_mmu_helper_dprot(address, context, mmu_idx, env->tl);
             }
 
             if (!do_fault) {
                 full->prot = PAGE_READ;
                 if (TTE_IS_W_OK(env->dtlb[i].tte)) {
                     full->prot |= PAGE_WRITE;
                 }
 
                 TTE_SET_USED(env->dtlb[i].tte);
 
                 return 0;
             }
 
             env->dmmu.sfsr = sfsr;
             env->dmmu.sfar = address; /* Fault address register */
             env->dmmu.tag_access = (address & ~0x1fffULL) | context;
             return 1;
         }
     }
 
     trace_mmu_helper_dmiss(address, context);
 
     /*
      * On MMU misses:
      * - UltraSPARC IIi: SFSR and SFAR unmodified
      * - JPS1: SFAR updated and some fields of SFSR updated
      */
     env->dmmu.tag_access = (address & ~0x1fffULL) | context;
     cs->exception_index = TT_DMISS;
     return 1;
 }
@@ -645,75 +645,75 @@ static int get_physical_address_data(CPUSPARCState *env, CPUTLBEntryFull *full,
 static int get_physical_address_code(CPUSPARCState *env, CPUTLBEntryFull *full,
                                      target_ulong address, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
     unsigned int i;
     uint64_t context;
     bool is_user = false;
 
     switch (mmu_idx) {
     case MMU_PHYS_IDX:
     case MMU_USER_SECONDARY_IDX:
     case MMU_KERNEL_SECONDARY_IDX:
         g_assert_not_reached();
     case MMU_USER_IDX:
         is_user = true;
-        /* fallthru */
+        fallthrough;
     case MMU_KERNEL_IDX:
         context = env->dmmu.mmu_primary_context & 0x1fff;
         break;
     default:
         context = 0;
         break;
     }
 
     if (env->tl == 0) {
         /* PRIMARY context */
         context = env->dmmu.mmu_primary_context & 0x1fff;
     } else {
         /* NUCLEUS context */
         context = 0;
     }
 
     for (i = 0; i < 64; i++) {
         /* ctx match, vaddr match, valid? */
         if (ultrasparc_tag_match(&env->itlb[i],
                                  address, context, &full->phys_addr)) {
             /* access ok? */
             if (TTE_IS_PRIV(env->itlb[i].tte) && is_user) {
                 /* Fault status register */
                 if (env->immu.sfsr & SFSR_VALID_BIT) {
                     env->immu.sfsr = SFSR_OW_BIT; /* overflow (not read before
                                                      another fault) */
                 } else {
                     env->immu.sfsr = 0;
                 }
                 if (env->pstate & PS_PRIV) {
                     env->immu.sfsr |= SFSR_PR_BIT;
                 }
                 if (env->tl > 0) {
                     env->immu.sfsr |= SFSR_CT_NUCLEUS;
                 }
 
                 /* FIXME: ASI field in SFSR must be set */
                 env->immu.sfsr |= SFSR_FT_PRIV_BIT | SFSR_VALID_BIT;
                 cs->exception_index = TT_TFAULT;
 
                 env->immu.tag_access = (address & ~0x1fffULL) | context;
 
                 trace_mmu_helper_tfault(address, context);
 
                 return 1;
             }
             full->prot = PAGE_EXEC;
             TTE_SET_USED(env->itlb[i].tte);
             return 0;
         }
     }
 
     trace_mmu_helper_tmiss(address, context);
 
     /* Context is stored in DMMU (dmmuregs[1]) also for IMMU */
     env->immu.tag_access = (address & ~0x1fffULL) | context;
     cs->exception_index = TT_TMISS;
     return 1;
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..4f179473d7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1020,167 +1020,168 @@ static void gen_op_next_insn(void)
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
     static int subcc_cond[16] = {
         TCG_COND_NEVER,
         TCG_COND_EQ,
         TCG_COND_LE,
         TCG_COND_LT,
         TCG_COND_LEU,
         TCG_COND_LTU,
         -1, /* neg */
         -1, /* overflow */
         TCG_COND_ALWAYS,
         TCG_COND_NE,
         TCG_COND_GT,
         TCG_COND_GE,
         TCG_COND_GTU,
         TCG_COND_GEU,
         -1, /* pos */
         -1, /* no overflow */
     };
 
     static int logic_cond[16] = {
         TCG_COND_NEVER,
         TCG_COND_EQ,     /* eq:  Z */
         TCG_COND_LE,     /* le:  Z | (N ^ V) -> Z | N */
         TCG_COND_LT,     /* lt:  N ^ V -> N */
         TCG_COND_EQ,     /* leu: C | Z -> Z */
         TCG_COND_NEVER,  /* ltu: C -> 0 */
         TCG_COND_LT,     /* neg: N */
         TCG_COND_NEVER,  /* vs:  V -> 0 */
         TCG_COND_ALWAYS,
         TCG_COND_NE,     /* ne:  !Z */
         TCG_COND_GT,     /* gt:  !(Z | (N ^ V)) -> !(Z | N) */
         TCG_COND_GE,     /* ge:  !(N ^ V) -> !N */
         TCG_COND_NE,     /* gtu: !(C | Z) -> !Z */
         TCG_COND_ALWAYS, /* geu: !C -> 1 */
         TCG_COND_GE,     /* pos: !N */
         TCG_COND_ALWAYS, /* vc:  !V -> 1 */
     };
 
     TCGv_i32 r_src;
     TCGv r_dst;
 
 #ifdef TARGET_SPARC64
     if (xcc) {
         r_src = cpu_xcc;
     } else {
         r_src = cpu_psr;
     }
 #else
     r_src = cpu_psr;
 #endif
 
     switch (dc->cc_op) {
     case CC_OP_LOGIC:
         cmp->cond = logic_cond[cond];
     do_compare_dst_0:
         cmp->is_bool = false;
         cmp->c2 = tcg_constant_tl(0);
 #ifdef TARGET_SPARC64
         if (!xcc) {
             cmp->c1 = tcg_temp_new();
             tcg_gen_ext32s_tl(cmp->c1, cpu_cc_dst);
             break;
         }
 #endif
         cmp->c1 = cpu_cc_dst;
         break;
 
     case CC_OP_SUB:
         switch (cond) {
         case 6:  /* neg */
         case 14: /* pos */
             cmp->cond = (cond == 6 ? TCG_COND_LT : TCG_COND_GE);
             goto do_compare_dst_0;
 
         case 7: /* overflow */
         case 15: /* !overflow */
             goto do_dynamic;
 
         default:
             cmp->cond = subcc_cond[cond];
             cmp->is_bool = false;
 #ifdef TARGET_SPARC64
             if (!xcc) {
                 /* Note that sign-extension works for unsigned compares as
                    long as both operands are sign-extended.  */
                 cmp->c1 = tcg_temp_new();
                 cmp->c2 = tcg_temp_new();
                 tcg_gen_ext32s_tl(cmp->c1, cpu_cc_src);
                 tcg_gen_ext32s_tl(cmp->c2, cpu_cc_src2);
                 break;
             }
 #endif
             cmp->c1 = cpu_cc_src;
             cmp->c2 = cpu_cc_src2;
             break;
         }
         break;
 
     default:
     do_dynamic:
         gen_helper_compute_psr(tcg_env);
         dc->cc_op = CC_OP_FLAGS;
         /* FALLTHRU */
+        fallthrough;
 
     case CC_OP_FLAGS:
         /* We're going to generate a boolean result.  */
         cmp->cond = TCG_COND_NE;
         cmp->is_bool = true;
         cmp->c1 = r_dst = tcg_temp_new();
         cmp->c2 = tcg_constant_tl(0);
 
         switch (cond) {
         case 0x0:
             gen_op_eval_bn(r_dst);
             break;
         case 0x1:
             gen_op_eval_be(r_dst, r_src);
             break;
         case 0x2:
             gen_op_eval_ble(r_dst, r_src);
             break;
         case 0x3:
             gen_op_eval_bl(r_dst, r_src);
             break;
         case 0x4:
             gen_op_eval_bleu(r_dst, r_src);
             break;
         case 0x5:
             gen_op_eval_bcs(r_dst, r_src);
             break;
         case 0x6:
             gen_op_eval_bneg(r_dst, r_src);
             break;
         case 0x7:
             gen_op_eval_bvs(r_dst, r_src);
             break;
         case 0x8:
             gen_op_eval_ba(r_dst);
             break;
         case 0x9:
             gen_op_eval_bne(r_dst, r_src);
             break;
         case 0xa:
             gen_op_eval_bg(r_dst, r_src);
             break;
         case 0xb:
             gen_op_eval_bge(r_dst, r_src);
             break;
         case 0xc:
             gen_op_eval_bgu(r_dst, r_src);
             break;
         case 0xd:
             gen_op_eval_bcc(r_dst, r_src);
             break;
         case 0xe:
             gen_op_eval_bpos(r_dst, r_src);
             break;
         case 0xf:
             gen_op_eval_bvc(r_dst, r_src);
             break;
         }
         break;
     }
 }
@@ -2186,75 +2187,75 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
 static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
                        int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
     switch (da.type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DTWINX: /* Reserved for stda.  */
 #ifndef TARGET_SPARC64
         gen_exception(dc, TT_ILL_INSN);
         break;
 #else
         if (!(dc->def->features & CPU_FEATURE_HYPV)) {
             /* Pre OpenSPARC CPUs don't have these */
             gen_exception(dc, TT_ILL_INSN);
             return;
         }
         /* in OpenSPARC T1+ CPUs TWINX ASIs in store instructions
          * are ST_BLKINIT_ ASIs */
 #endif
-        /* fall through */
+        fallthrough;
     case GET_ASI_DIRECT:
         gen_address_mask(dc, addr);
         tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop | MO_ALIGN);
         break;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     case GET_ASI_BCOPY:
         /* Copy 32 bytes from the address in SRC to ADDR.  */
         /* ??? The original qemu code suggests 4-byte alignment, dropping
            the low bits, but the only place I can see this used is in the
            Linux kernel with 32 byte alignment, which would make more sense
            as a cacheline-style operation.  */
         {
             TCGv saddr = tcg_temp_new();
             TCGv daddr = tcg_temp_new();
             TCGv four = tcg_constant_tl(4);
             TCGv_i32 tmp = tcg_temp_new_i32();
             int i;
 
             tcg_gen_andi_tl(saddr, src, -4);
             tcg_gen_andi_tl(daddr, addr, -4);
             for (i = 0; i < 32; i += 4) {
                 /* Since the loads and stores are paired, allow the
                    copy to happen in the host endianness.  */
                 tcg_gen_qemu_ld_i32(tmp, saddr, da.mem_idx, MO_UL);
                 tcg_gen_qemu_st_i32(tmp, daddr, da.mem_idx, MO_UL);
                 tcg_gen_add_tl(saddr, saddr, four);
                 tcg_gen_add_tl(daddr, daddr, four);
             }
         }
         break;
 #endif
     default:
         {
             TCGv_i32 r_asi = tcg_constant_i32(da.asi);
             TCGv_i32 r_mop = tcg_constant_i32(memop | MO_ALIGN);
 
             save_state(dc);
 #ifdef TARGET_SPARC64
             gen_helper_st_asi(tcg_env, addr, src, r_asi, r_mop);
 #else
             {
                 TCGv_i64 t64 = tcg_temp_new_i64();
                 tcg_gen_extu_tl_i64(t64, src);
                 gen_helper_st_asi(tcg_env, addr, t64, r_asi, r_mop);
             }
 #endif
 
             /* A write to a TLB register may alter page maps.  End the TB. */
             dc->npc = DYNAMIC_PC;
         }
         break;
     }
 }
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 3a7c0ff943..0c54b63938 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -296,20 +296,21 @@ void helper_wrcwp(CPUSPARCState *env, target_ulong new_cwp)
 static inline uint64_t *get_gregset(CPUSPARCState *env, uint32_t pstate)
 {
     if (env->def.features & CPU_FEATURE_GL) {
         return env->glregs + (env->gl & 7) * 8;
     }
 
     switch (pstate) {
     default:
         trace_win_helper_gregset_error(pstate);
         /* fall through to normal set of global registers */
+        fallthrough;
     case 0:
         return env->bgregs;
     case PS_AG:
         return env->agregs;
     case PS_MG:
         return env->mgregs;
     case PS_IG:
         return env->igregs;
     }
 }
-- 
2.39.2


