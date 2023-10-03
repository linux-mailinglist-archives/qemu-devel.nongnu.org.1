Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4A7B702A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRL-0003IU-CC; Tue, 03 Oct 2023 13:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRH-0003As-DK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:07 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRF-0001NA-6R
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:07 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-564af0ac494so777541a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355043; x=1696959843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6JYtGa97cuosEM5VDcf3LKcNGLmdPu5gCSz8iVRQTTY=;
 b=xPBZOIm2NNIjZTpZXAA8C61GKagoZ74HWeBDdZQZ/avlVttuK8Brc68wQUAaHVIcT2
 bqVcpvVQlsXKx+PRkO1I/6v+5YEwl167dF4vxfZq0TeCudbCJIkKkcIVqiTWnODfuciN
 iIniP4WJjsj4jY1BxI8D2wpODLOcLBNi7HdEWIECXFsEXpZYV8xy6iCzpcMLhjEYWFl2
 oP34DTsKE/fR6luK/ZpjlzU5zm4Tv1TiItxB3ji902O1M2v/5zsmdCBlReUi7Jui4r+5
 gwy5KfZVfmSz60YPDGr9YUp0Id3GNKVncw7Z8Xy0VV5S5tAorw3/feQFbKU0vEpthlBT
 TTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355043; x=1696959843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JYtGa97cuosEM5VDcf3LKcNGLmdPu5gCSz8iVRQTTY=;
 b=K/NKaKQKr+xpP91OM4QJd1vdYKfgGqIOXtje/vSMmQ7ecAdkz6Mgj/yxved3ptj/IM
 jNIQlya3VgqmwOcMhIHLOjvofK1gUvxU6TmUPLg57qe0/lIOqePKmQaxco136bE6526f
 SAfLL/I6crnfBehHEcPrr5Azz9fj6uz8QG8ZyCBfqlnSRWAZ+ORR7/jvBU/shjxlmOXY
 NqK5I/c2LzQ8uiKqbkb/pWw/8KemAMAWQcg6+V9TEqRck1nZ1rb7Y2m3qlDfKg8y3uwo
 zf2Vmb9t6bZ+e2cWxZpfHMvgAmkE+MtyzCWGTOGH2xoVDbQMgMdYDS2S0MUqBwPVM5ah
 1unQ==
X-Gm-Message-State: AOJu0Ywq91cUDaE7s1WnUd15NR34KH/9Ru2nmqJXbQMTbD481kSoNstv
 eM9VaKZkG9Lx57ZAhjhOOfrMvpKdPxVoRLaD+hs=
X-Google-Smtp-Source: AGHT+IF8G4ias7Dwghg1ovUQOHiiIsmG36bv/BgdRdlidT9pKvBmah2rswxm9e94lLpTNpfSCvYvFg==
X-Received: by 2002:a17:902:778a:b0:1bd:d14a:7e14 with SMTP id
 o10-20020a170902778a00b001bdd14a7e14mr214305pll.65.1696355042759; 
 Tue, 03 Oct 2023 10:44:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] tcg/i386: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:51 -0700
Message-Id: <20231003174356.1602279-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 184 ++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 95 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4e47151241..139f657225 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -153,11 +153,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 # define ALL_VECTOR_REGS       0x00ff0000u
 # define ALL_BYTEL_REGS        0x0000000fu
 #endif
-#ifdef CONFIG_SOFTMMU
-# define SOFTMMU_RESERVE_REGS  ((1 << TCG_REG_L0) | (1 << TCG_REG_L1))
-#else
-# define SOFTMMU_RESERVE_REGS  0
-#endif
+#define SOFTMMU_RESERVE_REGS \
+    (tcg_use_softmmu ? (1 << TCG_REG_L0) | (1 << TCG_REG_L1) : 0)
 
 /* For 64-bit, we always know that CMOV is available.  */
 #if TCG_TARGET_REG_BITS == 64
@@ -1933,7 +1930,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     return true;
 }
 
-#ifndef CONFIG_SOFTMMU
 static HostAddress x86_guest_base = {
     .index = -1
 };
