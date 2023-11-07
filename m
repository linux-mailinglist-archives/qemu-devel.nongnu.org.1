Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC27E3411
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRR-00043l-I3; Mon, 06 Nov 2023 22:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRM-00040E-Hc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:44 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRK-0001Md-Np
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:44 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2802c41b716so4331118a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326461; x=1699931261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jn/tiXGq8rOEHtW5BliLo3GxJCO/SJOx7jptFAyyAyI=;
 b=LKaTZOrC5XPcCL+IpUjLeTFOHzr+W8OD0jwZ3oix2T1sZjj6l0a2xuCrigkIwOtsY+
 suPkDvBk90XwYrVpo6+wLVcB/biMspU2t9BoBzrZQSpQ+t1yKmQ0YzyYUD2f287aTWfI
 f7AlLAJPgdmdLpsT+gK/2og9G4J8zyzAOh60AQZwF/mgNBejXlj0dKKLjJ/Uokkb7HpO
 AmGhPv65/QL2Z8XTZ0/cumw2GSFXtL54s8BlVuVRG8NoEHF4YZoWTJq08dlmbuCX5Gpk
 /jBiLSyMp/H7Ryxix+MgTi1FHW5zBXmS5HGKVAFdMBrIi2Okvy7HfcMZcthv8YwCdUZ6
 EWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326461; x=1699931261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jn/tiXGq8rOEHtW5BliLo3GxJCO/SJOx7jptFAyyAyI=;
 b=lZfp3O4Xz6Z6Nskg4Yql0GqIX7I25rzNwcqi1eRTrFuIV/H962hQPvY6SGyAiWPR6X
 0BMhE1xCk4Wepx0T0zGZc/MGnEjQWzDB3x3yOVN/NT7aY5e3TpUi8PwWhYCeM1ykTq7P
 iI8RjfBOM6cIsJ3aDu9tlUoU+M3pR+kttZjtg5nuw2VKJRAFWiAvHe0e42sutF8zqSDp
 1P+CLNq8f9SzTPZ74nHVyS3DCNCR4Aq2csLjTc0iooCcMdjLvhZmZ6yBwodudS5dnKvl
 99AuAnjJCrcQpWAv29mLpK5tU/ho4Vz/r/3IHKTxikct3fWyNw+MpMk/HOc8wUXwX75k
 dfDA==
X-Gm-Message-State: AOJu0Yz/UkBC+BlmQgTvbP9mdVfUYzV9TNXr/yMJnTNvzr9akEJnCn2K
 Cj2exe/VkbxFn/jrIeO1D+2jRstE8whAaLCHVWc=
X-Google-Smtp-Source: AGHT+IHpgCGtmxzR0+nqxanW23UHfDGGMAk0T0pkNiY2iWB1KwvTsFBy+8iK51EpXBe/575BuUmrLw==
X-Received: by 2002:a17:90b:350d:b0:281:2634:f81e with SMTP id
 ls13-20020a17090b350d00b002812634f81emr2541217pjb.37.1699326461341; 
 Mon, 06 Nov 2023 19:07:41 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/85] target/hppa: Decode d for cmpb instructions
Date: Mon,  6 Nov 2023 19:03:26 -0800
Message-Id: <20231107030407.8979-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
 target/hppa/insns.decode |  9 +++++++--
 target/hppa/translate.c  | 12 ++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index b185523021..fc327e2bb3 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -67,6 +67,7 @@
 &rri_cf_d       t r i cf d
 
 &rrb_c_f        disp n c f r1 r2
+&rrb_c_d_f      disp n c d f r1 r2
 &rib_c_f        disp n c f r i
 
 ####
@@ -83,6 +84,8 @@
 
 @rrb_cf         ...... r2:5 r1:5 c:3 ........... n:1 .  \
                 &rrb_c_f disp=%assemble_12
+@rrb_cdf        ...... r2:5 r1:5 c:3 ........... n:1 .  \
+                &rrb_c_d_f disp=%assemble_12
 @rib_cf         ...... r:5 ..... c:3 ........... n:1 .  \
                 &rib_c_f disp=%assemble_12 i=%im5_16
 
@@ -296,8 +299,10 @@ bb_imm          110001 p:5   r:5 c:1 1 d:1 ........... n:1 . disp=%assemble_12
 movb            110010 ..... ..... ... ........... . .  @rrb_cf f=0
 movbi           110011 ..... ..... ... ........... . .  @rib_cf f=0
 
-cmpb            100000 ..... ..... ... ........... . .  @rrb_cf f=0
-cmpb            100010 ..... ..... ... ........... . .  @rrb_cf f=1
+cmpb            100000 ..... ..... ... ........... . .  @rrb_cdf d=0 f=0
+cmpb            100010 ..... ..... ... ........... . .  @rrb_cdf d=0 f=1
+cmpb            100111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=0
+cmpb            101111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=1
 cmpbi           100001 ..... ..... ... ........... . .  @rib_cf f=0
 cmpbi           100011 ..... ..... ... ........... . .  @rib_cf f=1
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e326f63866..6cd06fbc0d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3091,11 +3091,10 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
 }
 
 static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
-                    unsigned c, unsigned f, unsigned n, int disp)
+                    unsigned c, unsigned f, bool d, unsigned n, int disp)
 {
     TCGv_reg dest, in2, sv;
     DisasCond cond;
-    bool d = false;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
@@ -3113,14 +3112,19 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
 
 static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 {
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r2, load_gpr(ctx, a->r1), a->c, a->f, a->n, a->disp);
+    return do_cmpb(ctx, a->r2, load_gpr(ctx, a->r1),
+                   a->c, a->f, a->d, a->n, a->disp);
 }
 
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
+    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i),
+                   a->c, a->f, false, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
-- 
2.34.1


