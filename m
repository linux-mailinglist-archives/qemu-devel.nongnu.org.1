Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C374E716D16
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zx-0000uZ-Mz; Tue, 30 May 2023 15:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zb-0000nF-R2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:00 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZY-0000t3-QA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:58 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-25676b4fb78so1776605a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473195; x=1688065195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up8bpVG/xxLBkLCRFvFUrQ+E6nTLymIKT+8hlQTww9A=;
 b=u4DSMe+s8Q3xSOuoZv0vxNx3BP1Z9NCGf8TqE6x27qhQxBwXGAl0BEwZs/DUbVsKKh
 U0IIEDOJV0oNoz+dmae/2+YNLnmuQPkIKCT8lRfhqKMlmg0Bbf5YiBnpzSMtRIPnKS+q
 B230gD2ueLkiPl531PEXqHcW90aXzNZrEX1VrB2guMGKA9/SFDmwwehFYkHr1NXKE6iL
 kY29OOqTZLXWzfwXDtS3uQB5uWYXSe3Zie7tS5B+QQSfPPcxUSdOKiLLHzdLOhUVFozI
 Wna4EUQ2XbdPCUfRETDRfba7MzwacZCpgGGehGsb1CtoBCLNuHleQ1zldolDps1h+yHF
 NA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473195; x=1688065195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up8bpVG/xxLBkLCRFvFUrQ+E6nTLymIKT+8hlQTww9A=;
 b=SG+8JWDZw80cOyDVd2LErRE6SCvS0FHhHSjwrL79PvzjumvkNRX9S1/552tejpgw69
 qDxvJ6/mJYVMWG5r7+061It2Y9wis69pLtHq/00/XNXVJ9e5e34EKVh3fEsjwGxq54/W
 T07Zzj/DxPBJ5TNkQkCvLs9V3sLxHIFW9Gbriurj7t6EexLc1ETLWyjYHiSafjV+pV9U
 e6lPcOqPjXXvA8w/CZ2VepQW8fQEc9AllRWk3ZHzX/AOevYP5tTeztrOsM/VMB2LwqCQ
 15uai2+56BjAWbBYX37nRuXVzxo69z91PoBXqP0VQvM14l0mTnoO7NgZTOgwup/0ItBS
 jFNQ==
X-Gm-Message-State: AC+VfDxEUkReA5BME3+qGz6R1oFBziVHo5UydejuJjT7OyX7RPcZTRzx
 IHifAQNBUp1yTV13E2ab8VEyAZUCZYBAtY3o3rg=
X-Google-Smtp-Source: ACHHUZ52jphBwwl9z+oIrJiII4fPmyw9rio+8ueeVYc4evOIhS5RACUMzmVL1j5mVl/l5Uni+aXoIg==
X-Received: by 2002:a17:90b:1050:b0:23d:286:47d3 with SMTP id
 gq16-20020a17090b105000b0023d028647d3mr3292995pjb.40.1685473194873; 
 Tue, 30 May 2023 11:59:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/27] tcg/i386: Support 128-bit load/store
Date: Tue, 30 May 2023 11:59:27 -0700
Message-Id: <20230530185949.410208-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |   4 +-
 tcg/i386/tcg-target.c.inc | 191 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 190 insertions(+), 5 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 0106946996..b167f1e8d6 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -118,7 +118,6 @@ typedef enum {
 #define have_avx1         (cpuinfo & CPUINFO_AVX1)
 #define have_avx2         (cpuinfo & CPUINFO_AVX2)
 #define have_movbe        (cpuinfo & CPUINFO_MOVBE)
-#define have_atomic16     (cpuinfo & CPUINFO_ATOMIC_VMOVDQA)
 
 /*
  * There are interesting instructions in AVX512, so long as we have AVX512VL,
@@ -202,7 +201,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_st8_i32     1
 #endif
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
+#define TCG_TARGET_HAS_qemu_ldst_i128 \
+    (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
 /* We do not support older SSE systems, only beginning with AVX1.  */
 #define TCG_TARGET_HAS_v64              have_avx1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index bfe9d98b7e..ae54e5fbf3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -91,6 +91,8 @@ static const int tcg_target_reg_alloc_order[] = {
 #endif
 };
 
+#define TCG_TMP_VEC  TCG_REG_XMM5
+
 static const int tcg_target_call_iarg_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
 #if defined(_WIN64)