@@ -1965,7 +1961,6 @@ static inline int setup_guest_base_seg(void)
     return 0;
 }
 #endif /* setup_guest_base_seg */
-#endif /* !SOFTMMU */
 
 #define MIN_TLB_MASK_TABLE_OFS  INT_MIN
 
@@ -1984,94 +1979,94 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     MemOp s_bits = opc & MO_SIZE;
     unsigned a_mask;
 
-#ifdef CONFIG_SOFTMMU
-    h->index = TCG_REG_L0;
-    h->ofs = 0;
-    h->seg = 0;
-#else
-    *h = x86_guest_base;
-#endif
+    if (tcg_use_softmmu) {
+        h->index = TCG_REG_L0;
+        h->ofs = 0;
+        h->seg = 0;
+    } else {
+        *h = x86_guest_base;
+    }
     h->base = addrlo;
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    int cmp_ofs = is_ld ? offsetof(CPUTLBEntry, addr_read)
-                        : offsetof(CPUTLBEntry, addr_write);
-    TCGType ttype = TCG_TYPE_I32;
-    TCGType tlbtype = TCG_TYPE_I32;
-    int trexw = 0, hrexw = 0, tlbrexw = 0;
-    unsigned mem_index = get_mmuidx(oi);
-    unsigned s_mask = (1 << s_bits) - 1;
-    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
-    int tlb_mask;
+    if (tcg_use_softmmu) {
+        int cmp_ofs = is_ld ? offsetof(CPUTLBEntry, addr_read)
+                            : offsetof(CPUTLBEntry, addr_write);
+        TCGType ttype = TCG_TYPE_I32;
+        TCGType tlbtype = TCG_TYPE_I32;
+        int trexw = 0, hrexw = 0, tlbrexw = 0;
+        unsigned mem_index = get_mmuidx(oi);
+        unsigned s_mask = (1 << s_bits) - 1;
+        int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+        int tlb_mask;
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addrlo;
-    ldst->addrhi_reg = addrhi;
+        ldst = new_ldst_label(s);
+        ldst->is_ld = is_ld;
+        ldst->oi = oi;
+        ldst->addrlo_reg = addrlo;
+        ldst->addrhi_reg = addrhi;
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        ttype = s->addr_type;
-        trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
-        if (TCG_TYPE_PTR == TCG_TYPE_I64) {
-            hrexw = P_REXW;
-            if (s->page_bits + s->tlb_dyn_max_bits > 32) {
-                tlbtype = TCG_TYPE_I64;
-                tlbrexw = P_REXW;
+        if (TCG_TARGET_REG_BITS == 64) {
+            ttype = s->addr_type;
+            trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
+            if (TCG_TYPE_PTR == TCG_TYPE_I64) {
+                hrexw = P_REXW;
+                if (s->page_bits + s->tlb_dyn_max_bits > 32) {
+                    tlbtype = TCG_TYPE_I64;
+                    tlbrexw = P_REXW;
+                }
             }
         }
-    }
 
-    tcg_out_mov(s, tlbtype, TCG_REG_L0, addrlo);
-    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
-                   s->page_bits - CPU_TLB_ENTRY_BITS);
+        tcg_out_mov(s, tlbtype, TCG_REG_L0, addrlo);
+        tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
+                       s->page_bits - CPU_TLB_ENTRY_BITS);
 
-    tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, TCG_REG_L0, TCG_AREG0,
-                         fast_ofs + offsetof(CPUTLBDescFast, mask));
+        tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, TCG_REG_L0, TCG_AREG0,
+                             fast_ofs + offsetof(CPUTLBDescFast, mask));
 
-    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, TCG_REG_L0, TCG_AREG0,
-                         fast_ofs + offsetof(CPUTLBDescFast, table));
+        tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, TCG_REG_L0, TCG_AREG0,
+                             fast_ofs + offsetof(CPUTLBDescFast, table));
 
