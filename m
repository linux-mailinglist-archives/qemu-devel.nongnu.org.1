Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6557DEA44
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcW-0007sM-9g; Wed, 01 Nov 2023 21:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbD-0006b7-Ci
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:20 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbB-00023C-G9
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:19 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5b9a456798eso292129a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888855; x=1699493655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TGhrVvSioZOKLzuGEDT0EYlmb53GWffcGiWzBh1bjs=;
 b=uJ43/joGWgLhq9NW53EABIIvnOc6yKpKF7/u/bdpavbZ5h4rempg+BIly2n4hJg8jS
 5OycgOv7ln1QlKSA80i9mAl4r/z5ml+pqLbB6MEU9XphSPKq0BrBGJu3bq30cJv/8Awp
 Q40GjOA+OKDU3r3sNarFweXpu12xEUr6nKaGNFR0gEth4DYWorz4Vh6X2siKDIGbTg37
 ph2BgBspy04C4w+SI8GaRBep1YN4ku0XMCp8ygaatSBnsMIEUu0GmX/9TNH8vsn+XUM0
 dZVOuTECYzAB6is13G4c/nnF9R9sUnu2eg6ndVuvvapd+gnxPmSPWUxDY0jhp3TN2nHS
 SC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888855; x=1699493655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TGhrVvSioZOKLzuGEDT0EYlmb53GWffcGiWzBh1bjs=;
 b=k9qdS4J2zgyRbMUHnAhSSCn3/WYeKy3+iYQ2B5kHZBzDI7kzvXiaFcwjwycvlXFV5F
 /gSMmLl8ZwS8RAIG0LsskhxoSH1fesUTdDOfpZMyFAz91eMrLVJ5TKF3IGC/Z2X7qVCG
 17VgAFuhTbeF87TsbOHE0yxM3n8SdlmGeouevazVBm/VIjlHJfi+GRB/mQgSgzVIDHMa
 xQaoU0D82+Pxxgk61UbZyY/8EozbAPSE4As3pjQvOGW1+nEFzvC0zu7iJut/0lIusgh+
 3AJmtXGdkadYKOt2YTWT5LTzaZ7vX5DHB3JQeHayzmevkhLNxirGqBIO0NwLErCzqLhA
 sWwQ==
X-Gm-Message-State: AOJu0YyaextApGJMQ2lHzxtESP6jQnW5lYCyt6VxV0FCeDfUCtA//xn4
 TWNWw6qzpKgSwmRtQCcn6CkqgM6zpa+J5K5sLMg=
X-Google-Smtp-Source: AGHT+IG+eugWM3XPnZ4i6UNdst2M9quSxGxXOgzyBz0l+ml87NqLdwB9N2ZPw62b91kzWEebX5NjHw==
X-Received: by 2002:a05:6a20:bea0:b0:161:27c5:9c41 with SMTP id
 gf32-20020a056a20bea000b0016127c59c41mr10881293pzb.28.1698888855124; 
 Wed, 01 Nov 2023 18:34:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 67/88] target/hppa: Implement HSHLADD, HSHRADD
Date: Wed,  1 Nov 2023 18:29:55 -0700
Message-Id: <20231102013016.369010-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 target/hppa/helper.h     |  2 ++
 target/hppa/insns.decode | 12 ++++++++++--
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 51c24b31b0..c5f1db574b 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_3(hshladd, TCG_CALL_NO_RWG, i64, i64, i64, i32)
+DEF_HELPER_FLAGS_3(hshradd, TCG_CALL_NO_RWG, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index bb5cd267b0..87db726d9e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -68,6 +68,7 @@
 &rrr            t r1 r2
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
+&rrr_sh         t r1 r2 sh
 &rrr_cf_d_sh    t r1 r2 cf d sh
 &rri            t r i
 &rri_cf         t r i cf
@@ -86,6 +87,7 @@
 @rrr            ...... r2:5 r1:5 .... ....... t:5       &rrr
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
 @rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
+@rrr_sh         ...... r2:5 r1:5 ........ sh:2 . t:5    &rrr_sh
 @rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
 @rrr_cf_d_sh0   ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
@@ -187,14 +189,20 @@ dcor_i          000010 ..... 00000 .... 101111 . .....  @rr_cf_d
 add             000010 ..... ..... .... 0110.. . .....  @rrr_cf_d_sh
 add_l           000010 ..... ..... .... 1010.. . .....  @rrr_cf_d_sh
 add_tsv         000010 ..... ..... .... 1110.. . .....  @rrr_cf_d_sh
-add_c           000010 ..... ..... .... 011100 . .....  @rrr_cf_d_sh0
+{
+  add_c         000010 ..... ..... .... 011100 . .....  @rrr_cf_d_sh0
+  hshladd       000010 ..... ..... 0000 0111.. 0 .....  @rrr_sh
+}
 add_c_tsv       000010 ..... ..... .... 111100 . .....  @rrr_cf_d_sh0
 
 sub             000010 ..... ..... .... 010000 . .....  @rrr_cf_d
 sub_tsv         000010 ..... ..... .... 110000 . .....  @rrr_cf_d
 sub_tc          000010 ..... ..... .... 010011 . .....  @rrr_cf_d
 sub_tsv_tc      000010 ..... ..... .... 110011 . .....  @rrr_cf_d
-sub_b           000010 ..... ..... .... 010100 . .....  @rrr_cf_d
+{
+  sub_b         000010 ..... ..... .... 010100 . .....  @rrr_cf_d
+  hshradd       000010 ..... ..... 0000 0101.. 0 .....  @rrr_sh
+}
 sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index cba610ac75..9d8e728460 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -455,3 +455,35 @@ uint64_t HELPER(hsub_us)(uint64_t r1, uint64_t r2)
     }
     return ret;
 }
+
+uint64_t HELPER(hshladd)(uint64_t r1, uint64_t r2, uint32_t sh)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = sextract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = (f1 << sh) + f2;
+
+        fr = MIN(fr, INT16_MAX);
+        fr = MAX(fr, INT16_MIN);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
+
+uint64_t HELPER(hshradd)(uint64_t r1, uint64_t r2, uint32_t sh)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = sextract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = (f1 >> sh) + f2;
+
+        fr = MIN(fr, INT16_MAX);
+        fr = MAX(fr, INT16_MIN);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d342df2dfa..dc68d5a263 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2809,6 +2809,28 @@ static bool do_multimedia_sh(DisasContext *ctx, arg_rri *a,
     return nullify_end(ctx);
 }
 
+static bool do_multimedia_shadd(DisasContext *ctx, arg_rrr_sh *a,
+                                void (*fn)(TCGv_i64, TCGv_i64,
+                                           TCGv_i64, TCGv_i32))
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
+    fn(dest, r1, r2, tcg_constant_i32(a->sh));
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
 static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
@@ -2844,6 +2866,16 @@ static bool trans_hshr_u(DisasContext *ctx, arg_rri *a)
     return do_multimedia_sh(ctx, a, tcg_gen_vec_shr16i_i64);
 }
 
+static bool trans_hshladd(DisasContext *ctx, arg_rrr_sh *a)
+{
+    return do_multimedia_shadd(ctx, a, gen_helper_hshladd);
+}
+
+static bool trans_hshradd(DisasContext *ctx, arg_rrr_sh *a)
+{
+    return do_multimedia_shadd(ctx, a, gen_helper_hshradd);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