@@ -319,6 +321,8 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define OPC_PCMPGTW     (0x65 | P_EXT | P_DATA16)
 #define OPC_PCMPGTD     (0x66 | P_EXT | P_DATA16)
 #define OPC_PCMPGTQ     (0x37 | P_EXT38 | P_DATA16)
+#define OPC_PEXTRD      (0x16 | P_EXT3A | P_DATA16)
+#define OPC_PINSRD      (0x22 | P_EXT3A | P_DATA16)
 #define OPC_PMAXSB      (0x3c | P_EXT38 | P_DATA16)
 #define OPC_PMAXSW      (0xee | P_EXT | P_DATA16)
 #define OPC_PMAXSD      (0x3d | P_EXT38 | P_DATA16)
@@ -1753,7 +1757,21 @@ typedef struct {
 
 bool tcg_target_has_memory_bswap(MemOp memop)
 {
-    return have_movbe;
+    TCGAtomAlign aa;
+
+    if (!have_movbe) {
+        return false;
+    }
+    if ((memop & MO_SIZE) < MO_128) {
+        return true;
+    }
+
+    /*
+     * Reject 16-byte memop with 16-byte atomicity, i.e. VMOVDQA,
+     * but do allow a pair of 64-bit operations, i.e. MOVBEQ.
+     */
+    aa = atom_and_align_for_opc(tcg_ctx, memop, MO_ATOM_IFALIGN, true);
+    return aa.atom < MO_128;
 }
 
 /*
@@ -1781,6 +1799,30 @@ static const TCGLdstHelperParam ldst_helper_param = {
 static const TCGLdstHelperParam ldst_helper_param = { };
 #endif
 
+static void tcg_out_vec_to_pair(TCGContext *s, TCGType type,
+                                TCGReg l, TCGReg h, TCGReg v)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    /* vpmov{d,q} %v, %l */
+    tcg_out_vex_modrm(s, OPC_MOVD_EyVy + rexw, v, 0, l);
+    /* vpextr{d,q} $1, %v, %h */
+    tcg_out_vex_modrm(s, OPC_PEXTRD + rexw, v, 0, h);
+    tcg_out8(s, 1);
+}
+
+static void tcg_out_pair_to_vec(TCGContext *s, TCGType type,
+                                TCGReg v, TCGReg l, TCGReg h)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    /* vmov{d,q} %l, %v */
+    tcg_out_vex_modrm(s, OPC_MOVD_VyEy + rexw, v, 0, l);
+    /* vpinsr{d,q} $1, %h, %v, %v */
+    tcg_out_vex_modrm(s, OPC_PINSRD + rexw, v, v, h);
+    tcg_out8(s, 1);
+}
+
 /*
  * Generate code for the slow path for a load at the end of block
  */
@@ -1870,6 +1912,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
+    MemOp s_bits = opc & MO_SIZE;
     unsigned a_mask;
 
 #ifdef CONFIG_SOFTMMU
@@ -1880,7 +1923,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     *h = x86_guest_base;
 #endif
     h->base = addrlo;
-    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
 #ifdef CONFIG_SOFTMMU
@@ -1890,7 +1933,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     TCGType tlbtype = TCG_TYPE_I32;
     int trexw = 0, hrexw = 0, tlbrexw = 0;
     unsigned mem_index = get_mmuidx(oi);
-    unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1 << s_bits) - 1;
     int tlb_mask;
 
@@ -2070,6 +2112,72 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                      h.base, h.index, 0, h.ofs + 4);
         }
         break;
