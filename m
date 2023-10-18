Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C47CEA58
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESh-0001mv-RA; Wed, 18 Oct 2023 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESK-00018k-5e
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:57 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESI-0004Qk-E3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:55 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so5076617fac.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665913; x=1698270713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9nUcdEt7w+NCkvnMW2YnG2igY5bd41b5qtUzVj7Mew=;
 b=GguMiPaldiSe/RdlR54LmFbmFXs6tyish59fcM3bwQlNmfkDSPnAEBePKfgV2ttwgJ
 msimo1/SNkxS1PVZ8AsLmT/2EfvhhqAI0b1wOEpTHvugQwK1sT1IppCv8XR3GYKTcOWQ
 66yJpB0HMcDME9YF2rrbTQ4+iqLhQSfOoxjsFySfeFPqkVjhyB/HElM1Jr5FbHcXf8Cj
 WO3p88QfE6mFXihEMrWn5dbZyPUHxljSx2xvryFcgUrfPfFyrDRcIqrYiOGO3BwonCQX
 5HKPaGvAnboxL1df7d3wYAuGPj8QkEF7rcnbl1QdfA8K3kidPx0Uddp4BLwf06e1VP5C
 eEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665913; x=1698270713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9nUcdEt7w+NCkvnMW2YnG2igY5bd41b5qtUzVj7Mew=;
 b=ZN491XaWMaTNoorIkxrC1L7oPUOtht3Ooi9+jECXe6mKtyGNu8a6CBuKK/uqKe8hxR
 ozxzI2sHt/JbcArEPXv+uKQWIG0KbgQgSpmwuyvQBgOBFjM9EzwzSOBuWQgs/Z09pwNC
 jHkafhgCrtKAnccJ2J7oMfUxuzQMwKU35qPkMzq2Npn9g/vYD2sIASuoSZHpyHWQjGvy
 nTVrAfCKeyzqBPvRzax35xMzEuxf+FRiHc5nI8OWJtQdh2m2UMUoVwDCh4mz49YQk1RN
 o7ZF5qYkQL6aj7jG7ddXlYEVcdHyM/DAFW1hzl7cUuNRHQzi9p2EOUXBGsPNPruwgIPr
 rfKg==
X-Gm-Message-State: AOJu0Yw83egH2qASlM+kZYVmgKEKYxyq4Q7qHFtpN4jTZRkGAe3SHRrw
 wBAtzM6KzuKlVR6rrz+5dH/ujDeFBsBnRVTAwD4=
X-Google-Smtp-Source: AGHT+IHdEDRoynh+oJMM40mbGuB/x7sP9Wu0L52H9F8wUXlw+/ZoKJosPfc2aC9Um3GipnJTF+Q0tA==
X-Received: by 2002:a05:6870:98a7:b0:1e9:d8a4:5523 with SMTP id
 eg39-20020a05687098a700b001e9d8a45523mr543486oab.41.1697665913171; 
 Wed, 18 Oct 2023 14:51:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 20/61] target/hppa: Fix hppa64 addressing
Date: Wed, 18 Oct 2023 14:50:54 -0700
Message-Id: <20231018215135.1561375-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
index 671e43ebd8..1a12b2a186 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,7 +272,7 @@ static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
 #ifdef CONFIG_USER_ONLY
     return off;
 #else
-    off &= (psw & PSW_W ? 0x3fffffffffffffffull : 0xffffffffull);
+    off &= psw & PSW_W ? MAKE_64BIT_MASK(0, 62) : MAKE_64BIT_MASK(0, 32);
     return spc | off;
 #endif
 }
@@ -313,9 +313,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
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
index 9d6670f91c..ace6fb0ab2 100644
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


