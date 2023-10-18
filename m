Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977F7CEA62
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESh-0001mq-Fa; Wed, 18 Oct 2023 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESX-0001Pj-N3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:09 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESV-0004Ta-QI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:09 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce27aadf24so163075a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665926; x=1698270726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJvdFesDZvRn5V/HgHv8lkINBr9ZJC7sBp4BrdViQcI=;
 b=NV8bF61mnfGyVvYPauYGV61vntI6lZv22SmiOvRV+WyThvL20FSBMT/u+e2VVOtkr8
 p99QKM9AC3wh9M/SfVDhP2F4hCwnBDjup/0xM1Uc0NtYQogpN42Z4MHpSYhdZ5czBvgT
 afVKTrrwwJQtA3NrOxr/Am+YqjcsgQGOLXBCZ/3znmYt8WNk/f3IPRjZAM3SVCQSZERC
 Oyx7E4lfIjU2y0fjueNewuSEa4goDYjBw4tHXR67BgNamKJ+maDkU8TWGyDyXveqzYSR
 HyRhoSg6EPE0M5A+Vb2K5bwDlRZY5RKWpN9rAbBLYuBQ2FWUE+bVcWcCbFeuABqlv7wJ
 A6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665926; x=1698270726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJvdFesDZvRn5V/HgHv8lkINBr9ZJC7sBp4BrdViQcI=;
 b=tBEbbaIaPczwDueUIKPrpN112MjjH92BfV007QhI6sZ7lYFwNDLff57NrEBo4/LLnD
 YWJyLmsy29WjHlRcziP/Pjx+dtl7SCEs14aSzB+m+zlaZxdSWLtPXzxm3YDdWwv5eHfs
 ZGAHrYiOHk5jWPtic9iRXaw7hpvFx4OVArGVjDBj8ehGYXy1zlfjl59b+rxWF69GxpxF
 Uq56AqUqNOns5VMbbFSCH9SyG0FjtCGrUXSa/Rm+Y+vAtaKtzp6zkmlJPTooPKT5Lcx8
 Adyr1v61l92sDimKA80WxkQmbpZIxSuKepiJB+J8XzpwkE0OxCS/DuXc/lWeSM05CkMi
 Poeg==
X-Gm-Message-State: AOJu0YzmE+p/eX2lvZMWrNroI4zri3a60tXPLp62efJDwsGkFQMUphwd
 afi0drFbqYhdYPGaajl35/qew63EyTd6sd86u2Q=
X-Google-Smtp-Source: AGHT+IH9ShTNcmFpVWp8ybNHlGHMh704G+9yibV26ANV45aqO6+ntnOekFhKOE7elViCSSk4AlQ0AA==
X-Received: by 2002:a05:6870:f153:b0:1e9:b6aa:a629 with SMTP id
 l19-20020a056870f15300b001e9b6aaa629mr700843oac.6.1697665926463; 
 Wed, 18 Oct 2023 14:52:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 36/61] target/hppa: Decode d for cmpb instructions
Date: Wed, 18 Oct 2023 14:51:10 -0700
Message-Id: <20231018215135.1561375-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
index 33da82b7c8..681c955125 100644
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


