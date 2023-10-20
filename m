Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B8D7D1770
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM3-0007yI-1b; Fri, 20 Oct 2023 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLh-0007ka-GF
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLZ-0008Bh-IM
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso1184928b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834631; x=1698439431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kr+C20DtXtMGy3xs/PIBOfM94TBLe/tVvjYddrVGe/s=;
 b=VYK1KCH8P88I1lQcPtliJgur28/Cvh5PwVaYNli3FUZvqQ4CMC//Q3VaFA9ulhfUrJ
 m69nR+qBddUE4XGtj3uJs1cHY3vni4MulZXd7fpoUlPQtGBBYNmKti6mfABV8hl87nMi
 5UO2d4zKb133HyO2SyIJrGGh0NmfC8uvWTz1rKMgDMyVHXXnOREzpejiCqNyL1hQq6tb
 HwcFjsou36fGqEsSXLJ8qblBfBbfEXoEKHkS2Rc/LNZiZUZyq0efmKNzxcQl4zsnn1AI
 IDULg2s/WnckL5BQDMFvv5N7SdOSrljNQCdYRL3OTk4xz9Dd282xk8XOV8RIiieaIMPx
 7CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834631; x=1698439431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr+C20DtXtMGy3xs/PIBOfM94TBLe/tVvjYddrVGe/s=;
 b=K713+T4Cf1LIQkrXuAqH737pHUU7z2ZBSerIQ/6CqpzlOPMUO/mxJD/cnGETAhnQJo
 Dmhlaq1zlS+B41+pWo98oEkZcimxAIXqvmllEkseMjq6Fkbgk7ml0pHURGKCAjYp20lX
 YWgJfHPZ31UEKa5MqqSdl0/R2n8NtKvkZ9zQ7aKpHKBEmxxpkjZXZ5pOFxXbiaODtAdh
 QWTUMiWoyUYOXgNqM3Z9XE7exaHw9CASwerIzxSX0pcp5i2PThnP5yMTCOG8I6N1DdAG
 W+2NK+bUxhTgHZ/91QG7c5eTHP/jtFFIAVrqfOoGvefpxXL6wcFi2PHAay1kIOMkQMuO
 cKIA==
X-Gm-Message-State: AOJu0Yy8OcTd9PVeS5xanpdrNj3NJqKOzWwQLUIKKXle+F5t6nB0uCh1
 zrvZFB9F/j1VzUIIzsjJel7JFNZIsbrr+aIrkBw=
X-Google-Smtp-Source: AGHT+IGNkexM96nN65R+76815n4z/UR/WGXkS1IA/C5hBtFQGMs40ARITpXnx81Q4qMMQYyWMoe6Ug==
X-Received: by 2002:a05:6a00:1747:b0:6b1:c1c4:ae98 with SMTP id
 j7-20020a056a00174700b006b1c1c4ae98mr3458507pfc.18.1697834630740; 
 Fri, 20 Oct 2023 13:43:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 20/65] target/hppa: Fix hppa64 addressing
Date: Fri, 20 Oct 2023 13:42:46 -0700
Message-Id: <20231020204331.139847-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

In form_gva and cpu_get_tb_cpu_state, we must truncate when PSW_W == 0.
In space_select, the bits that choose the space depend on PSW_W.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  7 +++----
 target/hppa/translate.c | 22 +++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 622b4af890..2182437882 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -273,7 +273,7 @@ static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
 #ifdef CONFIG_USER_ONLY
     return off;
 #else
-    off &= (psw & PSW_W ? 0x3fffffffffffffffull : 0xffffffffull);
+    off &= psw & PSW_W ? MAKE_64BIT_MASK(0, 62) : MAKE_64BIT_MASK(0, 32);
     return spc | off;
 #endif
 }
@@ -314,9 +314,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     flags |= env->psw & (PSW_W | PSW_C | PSW_D);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    *pc = (env->psw & PSW_C
-           ? hppa_form_gva_psw(env->psw, env->iasq_f, env->iaoq_f & -4)
-           : env->iaoq_f & -4);
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
     *cs_base = env->iasq_f;
 
     /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 83115c944b..c7d17900f1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -764,6 +764,13 @@ static bool gen_illegal(DisasContext *ctx)
     } while (0)
 #endif
 
+static target_ureg gva_offset_mask(DisasContext *ctx)
+{
+    return (ctx->tb_flags & PSW_W
+            ? MAKE_64BIT_MASK(0, 62)
+            : MAKE_64BIT_MASK(0, 32));
+}
+
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
     return translator_use_goto_tb(&ctx->base, dest);
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