+
+    case MO_128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+
+        /*
+         * Without 16-byte atomicity, use integer regs.
+         * That is where we want the data, and it allows bswaps.
+         */
+        if (h.aa.atom < MO_128) {
+            if (use_movbe) {
+                TCGReg t = datalo;
+                datalo = datahi;
+                datahi = t;
+            }
+            if (h.base == datalo || h.index == datalo) {
+                tcg_out_modrm_sib_offset(s, OPC_LEA + P_REXW, datahi,
+                                         h.base, h.index, 0, h.ofs);
+                tcg_out_modrm_offset(s, movop + P_REXW + h.seg,
+                                     datalo, datahi, 0);
+                tcg_out_modrm_offset(s, movop + P_REXW + h.seg,
+                                     datahi, datahi, 8);
+            } else {
+                tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
+                                         h.base, h.index, 0, h.ofs);
+                tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datahi,
+                                         h.base, h.index, 0, h.ofs + 8);
+            }
+            break;
+        }
+
+        /*
+         * With 16-byte atomicity, a vector load is required.
+         * If we already have 16-byte alignment, then VMOVDQA always works.
+         * Else if VMOVDQU has atomicity with dynamic alignment, use that.
+         * Else use we require a runtime test for alignment for VMOVDQA;
+         * use VMOVDQU on the unaligned nonatomic path for simplicity.
+         */
+        if (h.aa.align >= MO_128) {
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+        } else if (cpuinfo & CPUINFO_ATOMIC_VMOVDQU) {
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQU_VxWx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+        } else {
+            TCGLabel *l1 = gen_new_label();
+            TCGLabel *l2 = gen_new_label();
+
+            tcg_out_testi(s, h.base, 15);
+            tcg_out_jxx(s, JCC_JNE, l1, true);
+
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+            tcg_out_jxx(s, JCC_JMP, l2, true);
+
+            tcg_out_label(s, l1);
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQU_VxWx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+            tcg_out_label(s, l2);
+        }
+        tcg_out_vec_to_pair(s, TCG_TYPE_I64, datalo, datahi, TCG_TMP_VEC);
+        break;
+
     default:
         g_assert_not_reached();
     }
@@ -2140,6 +2248,63 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                      h.base, h.index, 0, h.ofs + 4);
         }
         break;
+
+    case MO_128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+
+        /*
+         * Without 16-byte atomicity, use integer regs.
+         * That is where we have the data, and it allows bswaps.
+         */
+        if (h.aa.atom < MO_128) {
+            if (use_movbe) {
+                TCGReg t = datalo;
+                datalo = datahi;
+                datahi = t;
+            }
+            tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
+                                     h.base, h.index, 0, h.ofs);
+            tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datahi,
+                                     h.base, h.index, 0, h.ofs + 8);
+            break;
+        }
+
+        /*
+         * With 16-byte atomicity, a vector store is required.
+         * If we already have 16-byte alignment, then VMOVDQA always works.
+         * Else if VMOVDQU has atomicity with dynamic alignment, use that.
+         * Else use we require a runtime test for alignment for VMOVDQA;
+         * use VMOVDQU on the unaligned nonatomic path for simplicity.
+         */
+        tcg_out_pair_to_vec(s, TCG_TYPE_I64, TCG_TMP_VEC, datalo, datahi);
+        if (h.aa.align >= MO_128) {
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+        } else if (cpuinfo & CPUINFO_ATOMIC_VMOVDQU) {
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQU_WxVx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+        } else {
+            TCGLabel *l1 = gen_new_label();
+            TCGLabel *l2 = gen_new_label();
+
+            tcg_out_testi(s, h.base, 15);
+            tcg_out_jxx(s, JCC_JNE, l1, true);
+
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+            tcg_out_jxx(s, JCC_JMP, l2, true);
+
+            tcg_out_label(s, l1);
+            tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQU_WxVx + h.seg,
+                                         TCG_TMP_VEC, 0,
+                                         h.base, h.index, 0, h.ofs);
+            tcg_out_label(s, l2);
+        }
+        break;
+
     default:
         g_assert_not_reached();
     }
@@ -2470,6 +2635,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out_qemu_ld(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        break;
 
     case INDEX_op_qemu_st_a64_i32:
     case INDEX_op_qemu_st8_a64_i32:
@@ -2496,6 +2666,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out_qemu_st(s, a0, a1, a2, args[3], args[4], TCG_TYPE_I64);
         }
         break;
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        break;
 
     OP_32_64(mulu2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, args[3]);
@@ -3193,6 +3368,15 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I4(L, L, L, L);
 
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        return C_O2_I1(r, r, L);
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        return C_O0_I3(L, L, L);
+
     case INDEX_op_brcond2_i32:
         return C_O0_I4(r, r, ri, ri);
 
@@ -3962,6 +4146,7 @@ static void tcg_target_init(TCGContext *s)
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+    tcg_regset_set_reg(s->reserved_regs, TCG_TMP_VEC);
 #ifdef _WIN64
     /* These are call saved, and we don't save them, so don't use them. */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_XMM6);
-- 
2.34.1


