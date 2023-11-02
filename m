Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E936D7DEA4F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcn-00016s-T3; Wed, 01 Nov 2023 21:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbA-0006YR-1x
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:17 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb7-0001zB-31
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5bcf83a8f6cso300012a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888852; x=1699493652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2CvEfV4x9tkVgjcQfaMTVqejZwVMEFjiL8lyr8+l3M=;
 b=wIFtPZxN2l4UlvDJdx0bSE78fPMYS22rLzupBUU6N1bpEJQQO2MzwSpKHUBNPYo2MH
 RSgsU9G+DtRjumgnNc9UhXKiXCAmw2XBBNjp2E9ONqTucyEbcJRYoReoSrCnQ4alO67M
 cbLMBiOfV0tIgD3ysiegbvyb456avTDEoPVfpPsEtjA0TRQuGKiSx6NtOjJC6YJn1tqW
 9LPiEDDNbXwxGR5kgUMyhbmH5tRQJf0sKaWVzhZMQlOvnWq4K+XMcw7TlcXeSfINg1tw
 MNvZlQG6O+Gng9mluN1QpiV3q/pkVz0WpdoR/hNnyviPc0aKebxN4VpN4l6bZzcWxYKk
 t27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888852; x=1699493652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2CvEfV4x9tkVgjcQfaMTVqejZwVMEFjiL8lyr8+l3M=;
 b=d8JvOYWontvr7WRkfIGhDzBC39PHT/fsPQxTF17DSlAo8Bd6a05EdUcKPRBXwz0VTy
 /iC/nhwfe0d4NRTGKU1T8sZVB4TcTmdvGjuQEOhCBXUcXwYJt4h3r53wAOX/DIpp99NI
 zKcHoXKrSGNqCCJryK5XhY1EaKLuR6Dq/xK7DeCD/emr4dlajqpWkSt4x+Q/QFhvlABt
 XMhTdUHPlUR/elIJIiupmMwbHOVWNGmQaNM/xRhsRWgw2ttPI1G7h9yXgZ1eQBzAhUX2
 c2a1sww6opmrXSnUvzgPS6CH7r0KmMZ1UdXdwj3dvtGC1OnvL1cAZ/FmHEjIBunWXivn
 vLng==
X-Gm-Message-State: AOJu0YzUetMLYyH5SIHeskOruXltpi0wUrZRMqnc8iIy+aBxx0umZIaS
 uKcGSr048yxUUa10i+M0W8UrukWFDjU7SDSaK5A=
X-Google-Smtp-Source: AGHT+IEBKADnUNXuKg4q9fMsE2YXMSmQQLVZZzqpiXac3S27WSAiJyxbZdIb1oqm9uOEGw+Oy94fLg==
X-Received: by 2002:a05:6a21:99a2:b0:153:353e:5e39 with SMTP id
 ve34-20020a056a2199a200b00153353e5e39mr16890445pzb.51.1698888851844; 
 Wed, 01 Nov 2023 18:34:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 63/88] target/hppa: Implement HADD
Date: Wed,  1 Nov 2023 18:29:51 -0700
Message-Id: <20231102013016.369010-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index 57ea5447b6..b3c961b50d 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -14,6 +14,9 @@ DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
+DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
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
index 0bccca1e11..a230a3a0c3 100644
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
index f570b17ecd..f564aea8fb 100644
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


