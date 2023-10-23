Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 631527D3ED0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRF-0005k0-0p; Mon, 23 Oct 2023 14:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR1-0005aq-Lc
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:51 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQz-0008CZ-Ig
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:51 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-581b6b93bd1so2157649eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084828; x=1698689628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NA4v6NXBUoR4C0a50DqS4JX4mw0CRsfvfpO9da4xso=;
 b=XLcpKAi9ridF723koTamtCdy+WZ4Ifrd7MtpIW8RKLv91qpCzHuYlTqAvEp5A6gPVX
 wr3psIG75UAoQP/iPJAPCDZWXYR5VQzUb9e+pAlhmZbvKWLpPxjjAsS9plbXQbt/n7X7
 qcViXKef1dA2WGzytH1nlxMGG2qF2xU/wzDgmbAiGHfb6MpDmK0v5BMCJQxKBqmAg3As
 j0RV6o86igI8hyuxDN8nT/BGkPsKtUpDzH4nKKwJc1x/wqCzexbPzc1nCxsMgZFPSSEb
 QampYQLN7ZoQ5Invm5caGk6lTfPo3mZxF+X/ebow0pghE1G+dPyJ2doJueW3AZsFtQQj
 3YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084828; x=1698689628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NA4v6NXBUoR4C0a50DqS4JX4mw0CRsfvfpO9da4xso=;
 b=j9dI55mAhdd05zwbmGWdZZakbgB/ATiGIAUe+6Ckhj8a1eyJmGyza9ts9J5P3f5oVT
 EL58OHBxigiE1sqkJvTSRuYYvHPzJDPw5PKtm6glgCBNMu87ixpvKwsQOmQdpltpnaPK
 h9aQualVlGWY6gFXoZj/NEsZydR+Wq/UxGKZ0YlWP7DVyTsEytqidDnl/kmOBXnlRxxu
 XjafD/X8qSK6E891fD+yePIRkuVz1Iywlzqyu5trpyHaNtgGDKe7qh8TjH4ZKUKsW1qr
 9XSUsjpnyOk3wA0ODxJyTFwzNqKL+V4a3w3tl1VdLJHjLW9hyVIaqWJoYNXCR/6+hiMa
 AglA==
X-Gm-Message-State: AOJu0YzArK9+C5/2208EV3YLB6W/wxDF07wTMn4dSCAdNJuGGa3bx/SC
 UhDHQF27aKqwECVnr6D4MZ5vPiAtJGxYulYqmlo=
X-Google-Smtp-Source: AGHT+IFMoLvQg+LS5bS3pUE3cGYxk3F1p6us+qnjzXAXoJTg2b/F3xn/jwUy+uKCMffOhYJOdJoIHg==
X-Received: by 2002:a05:6358:ee45:b0:168:d346:9ee3 with SMTP id
 ik5-20020a056358ee4500b00168d3469ee3mr7194239rwb.24.1698084828348; 
 Mon, 23 Oct 2023 11:13:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 20/38] tcg/mips: Use tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:11 -0700
Message-Id: <20231023181329.171490-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 231 +++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 118 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e2892edc6a..328984ccff 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -78,13 +78,11 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP2  TCG_REG_T8
 #define TCG_TMP3  TCG_REG_T7
 
-#ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_S7
-#endif
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_REG_TB         TCG_REG_S6
 #else
-#define TCG_REG_TB         (qemu_build_not_reached(), TCG_REG_ZERO)
+#define TCG_REG_TB         ({ qemu_build_not_reached(); TCG_REG_ZERO; })
 #endif
 
 /* check if we really need so many registers :P */
@@ -1279,130 +1277,129 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     a_bits = h->aa.align;
     a_mask = (1 << a_bits) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    unsigned s_mask = (1 << s_bits) - 1;
