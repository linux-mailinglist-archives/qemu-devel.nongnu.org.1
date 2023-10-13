Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB77C7FC2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4h-0001u2-0d; Fri, 13 Oct 2023 03:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4S-0000xF-VC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4E-0006ty-97
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507975d34e8so1100325e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183920; x=1697788720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbCML2QUJhAHlr4bUtsgIbYnvvz0tb/IISc/i9CJrtM=;
 b=tEdhqJBGHLw76Tvbwh00C8tO/+Qegu4ZUf/OLIA2ULOhgS9BOvhJfneddKsD0ZGMTf
 8GH90bckFjmE2ssOYN5BAg3VCLJXQ3oJ0lxhY+Y2DG6I/wf7eE6wfuRfPsXE0VWoPuHr
 1/pSesEorKmehJwZL3l0uaGy04iceb4nIlDuFSqFpa9qPt7ZE+I+p0xfJME30bDl26Rx
 xzB/1Ht5J0IExQk2adAtcToxIg4EZtobcISZk6at+u3lUTauI9KSEe/P8M1cPLn3DgkO
 81z/vpK53sJL8SICUFoyt5scUeke5Tobm82ormfh0Hi17NaWNW0UymhuWueTI1d8Rqho
 Tcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183920; x=1697788720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbCML2QUJhAHlr4bUtsgIbYnvvz0tb/IISc/i9CJrtM=;
 b=k6fWpDRnofqUKktLiJWOgho8rup25UG961VC9vNMMrBi0uwBTj4eGycrDrvMFVdWFL
 JmSkNYU/0l82adiCpqNt2bRAA03nrqsBncykKcCLxg+OJwO0Z00benDnt072A8SCVE5t
 HtonL/0EZSZCtEId0gyeXYAi0cP69ZfqzEQgi4u1u1L03VmbRxNalDuZRshbXfZ4g54G
 290diqJ+4o+xuZK628DJeNc6J2eT9OJ2RqPtNfugzh+wuGh3OORQx0QwnQ/Zax3acVFx
 HLdKY6vL5EvQUBGRfzfsx2RG72M4BHoGQgrFfMglehlW9/hLig7DATQD/T8SihOR+kUC
 0FcA==
X-Gm-Message-State: AOJu0Yx3OuvdF5qZksbAc3nfKtroxtcJuxCrKGM/A94FDsELUeB5Mtyk
 +QUdRMqFS5Q8zbFvUNnErqkelue2IzZDs6ZY6tw=
X-Google-Smtp-Source: AGHT+IE/st3NDC9zlSbBdOH+xcSB+dj+ZkFy+2Z2XKl9z0Jwy5wQybSRTiYA8KiUG/nzBhHqm/4KeQ==
X-Received: by 2002:a05:6512:3608:b0:4ff:9a75:211e with SMTP id
 f8-20020a056512360800b004ff9a75211emr18136034lfs.42.1697183919868; 
 Fri, 13 Oct 2023 00:58:39 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 24/78] target/alpha: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:51 +0300
