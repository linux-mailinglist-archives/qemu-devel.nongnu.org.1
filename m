Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCC7E33FE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRN-0003vy-6T; Mon, 06 Nov 2023 22:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRJ-0003te-IX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:41 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRH-0001ME-MI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:41 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso4943260a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326458; x=1699931258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RQKqVWPtgxXGrzYjTuQHxTd6qyqCynIOEiRaLSJd7Dw=;
 b=E+yLIaag5Yb2q4GMUpNhPHkXBBq6ty3s1+tzV9mcMv44cKHC9F5SiF81itw7OR4jJN
 YKRkdtZbA/45lQBAwK8xXMaqNPoAMQOGi0gtdVa3bkCl73w8zv7QVhnlJZnmbVbDTve9
 w/4BpJbi7pvjAKw3moCVnNIZntK+Hk0BbDniyRsw7vP3KsyRKmFh1WPFbUQlhA9bAHD5
 fBuyMVvxzXGJwKsBosVaIcyiYfIo86VT4/mZ9rx3e1+S5kS/RD+N5WlCSUGoYheXFWUS
 gOuFgAb5wZ7WtRBkbjUj62wEjAJ5FFuj8nG5G0VhB425zQC5ekaLgmvQ7g7oQy9tBGfi
 wpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326458; x=1699931258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQKqVWPtgxXGrzYjTuQHxTd6qyqCynIOEiRaLSJd7Dw=;
 b=FlhX4SIGfPrVf10v3OXX3oc07uipzZOtRRAHGI5oIaiwcN4zDyzy9LIKxr3Co8t522
 OilxgVzsQ9/M8aaP4v4/53rFKCtJtwqYVO/BwpB1CYaytEwfP0ky8K0+henZvTsCh0D9
 MihMuWSNZ9/Aan0l6Q3tC7lcU6Y57xJhQ5jhJsrjYYZtFXO9zYKuwsz+wiZkrwJnifJr
 KOi+KGouRQLAoP7+TRFLFu79RFj0s4zEsRaD9cly4Zk3abYzVGVLGG79GI4CjIXAXPEO
 53u+r7bWalqWa732FohjPmC1URxnJNiiRpOsgGYEkgsTWUZqS88iGJgcpAliww82QXaX
 kcEQ==
X-Gm-Message-State: AOJu0YxqVvqN98r2MYT1+lDTuncFwxfgyt1/HPNKEHyJP8IZ1PGUJYwl
 8YQhnfwR7vs2TMVreMC3IJSC/aq/wxiy2VxFF1E=
X-Google-Smtp-Source: AGHT+IHlxbi2xHf/rmIEcuC+8k5UNU2vfB35/HHLot3I7iOoO55e76tEt9l/kvsHRjHkx4vDZ2gSvA==
X-Received: by 2002:a17:90a:d708:b0:280:5b98:5450 with SMTP id
 y8-20020a17090ad70800b002805b985450mr22269369pju.15.1699326458336; 
 Mon, 06 Nov 2023 19:07:38 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/85] target/hppa: Decode d for cmpclr instructions
Date: Mon,  6 Nov 2023 19:03:22 -0800
Message-Id: <20231107030407.8979-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 target/hppa/insns.decode |  6 ++++--
 target/hppa/translate.c  | 11 +++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 03b1a11cac..d4a03b0299 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -64,6 +64,7 @@
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_sh      t r1 r2 cf sh
 &rri_cf         t r i cf
+&rri_cf_d       t r i cf d
 
 &rrb_c_f        disp n c f r1 r2
 &rib_c_f        disp n c f r i
@@ -78,6 +79,7 @@
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
 @rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
+@rri_cf_d       ...... r:5  t:5  cf:4 d:1 ...........   &rri_cf_d i=%lowsign_11
 
 @rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
                 &rrb_c_f disp=%assemble_12
@@ -158,7 +160,7 @@ or              000010 ..... ..... .... 001001 . .....  @rrr_cf_d
 xor             000010 ..... ..... .... 001010 . .....  @rrr_cf_d
 uxor            000010 ..... ..... .... 001110 . .....  @rrr_cf_d
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
-cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
+cmpclr          000010 ..... ..... .... 100010 . .....  @rrr_cf_d
 uaddcm          000010 ..... ..... .... 100110 . .....  @rrr_cf_d
 uaddcm_tc       000010 ..... ..... .... 100111 . .....  @rrr_cf_d
 dcor            000010 ..... 00000 .... 101110 . .....  @rr_cf_d
@@ -189,7 +191,7 @@ addi_tc_tsv     101100 ..... ..... .... 1 ...........   @rri_cf
 subi            100101 ..... ..... .... 0 ...........   @rri_cf
 subi_tsv        100101 ..... ..... .... 1 ...........   @rri_cf
 
-cmpiclr         100100 ..... ..... .... 0 ...........   @rri_cf
+cmpiclr         100100 ..... ..... .... . ...........   @rri_cf_d
 
 ####
 # Index Mem
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a0785bb32c..8301d007ff 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1377,11 +1377,10 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
 }
 
 static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                      TCGv_reg in2, unsigned cf)
+                      TCGv_reg in2, unsigned cf, bool d)
 {
     TCGv_reg dest, sv;
     DisasCond cond;
-    bool d = false;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
@@ -2758,7 +2757,7 @@ static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
     return do_log_reg(ctx, a, tcg_gen_xor_reg);
 }
 
-static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     TCGv_reg tcg_r1, tcg_r2;
 
@@ -2767,7 +2766,7 @@ static bool trans_cmpclr(DisasContext *ctx, arg_rrr_cf *a)
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -2925,7 +2924,7 @@ static bool trans_subi_tsv(DisasContext *ctx, arg_rri_cf *a)
     return do_sub_imm(ctx, a, true);
 }
 
-static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
+static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
 {
     TCGv_reg tcg_im, tcg_r2;
 
@@ -2935,7 +2934,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
 
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
+    do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf, a->d);
 
     return nullify_end(ctx);
 }
-- 
2.34.1