-    int mem_index = get_mmuidx(oi);
-    int fast_off = tlb_mask_table_ofs(s, mem_index);
-    int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
-    int table_off = fast_off + offsetof(CPUTLBDescFast, table);
-    int add_off = offsetof(CPUTLBEntry, addend);
-    int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
-                        : offsetof(CPUTLBEntry, addr_write);
+    if (tcg_use_softmmu) {
+        unsigned s_mask = (1 << s_bits) - 1;
+        int mem_index = get_mmuidx(oi);
+        int fast_off = tlb_mask_table_ofs(s, mem_index);
+        int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
+        int table_off = fast_off + offsetof(CPUTLBDescFast, table);
+        int add_off = offsetof(CPUTLBEntry, addend);
+        int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
+                            : offsetof(CPUTLBEntry, addr_write);
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addrlo;
-    ldst->addrhi_reg = addrhi;
-
-    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
-
-    /* Extract the TLB index from the address into TMP3.  */
-    if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-        tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addrlo,
-                       s->page_bits - CPU_TLB_ENTRY_BITS);
-    } else {
-        tcg_out_dsrl(s, TCG_TMP3, addrlo,
-                     s->page_bits - CPU_TLB_ENTRY_BITS);
-    }
-    tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
-
-    /* Add the tlb_table pointer, creating the CPUTLBEntry address in TMP3.  */
-    tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
-
-    if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-        /* Load the (low half) tlb comparator.  */
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
-                   cmp_off + HOST_BIG_ENDIAN * 4);
-    } else {
-        tcg_out_ld(s, TCG_TYPE_I64, TCG_TMP0, TCG_TMP3, cmp_off);
-    }
-
-    if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
-        /* Load the tlb addend for the fast path.  */
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
-    }
-
-    /*
-     * Mask the page bits, keeping the alignment bits to compare against.
-     * For unaligned accesses, compare against the end of the access to
-     * verify that it does not cross a page boundary.
-     */
-    tcg_out_movi(s, addr_type, TCG_TMP1, s->page_mask | a_mask);
-    if (a_mask < s_mask) {
-        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-            tcg_out_opc_imm(s, OPC_ADDIU, TCG_TMP2, addrlo, s_mask - a_mask);
-        } else {
-            tcg_out_opc_imm(s, OPC_DADDIU, TCG_TMP2, addrlo, s_mask - a_mask);
-        }
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
-    } else {
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrlo);
-    }
-
-    /* Zero extend a 32-bit guest address for a 64-bit host. */
-    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
-        tcg_out_ext32u(s, TCG_TMP2, addrlo);
-        addrlo = TCG_TMP2;
-    }
-
-    ldst->label_ptr[0] = s->code_ptr;
-    tcg_out_opc_br(s, OPC_BNE, TCG_TMP1, TCG_TMP0);
-
-    /* Load and test the high half tlb comparator.  */
-    if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-        /* delay slot */
-        tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + HI_OFF);
-
-        /* Load the tlb addend for the fast path.  */
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
-
-        ldst->label_ptr[1] = s->code_ptr;
-        tcg_out_opc_br(s, OPC_BNE, addrhi, TCG_TMP0);
-    }
-
-    /* delay slot */
-    base = TCG_TMP3;
-    tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addrlo);
-#else
-    if (a_mask && (use_mips32r6_instructions || a_bits != s_bits)) {
         ldst = new_ldst_label(s);
-
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        /* We are expecting a_bits to max out at 7, much lower than ANDI. */
-        tcg_debug_assert(a_bits < 16);
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, addrlo, a_mask);
+        /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
+
+        /* Extract the TLB index from the address into TMP3.  */
+        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addrlo,
+                           s->page_bits - CPU_TLB_ENTRY_BITS);
+        } else {
+            tcg_out_dsrl(s, TCG_TMP3, addrlo,
+                         s->page_bits - CPU_TLB_ENTRY_BITS);
+        }
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
+
+        /* Add the tlb_table pointer, creating the CPUTLBEntry address.  */
+        tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+
+        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+            /* Load the (low half) tlb comparator.  */
+            tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
+                       cmp_off + HOST_BIG_ENDIAN * 4);
+        } else {
+            tcg_out_ld(s, TCG_TYPE_I64, TCG_TMP0, TCG_TMP3, cmp_off);
+        }
+
+        if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
+            /* Load the tlb addend for the fast path.  */
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
+        }
+
+        /*
+         * Mask the page bits, keeping the alignment bits to compare against.
+         * For unaligned accesses, compare against the end of the access to
+         * verify that it does not cross a page boundary.
+         */
+        tcg_out_movi(s, addr_type, TCG_TMP1, s->page_mask | a_mask);
+        if (a_mask < s_mask) {
+            tcg_out_opc_imm(s, (TCG_TARGET_REG_BITS == 32
+                                || addr_type == TCG_TYPE_I32
+                                ? OPC_ADDIU : OPC_DADDIU),
+                            TCG_TMP2, addrlo, s_mask - a_mask);
+            tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP2);
+        } else {
+            tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrlo);
+        }
+
+        /* Zero extend a 32-bit guest address for a 64-bit host. */
+        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+            tcg_out_ext32u(s, TCG_TMP2, addrlo);
+            addrlo = TCG_TMP2;
+        }
 
         ldst->label_ptr[0] = s->code_ptr;