-    /*
-     * If the required alignment is at least as large as the access, simply
-     * copy the address and mask.  For lesser alignments, check that we don't
-     * cross pages for the complete access.
-     */
-    if (a_mask >= s_mask) {
-        tcg_out_mov(s, ttype, TCG_REG_L1, addrlo);
-    } else {
-        tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
-                             addrlo, s_mask - a_mask);
-    }
-    tlb_mask = s->page_mask | a_mask;
-    tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
+        /*
+         * If the required alignment is at least as large as the access,
+         * simply copy the address and mask.  For lesser alignments,
+         * check that we don't cross pages for the complete access.
+         */
+        if (a_mask >= s_mask) {
+            tcg_out_mov(s, ttype, TCG_REG_L1, addrlo);
+        } else {
+            tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
+                                 addrlo, s_mask - a_mask);
+        }
+        tlb_mask = s->page_mask | a_mask;
+        tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
 
-    /* cmp 0(TCG_REG_L0), TCG_REG_L1 */
-    tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw,
-                         TCG_REG_L1, TCG_REG_L0, cmp_ofs);
-
-    /* jne slow_path */
-    tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
-    ldst->label_ptr[0] = s->code_ptr;
-    s->code_ptr += 4;
-
-    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I64) {
-        /* cmp 4(TCG_REG_L0), addrhi */
-        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, TCG_REG_L0, cmp_ofs + 4);
+        /* cmp 0(TCG_REG_L0), TCG_REG_L1 */
+        tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw,
+                             TCG_REG_L1, TCG_REG_L0, cmp_ofs);
 
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
-        ldst->label_ptr[1] = s->code_ptr;
+        ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
-    }
 
-    /* TLB Hit.  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
-               offsetof(CPUTLBEntry, addend));
-#else
-    if (a_mask) {
+        if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I64) {
+            /* cmp 4(TCG_REG_L0), addrhi */
+            tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi,
+                                 TCG_REG_L0, cmp_ofs + 4);
+
+            /* jne slow_path */
+            tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
+            ldst->label_ptr[1] = s->code_ptr;
+            s->code_ptr += 4;
+        }
+
+        /* TLB Hit.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
+                   offsetof(CPUTLBEntry, addend));
+    } else if (a_mask) {
         ldst = new_ldst_label(s);
 
         ldst->is_ld = is_ld;
@@ -2085,7 +2080,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
     }
-#endif
 
     return ldst;
 }
@@ -4140,35 +4134,35 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         tcg_out_push(s, tcg_target_callee_save_regs[i]);
     }
 
-#if TCG_TARGET_REG_BITS == 32
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP,
-               (ARRAY_SIZE(tcg_target_callee_save_regs) + 1) * 4);
-    tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
-    /* jmp *tb.  */
-    tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_ESP,
-                         (ARRAY_SIZE(tcg_target_callee_save_regs) + 2) * 4
-                         + stack_addend);
-#else
-# if !defined(CONFIG_SOFTMMU)
-    if (guest_base) {
+    if (!tcg_use_softmmu && guest_base) {
         int seg = setup_guest_base_seg();
         if (seg != 0) {
             x86_guest_base.seg = seg;
         } else if (guest_base == (int32_t)guest_base) {
             x86_guest_base.ofs = guest_base;
         } else {
+            assert(TCG_TARGET_REG_BITS == 64);
             /* Choose R12 because, as a base, it requires a SIB byte. */
             x86_guest_base.index = TCG_REG_R12;
             tcg_out_movi(s, TCG_TYPE_PTR, x86_guest_base.index, guest_base);
             tcg_regset_set_reg(s->reserved_regs, x86_guest_base.index);
         }
     }
-# endif
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-    tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
-    /* jmp *tb.  */
-    tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
-#endif
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_AREG0, TCG_REG_ESP,
+                   (ARRAY_SIZE(tcg_target_callee_save_regs) + 1) * 4);
+        tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
+        /* jmp *tb.  */
+        tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_ESP,
+                             (ARRAY_SIZE(tcg_target_callee_save_regs) + 2) * 4
+                             + stack_addend);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
+        tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
+        /* jmp *tb.  */
+        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
+    }
 
     /*
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
-- 
2.34.1


