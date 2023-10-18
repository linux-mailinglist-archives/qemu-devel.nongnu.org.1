Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94B7CEAF0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVn-0002Jx-FB; Wed, 18 Oct 2023 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVj-0002Eh-HB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:27 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVh-00056h-O9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:27 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6cd0a8bc6dcso483876a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666124; x=1698270924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=of1/SQFOqlAvS9aND7Kiwy5bZQumQelFC5EO7Qp9wnk=;
 b=wL15c1axAgjz2FrMIUObLfnmMpNg77fHICu1l78wFmYflct0sQJEGs1IYfQl3hS5of
 PrZy699l6+f1K+xBWFf3H3PfimuadPvl+Rf5MVoplbYClBLmL+vFtP9I1CCpEAIqyw4R
 +pMX2TcFW52sFKgr9m8UVmIpdUypO/c9Qykg3KFtOHn068iVL4oZ2pzKD4o5RcFf+lWU
 TzQtDVBkRyjK889fW7EKFLa8OZ/MiEfaJ+Cf16/WJC2UpJMR1/lFkRj+GxQHcgZMgg9o
 szq8YnuAmyXbbpyAKo5ShNvpiWmtJ6gaNEQ7nl1iVifT01xI/wPHonQ5owBxm2FOUhej
 3Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666124; x=1698270924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=of1/SQFOqlAvS9aND7Kiwy5bZQumQelFC5EO7Qp9wnk=;
 b=efh/Oon22kt5Sra6XPJlJ3j9KtFGUu0xIMstyR7e//Pw2qttzieru14ZunWkLiW8Zy
 LrqevEjvq3cDR8lALcQ58tQ3SRwHUu2WbMFHWOnNE7HQnhmv5aIbZZfz+tJrvHHCxl8v
 movhk/4OlkFl+/L7/+adkTLcB6G2onCzen0kRNZ0POOor9rstZx9oxDS2Q6urB20HbnU
 uUIFEb0qSECzXGqPVl5oYsSpeZAoHQW28kwRRvJ5F4aEbWyEKRRoS6Q+uNXXoGs5+zoL
 sgxHV0kaYtK3CIcTdQYRit2kVjZHa4mIkR4zzIuGIgOFRZ4lZRuX2ZkIGJE/tAgvgY5I
 hluA==
X-Gm-Message-State: AOJu0YyEIfOfadm32owhjYok2CYbN2Z3huyw+Lu4TLy9MPKVGJu9o3jb
 Nie+pGBB53yTa/ytfNkoR5VzdntvpuYzerpP/qc=
X-Google-Smtp-Source: AGHT+IHjrNdWBsute6joVMme2YycwbW5iHWmS+q4/TmfZufu0qwxjIwBjA3p/7kuyii6hZUgp7GYMQ==
X-Received: by 2002:a9d:6203:0:b0:6cd:da93:90ce with SMTP id
 g3-20020a9d6203000000b006cdda9390cemr519933otj.19.1697666124507; 
 Wed, 18 Oct 2023 14:55:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 55/61] target/hppa: Implement HSHLADD, HSHRADD
Date: Wed, 18 Oct 2023 14:51:29 -0700
Message-Id: <20231018215135.1561375-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
index b912673531..b0aefecd2e 100644
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


