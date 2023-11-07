Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9F7E33D8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:13:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS3-00069d-74; Mon, 06 Nov 2023 22:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRq-0005cb-Ql
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:14 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRa-0001Pz-Np
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:14 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so39169125ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326477; x=1699931277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dwpYXNZ8cPxB4iReliaHkutav07tK42b+r5ULdK3KrA=;
 b=zcH+uJ3Adb/8Lb6qxF219VlaD1d3W7Mn8tbXZYc11hV8uS/x1UsV0SIHs9Zc3qIKaW
 tQYbNBjuhfLNZPRIg1SqJIJP31n5WCaGInNKmPEhOqBiWEbzXa6f17CYCzBzxhJUtSGo
 cYcDjN3IkzhqIUtbQYuQqcn7tyw+v4scgc2ILcVgMlEeZwPqORIYTeayylbapxS0JZKK
 YocSG+KMTx3bGTs7VoDtWEbUE7nPEVJrGYSEV1cNw9pbKBPrlFqHu1tUTJq1ExlE/N15
 KqqHunk8UOkenF9BNla0ZjMRhxBoivbgtubVnZKrr3O1B9ATmKZvlVLbkHpL3MwnJXHZ
 +ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326477; x=1699931277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwpYXNZ8cPxB4iReliaHkutav07tK42b+r5ULdK3KrA=;
 b=rg1THS/NX8L9kJJEa7faIZqUSbbP7/jhxG5xJdFvVaG19O6Z/JEgUUizhHS/gxWp5b
 udOVRfQO4ehDuqesPtVmrbevKHUEnworkuVQj4X169gsEVPtkiMgWbVv//G7Pfz+28nF
 eDtIg09tezJgP5SZ53r7mIcBQRZr1dLNYjKGQg/h2lYM43Uvl+7u+NKlKBXX0vZlYroZ
 fTf3vob5nBPSgQYdLuUrzb78kSMjVG2BTMf9f82imYi+J9mo6LM6fcS1Ztp5OZ4hgfOE
 yhNVmE0zR5J5julj/2O1lZvN/oG54fuHFuifrOjj0MC1NZu+WbVBsFF0c/ZICQgvx8kz
 fD8Q==
X-Gm-Message-State: AOJu0YzId5QJMcFjeA+3/Br15HqbseecDRxtWmWGrTmeKWs3fLZpqD3r
 UOOJ0RIcH6L9y1xqoM+AHt2/k6Y+FOi9bt8KClw=
X-Google-Smtp-Source: AGHT+IFtixIhPYyLxVEOkp068UdnLJBk8uR3nnitPFYfqbxyGobd7dfcnDNbIJdqbX3ZdVhvGNnlPA==
X-Received: by 2002:a17:90a:1d5:b0:280:53b2:4b9b with SMTP id
 21-20020a17090a01d500b0028053b24b9bmr19348757pjd.15.1699326477421; 
 Mon, 06 Nov 2023 19:07:57 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/85] target/hppa: Implement HSHLADD, HSHRADD
Date: Mon,  6 Nov 2023 19:03:47 -0800
Message-Id: <20231107030407.8979-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 3b3a543216..d586be3f15 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_3(hshladd, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
+DEF_HELPER_FLAGS_3(hshradd, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
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
index e76f201472..a0e31c0c25 100644
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
index a3a12d63f8..648c37fb28 100644
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