-        if (use_mips32r6_instructions) {
-            tcg_out_opc_br(s, OPC_BNEZALC_R6, TCG_REG_ZERO, TCG_TMP0);
-        } else {
-            tcg_out_opc_br(s, OPC_BNEL, TCG_TMP0, TCG_REG_ZERO);
-            tcg_out_nop(s);
-        }
-    }
+        tcg_out_opc_br(s, OPC_BNE, TCG_TMP1, TCG_TMP0);
 
-    base = addrlo;
-    if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
-        tcg_out_ext32u(s, TCG_REG_A0, base);
-        base = TCG_REG_A0;
-    }
-    if (guest_base) {
-        if (guest_base == (int16_t)guest_base) {
-            tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, base, guest_base);
-        } else {
-            tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, base,
-                            TCG_GUEST_BASE_REG);
+        /* Load and test the high half tlb comparator.  */
+        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
+            /* delay slot */
+            tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + HI_OFF);
+
+            /* Load the tlb addend for the fast path.  */
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
+
+            ldst->label_ptr[1] = s->code_ptr;
+            tcg_out_opc_br(s, OPC_BNE, addrhi, TCG_TMP0);
+        }
+
+        /* delay slot */
+        base = TCG_TMP3;
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addrlo);
+    } else {
+        if (a_mask && (use_mips32r6_instructions || a_bits != s_bits)) {
+            ldst = new_ldst_label(s);
+
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addrlo;
+            ldst->addrhi_reg = addrhi;
+
+            /* We are expecting a_bits to max out at 7, much lower than ANDI. */
+            tcg_debug_assert(a_bits < 16);
+            tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP0, addrlo, a_mask);
+
+            ldst->label_ptr[0] = s->code_ptr;
+            if (use_mips32r6_instructions) {
+                tcg_out_opc_br(s, OPC_BNEZALC_R6, TCG_REG_ZERO, TCG_TMP0);
+            } else {
+                tcg_out_opc_br(s, OPC_BNEL, TCG_TMP0, TCG_REG_ZERO);
+                tcg_out_nop(s);
+            }
+        }
+
+        base = addrlo;
+        if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
+            tcg_out_ext32u(s, TCG_REG_A0, base);
+            base = TCG_REG_A0;
+        }
+        if (guest_base) {
+            if (guest_base == (int16_t)guest_base) {
+                tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, base, guest_base);
+            } else {
+                tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, base,
+                                TCG_GUEST_BASE_REG);
+            }
+            base = TCG_REG_A0;
         }
-        base = TCG_REG_A0;
     }
-#endif
 
     h->base = base;
     return ldst;
@@ -2465,8 +2462,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#ifndef CONFIG_SOFTMMU
-    if (guest_base != (int16_t)guest_base) {
+    if (!tcg_use_softmmu && guest_base != (int16_t)guest_base) {
         /*
          * The function call abi for n32 and n64 will have loaded $25 (t9)
          * with the address of the prologue, so we can use that instead
@@ -2479,7 +2475,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                          TCG_TARGET_REG_BITS == 64 ? TCG_REG_T9 : 0);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
 
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
-- 
2.34.1


