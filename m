Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DB7057BB
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Z0-0006pJ-Pj; Tue, 16 May 2023 15:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yy-0006oC-DK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:24 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yu-0002uZ-M7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6434e65d808so15320002b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266139; x=1686858139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcfRwBSVBOMMwU/KCtGetv2R2rpWXZs+QgPxQTLw33g=;
 b=QZiI9wtrW/dSZLKyvxWZzhKddqnVchXJqWcpTFgQ3tG0SZFzIryumJwoJ2BChVHnqE
 aNSpZwvSIi41TEJP2gEJ0gGNLFXF6TvU9X+GignpOohw+gJ+c82TYb9ZmoEX4aZHplVt
 8rUB4wsZ9zYEOcRtVcSyRshNQWl/idSEN8mRDp+DUs14S9As5tGkFtR5BwycteuVFuKm
 /bOWctxZaOre2ms+QrsOJmlMZwPIp0cI+WhesabFl7LwCKR7GkXPkuc+WokcQ/cCQgDF
 wjGNnNdAPqMy15cewBgw1bWZ+F1M1dxI8fPFXwbiiCwtJiLjoXOIIwmCTNNnvYYdkfn9
 44Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266139; x=1686858139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcfRwBSVBOMMwU/KCtGetv2R2rpWXZs+QgPxQTLw33g=;
 b=SfD3kMp7zitYmbCTuwdPcXOEXOpKShpMh1qvND7my2f+IIqUeC0Ytual/U+fxsSKcM
 QAX7wmGAlxDya2L+ziJZtV4XaQshVxWJVHx8LlXcTPTcEmDz9uw2o+9/NaWprFB6oOmt
 t26augIf9FfBOOivU2r47FCDpgaFXy07YcdjGDCIFKCQTj3jFeEgTaTGR4w8JWlxSGsm
 kV+kuYt+bRiFp/hI0WpNYtEHCNw4VnEZRCQAvQG2ZbgwW4MXcyhdj3x5lP+6Kj1sAhEP
 hAscnSpY1DVlhG2BbVELiJMM/uYjEvUjifIMOSH/g0P24/3mbhub4EIPp1wqqKh4iQlO
 k3vg==
X-Gm-Message-State: AC+VfDzNDcjExwVWIYKr/yVyk5Bh5LLGTEmq9lD1dqtisM17j+Gn5+To
 n7on2BX4YDS73TCaY2vdkycQaCZ2wjhQqDVm/2M=
X-Google-Smtp-Source: ACHHUZ5wbAMk4v2q97lMgAexDwNBbxdd1ugTPEbDfR+xLb9+g+TvQSZFi0c9oMK5HEySioPrr/zogQ==
X-Received: by 2002:a05:6a00:88f:b0:648:24c1:fe5a with SMTP id
 q15-20020a056a00088f00b0064824c1fe5amr31708497pfj.16.1684266139468; 
 Tue, 16 May 2023 12:42:19 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 36/80] tcg: Support TCG_TYPE_I128 in tcg_out_{ld,
 st}_helper_{args, ret}
Date: Tue, 16 May 2023 12:41:01 -0700
Message-Id: <20230516194145.1749305-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 tcg/tcg.c | 196 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 163 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2b9e032b70..582fd1b36d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -206,6 +206,7 @@ static void * const qemu_ld_helpers[MO_SSIZE + 1] __attribute__((unused)) = {
     [MO_UQ] = helper_ldq_mmu,
 #if TCG_TARGET_REG_BITS == 64
     [MO_SL] = helper_ldsl_mmu,
+    [MO_128] = helper_ld16_mmu,
 #endif
 };
 
@@ -214,6 +215,9 @@ static void * const qemu_st_helpers[MO_SIZE + 1] __attribute__((unused)) = {
     [MO_16] = helper_stw_mmu,
     [MO_32] = helper_stl_mmu,
     [MO_64] = helper_stq_mmu,
+#if TCG_TARGET_REG_BITS == 64
+    [MO_128] = helper_st16_mmu,
+#endif
 };
 
 TCGContext tcg_init_ctx;
