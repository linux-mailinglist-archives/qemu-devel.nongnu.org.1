Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 829377E33A8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS2-00067O-Bu; Mon, 06 Nov 2023 22:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRn-0005Mc-20
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:11 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRX-0001PR-Pj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:10 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5bcf83a8f6cso3962771a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326474; x=1699931274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=teUXRCS9hbmMwN14sWa92YzOcytx3Xwvy4gsjLCfcYo=;
 b=h4ddwopnGAzkem1Uate7s+3wJyxsaXIw7ENhGq0waT/++F0MXRD1xm6ou94eNMCbsX
 lcMm3DAafml8TWXwx3Qn2FUbFl6pJWE9ThXTalLxrSY12ObduDNzC114dH4ZT9mpVeNT
 QTKyEtzdWXrhpsGoMCjk0kVau8L0Y5sWB6cRwUeEMstzLVgkjxhQAt7XRoz356MxI2Yk
 I1DEzqcubZbeYxKabPQ5n9CeVnTdD5tvia5VlbXXzJ+RGthrbioHbrKdvSJSYvwRzOYb
 zTABfej1mZ2mo0qaQYF6Sxg2rCymmmlH4D9L3XoJT5zxKuJxaFsD57D1ih72914u6jlC
 7/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326474; x=1699931274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teUXRCS9hbmMwN14sWa92YzOcytx3Xwvy4gsjLCfcYo=;
 b=ZnkrISDOywt2JdLZibj8rSzr4WbVjrAKWl8vyWZ7OG+8cbn9JANaT3fWhdkLqV/tG+
 aLAoaVJ8MYDLoQ+xwbF06ETVAl0ErE0gB4fndBA7yI2YreGrTBjS1+5JZ9wAAT0CWVlx
 nNj1mw9HGIqKi/pZ40E38jBbvPy2XO0qNumVJI9sbRuQSsrEMdRwKl8k2eYy7oboWZsJ
 1voYj1SSSryJYBZcnudXB7Gov9yF96H518YBWn/OjQGjxIo/oPBvC7hSCBt4RYT+7Vbg
 j1A1Nd1Rq9k9TePri7bibJ1o9qXqFeGcOa+5s3x7t08AES2BpFwmXG/6q13x+AwbDaUj
 dXaw==
X-Gm-Message-State: AOJu0YxlDFvSESZ99Y7Wn6mSI2F3huIho53AwcPP+SiS3M0thRbgq3xK
 8FGusXkV57uqNxccAYQPYgq4dNeL6rHmTfhP5Ao=
X-Google-Smtp-Source: AGHT+IHlFE5EFeT2orls+xe+Hiy93WRhlcgz6jXXPaAL/QwSEs0vCkRz+DqKubUXs2NLU514015/GA==
X-Received: by 2002:a05:6300:8081:b0:180:e6ba:7030 with SMTP id
 ap1-20020a056300808100b00180e6ba7030mr18980789pzc.29.1699326474373; 
 Mon, 06 Nov 2023 19:07:54 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/85] target/hppa: Implement HADD
Date: Mon,  6 Nov 2023 19:03:43 -0800
Message-Id: <20231107030407.8979-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 target/hppa/helper.h     |  3 +++
 target/hppa/insns.decode |  8 +++++++-
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 57ea5447b6..db662f0c33 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -14,6 +14,9 @@ DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
+DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 820049b0c5..4bcfc94b1c 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -65,6 +65,7 @@
 &ldst           t b x disp sp m scale size
 
 &rr_cf_d        t r cf d
+&rrr            t r1 r2
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_d_sh    t r1 r2 cf d sh
@@ -81,6 +82,7 @@
 ####
 
 @rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
+@rrr            ...... r2:5 r1:5 .... ....... t:5       &rrr
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
 @rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
 @rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
@@ -208,6 +210,10 @@ subi_tsv        100101 ..... ..... .... 1 ...........   @rri_cf
 
 cmpiclr         100100 ..... ..... .... . ...........   @rri_cf_d
 
+hadd            000010 ..... ..... 00000011 11 0 .....  @rrr
+hadd_ss         000010 ..... ..... 00000011 01 0 .....  @rrr
+hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
+
 ####
 # Index Mem
 ####
@@ -429,7 +435,7 @@ fmpyfadd_d      101110 rm1:5 rm2:5 ... 0 1 ..0 0 0 neg:1 t:5    ra3=%rc32
 
 @f0e_f_3        ...... ..... ..... ... .0 110 ..0 .....    \
                 &fclass3 r1=%ra64 r2=%rb64 t=%rt64
-@f0e_d_3        ...... r1:5  r2:5  ... 01 110 000 t:5
+@f0e_d_3        ...... r1:5  r2:5  ... 01 110 000 t:5      &fclass3
 
 # Floating point class 0
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a25e6df7e4..d93801ca47 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -377,3 +377,35 @@ target_ulong HELPER(read_interval_timer)(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2;
 #endif
 }
+
+uint64_t HELPER(hadd_ss)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = sextract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        fr = MIN(fr, INT16_MAX);
+        fr = MAX(fr, INT16_MIN);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
+
+uint64_t HELPER(hadd_us)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = extract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        fr = MIN(fr, UINT16_MAX);
+        fr = MAX(fr, 0);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1d749e2a78..dc8e37f99c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -23,6 +23,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -2767,6 +2768,42 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
     return nullify_end(ctx);
 }
 
+static bool do_multimedia(DisasContext *ctx, arg_rrr *a,
+                          void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 r1, r2, dest;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r1 = load_gpr(ctx, a->r1);
+    r2 = load_gpr(ctx, a->r2);
+    dest = dest_gpr(ctx, a->t);
+
+    fn(dest, r1, r2);
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
+static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
+}
+
+static bool trans_hadd_ss(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hadd_ss);
+}
+
+static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hadd_us);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


