Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B387CEA6C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESe-0001gB-0a; Wed, 18 Oct 2023 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEST-0001BJ-Tq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:07 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESR-0004SS-Uo
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1e9baf16a86so3880737fac.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665923; x=1698270723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZGDloHtnLt/m04cAgCo8iimUueJiT9M8I7gLtdl/IY=;
 b=u/y0vKPooJ3GUw/ERNgSRhtlaoW5VM58Z1a22m4rSxSNNfQrDZRxvoiEtZ3lm80oyf
 sX+5tXqRkshxpFbIYbPCYXRcUm3Q+O1Z0Y0Q52LdTF2TgmIK/ZFCnfY6LIixkrAdXIJK
 hHTwjgTslWok0lmZp7tBr70h40tZrf7cRm30x+IIIJHOLCApr2gjgIES2Na+I7NOnvww
 GMPS1JQ1oVrnrbd3b1e5VFlTBTEAC/+2H48Mzqnij0e4T0vrPJlj0oc+9HvX4xpspaiu
 26U0b3CQz53qV4DxuzfOqguhuf60NAasBQp79/LSHKDCiU/ehxohECczp/DI5I+aEgSr
 G0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665923; x=1698270723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZGDloHtnLt/m04cAgCo8iimUueJiT9M8I7gLtdl/IY=;
 b=Sy3SvMqNprUXax7QabejsLVbnQWDwGXdAQ17diWe8mwITXDETRHvTdkz84Rfp0OL3W
 7ZmJv0oAg+Uu38QObR6kJDod7Nku94/3yxPyM8tngDrvizpgtCtkhXObqtEKK/iNcq/E
 +vxY8OOgaBKb6MC4fkPQCITIKM6dzg7kd6UGW+SSSBNHNqSG67+0VRcXHFolvuSkTmjp
 byx0BpjRyjK/NI87uOT6Iqhf3BLPSmBzpRw3B1gsvA2KYicZH5Yr5LYTN9j3/3HL8SPI
 8ttof3zHFU6F23Fxuyo1bVoUESxK+MW1a1he2wLLOmPMhYeEgfdZNsdq3MV8yU307JHL
 LpfQ==
X-Gm-Message-State: AOJu0YxdTrjFPR7E625QBv8vljum1JMPsLMszFTAhczpI0VfnwxETjTX
 aGn8gGin4cC6zj5O8MDd7C5Hn5nHVRR90ZyQtr8=
X-Google-Smtp-Source: AGHT+IEILVFqb/c+Oug0Yj2MEqXkgMvnU5W0542MlLv1MrhpmAPTKrOtPf5I74odRxuRGGJTARgD6A==
X-Received: by 2002:a05:6871:8aa:b0:1b4:4a2e:33f1 with SMTP id
 r42-20020a05687108aa00b001b44a2e33f1mr747815oaq.29.1697665922790; 
 Wed, 18 Oct 2023 14:52:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 31/61] target/hppa: Decode d for unit instructions
Date: Wed, 18 Oct 2023 14:51:05 -0700
Message-Id: <20231018215135.1561375-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
index 5eecced442..ed00b58fbc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1423,12 +1423,11 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
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
@@ -2751,7 +2750,7 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
     return nullify_end(ctx);
 }
 
-static bool trans_uxor(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     TCGv_reg tcg_r1, tcg_r2;
 
@@ -2760,11 +2759,11 @@ static bool trans_uxor(DisasContext *ctx, arg_rrr_cf *a)
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
 
@@ -2775,21 +2774,21 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_cf *a, bool is_tc)
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
 
@@ -2800,19 +2799,19 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
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