@@ -866,6 +870,15 @@ static TCGHelperInfo info_helper_ld64_mmu = {
               | dh_typemask(ptr, 4)  /* uintptr_t ra */
 };
 
+static TCGHelperInfo info_helper_ld128_mmu = {
+    .flags = TCG_CALL_NO_WG,
+    .typemask = dh_typemask(i128, 0) /* return Int128 */
+              | dh_typemask(env, 1)
+              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i32, 3)  /* unsigned oi */
+              | dh_typemask(ptr, 4)  /* uintptr_t ra */
+};
+
 static TCGHelperInfo info_helper_st32_mmu = {
     .flags = TCG_CALL_NO_WG,
     .typemask = dh_typemask(void, 0)
@@ -886,6 +899,16 @@ static TCGHelperInfo info_helper_st64_mmu = {
               | dh_typemask(ptr, 5)  /* uintptr_t ra */
 };
 
+static TCGHelperInfo info_helper_st128_mmu = {
+    .flags = TCG_CALL_NO_WG,
+    .typemask = dh_typemask(void, 0)
+              | dh_typemask(env, 1)
+              | dh_typemask(tl, 2)   /* target_ulong addr */
+              | dh_typemask(i128, 3) /* Int128 data */
+              | dh_typemask(i32, 4)  /* unsigned oi */
+              | dh_typemask(ptr, 5)  /* uintptr_t ra */
+};
+
 #ifdef CONFIG_TCG_INTERPRETER
 static ffi_type *typecode_to_ffi(int argmask)
 {
@@ -1299,8 +1322,10 @@ static void tcg_context_init(unsigned max_cpus)
 
     init_call_layout(&info_helper_ld32_mmu);
     init_call_layout(&info_helper_ld64_mmu);
+    init_call_layout(&info_helper_ld128_mmu);
     init_call_layout(&info_helper_st32_mmu);
     init_call_layout(&info_helper_st64_mmu);
+    init_call_layout(&info_helper_st128_mmu);
 
 #ifdef CONFIG_TCG_INTERPRETER
     init_ffi_layouts();
@@ -5399,6 +5424,8 @@ static unsigned tcg_out_helper_add_mov(TCGMovExtend *mov,
                                        TCGType dst_type, TCGType src_type,
                                        TCGReg lo, TCGReg hi)
 {
+    MemOp reg_mo;
+
     if (dst_type <= TCG_TYPE_REG) {
         MemOp src_ext;
 
@@ -5426,19 +5453,25 @@ static unsigned tcg_out_helper_add_mov(TCGMovExtend *mov,
         return 1;
     }
 
-    assert(TCG_TARGET_REG_BITS == 32);
+    if (TCG_TARGET_REG_BITS == 32) {
+        assert(dst_type == TCG_TYPE_I64);
+        reg_mo = MO_32;
+    } else {
+        assert(dst_type == TCG_TYPE_I128);
+        reg_mo = MO_64;
+    }
 
     mov[0].dst = loc[HOST_BIG_ENDIAN].arg_slot;
     mov[0].src = lo;
-    mov[0].dst_type = TCG_TYPE_I32;
-    mov[0].src_type = TCG_TYPE_I32;
-    mov[0].src_ext = MO_32;
+    mov[0].dst_type = TCG_TYPE_REG;
+    mov[0].src_type = TCG_TYPE_REG;
+    mov[0].src_ext = reg_mo;
 
     mov[1].dst = loc[!HOST_BIG_ENDIAN].arg_slot;
     mov[1].src = hi;
-    mov[1].dst_type = TCG_TYPE_I32;
-    mov[1].src_type = TCG_TYPE_I32;
-    mov[1].src_ext = MO_32;
+    mov[1].dst_type = TCG_TYPE_REG;
+    mov[1].src_type = TCG_TYPE_REG;
+    mov[1].src_ext = reg_mo;
 
     return 2;
 }
@@ -5461,6 +5494,9 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
     case MO_64:
         info = &info_helper_ld64_mmu;
         break;
+    case MO_128:
+        info = &info_helper_ld128_mmu;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -5475,8 +5511,33 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
     tcg_out_helper_load_slots(s, nmov, mov, parm);
 
-    /* No special attention for 32 and 64-bit return values. */
-    tcg_debug_assert(info->out_kind == TCG_CALL_RET_NORMAL);
+    switch (info->out_kind) {
+    case TCG_CALL_RET_NORMAL:
+    case TCG_CALL_RET_BY_VEC:
+        break;
+    case TCG_CALL_RET_BY_REF:
+        /*
+         * The return reference is in the first argument slot.
+         * We need memory in which to return: re-use the top of stack.
+         */
+        {
+            int ofs_slot0 = TCG_TARGET_CALL_STACK_OFFSET;
+
+            if (arg_slot_reg_p(0)) {
+                tcg_out_addi_ptr(s, tcg_target_call_iarg_regs[0],
+                                 TCG_REG_CALL_STACK, ofs_slot0);
+            } else {
+                tcg_debug_assert(parm->ntmp != 0);
+                tcg_out_addi_ptr(s, parm->tmp[0],
+                                 TCG_REG_CALL_STACK, ofs_slot0);
+                tcg_out_st(s, TCG_TYPE_PTR, parm->tmp[0],
+                           TCG_REG_CALL_STACK, ofs_slot0);
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
@@ -5485,11 +5546,18 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
                                   bool load_sign,
                                   const TCGLdstHelperParam *parm)
 {
+    MemOp mop = get_memop(ldst->oi);
     TCGMovExtend mov[2];
+    int ofs_slot0;
 
-    if (ldst->type <= TCG_TYPE_REG) {
-        MemOp mop = get_memop(ldst->oi);
+    switch (ldst->type) {
+    case TCG_TYPE_I64:
+        if (TCG_TARGET_REG_BITS == 32) {
+            break;
+        }
+        /* fall through */
 
+    case TCG_TYPE_I32:
         mov[0].dst = ldst->datalo_reg;
         mov[0].src = tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, 0);
         mov[0].dst_type = ldst->type;
@@ -5515,25 +5583,49 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
             mov[0].src_ext = mop & MO_SSIZE;
         }
         tcg_out_movext1(s, mov);
-    } else {
-        assert(TCG_TARGET_REG_BITS == 32);
+        return;
 
-        mov[0].dst = ldst->datalo_reg;
-        mov[0].src =
-            tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
-        mov[0].dst_type = TCG_TYPE_I32;
-        mov[0].src_type = TCG_TYPE_I32;
-        mov[0].src_ext = MO_32;
+    case TCG_TYPE_I128:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        ofs_slot0 = TCG_TARGET_CALL_STACK_OFFSET;
+        switch (TCG_TARGET_CALL_RET_I128) {
+        case TCG_CALL_RET_NORMAL:
+            break;
+        case TCG_CALL_RET_BY_VEC:
+            tcg_out_st(s, TCG_TYPE_V128,
+                       tcg_target_call_oarg_reg(TCG_CALL_RET_BY_VEC, 0),
+                       TCG_REG_CALL_STACK, ofs_slot0);
+            /* fall through */
+        case TCG_CALL_RET_BY_REF:
+            tcg_out_ld(s, TCG_TYPE_I64, ldst->datalo_reg,
+                       TCG_REG_CALL_STACK, ofs_slot0 + 8 * HOST_BIG_ENDIAN);
+            tcg_out_ld(s, TCG_TYPE_I64, ldst->datahi_reg,
+                       TCG_REG_CALL_STACK, ofs_slot0 + 8 * !HOST_BIG_ENDIAN);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+        break;
 
-        mov[1].dst = ldst->datahi_reg;
-        mov[1].src =
-            tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, !HOST_BIG_ENDIAN);
-        mov[1].dst_type = TCG_TYPE_REG;
-        mov[1].src_type = TCG_TYPE_REG;
-        mov[1].src_ext = MO_32;
-
-        tcg_out_movext2(s, mov, mov + 1, parm->ntmp ? parm->tmp[0] : -1);
+    default:
+        g_assert_not_reached();
     }
+
+    mov[0].dst = ldst->datalo_reg;
+    mov[0].src =
+        tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
+    mov[0].dst_type = TCG_TYPE_I32;
+    mov[0].src_type = TCG_TYPE_I32;
+    mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
+
+    mov[1].dst = ldst->datahi_reg;
+    mov[1].src =
+        tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, !HOST_BIG_ENDIAN);
+    mov[1].dst_type = TCG_TYPE_REG;
+    mov[1].src_type = TCG_TYPE_REG;
+    mov[1].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
+
+    tcg_out_movext2(s, mov, mov + 1, parm->ntmp ? parm->tmp[0] : -1);
 }
 
 static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
@@ -5557,6 +5649,10 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         info = &info_helper_st64_mmu;
         data_type = TCG_TYPE_I64;
         break;
+    case MO_128:
+        info = &info_helper_st128_mmu;
+        data_type = TCG_TYPE_I128;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -5574,13 +5670,47 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
     /* Handle data argument. */
     loc = &info->in[next_arg];
-    n = tcg_out_helper_add_mov(mov + nmov, loc, data_type, ldst->type,
-                               ldst->datalo_reg, ldst->datahi_reg);
-    next_arg += n;
-    nmov += n;
-    tcg_debug_assert(nmov <= ARRAY_SIZE(mov));
+    switch (loc->kind) {
+    case TCG_CALL_ARG_NORMAL:
+    case TCG_CALL_ARG_EXTEND_U:
+    case TCG_CALL_ARG_EXTEND_S:
+        n = tcg_out_helper_add_mov(mov + nmov, loc, data_type, ldst->type,
+                                   ldst->datalo_reg, ldst->datahi_reg);
+        next_arg += n;
+        nmov += n;
+        tcg_out_helper_load_slots(s, nmov, mov, parm);
+        break;
+
+    case TCG_CALL_ARG_BY_REF:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        tcg_debug_assert(data_type == TCG_TYPE_I128);
+        tcg_out_st(s, TCG_TYPE_I64,
+                   HOST_BIG_ENDIAN ? ldst->datahi_reg : ldst->datalo_reg,
+                   TCG_REG_CALL_STACK, arg_slot_stk_ofs(loc[0].ref_slot));
+        tcg_out_st(s, TCG_TYPE_I64,
+                   HOST_BIG_ENDIAN ? ldst->datalo_reg : ldst->datahi_reg,
+                   TCG_REG_CALL_STACK, arg_slot_stk_ofs(loc[1].ref_slot));
+
+        tcg_out_helper_load_slots(s, nmov, mov, parm);
+
+        if (arg_slot_reg_p(loc->arg_slot)) {
+            tcg_out_addi_ptr(s, tcg_target_call_iarg_regs[loc->arg_slot],
+                             TCG_REG_CALL_STACK,
+                             arg_slot_stk_ofs(loc->ref_slot));
+        } else {
+            tcg_debug_assert(parm->ntmp != 0);
+            tcg_out_addi_ptr(s, parm->tmp[0], TCG_REG_CALL_STACK,
+                             arg_slot_stk_ofs(loc->ref_slot));
+            tcg_out_st(s, TCG_TYPE_PTR, parm->tmp[0],
+                       TCG_REG_CALL_STACK, arg_slot_stk_ofs(loc->arg_slot));
+        }
+        next_arg += 2;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
-    tcg_out_helper_load_slots(s, nmov, mov, parm);
     tcg_out_helper_load_common_args(s, ldst, parm, info, next_arg);
 }
 
-- 
2.34.1


