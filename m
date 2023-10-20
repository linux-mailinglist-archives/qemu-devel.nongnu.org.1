Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773E87D1796
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP2-000221-VN; Fri, 20 Oct 2023 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP0-0001ze-5L
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOy-0001Cs-9T
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso1172493b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834842; x=1698439642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZQqhnqvw8jUMDjxWBT9l+s67nfFE6KW7Kxk+PLyIRA=;
 b=hXy5IGvqfXsi1Wcb9dSznWPCEydHYXBE7Z8udw38XFrvJ3i8+hltNfSDXl1XwE2o1a
 sq/blMt5GFaW0WoZxhZHlSkjAGvAyRmsfFEUpp4oUX7wDFLiWDzwGKFnUsOavd6fO015
 CwutWU1XcHtQIJ4eItjcV/0tY1HEceMDx/GB/itPmUkWOU2RMZa2l2ZcLBKzxWoQ/wV/
 fDbcJTQf04K18BtdrOPmt68meUxbIcYd7eW4WiAgxFJ6Svjvn7kuSUvPtbI66s/oByr4
 hHz/bHANQooLtrM1HLkidasYTwgffcAVq7vk5dFV9G1zy5gSuJIAHYf+9hty8vK3TYtb
 CJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834842; x=1698439642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZQqhnqvw8jUMDjxWBT9l+s67nfFE6KW7Kxk+PLyIRA=;
 b=Yw/0lRJ1drE2vRm/AuepQrbNKoRWjYByoshpLs4n6IlT5SR5hLWDauocKSoySRkejV
 uQgcJJGKIwqWRzjULN3BDhxiuYNTeCwkSdhXpqif3EfhGbNdznitfG2HvWZ0nhfjb8UM
 7YcAbU+YbuI6ndty1CMqMKdnstYTg6zdqQBGuTowurHDz9ffUUtbC6OJ+adLz1WGXvpv
 6GJ9PNfIRGrt1mwHwzPlBnWfJssJiqOvkAWxT/1CCLgjWpM/Asjk9ZC08OHJM+s5WeTX
 KWIvaoNJqWzuVkA2ryshD1geLVaKCrS6kLvIqGwrhdT0Y3gVOfUZP2C0ill1QYQg5320
 aiaw==
X-Gm-Message-State: AOJu0YzIiNuSHQSc+9Z2VDQpWF7wofI4PY9B8Mal6BKQXHHkT31JbDhL
 A6SGXvmeML6H3iItc87sIgF7rJ/4nRir4XQ1oKI=
X-Google-Smtp-Source: AGHT+IHzb8ilsVa58F6ot6uizuOFUWehjns5NcLU2LxUe2cPPIXYDKwskWmhTTHcjoX8h9niYb7KSQ==
X-Received: by 2002:a05:6a00:1a09:b0:6be:2dce:cf5a with SMTP id
 g9-20020a056a001a0900b006be2dcecf5amr2797719pfv.26.1697834842318; 
 Fri, 20 Oct 2023 13:47:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 56/65] target/hppa: Implement HSHLADD, HSHRADD
Date: Fri, 20 Oct 2023 13:43:22 -0700
Message-Id: <20231020204331.139847-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/hppa/helper.h     |  2 ++
 target/hppa/insns.decode | 12 ++++++++++--
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1feb2fdfc4..c4c3093a83 100644
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
index f0c4866ca2..d7befbf73d 100644
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
index 353d51cc8b..47abed1662 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2781,6 +2781,28 @@ static bool do_multimedia_sh(DisasContext *ctx, arg_rri *a,
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
@@ -2816,6 +2838,16 @@ static bool trans_hshr_u(DisasContext *ctx, arg_rri *a)
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


