Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE57DEA54
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbu-0007Aq-1N; Wed, 01 Nov 2023 21:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaw-0006O6-JG
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0001vA-Lk
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so3686035ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888839; x=1699493639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn/tiXGq8rOEHtW5BliLo3GxJCO/SJOx7jptFAyyAyI=;
 b=vUy4sRRYcq5Ov9KLe9CVeiQJVuKYsl24qrgiyZ0XfemCEAN+BhAWIOKeYshnjx/h5Z
 TGdOCRxchqUZMLF+qPR35ZhIRnaT/FatpbreNfYdqxa7XyqGr24h86dS5dRP+mpYp9a4
 tVqtkIG1gvhMEZb5+O6YhMQQcroLX13ZZE9DW51emr0efd+kSWe3VoC9IJc9+NiVAgbE
 H8Z+ty+YwQGYwts7TYQT9cDEHsfRPUxICMwgVLd79da7BETumdt/JTZtZdz/4HaLjmoT
 7P3kF5416klf4UTtKA6SiCwIL1ygi4yxCw1IRe9NzRXQ/ji3Xh7n4gh5kPlqIEoW0xgj
 tJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888839; x=1699493639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jn/tiXGq8rOEHtW5BliLo3GxJCO/SJOx7jptFAyyAyI=;
 b=h2B0gDcrgi72SfITkMBLYAOtR9D4MxI2ypAvYoRi7Y2gipxB4Qr8J2Nbfez63MNuET
 Y2/X+IB0lR4tvbbNQUHhh18iyOtZkQ5Xo8xKwbS/P6gMuTc4DzmUkNw5KXfAwz7vxniz
 ZJMs+QwEhcPsume3UV46WiOVsSL5x4RjyhGxFwa0AbT2twNei0TsMKR2Bgd2oGnQg0Dt
 VvAuSgI8k8LBVKz8NFXEsvM8VEOi1OfOkw87doD5HqcV45jNz9H9oYTMavwBREP0Xhtv
 PzzHzgeB99m5dwsj7pA9T1dP1q3cmIlfA0oH9sXtbRokrTNNMRgkL9S77fS0op1au9Ot
 /8yQ==
X-Gm-Message-State: AOJu0YxsjrnoLhCUHmEyD5UZD+xyHFSgZQYU30l9dLFrX2hcSz181auq
 sM3wPYg4cmcG9+ZTBdT5NmFEtzmglO7zekhuim0=
X-Google-Smtp-Source: AGHT+IGHzJFNRG0RQ7b6IPAL/Jgbz3oeap/N4Xdn0iKTJtl+71LtucswXoO56KqrFwvA5XcKIfr6EA==
X-Received: by 2002:a17:902:da8d:b0:1cc:42d0:dbc5 with SMTP id
 j13-20020a170902da8d00b001cc42d0dbc5mr9840243plx.13.1698888838936; 
 Wed, 01 Nov 2023 18:33:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 46/88] target/hppa: Decode d for cmpb instructions
Date: Wed,  1 Nov 2023 18:29:34 -0700
Message-Id: <20231102013016.369010-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
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


