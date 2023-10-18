Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF57CEAE6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVi-0002Dy-Ol; Wed, 18 Oct 2023 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVg-0002DI-DM
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVe-00053y-K4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:24 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so3704073b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666121; x=1698270921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYe6qSFa58+9C+lzb+b7/7YPN7n3mkRlSU5qeFeX9fI=;
 b=AwfLZYX5WEMRIFVYrAib0YRI9ZmNRVvOYHKfSoz0X0vUxeqUbrSkn7t0UYUA7xjp8k
 FFBTZ7FtC16dUbQN/i7UTNyZv2dssQpRb8ejy7tkA1X8m+zCbW9ggrwfnJH2PbUM3GYs
 3yCOwR8L/t6qouf4p+euOdcK7cAhzHnzu+p0gMWM7i5vHu8dbUM9kQe4uPChoF6bkJnz
 2o6vl77wE+ZoCVif+axQfpjT79+OsUln1cwwyYugHBNbgs3VOUdfwxNOMRKCt0Yx4Sur
 yC7d4IB4SIyL01Q/7o0E95Tkd4KVWa+s/TVPTqgW1Ah/1ktjQ026teLm4pxRxZ/s7GgI
 AJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666121; x=1698270921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYe6qSFa58+9C+lzb+b7/7YPN7n3mkRlSU5qeFeX9fI=;
 b=IkliMR2+tLWokIDyvs/u1TMxbr9jYHDrC2+1gU9m9Ql+1sAVb5nqb5dxIsjqG61iHK
 e2oz3A3SuyCcKt74jl7UCRd2U1hvey87pVckjf05BlsdE+femWrGsLp+oxGhwuHA1hq6
 JItCzTh5HldIxo9hVSAjOplnfAc0qdEB+50EFHP2A9rs6eEKeYEtERMywaL0dQDDmV3o
 3mdSINgH14sDw4mDgWgQg7nJ9NAoGVFA4WJoOWpI0p5M6SlQESXUf73PMNu8I6FUcSaQ
 HpzAL/IUJgBJewTx74XcyepVZXdh6/izVO0u7EVCTkMZJnrIrfNtYbxe1wdRdEPXSepV
 Oizw==
X-Gm-Message-State: AOJu0YyBq3w0sM9Wzxe+j0pEV7i/1SDShF5klIDFM1vViiCoXPJidM3t
 r3E8loOTgnnbiLCWsITow/ciiLOjMTCrfImgGdk=
X-Google-Smtp-Source: AGHT+IGFPwYXS6xo26bJUkaqoK2oolNlOJCk2yCpO2Z0cRfUvZdDHsgl0f1Xn0Rwkdz683+LYFdg5A==
X-Received: by 2002:a05:6a00:2315:b0:68e:3eb6:d45 with SMTP id
 h21-20020a056a00231500b0068e3eb60d45mr317254pfh.30.1697666121265; 
 Wed, 18 Oct 2023 14:55:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 51/61] target/hppa: Implement HADD
Date: Wed, 18 Oct 2023 14:51:25 -0700
Message-Id: <20231018215135.1561375-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/hppa/helper.h     |  3 +++
 target/hppa/insns.decode |  8 +++++++-
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 4b2c66316f..ff2695797e 100644
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
index db1b9f750f..88248ed3e2 100644
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
index 366a8f1acc..bbf216fcde 100644
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
@@ -2739,6 +2740,42 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
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


