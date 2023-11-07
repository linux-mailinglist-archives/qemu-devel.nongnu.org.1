Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE07E3387
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPT-0001Ap-Kl; Mon, 06 Nov 2023 22:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COb-0007Hz-Bz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COM-0000iB-Oh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:53 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so37383085ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326277; x=1699931077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZQfRGRQVyJPekW6ejX/CWdupdE4Dg4Nz+X0zThatbog=;
 b=VA1hnRUHP80a7ZZu9TR2biFg8KE4WKGAOHsSz2xWr4Qxq93IW41hAPQXnEWKc1gdKx
 b78L0gsLLbdjxNH3OdbNOwRML/KWyclL+9VaREIdlYwvHCURz5CPRnUF29IFXh24pvSn
 zw7eAIUsu4HxsEc02Z3Ql0oJc1uDYpUIDTDTNQIJ5+R0LqpUhT+B3VsY10ZN/ZOXqfJ5
 emaha6whT5rtL8PaxGRHSfmXzWYHzqMArwBSxjFA6frfzgzesOKHt2OSpsrhefBCSWgN
 M29TzPXHTtlwfcJX6KPBza2/OTbFUywvuhBplSZg6tZnY5DQgyAsr4tuMglbn5RN6e/r
 +NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326277; x=1699931077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQfRGRQVyJPekW6ejX/CWdupdE4Dg4Nz+X0zThatbog=;
 b=dveH1o4SyGif/i+gPS+kRs686HWFVHc1dqTnDqRlhuCv6sbZQvEVJJbfcscLz9/YTI
 T87rYK8ftIH0M5B75tPh2kdRxcPecV8oHzmP+CemrE0ACTh97fezNbdpy5eXgTdbqI6O
 axIeg7P2eWQMjUISFjrMaAdoRhBkvTyjgknuiapeGMstcSqCUfJAFJxLLl3DfRrzYnYi
 RPLLgXThiAIw2Km1ko/K3cooozpfsAKjz67DzGO3s3uDPvcAi3bxwy+C3Tfx5UZA79PA
 sgpxIOU3/k5O7qoyfOeEW89Iiu+MHV4GPO4UWyrk81VLcMLSal4ohl5GHCfc1EOXmuE8
 bmpg==
X-Gm-Message-State: AOJu0YwQfkkziK7aGRBPPpmoNL2v4AXbedWUxcG3CO7ydzYvJXPsj/sT
 mOcc4MIh2RcZjvnZzxoh73BX07YZQrM2wPJ4lHg=
X-Google-Smtp-Source: AGHT+IEf5Stf0GgF11x6Qiq+F/ZXq74cEj5Luf5l/C+DIsyrfPf7DEmWUTyQBZtzmFDNXneh7F9Jow==
X-Received: by 2002:a17:903:4093:b0:1cc:3371:7b6f with SMTP id
 z19-20020a170903409300b001cc33717b6fmr19228272plc.8.1699326277229; 
 Mon, 06 Nov 2023 19:04:37 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/85] target/hppa: Decode d for unit instructions
Date: Mon,  6 Nov 2023 19:03:21 -0800
Message-Id: <20231107030407.8979-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 14 +++++++-------
 target/hppa/translate.c  | 25 ++++++++++++-------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 26ca9f1063..03b1a11cac 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -59,7 +59,7 @@
 # All insns that need to form a virtual address should use this set.
 &ldst           t b x disp sp m scale size
 
-&rr_cf          t r cf
+&rr_cf_d        t r cf d
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_sh      t r1 r2 cf sh
@@ -72,7 +72,7 @@
 # Format definitions
 ####
 
-@rr_cf          ...... r:5 ..... cf:4 ....... t:5       &rr_cf
+@rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
 @rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
@@ -156,13 +156,13 @@ andcm           000010 ..... ..... .... 000000 . .....  @rrr_cf_d
 and             000010 ..... ..... .... 001000 . .....  @rrr_cf_d
 or              000010 ..... ..... .... 001001 . .....  @rrr_cf_d
 xor             000010 ..... ..... .... 001010 . .....  @rrr_cf_d
-uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
+uxor            000010 ..... ..... .... 001110 . .....  @rrr_cf_d
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
 cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
-uaddcm          000010 ..... ..... .... 100110 0 .....  @rrr_cf
-uaddcm_tc       000010 ..... ..... .... 100111 0 .....  @rrr_cf
-dcor            000010 ..... 00000 .... 101110 0 .....  @rr_cf
-dcor_i          000010 ..... 00000 .... 101111 0 .....  @rr_cf
+uaddcm          000010 ..... ..... .... 100110 . .....  @rrr_cf_d
+uaddcm_tc       000010 ..... ..... .... 100111 . .....  @rrr_cf_d
+dcor            000010 ..... 00000 .... 101110 . .....  @rr_cf_d
+dcor_i          000010 ..... 00000 .... 101111 . .....  @rr_cf_d
 
 add             000010 ..... ..... .... 0110.. - .....  @rrr_cf_sh
 add_l           000010 ..... ..... .... 1010.. 0 .....  @rrr_cf_sh
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 227d59b263..a0785bb32c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1436,12 +1436,11 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
 }
 
 static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                    TCGv_reg in2, unsigned cf, bool is_tc,
+                    TCGv_reg in2, unsigned cf, bool d, bool is_tc,
                     void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest;
     DisasCond cond;
-    bool d = false;
 
     if (cf == 0) {
         dest = dest_gpr(ctx, rt);
@@ -2772,7 +2771,7 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
     return nullify_end(ctx);
 }
 
-static bool trans_uxor(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     TCGv_reg tcg_r1, tcg_r2;
 
@@ -2781,11 +2780,11 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf *a)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, false, tcg_gen_xor_reg);
+    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, false, tcg_gen_xor_reg);
     return nullify_end(ctx);
 }
 
-static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf *a, bool is_tc)
+static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a, bool is_tc)
 {
     TCGv_reg tcg_r1, tcg_r2, tmp;
 
@@ -2796,21 +2795,21 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf *a, bool is_tc)
     tcg_r2 = load_gpr(ctx, a->r2);
     tmp = tcg_temp_new();
     tcg_gen_not_reg(tmp, tcg_r2);
-    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, is_tc, tcg_gen_add_reg);
+    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_reg);
     return nullify_end(ctx);
 }
 
-static bool trans_uaddcm(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_uaddcm(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_uaddcm(ctx, a, false);
 }
 
-static bool trans_uaddcm_tc(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_uaddcm_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_uaddcm(ctx, a, true);
 }
 
-static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
+static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
 {
     TCGv_reg tmp;
 
@@ -2821,19 +2820,19 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
     if (!is_i) {
         tcg_gen_not_reg(tmp, tmp);
     }
-    tcg_gen_andi_reg(tmp, tmp, 0x11111111);
+    tcg_gen_andi_reg(tmp, tmp, (target_ureg)0x1111111111111111ull);
     tcg_gen_muli_reg(tmp, tmp, 6);
-    do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, false,
+    do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, a->d, false,
             is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
     return nullify_end(ctx);
 }
 
-static bool trans_dcor(DisasContext *ctx, arg_rr_cf *a)
+static bool trans_dcor(DisasContext *ctx, arg_rr_cf_d *a)
 {
     return do_dcor(ctx, a, false);
 }
 
-static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf *a)
+static bool trans_dcor_i(DisasContext *ctx, arg_rr_cf_d *a)
 {
     return do_dcor(ctx, a, true);
 }
-- 
2.34.1


