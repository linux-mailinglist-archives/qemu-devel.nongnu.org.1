Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622177E07A1
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy90-0005Xo-O4; Fri, 03 Nov 2023 13:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8P-0005Fa-71
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8I-0003aR-3Z
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so24607575ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033136; x=1699637936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94raU7rUG4SaFXDKyXSSaATMe2GXL+iedReuLCx526s=;
 b=zC2+CMtJtqTHLJNNS8fetXgNw/laLVhIZ2dqqSpPAK7NmLOg35Ov7ZFicnUMZN98Qy
 ibaMvB1SyxmqIw8V9e4fpYJmL48OKAQ1S8ItKZytsZzGOGseE5ZsJeP1c3OfppXnsJlA
 zh/5YSF78fJ1ctucKeHomqK54Fe3kfFrB/0bs+OBCngbFOkX6hQSv4oGR/Tp/wEspcC/
 3S+GhoKJj2Fw+ozutrw4+M/p7Z0xWkKSxzyWaJ+X6ULGmkw3GY5JV4m+TNmZOFoqfAln
 R55mE7htnmN7fLAxA3EesuYK4v3BGp3koBaRAJPDJeCjwXPCTX8J4PFd6G5akH/rsMKc
 f32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033136; x=1699637936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94raU7rUG4SaFXDKyXSSaATMe2GXL+iedReuLCx526s=;
 b=LkbSmOTK6KOmgIohkahpPWspp5JD/7WFUbyNAOij95JpupBaooyUyBZlQsnmr9O2Kf
 83q7OilAW01SDNzvjJvU7j14rMgFzmrJQhf5gmFPxtvbNVGG6Dfp1MLx96rbaTrfMTmz
 zv9W50mRwUsinA06bQFoHitM4a1Jg84+ysA9R+4vjZmfd8CSjXUjW7gIo3Xyeus+MCE6
 VvdtQdzxWUbwJj4OwUdFRIra52XHVocouMaGpip8VR0Pue+D0CoX6QfLB6mdRk2k9p1w
 w6YUEZDa5SyY8HYeZMe5+AXPmiLebEMRF4/RBMLtr/aScsL201iP6VvrgdeDgn8a6d3i
 8GVg==
X-Gm-Message-State: AOJu0Yyd5SRo4Tn5mzl4mMMzyjuLAYuidn7jFVVWjNu8VvGxJaqWHfik
 XllZVSK+jYUkQdV44eSa2P94dIH3dZgnAyaioMI=
X-Google-Smtp-Source: AGHT+IEXs23dqk2vgcmefCnJxWLIs6CYdBvYGX69hoRot4xsommEjNIAfD4iPZtTlfyR6XGoj4yAVg==
X-Received: by 2002:a17:902:db0c:b0:1cc:5833:cf57 with SMTP id
 m12-20020a170902db0c00b001cc5833cf57mr15358114plx.45.1699033136375; 
 Fri, 03 Nov 2023 10:38:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/22] target/sparc: Clear cexc and ftt in
 do_check_ieee_exceptions
Date: Fri,  3 Nov 2023 10:38:36 -0700
Message-Id: <20231103173841.33651-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Don't do the clearing explicitly before each FPop,
rather do it as part of the rest of exception handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/fop_helper.c |  2 ++
 target/sparc/translate.c  | 16 ----------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 22b412adb5..64f20e78f1 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -50,6 +50,8 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
     target_ulong status = get_float_exception_flags(&env->fp_status);
     target_ulong fsr = env->fsr;
 
+    fsr &= FSR_FTT_CEXC_NMASK;
+
     if (unlikely(status)) {
         /* Keep exception flags clear for next time.  */
         set_float_exception_flags(0, &env->fp_status);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1d5f36dafc..11d025f4ea 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4524,7 +4524,6 @@ static bool do_env_ff(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     tmp = gen_load_fpr_F(dc, a->rs);
     func(tmp, tcg_env, tmp);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4546,7 +4545,6 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4590,7 +4588,6 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4613,7 +4610,6 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4661,8 +4657,6 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
-
     t = gen_load_fpr_Q(dc, a->rs);
     func(t, tcg_env, t);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4685,7 +4679,6 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_Q(dc, a->rs);
     dst = tcg_temp_new_i32();
     func(dst, tcg_env, src);
@@ -4710,7 +4703,6 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_Q(dc, a->rs);
     dst = gen_dest_fpr_D(dc, a->rd);
     func(dst, tcg_env, src);
@@ -4808,7 +4800,6 @@ static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
@@ -4903,7 +4894,6 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
@@ -4930,7 +4920,6 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
         return raise_unimpfpop(dc);
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
@@ -4972,7 +4961,6 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
@@ -4998,7 +4986,6 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     dst = tcg_temp_new_i128();
@@ -5087,7 +5074,6 @@ static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     if (e) {
@@ -5112,7 +5098,6 @@ static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     if (e) {
@@ -5140,7 +5125,6 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     if (e) {
-- 
2.34.1


