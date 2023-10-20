Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718C7D1793
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM7-00084f-1n; Fri, 20 Oct 2023 16:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLt-0007pN-3e
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLm-0008Gj-LW
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso1170059b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834645; x=1698439445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXqbl0J9UOFpqWT8nVVjfRWDi4TXJT7ar8Epjag9g10=;
 b=zVkzk24S7hNOUu5xMiQtXnOG7dCA0KBhspZoMQLPfEYJVt08g3hmrlpDOxc2E/XX/0
 3zXF83AdAjsgkL9heMDdtTyXn64xVGrX1ueLZ/Qkbeyr6xQyFsMLl2ZpjuZnsSD7q9IJ
 bBx/LCerw2WSFpm2kB8DDhAfUqhDjQc0r9d7DkzH9GrYukYoidfULTjJ45wAfiWEJqGD
 WbIE+peIZKO4Hu2zElLiQtudM1q2UaCdI+2Mf5tXkt/glN2FxeIKwatcLo8WpAhK6jBu
 inO469X9oRKukM0XVsuPz1ctZh8ccqK7ALEwk7ErZymRlMp8QIAc6jj9BkPdgNZ2vYR+
 hZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834645; x=1698439445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXqbl0J9UOFpqWT8nVVjfRWDi4TXJT7ar8Epjag9g10=;
 b=oqbueXr3JN+vHA25gbj3nRi9DN7PQvp2hVdV8T143+Yxr/6xXbbsFpk7qlooMxO6Qj
 HBlIjM/kocZQ6iufSWb4zu/OxTPfWrqX5sZD+etUxpzA5mn9yAAHAAErc4URfj6Qau2n
 yDbcIh2UIIyiwgfKF6MjXPiiFMKslqfP3b9/Pn9Ca+YTUGKxm09nRJPWaNYxvr4Y5usO
 aJ+vPmFBCXzyrfTCZ1O6hTvO6o6Ig4fxYZMqdxspRBWhjGbG4rXPOvUc6kTwsklO83Bi
 3UjVvja/MyS3Oppw9j0yGIoYEfKOPRJvvsqTFrU/ytqYI4oTzkqg8K1yBhe5X++Q+pld
 OXyQ==
X-Gm-Message-State: AOJu0Yyc+ygAritTBNlK47HwUnYfaXuLEKZlshGD3kZ5il1sV6VmeFOc
 ws0MD5Gn9k9JDamQDBDIWc1FRN2mOSAtqD+K8Lk=
X-Google-Smtp-Source: AGHT+IGf5STZvzw+2RaWmflgnvlCbtPckb58Zg4jjdp2LHAUVtoaxcKEDx441l0/yOkzphcBMSlnaQ==
X-Received: by 2002:a05:6a00:a13:b0:6b2:6835:2a82 with SMTP id
 p19-20020a056a000a1300b006b268352a82mr2987648pfh.13.1697834645400; 
 Fri, 20 Oct 2023 13:44:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 36/65] target/hppa: Decode d for cmpb instructions
Date: Fri, 20 Oct 2023 13:43:02 -0700
Message-Id: <20231020204331.139847-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 543a694724..d1d9a4a137 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3070,11 +3070,10 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
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
@@ -3092,14 +3091,19 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
 
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