Message-Id: <d165f3af5d496ace73ef9cb26929c3ad9e628ba3.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
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
 target/alpha/helper.c    | 6 +++---
 target/alpha/translate.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 970c869771..1afdc1beec 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -436,45 +436,45 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
     int idx = -1;
 
     /* We never take interrupts while in PALmode.  */
     if (env->flags & ENV_FLAG_PAL_MODE) {
         return false;
     }
 
     /* Fall through the switch, collecting the highest priority
        interrupt that isn't masked by the processor status IPL.  */
     /* ??? This hard-codes the OSF/1 interrupt levels.  */
     switch ((env->flags >> ENV_FLAG_PS_SHIFT) & PS_INT_MASK) {
     case 0 ... 3:
         if (interrupt_request & CPU_INTERRUPT_HARD) {
             idx = EXCP_DEV_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 4:
         if (interrupt_request & CPU_INTERRUPT_TIMER) {
             idx = EXCP_CLK_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 5:
         if (interrupt_request & CPU_INTERRUPT_SMP) {
             idx = EXCP_SMP_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 6:
         if (interrupt_request & CPU_INTERRUPT_MCHK) {
             idx = EXCP_MCHK;
         }
     }
     if (idx >= 0) {
         cs->exception_index = idx;
         env->error_code = 0;
         alpha_cpu_do_interrupt(cs);
         return true;
     }
     return false;
 }
 
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..19e1d2ed86 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1377,1493 +1377,1493 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 {
     int32_t disp21, disp16, disp12 __attribute__((unused));
     uint16_t fn11;
     uint8_t opc, ra, rb, rc, fpfn, fn7, lit;
     bool islit, real_islit;
     TCGv va, vb, vc, tmp, tmp2;
     TCGv_i32 t32;
     DisasJumpType ret;
 
     /* Decode all instruction fields */
     opc = extract32(insn, 26, 6);
     ra = extract32(insn, 21, 5);
     rb = extract32(insn, 16, 5);
     rc = extract32(insn, 0, 5);
     real_islit = islit = extract32(insn, 12, 1);
     lit = extract32(insn, 13, 8);
 
     disp21 = sextract32(insn, 0, 21);
     disp16 = sextract32(insn, 0, 16);
     disp12 = sextract32(insn, 0, 12);
 
     fn11 = extract32(insn, 5, 11);
     fpfn = extract32(insn, 5, 6);
     fn7 = extract32(insn, 5, 7);
 
     if (rb == 31 && !islit) {
         islit = true;
         lit = 0;
     }
 
     ret = DISAS_NEXT;
     switch (opc) {
     case 0x00:
         /* CALL_PAL */
         ret = gen_call_pal(ctx, insn & 0x03ffffff);
         break;
     case 0x01:
         /* OPC01 */
         goto invalid_opc;
     case 0x02:
         /* OPC02 */
         goto invalid_opc;
     case 0x03:
         /* OPC03 */
         goto invalid_opc;
     case 0x04:
         /* OPC04 */
         goto invalid_opc;
     case 0x05:
         /* OPC05 */
         goto invalid_opc;
     case 0x06:
         /* OPC06 */
         goto invalid_opc;
     case 0x07:
         /* OPC07 */
         goto invalid_opc;
 
     case 0x09:
         /* LDAH */
         disp16 = (uint32_t)disp16 << 16;
-        /* fall through */
+        fallthrough;
     case 0x08:
         /* LDA */
         va = dest_gpr(ctx, ra);
         /* It's worth special-casing immediate loads.  */
         if (rb == 31) {
             tcg_gen_movi_i64(va, disp16);
         } else {
             tcg_gen_addi_i64(va, load_gpr(ctx, rb), disp16);
         }
         break;
 
     case 0x0A:
         /* LDBU */
         REQUIRE_AMASK(BWX);
         gen_load_int(ctx, ra, rb, disp16, MO_UB, 0, 0);
         break;
     case 0x0B:
         /* LDQ_U */
         gen_load_int(ctx, ra, rb, disp16, MO_LEUQ, 1, 0);
         break;
     case 0x0C:
         /* LDWU */
         REQUIRE_AMASK(BWX);
         gen_load_int(ctx, ra, rb, disp16, MO_LEUW, 0, 0);
         break;
     case 0x0D:
         /* STW */
         REQUIRE_AMASK(BWX);
         gen_store_int(ctx, ra, rb, disp16, MO_LEUW, 0);
         break;
     case 0x0E:
         /* STB */
         REQUIRE_AMASK(BWX);
         gen_store_int(ctx, ra, rb, disp16, MO_UB, 0);
         break;
     case 0x0F:
         /* STQ_U */
         gen_store_int(ctx, ra, rb, disp16, MO_LEUQ, 1);
         break;
 
     case 0x10:
         vc = dest_gpr(ctx, rc);
         vb = load_gpr_lit(ctx, rb, lit, islit);
 
         if (ra == 31) {
             if (fn7 == 0x00) {
                 /* Special case ADDL as SEXTL.  */
                 tcg_gen_ext32s_i64(vc, vb);
                 break;
             }
             if (fn7 == 0x29) {
                 /* Special case SUBQ as NEGQ.  */
                 tcg_gen_neg_i64(vc, vb);
                 break;
             }
         }
 
         va = load_gpr(ctx, ra);
         switch (fn7) {
         case 0x00:
             /* ADDL */
             tcg_gen_add_i64(vc, va, vb);
             tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x02:
             /* S4ADDL */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_add_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
             break;
         case 0x09:
             /* SUBL */
             tcg_gen_sub_i64(vc, va, vb);
             tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x0B:
             /* S4SUBL */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_sub_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
             break;
         case 0x0F:
             /* CMPBGE */
             if (ra == 31) {
                 /* Special case 0 >= X as X == 0.  */
                 gen_helper_cmpbe0(vc, vb);
             } else {
                 gen_helper_cmpbge(vc, va, vb);
             }
             break;
         case 0x12:
             /* S8ADDL */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_add_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
             break;
         case 0x1B:
             /* S8SUBL */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_sub_i64(tmp, tmp, vb);
             tcg_gen_ext32s_i64(vc, tmp);
             break;
         case 0x1D:
             /* CMPULT */
             tcg_gen_setcond_i64(TCG_COND_LTU, vc, va, vb);
             break;
         case 0x20:
             /* ADDQ */
             tcg_gen_add_i64(vc, va, vb);
             break;
         case 0x22:
             /* S4ADDQ */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_add_i64(vc, tmp, vb);
             break;
         case 0x29:
             /* SUBQ */
             tcg_gen_sub_i64(vc, va, vb);
             break;
         case 0x2B:
             /* S4SUBQ */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 2);
             tcg_gen_sub_i64(vc, tmp, vb);
             break;
         case 0x2D:
             /* CMPEQ */
             tcg_gen_setcond_i64(TCG_COND_EQ, vc, va, vb);
             break;
         case 0x32:
             /* S8ADDQ */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_add_i64(vc, tmp, vb);
             break;
         case 0x3B:
             /* S8SUBQ */
             tmp = tcg_temp_new();
             tcg_gen_shli_i64(tmp, va, 3);
             tcg_gen_sub_i64(vc, tmp, vb);
             break;
         case 0x3D:
             /* CMPULE */
             tcg_gen_setcond_i64(TCG_COND_LEU, vc, va, vb);
             break;
         case 0x40:
             /* ADDL/V */
             tmp = tcg_temp_new();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_add_i64(tmp, tmp, vc);
             tcg_gen_ext32s_i64(vc, tmp);
             gen_helper_check_overflow(tcg_env, vc, tmp);
             break;
         case 0x49:
             /* SUBL/V */
             tmp = tcg_temp_new();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_sub_i64(tmp, tmp, vc);
             tcg_gen_ext32s_i64(vc, tmp);
             gen_helper_check_overflow(tcg_env, vc, tmp);
             break;
         case 0x4D:
             /* CMPLT */
             tcg_gen_setcond_i64(TCG_COND_LT, vc, va, vb);
             break;
         case 0x60:
             /* ADDQ/V */
             tmp = tcg_temp_new();
             tmp2 = tcg_temp_new();
             tcg_gen_eqv_i64(tmp, va, vb);
             tcg_gen_mov_i64(tmp2, va);
             tcg_gen_add_i64(vc, va, vb);
             tcg_gen_xor_i64(tmp2, tmp2, vc);
             tcg_gen_and_i64(tmp, tmp, tmp2);
             tcg_gen_shri_i64(tmp, tmp, 63);
             tcg_gen_movi_i64(tmp2, 0);
             gen_helper_check_overflow(tcg_env, tmp, tmp2);
             break;
         case 0x69:
             /* SUBQ/V */
             tmp = tcg_temp_new();
             tmp2 = tcg_temp_new();
             tcg_gen_xor_i64(tmp, va, vb);
             tcg_gen_mov_i64(tmp2, va);
             tcg_gen_sub_i64(vc, va, vb);
             tcg_gen_xor_i64(tmp2, tmp2, vc);
             tcg_gen_and_i64(tmp, tmp, tmp2);
             tcg_gen_shri_i64(tmp, tmp, 63);
             tcg_gen_movi_i64(tmp2, 0);
             gen_helper_check_overflow(tcg_env, tmp, tmp2);
             break;
         case 0x6D:
             /* CMPLE */
             tcg_gen_setcond_i64(TCG_COND_LE, vc, va, vb);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x11:
         if (fn7 == 0x20) {
             if (rc == 31) {
                 /* Special case BIS as NOP.  */
                 break;
             }
             if (ra == 31) {
                 /* Special case BIS as MOV.  */
                 vc = dest_gpr(ctx, rc);
                 if (islit) {
                     tcg_gen_movi_i64(vc, lit);
                 } else {
                     tcg_gen_mov_i64(vc, load_gpr(ctx, rb));
                 }
                 break;
             }
         }
 
         vc = dest_gpr(ctx, rc);
         vb = load_gpr_lit(ctx, rb, lit, islit);
 
         if (fn7 == 0x28 && ra == 31) {
             /* Special case ORNOT as NOT.  */
             tcg_gen_not_i64(vc, vb);
             break;
         }
 
         va = load_gpr(ctx, ra);
         switch (fn7) {
         case 0x00:
             /* AND */
             tcg_gen_and_i64(vc, va, vb);
             break;
         case 0x08:
             /* BIC */
             tcg_gen_andc_i64(vc, va, vb);
             break;
         case 0x14:
             /* CMOVLBS */
             tmp = tcg_temp_new();
             tcg_gen_andi_i64(tmp, va, 1);
             tcg_gen_movcond_i64(TCG_COND_NE, vc, tmp, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x16:
             /* CMOVLBC */
             tmp = tcg_temp_new();
             tcg_gen_andi_i64(tmp, va, 1);
             tcg_gen_movcond_i64(TCG_COND_EQ, vc, tmp, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x20:
             /* BIS */
             tcg_gen_or_i64(vc, va, vb);
             break;
         case 0x24:
             /* CMOVEQ */
             tcg_gen_movcond_i64(TCG_COND_EQ, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x26:
             /* CMOVNE */
             tcg_gen_movcond_i64(TCG_COND_NE, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x28:
             /* ORNOT */
             tcg_gen_orc_i64(vc, va, vb);
             break;
         case 0x40:
             /* XOR */
             tcg_gen_xor_i64(vc, va, vb);
             break;
         case 0x44:
             /* CMOVLT */
             tcg_gen_movcond_i64(TCG_COND_LT, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x46:
             /* CMOVGE */
             tcg_gen_movcond_i64(TCG_COND_GE, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x48:
             /* EQV */
             tcg_gen_eqv_i64(vc, va, vb);
             break;
         case 0x61:
             /* AMASK */
             REQUIRE_REG_31(ra);
             tcg_gen_andi_i64(vc, vb, ~ctx->amask);
             break;
         case 0x64:
             /* CMOVLE */
             tcg_gen_movcond_i64(TCG_COND_LE, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x66:
             /* CMOVGT */
             tcg_gen_movcond_i64(TCG_COND_GT, vc, va, load_zero(ctx),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x6C:
             /* IMPLVER */
             REQUIRE_REG_31(ra);
             tcg_gen_movi_i64(vc, ctx->implver);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x12:
         vc = dest_gpr(ctx, rc);
         va = load_gpr(ctx, ra);
         switch (fn7) {
         case 0x02:
             /* MSKBL */
             gen_msk_l(ctx, vc, va, rb, islit, lit, 0x01);
             break;
         case 0x06:
             /* EXTBL */
             gen_ext_l(ctx, vc, va, rb, islit, lit, 0x01);
             break;
         case 0x0B:
             /* INSBL */
             gen_ins_l(ctx, vc, va, rb, islit, lit, 0x01);
             break;
         case 0x12:
             /* MSKWL */
             gen_msk_l(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x16:
             /* EXTWL */
             gen_ext_l(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x1B:
             /* INSWL */
             gen_ins_l(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x22:
             /* MSKLL */
             gen_msk_l(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x26:
             /* EXTLL */
             gen_ext_l(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x2B:
             /* INSLL */
             gen_ins_l(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x30:
             /* ZAP */
             if (islit) {
                 gen_zapnoti(vc, va, ~lit);
             } else {
                 gen_helper_zap(vc, va, load_gpr(ctx, rb));
             }
             break;
         case 0x31:
             /* ZAPNOT */
             if (islit) {
                 gen_zapnoti(vc, va, lit);
             } else {
                 gen_helper_zapnot(vc, va, load_gpr(ctx, rb));
             }
             break;
         case 0x32:
             /* MSKQL */
             gen_msk_l(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         case 0x34:
             /* SRL */
             if (islit) {
                 tcg_gen_shri_i64(vc, va, lit & 0x3f);
             } else {
                 tmp = tcg_temp_new();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_shr_i64(vc, va, tmp);
             }
             break;
         case 0x36:
             /* EXTQL */
             gen_ext_l(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         case 0x39:
             /* SLL */
             if (islit) {
                 tcg_gen_shli_i64(vc, va, lit & 0x3f);
             } else {
                 tmp = tcg_temp_new();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_shl_i64(vc, va, tmp);
             }
             break;
         case 0x3B:
             /* INSQL */
             gen_ins_l(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         case 0x3C:
             /* SRA */
             if (islit) {
                 tcg_gen_sari_i64(vc, va, lit & 0x3f);
             } else {
                 tmp = tcg_temp_new();
                 vb = load_gpr(ctx, rb);
                 tcg_gen_andi_i64(tmp, vb, 0x3f);
                 tcg_gen_sar_i64(vc, va, tmp);
             }
             break;
         case 0x52:
             /* MSKWH */
             gen_msk_h(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x57:
             /* INSWH */
             gen_ins_h(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x5A:
             /* EXTWH */
             gen_ext_h(ctx, vc, va, rb, islit, lit, 0x03);
             break;
         case 0x62:
             /* MSKLH */
             gen_msk_h(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x67:
             /* INSLH */
             gen_ins_h(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x6A:
             /* EXTLH */
             gen_ext_h(ctx, vc, va, rb, islit, lit, 0x0f);
             break;
         case 0x72:
             /* MSKQH */
             gen_msk_h(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         case 0x77:
             /* INSQH */
             gen_ins_h(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         case 0x7A:
             /* EXTQH */
             gen_ext_h(ctx, vc, va, rb, islit, lit, 0xff);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x13:
         vc = dest_gpr(ctx, rc);
         vb = load_gpr_lit(ctx, rb, lit, islit);
         va = load_gpr(ctx, ra);
         switch (fn7) {
         case 0x00:
             /* MULL */
             tcg_gen_mul_i64(vc, va, vb);
             tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x20:
             /* MULQ */
             tcg_gen_mul_i64(vc, va, vb);
             break;
         case 0x30:
             /* UMULH */
             tmp = tcg_temp_new();
             tcg_gen_mulu2_i64(tmp, vc, va, vb);
             break;
         case 0x40:
             /* MULL/V */
             tmp = tcg_temp_new();
             tcg_gen_ext32s_i64(tmp, va);
             tcg_gen_ext32s_i64(vc, vb);
             tcg_gen_mul_i64(tmp, tmp, vc);
             tcg_gen_ext32s_i64(vc, tmp);
             gen_helper_check_overflow(tcg_env, vc, tmp);
             break;
         case 0x60:
             /* MULQ/V */
             tmp = tcg_temp_new();
             tmp2 = tcg_temp_new();
             tcg_gen_muls2_i64(vc, tmp, va, vb);
             tcg_gen_sari_i64(tmp2, vc, 63);
             gen_helper_check_overflow(tcg_env, tmp, tmp2);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x14:
         REQUIRE_AMASK(FIX);
         vc = dest_fpr(ctx, rc);
         switch (fpfn) { /* fn11 & 0x3F */
         case 0x04:
             /* ITOFS */
             REQUIRE_REG_31(rb);
             REQUIRE_FEN;
             t32 = tcg_temp_new_i32();
             va = load_gpr(ctx, ra);
             tcg_gen_extrl_i64_i32(t32, va);
             gen_helper_memory_to_s(vc, t32);
             break;
         case 0x0A:
             /* SQRTF */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             vb = load_fpr(ctx, rb);
             gen_helper_sqrtf(vc, tcg_env, vb);
             break;
         case 0x0B:
             /* SQRTS */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_sqrts(ctx, rb, rc, fn11);
             break;
         case 0x14:
             /* ITOFF */
             REQUIRE_REG_31(rb);
             REQUIRE_FEN;
             t32 = tcg_temp_new_i32();
             va = load_gpr(ctx, ra);
             tcg_gen_extrl_i64_i32(t32, va);
             gen_helper_memory_to_f(vc, t32);
             break;
         case 0x24:
             /* ITOFT */
             REQUIRE_REG_31(rb);
             REQUIRE_FEN;
             va = load_gpr(ctx, ra);
             tcg_gen_mov_i64(vc, va);
             break;
         case 0x2A:
             /* SQRTG */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             vb = load_fpr(ctx, rb);
             gen_helper_sqrtg(vc, tcg_env, vb);
             break;
         case 0x02B:
             /* SQRTT */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_sqrtt(ctx, rb, rc, fn11);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x15:
         /* VAX floating point */
         /* XXX: rounding mode and trap are ignored (!) */
         vc = dest_fpr(ctx, rc);
         vb = load_fpr(ctx, rb);
         va = load_fpr(ctx, ra);
         switch (fpfn) { /* fn11 & 0x3F */
         case 0x00:
             /* ADDF */
             REQUIRE_FEN;
             gen_helper_addf(vc, tcg_env, va, vb);
             break;
         case 0x01:
             /* SUBF */
             REQUIRE_FEN;
             gen_helper_subf(vc, tcg_env, va, vb);
             break;
         case 0x02:
             /* MULF */
             REQUIRE_FEN;
             gen_helper_mulf(vc, tcg_env, va, vb);
             break;
         case 0x03:
             /* DIVF */
             REQUIRE_FEN;
             gen_helper_divf(vc, tcg_env, va, vb);
             break;
         case 0x1E:
             /* CVTDG -- TODO */
             REQUIRE_REG_31(ra);
             goto invalid_opc;
         case 0x20:
             /* ADDG */
             REQUIRE_FEN;
             gen_helper_addg(vc, tcg_env, va, vb);
             break;
         case 0x21:
             /* SUBG */
             REQUIRE_FEN;
             gen_helper_subg(vc, tcg_env, va, vb);
             break;
         case 0x22:
             /* MULG */
             REQUIRE_FEN;
             gen_helper_mulg(vc, tcg_env, va, vb);
             break;
         case 0x23:
             /* DIVG */
             REQUIRE_FEN;
             gen_helper_divg(vc, tcg_env, va, vb);
             break;
         case 0x25:
             /* CMPGEQ */
             REQUIRE_FEN;
             gen_helper_cmpgeq(vc, tcg_env, va, vb);
             break;
         case 0x26:
             /* CMPGLT */
             REQUIRE_FEN;
             gen_helper_cmpglt(vc, tcg_env, va, vb);
             break;
         case 0x27:
             /* CMPGLE */
             REQUIRE_FEN;
             gen_helper_cmpgle(vc, tcg_env, va, vb);
             break;
         case 0x2C:
             /* CVTGF */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_helper_cvtgf(vc, tcg_env, vb);
             break;
         case 0x2D:
             /* CVTGD -- TODO */
             REQUIRE_REG_31(ra);
             goto invalid_opc;
         case 0x2F:
             /* CVTGQ */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_helper_cvtgq(vc, tcg_env, vb);
             break;
         case 0x3C:
             /* CVTQF */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_helper_cvtqf(vc, tcg_env, vb);
             break;
         case 0x3E:
             /* CVTQG */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_helper_cvtqg(vc, tcg_env, vb);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x16:
         /* IEEE floating-point */
         switch (fpfn) { /* fn11 & 0x3F */
         case 0x00:
             /* ADDS */
             REQUIRE_FEN;
             gen_adds(ctx, ra, rb, rc, fn11);
             break;
         case 0x01:
             /* SUBS */
             REQUIRE_FEN;
             gen_subs(ctx, ra, rb, rc, fn11);
             break;
         case 0x02:
             /* MULS */
             REQUIRE_FEN;
             gen_muls(ctx, ra, rb, rc, fn11);
             break;
         case 0x03:
             /* DIVS */
             REQUIRE_FEN;
             gen_divs(ctx, ra, rb, rc, fn11);
             break;
         case 0x20:
             /* ADDT */
             REQUIRE_FEN;
             gen_addt(ctx, ra, rb, rc, fn11);
             break;
         case 0x21:
             /* SUBT */
             REQUIRE_FEN;
             gen_subt(ctx, ra, rb, rc, fn11);
             break;
         case 0x22:
             /* MULT */
             REQUIRE_FEN;
             gen_mult(ctx, ra, rb, rc, fn11);
             break;
         case 0x23:
             /* DIVT */
             REQUIRE_FEN;
             gen_divt(ctx, ra, rb, rc, fn11);
             break;
         case 0x24:
             /* CMPTUN */
             REQUIRE_FEN;
             gen_cmptun(ctx, ra, rb, rc, fn11);
             break;
         case 0x25:
             /* CMPTEQ */
             REQUIRE_FEN;
             gen_cmpteq(ctx, ra, rb, rc, fn11);
             break;
         case 0x26:
             /* CMPTLT */
             REQUIRE_FEN;
             gen_cmptlt(ctx, ra, rb, rc, fn11);
             break;
         case 0x27:
             /* CMPTLE */
             REQUIRE_FEN;
             gen_cmptle(ctx, ra, rb, rc, fn11);
             break;
         case 0x2C:
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             if (fn11 == 0x2AC || fn11 == 0x6AC) {
                 /* CVTST */
                 gen_cvtst(ctx, rb, rc, fn11);
             } else {
                 /* CVTTS */
                 gen_cvtts(ctx, rb, rc, fn11);
             }
             break;
         case 0x2F:
             /* CVTTQ */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_cvttq(ctx, rb, rc, fn11);
             break;
         case 0x3C:
             /* CVTQS */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_cvtqs(ctx, rb, rc, fn11);
             break;
         case 0x3E:
             /* CVTQT */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             gen_cvtqt(ctx, rb, rc, fn11);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x17:
         switch (fn11) {
         case 0x010:
             /* CVTLQ */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             vc = dest_fpr(ctx, rc);
             vb = load_fpr(ctx, rb);
             gen_cvtlq(vc, vb);
             break;
         case 0x020:
             /* CPYS */
             REQUIRE_FEN;
             if (rc == 31) {
                 /* Special case CPYS as FNOP.  */
             } else {
                 vc = dest_fpr(ctx, rc);
                 va = load_fpr(ctx, ra);
                 if (ra == rb) {
                     /* Special case CPYS as FMOV.  */
                     tcg_gen_mov_i64(vc, va);
                 } else {
                     vb = load_fpr(ctx, rb);
                     gen_cpy_mask(vc, va, vb, 0, 0x8000000000000000ULL);
                 }
             }
             break;
         case 0x021:
             /* CPYSN */
             REQUIRE_FEN;
             vc = dest_fpr(ctx, rc);
             vb = load_fpr(ctx, rb);
             va = load_fpr(ctx, ra);
             gen_cpy_mask(vc, va, vb, 1, 0x8000000000000000ULL);
             break;
         case 0x022:
             /* CPYSE */
             REQUIRE_FEN;
             vc = dest_fpr(ctx, rc);
             vb = load_fpr(ctx, rb);
             va = load_fpr(ctx, ra);
             gen_cpy_mask(vc, va, vb, 0, 0xFFF0000000000000ULL);
             break;
         case 0x024:
             /* MT_FPCR */
             REQUIRE_FEN;
             va = load_fpr(ctx, ra);
             gen_helper_store_fpcr(tcg_env, va);
             if (ctx->tb_rm == QUAL_RM_D) {
                 /* Re-do the copy of the rounding mode to fp_status
                    the next time we use dynamic rounding.  */
                 ctx->tb_rm = -1;
             }
             break;
         case 0x025:
             /* MF_FPCR */
             REQUIRE_FEN;
             va = dest_fpr(ctx, ra);
             gen_helper_load_fpcr(va, tcg_env);
             break;
         case 0x02A:
             /* FCMOVEQ */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_EQ, ra, rb, rc);
             break;
         case 0x02B:
             /* FCMOVNE */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_NE, ra, rb, rc);
             break;
         case 0x02C:
             /* FCMOVLT */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_LT, ra, rb, rc);
             break;
         case 0x02D:
             /* FCMOVGE */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_GE, ra, rb, rc);
             break;
         case 0x02E:
             /* FCMOVLE */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_LE, ra, rb, rc);
             break;
         case 0x02F:
             /* FCMOVGT */
             REQUIRE_FEN;
             gen_fcmov(ctx, TCG_COND_GT, ra, rb, rc);
             break;
         case 0x030: /* CVTQL */
         case 0x130: /* CVTQL/V */
         case 0x530: /* CVTQL/SV */
             REQUIRE_REG_31(ra);
             REQUIRE_FEN;
             vc = dest_fpr(ctx, rc);
             vb = load_fpr(ctx, rb);
             gen_helper_cvtql(vc, tcg_env, vb);
             gen_fp_exc_raise(rc, fn11);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x18:
         switch ((uint16_t)disp16) {
         case 0x0000:
             /* TRAPB */
             /* No-op.  */
             break;
         case 0x0400:
             /* EXCB */
             /* No-op.  */
             break;
         case 0x4000:
             /* MB */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
             break;
         case 0x4400:
             /* WMB */
             tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
             break;
         case 0x8000:
             /* FETCH */
             /* No-op */
             break;
         case 0xA000:
             /* FETCH_M */
             /* No-op */
             break;
         case 0xC000:
             /* RPCC */
             va = dest_gpr(ctx, ra);
             if (translator_io_start(&ctx->base)) {
                 ret = DISAS_PC_STALE;
             }
             gen_helper_load_pcc(va, tcg_env);
             break;
         case 0xE000:
             /* RC */
             gen_rx(ctx, ra, 0);
             break;
         case 0xE800:
             /* ECB */
             break;
         case 0xF000:
             /* RS */
             gen_rx(ctx, ra, 1);
             break;
         case 0xF800:
             /* WH64 */
             /* No-op */
             break;
         case 0xFC00:
             /* WH64EN */
             /* No-op */
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x19:
         /* HW_MFPR (PALcode) */
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         va = dest_gpr(ctx, ra);
         ret = gen_mfpr(ctx, va, insn & 0xffff);
         break;
 #else
         goto invalid_opc;
 #endif
 
     case 0x1A:
         /* JMP, JSR, RET, JSR_COROUTINE.  These only differ by the branch
            prediction stack action, which of course we don't implement.  */
         vb = load_gpr(ctx, rb);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
         if (ra != 31) {
             tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
         }
         ret = DISAS_PC_UPDATED;
         break;
 
     case 0x1B:
         /* HW_LD (PALcode) */
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             TCGv addr = tcg_temp_new();
             vb = load_gpr(ctx, rb);
             va = dest_gpr(ctx, ra);
 
             tcg_gen_addi_i64(addr, vb, disp12);
             switch ((insn >> 12) & 0xF) {
             case 0x0:
                 /* Longword physical access (hw_ldl/p) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_PHYS_IDX, MO_LESL | MO_ALIGN);
                 break;
             case 0x1:
                 /* Quadword physical access (hw_ldq/p) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_PHYS_IDX, MO_LEUQ | MO_ALIGN);
                 break;
             case 0x2:
                 /* Longword physical access with lock (hw_ldl_l/p) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_PHYS_IDX, MO_LESL | MO_ALIGN);
                 tcg_gen_mov_i64(cpu_lock_addr, addr);
                 tcg_gen_mov_i64(cpu_lock_value, va);
                 break;
             case 0x3:
                 /* Quadword physical access with lock (hw_ldq_l/p) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_PHYS_IDX, MO_LEUQ | MO_ALIGN);
                 tcg_gen_mov_i64(cpu_lock_addr, addr);
                 tcg_gen_mov_i64(cpu_lock_value, va);
                 break;
             case 0x4:
                 /* Longword virtual PTE fetch (hw_ldl/v) */
                 goto invalid_opc;
             case 0x5:
                 /* Quadword virtual PTE fetch (hw_ldq/v) */
                 goto invalid_opc;
                 break;
             case 0x6:
                 /* Invalid */
                 goto invalid_opc;
             case 0x7:
                 /* Invaliid */
                 goto invalid_opc;
             case 0x8:
                 /* Longword virtual access (hw_ldl) */
                 goto invalid_opc;
             case 0x9:
                 /* Quadword virtual access (hw_ldq) */
                 goto invalid_opc;
             case 0xA:
                 /* Longword virtual access with protection check (hw_ldl/w) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_KERNEL_IDX,
                                     MO_LESL | MO_ALIGN);
                 break;
             case 0xB:
                 /* Quadword virtual access with protection check (hw_ldq/w) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_KERNEL_IDX,
                                     MO_LEUQ | MO_ALIGN);
                 break;
             case 0xC:
                 /* Longword virtual access with alt access mode (hw_ldl/a)*/
                 goto invalid_opc;
             case 0xD:
                 /* Quadword virtual access with alt access mode (hw_ldq/a) */
                 goto invalid_opc;
             case 0xE:
                 /* Longword virtual access with alternate access mode and
                    protection checks (hw_ldl/wa) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_USER_IDX,
                                     MO_LESL | MO_ALIGN);
                 break;
             case 0xF:
                 /* Quadword virtual access with alternate access mode and
                    protection checks (hw_ldq/wa) */
                 tcg_gen_qemu_ld_i64(va, addr, MMU_USER_IDX,
                                     MO_LEUQ | MO_ALIGN);
                 break;
             }
             break;
         }
 #else
         goto invalid_opc;
 #endif
 
     case 0x1C:
         vc = dest_gpr(ctx, rc);
         if (fn7 == 0x70) {
             /* FTOIT */
             REQUIRE_AMASK(FIX);
             REQUIRE_REG_31(rb);
             va = load_fpr(ctx, ra);
             tcg_gen_mov_i64(vc, va);
             break;
         } else if (fn7 == 0x78) {
             /* FTOIS */
             REQUIRE_AMASK(FIX);
             REQUIRE_REG_31(rb);
             t32 = tcg_temp_new_i32();
             va = load_fpr(ctx, ra);
             gen_helper_s_to_memory(t32, va);
             tcg_gen_ext_i32_i64(vc, t32);
             break;
         }
 
         vb = load_gpr_lit(ctx, rb, lit, islit);
         switch (fn7) {
         case 0x00:
             /* SEXTB */
             REQUIRE_AMASK(BWX);
             REQUIRE_REG_31(ra);
             tcg_gen_ext8s_i64(vc, vb);
             break;
         case 0x01:
             /* SEXTW */
             REQUIRE_AMASK(BWX);
             REQUIRE_REG_31(ra);
             tcg_gen_ext16s_i64(vc, vb);
             break;
         case 0x30:
             /* CTPOP */
             REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_ctpop_i64(vc, vb);
             break;
         case 0x31:
             /* PERR */
             REQUIRE_AMASK(MVI);
             REQUIRE_NO_LIT;
             va = load_gpr(ctx, ra);
             gen_helper_perr(vc, va, vb);
             break;
         case 0x32:
             /* CTLZ */
             REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_clzi_i64(vc, vb, 64);
             break;
         case 0x33:
             /* CTTZ */
             REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_ctzi_i64(vc, vb, 64);
             break;
         case 0x34:
             /* UNPKBW */
             REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_unpkbw(vc, vb);
             break;
         case 0x35:
             /* UNPKBL */
             REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_unpkbl(vc, vb);
             break;
         case 0x36:
             /* PKWB */
             REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_pkwb(vc, vb);
             break;
         case 0x37:
             /* PKLB */
             REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_pklb(vc, vb);
             break;
         case 0x38:
             /* MINSB8 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minsb8(vc, va, vb);
             break;
         case 0x39:
             /* MINSW4 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minsw4(vc, va, vb);
             break;
         case 0x3A:
             /* MINUB8 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minub8(vc, va, vb);
             break;
         case 0x3B:
             /* MINUW4 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minuw4(vc, va, vb);
             break;
         case 0x3C:
             /* MAXUB8 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxub8(vc, va, vb);
             break;
         case 0x3D:
             /* MAXUW4 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxuw4(vc, va, vb);
             break;
         case 0x3E:
             /* MAXSB8 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxsb8(vc, va, vb);
             break;
         case 0x3F:
             /* MAXSW4 */
             REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxsw4(vc, va, vb);
             break;
         default:
             goto invalid_opc;
         }
         break;
 
     case 0x1D:
         /* HW_MTPR (PALcode) */
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         vb = load_gpr(ctx, rb);
         ret = gen_mtpr(ctx, vb, insn & 0xffff);
         break;
 #else
         goto invalid_opc;
 #endif
 
     case 0x1E:
         /* HW_RET (PALcode) */
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         if (rb == 31) {
             /* Pre-EV6 CPUs interpreted this as HW_REI, loading the return
                address from EXC_ADDR.  This turns out to be useful for our
                emulation PALcode, so continue to accept it.  */
             vb = dest_sink(ctx);
             tcg_gen_ld_i64(vb, tcg_env, offsetof(CPUAlphaState, exc_addr));
         } else {
             vb = load_gpr(ctx, rb);
         }
         tcg_gen_movi_i64(cpu_lock_addr, -1);
         st_flag_byte(load_zero(ctx), ENV_FLAG_RX_SHIFT);
         tmp = tcg_temp_new();
         tcg_gen_andi_i64(tmp, vb, 1);
         st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
         tcg_gen_andi_i64(cpu_pc, vb, ~3);
         /* Allow interrupts to be recognized right away.  */
         ret = DISAS_PC_UPDATED_NOCHAIN;
         break;
 #else
         goto invalid_opc;
 #endif
 
     case 0x1F:
         /* HW_ST (PALcode) */
 #ifndef CONFIG_USER_ONLY
         REQUIRE_TB_FLAG(ENV_FLAG_PAL_MODE);
         {
             switch ((insn >> 12) & 0xF) {
             case 0x0:
                 /* Longword physical access */
                 va = load_gpr(ctx, ra);
                 vb = load_gpr(ctx, rb);
                 tmp = tcg_temp_new();
                 tcg_gen_addi_i64(tmp, vb, disp12);
                 tcg_gen_qemu_st_i64(va, tmp, MMU_PHYS_IDX, MO_LESL | MO_ALIGN);
                 break;
             case 0x1:
                 /* Quadword physical access */
                 va = load_gpr(ctx, ra);
                 vb = load_gpr(ctx, rb);
                 tmp = tcg_temp_new();
                 tcg_gen_addi_i64(tmp, vb, disp12);
                 tcg_gen_qemu_st_i64(va, tmp, MMU_PHYS_IDX, MO_LEUQ | MO_ALIGN);
                 break;
             case 0x2:
                 /* Longword physical access with lock */
                 ret = gen_store_conditional(ctx, ra, rb, disp12,
                                             MMU_PHYS_IDX, MO_LESL | MO_ALIGN);
                 break;
             case 0x3:
                 /* Quadword physical access with lock */
                 ret = gen_store_conditional(ctx, ra, rb, disp12,
                                             MMU_PHYS_IDX, MO_LEUQ | MO_ALIGN);
                 break;
             case 0x4:
                 /* Longword virtual access */
                 goto invalid_opc;
             case 0x5:
                 /* Quadword virtual access */
                 goto invalid_opc;
             case 0x6:
                 /* Invalid */
                 goto invalid_opc;
             case 0x7:
                 /* Invalid */
                 goto invalid_opc;
             case 0x8:
                 /* Invalid */
                 goto invalid_opc;
             case 0x9:
                 /* Invalid */
                 goto invalid_opc;
             case 0xA:
                 /* Invalid */
                 goto invalid_opc;
             case 0xB:
                 /* Invalid */
                 goto invalid_opc;
             case 0xC:
                 /* Longword virtual access with alternate access mode */
                 goto invalid_opc;
             case 0xD:
                 /* Quadword virtual access with alternate access mode */
                 goto invalid_opc;
             case 0xE:
                 /* Invalid */
                 goto invalid_opc;
             case 0xF:
                 /* Invalid */
                 goto invalid_opc;
             }
             break;
         }
 #else
         goto invalid_opc;
 #endif
     case 0x20:
         /* LDF */
         REQUIRE_FEN;
         gen_load_fp(ctx, ra, rb, disp16, gen_ldf);
         break;
     case 0x21:
         /* LDG */
         REQUIRE_FEN;
         gen_load_fp(ctx, ra, rb, disp16, gen_ldg);
         break;
     case 0x22:
         /* LDS */
         REQUIRE_FEN;
         gen_load_fp(ctx, ra, rb, disp16, gen_lds);
         break;
     case 0x23:
         /* LDT */
         REQUIRE_FEN;
         gen_load_fp(ctx, ra, rb, disp16, gen_ldt);
         break;
     case 0x24:
         /* STF */
         REQUIRE_FEN;
         gen_store_fp(ctx, ra, rb, disp16, gen_stf);
         break;
     case 0x25:
         /* STG */
         REQUIRE_FEN;
         gen_store_fp(ctx, ra, rb, disp16, gen_stg);
         break;
     case 0x26:
         /* STS */
         REQUIRE_FEN;
         gen_store_fp(ctx, ra, rb, disp16, gen_sts);
         break;
     case 0x27:
         /* STT */
         REQUIRE_FEN;
         gen_store_fp(ctx, ra, rb, disp16, gen_stt);
         break;
     case 0x28:
         /* LDL */
         gen_load_int(ctx, ra, rb, disp16, MO_LESL, 0, 0);
         break;
     case 0x29:
         /* LDQ */
         gen_load_int(ctx, ra, rb, disp16, MO_LEUQ, 0, 0);
         break;
     case 0x2A:
         /* LDL_L */
         gen_load_int(ctx, ra, rb, disp16, MO_LESL | MO_ALIGN, 0, 1);
         break;
     case 0x2B:
         /* LDQ_L */
         gen_load_int(ctx, ra, rb, disp16, MO_LEUQ | MO_ALIGN, 0, 1);
         break;
     case 0x2C:
         /* STL */
         gen_store_int(ctx, ra, rb, disp16, MO_LEUL, 0);
         break;
     case 0x2D:
         /* STQ */
         gen_store_int(ctx, ra, rb, disp16, MO_LEUQ, 0);
         break;
     case 0x2E:
         /* STL_C */
         ret = gen_store_conditional(ctx, ra, rb, disp16,
                                     ctx->mem_idx, MO_LESL | MO_ALIGN);
         break;
     case 0x2F:
         /* STQ_C */
         ret = gen_store_conditional(ctx, ra, rb, disp16,
                                     ctx->mem_idx, MO_LEUQ | MO_ALIGN);
         break;
     case 0x30:
         /* BR */
         ret = gen_bdirect(ctx, ra, disp21);
         break;
     case 0x31: /* FBEQ */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x32: /* FBLT */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x33: /* FBLE */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x34:
         /* BSR */
         ret = gen_bdirect(ctx, ra, disp21);
         break;
     case 0x35: /* FBNE */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x36: /* FBGE */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x37: /* FBGT */
         REQUIRE_FEN;
         ret = gen_fbcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     case 0x38:
         /* BLBC */
         ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
         break;
     case 0x39:
         /* BEQ */
         ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
         break;
     case 0x3A:
         /* BLT */
         ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
         break;
     case 0x3B:
         /* BLE */
         ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
         break;
     case 0x3C:
         /* BLBS */
         ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
         break;
     case 0x3D:
         /* BNE */
         ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
         break;
     case 0x3E:
         /* BGE */
         ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
         break;
     case 0x3F:
         /* BGT */
         ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
         break;
     raise_fen:
         ret = gen_excp(ctx, EXCP_FEN, 0);
         break;
     }
 
     return ret;
 }
@@ -2929,27 +2929,29 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     switch (ctx->base.is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
         if (use_goto_tb(ctx, ctx->base.pc_next)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
             tcg_gen_exit_tb(ctx->base.tb, 0);
         }
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_UPDATED:
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_PC_UPDATED_NOCHAIN:
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


