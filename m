Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E194C7DEA18
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYp-0006ET-2j; Wed, 01 Nov 2023 21:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXl-0005kZ-4D
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:45 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXj-0001cD-Ew
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d31f3e8ca8so244250a34.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888642; x=1699493442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/ED2o2s4ms+vsY/bEE/bt2PcFzZktCazvwqho7s/dw=;
 b=aEeU6Ch6Rl+XqdKd1HXtBxdXGlfAFq+e9Ze7EFVn5llEmjv/5q/xED4slRai6MPfua
 pS51WXp6bGlTdtnNn3J379ZjNjBgqShLWTbUE4pn5d/0TWQrlfBVrpGu2ORMxexbFiiY
 hx62VF7WVyuKfgDFYC/s3yoqdUsPnzUC9EyZwEIUj+dqGcR2AxI1vkgthjMs6Zgei1dH
 l8OHf8mU438FwNuvpChF+cZLKhAdZlAKVRAsHeg4pQSLPqzQa4acv8U7MpDAhlBkvlFU
 vMuvAzVMWdXBEMEHSmdSp4mQz42FwK590CfdAcZLQWsHDJbExcPH4mjLZyOrth0XQF0i
 zCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888642; x=1699493442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/ED2o2s4ms+vsY/bEE/bt2PcFzZktCazvwqho7s/dw=;
 b=QLSGFTtw9m55EUp1TH54PZRgsYytYE3CH+nedq+uAQQMirt0DXSWTCC428Z5CHqym2
 uhKdiIuTQIAg9t62NIjFAbH1RZFXzX9nFHB324MQA6EgUGTNqtGB+xmPjWgNp0BC7HIp
 WSYFqV+t4gsRRlBGvhigAfPTosE9wbU5MEYkiw+wwXdUWFMndoNvas6pgh7Z+V8vBf/A
 534MEZcn610w0i42oDWePQOKLVXGDqzn0Cq9IWxTRRRqO9zQ2lfiLbh3I+yLzbcH4JPi
 b6ns1/PDrTLJ5Z+nbtnBCqFJSNuXCSQh/MXoSm9YQjcEcWEYyU6Ig671ft0XYctfEi9M
 1CcQ==
X-Gm-Message-State: AOJu0Yxvu2L5UMpdWYyKA0LowMlODx0NYhka97+80F7NzKRNQ2uEZCnB
 fxqE5jun7V6pSWBTO84TxtmWTTCPSGNgYecDeyI=
X-Google-Smtp-Source: AGHT+IH1TeYoi4lF5PTTIROslfhZjAsyPuSjfo7AVu7+DB47qFz5Igow5B3H8OaSQEczLTk6qD8zzw==
X-Received: by 2002:a05:6830:110c:b0:6cd:4358:1f02 with SMTP id
 w12-20020a056830110c00b006cd43581f02mr19111087otq.34.1698888642252; 
 Wed, 01 Nov 2023 18:30:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 26/88] target/hppa: Fix hppa64 addressing
Date: Wed,  1 Nov 2023 18:29:14 -0700
Message-Id: <20231102013016.369010-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

In form_gva and cpu_get_tb_cpu_state, we must truncate when PSW_W == 0.
In space_select, the bits that choose the space depend on PSW_W.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  7 +++----
 target/hppa/translate.c | 22 +++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 2999df9ff9..cb838defb0 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -302,7 +302,7 @@ static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
 #ifdef CONFIG_USER_ONLY
     return off;
 #else
-    off &= (psw & PSW_W ? 0x3fffffffffffffffull : 0xffffffffull);
+    off &= psw & PSW_W ? MAKE_64BIT_MASK(0, 62) : MAKE_64BIT_MASK(0, 32);
     return spc | off;
 #endif
 }
@@ -343,9 +343,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    *pc = (env->psw & PSW_C
-           ? hppa_form_gva_psw(env->psw, env->iasq_f, env->iaoq_f & -4)
-           : env->iaoq_f & -4);
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
     *cs_base = env->iasq_f;
 
     /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 44c9911720..4e0bc48b09 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -710,6 +710,13 @@ static bool nullify_end(DisasContext *ctx)
     return true;
 }
 
+static target_ureg gva_offset_mask(DisasContext *ctx)
+{
+    return (ctx->tb_flags & PSW_W
+            ? MAKE_64BIT_MASK(0, 62)
+            : MAKE_64BIT_MASK(0, 32));
+}
+
 static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
 {
     if (unlikely(ival == -1)) {
@@ -1398,7 +1405,8 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
     tmp = tcg_temp_new();
     spc = tcg_temp_new_tl();
 
-    tcg_gen_shri_reg(tmp, base, TARGET_REGISTER_BITS - 5);
+    /* Extract top 2 bits of the address, shift left 3 for uint64_t index. */
+    tcg_gen_shri_reg(tmp, base, (ctx->tb_flags & PSW_W ? 64 : 32) - 5);
     tcg_gen_andi_reg(tmp, tmp, 030);
     tcg_gen_trunc_reg_ptr(ptr, tmp);
 
@@ -1415,6 +1423,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
 {
     TCGv_reg base = load_gpr(ctx, rb);
     TCGv_reg ofs;
+    TCGv_tl addr;
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
@@ -1429,18 +1438,13 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
     }
 
     *pofs = ofs;
-#ifdef CONFIG_USER_ONLY
-    *pgva = (modify <= 0 ? ofs : base);
-#else
-    TCGv_tl addr = tcg_temp_new_tl();
+    *pgva = addr = tcg_temp_new_tl();
     tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
-    if (ctx->tb_flags & PSW_W) {
-        tcg_gen_andi_tl(addr, addr, 0x3fffffffffffffffull);
-    }
+    tcg_gen_andi_tl(addr, addr, gva_offset_mask(ctx));
+#ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
     }
-    *pgva = addr;
 #endif
 }
 
-- 
2.34.1


